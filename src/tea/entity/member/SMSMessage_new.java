package tea.entity.member;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;

import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.codec.digest.DigestUtils;
import tea.DateUtil;
import tea.HttpUtil;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Filex;
import tea.entity.site.CommunityOption;
import tea.entity.site.SMSEnterCode;
import tea.resource.Resource;
import tea.ui.TeaSession;



public class SMSMessage_new extends Entity
{
    private static Cache _cache = new Cache(100);
    public int smsmessage;
    public String community;
    public String member;
    public String mobile;
    public String content;
    public static final String[] SMS_TYPE =
            {"发送","接收","自动回复"};
    public int type; // 0:发送记录, 1:回复记录 2:自动回复
    public int operator;
    public Date time;
    public boolean exists;
    public int subnumber;

    public SMSMessage(int smsmessage) throws SQLException
    {
        this.smsmessage = smsmessage;
    }

    public static SMSMessage find(int smsmessage) throws SQLException
    {
        ArrayList al = find(" AND smsmessage=" + smsmessage,0,1);
        return al.size() > 0 ? (SMSMessage) al.get(0) : new SMSMessage(0);
    }

    // 收信息
    public static String findReverseByMember(String member,String community) throws SQLException
    {
        SMSProfile sp = SMSProfile.find(member,community);
        StringBuffer sb = new StringBuffer();
        try
        {
            URL url = new URL("http://sms.redcome.com/servlet/GetReverse?subcode=" + sp.getCode() + "&password=" + sp.getPassword());
            int value;
            java.io.InputStream is = url.openStream();
            while((value = is.read()) != -1)
            {
                sb.append((char) value);
            }
            is.close();
            return new String(sb.toString().getBytes("ISO-8859-1"),"GBK"); // "UTF-8"
        } catch(MalformedURLException ex)
        {
            return "";
        } catch(IOException ex)
        {
            ex.printStackTrace();
            return "";
        }
    }

    public static int countSendByMember(String member,String community) throws SQLException
    {
        SMSProfile sp = SMSProfile.find(member,community);
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        { // 0发送记录,1回复记录
            db.executeQuery("SELECT COUNT(smsmessage) FROM SMSMessage WHERE subnumber=" + sp.getCode() + " AND type=0");
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(smsmessage) FROM SMSMessage WHERE 1=1" + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT smsmessage,subnumber,community,member,mobile,content,type,operator,time FROM SMSMessage WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                SMSMessage t = new SMSMessage(db.getInt(j++));
                t.subnumber = db.getInt(j++);
                t.community = db.getString(j++);
                t.member = db.getString(j++);
                t.mobile = db.getString(j++);
                t.content = db.getString(j++);
                t.type = db.getInt(j++);
                t.operator = db.getInt(j++);
                t.time = db.getDate(j++);
                t.exists = true;
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Enumeration findSendByMember(String member,String community) throws SQLException
    {
        SMSProfile sp = SMSProfile.find(member,community);
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        { // 0发送记录,1回复记录
            db.executeQuery("SELECT smsmessage FROM SMSMessage WHERE subnumber=" + (sp.getCode()) + " AND type=0");
            while(db.next())
            {
                vector.addElement(new java.lang.Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    // 发信息
    public static String send(String member,int language,String number,String content,boolean save,String community,int type,Date time) throws SQLException,UnsupportedEncodingException,MalformedURLException,IOException
    {
        number = number.replaceAll(",",";").replaceAll("；",";").replaceAll(";;",";").replaceAll(" ","");

        tea.resource.Resource r = new tea.resource.Resource("tea/resource/SMS");
        SMSProfile sp = SMSProfile.find(member,community);

        //服务是否暂停
        if(!sp.isStates())
        {
            return r.getString(language,"ServiceStop");
        }

        int len = new StringTokenizer(number,";").countTokens();
        SMSMoney smsmoney = SMSMoney.find(member,community);
        // 余额是否够
        if(smsmoney == null || smsmoney.getBalance().compareTo(SMSMoney.SMS_PRICE.multiply(new BigDecimal(len))) < 0)
        {
            return r.getString(language,"BalanceLack");
        }
        // 是否过 有效期
        if(smsmoney.getEndtime().getTime() < System.currentTimeMillis())
        {
            return r.getString(language,"NoValidity");
        }

        content = content + sp.getSignature(language);

        if(content.length() > 60)
        {
            return "内容太长.";
        }
        System.out.println(number + ":" + content);

        SMSEnterCode sec = SMSEnterCode.find(community);
        //
        URL url = new URL("http://sms.redcome.com/servlet/SendSMS?fincode=" + sec.getCode() + "&finpassword=" + sec.getPassword() + "&subcode=" + sp.getCode() + "&subpassword=" + sp.getPassword() + "&tonumber=" + number + "&content=" + URLEncoder.encode(content,"UTF-8"));
        InputStream is = url.openStream();
        StringBuffer sb = new StringBuffer();
        int value;
        while((value = is.read()) != -1)
        {
            sb.append((char) value);
        }
        is.close();
        String rs[] = new String(sb.toString().getBytes("ISO-8859-1"),"UTF-8").split("/");
        //发送次数加一
        int hits = Integer.parseInt(rs[2]);
        smsmoney.setPayout(smsmoney.getPayout() + hits);
        if(save)
        {
            SMSMessage.create(sp.getCode(),number,content,type,time);
        }
        StringBuffer re = new StringBuffer();
        int error = Integer.parseInt(rs[0]);
        if(error != 0)
        {
            re.append("<br>描述:").append(rs[1]);
        }
        if(rs[3].length() > 0)
        {
            re.append("<br>发送成功:").append(hits).append("条");
            re.append("<br>失败的号:").append(rs[3]);
        } else
        {
            re.append("<br>发送成功");
        }
        return re.toString();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SMSMessage WHERE smsmessage=" + smsmessage);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(smsmessage));
    }

    public static void create(int subnumber,String mobile,String content,int type,Date time2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SMSMessage (subnumber,mobile,content,time,type,time2)VALUES(" + subnumber + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(content) + "," + db.citeCurTime() + "," + type + "," + db.cite(time2) + ")");
        } finally
        {
            db.close();
        }
    }

    public static String create(String community,String member,String mobile,int language,String content) throws SQLException
    {
        Filex.logs("yt_mobile.txt", "===========CREATE:"+community+","+member+","+mobile+","+content);
        Filex.logs("ytnotfp.txt", "测试发票短信是否收到===========CREATE:"+community+","+member+","+mobile+","+content);
        System.out.println("测试发票短信是否收到===========CREATE:"+community+","+member+","+mobile+","+content);
        mobile = mobile.replaceAll("[；;，]",",").replaceAll(" ","");
        mobile = mobile.replace("[", "");
        mobile = mobile.replace("]", "");
        Profile p = Profile.find(member);测试发票短信是否收到
        CommunityOption co = CommunityOption.find(community);
        //短信后缀
        /*String smssuffix = co.get("smssuffix");
        if(smssuffix != null)
        {
            if(smssuffix.equals("1")) //发送者姓名
                smssuffix = p.getName(language);
            content += " " + smssuffix;
        }*/
        int j = -1;

        String type = co.get("smstype");

        int  operator = 3;

        //String str = (String) Entity.open("http://chufa.lmobile.cn/submitdata/service.asmx/g_Submit?sname=" + co.get("cfuser") + "&spwd=" + co.get("cfpwd") + "&scorpid=&sprdid=1012808&sdst=" + mobile + "&smsg=" + java.net.URLEncoder.encode(content,"utf-8"));
        String mobileArr[] = mobile.split(",");
        for(int i=0;i<mobileArr.length;i++){
            //String str = (String) Entity.open("http://cf.lmobile.cn/submitdata/Service.asmx/g_Submit?sname=" + co.get("cfuser") + "&spwd=" + co.get("cfpwd") + "&scorpid=&sprdid=1012818&sdst=" + mobileArr[i].trim() + "&smsg=" + java.net.URLEncoder.encode(content,"utf-8"));
            /*String str = (String) Entity.open("http://cf.51welink.com/submitdata/Service.asmx/g_Submit?sname=" + co.get("cfuser") + "&spwd=" + co.get("cfpwd") + "&scorpid=&sprdid=1012818&sdst=" + mobileArr[i].trim() + "&smsg=" + java.net.URLEncoder.encode(content,"utf-8"));*/
            if(mobileArr[i].length()>0) {
                Map<String, String> map = new HashMap<String, String>();

                map.put("url", "https://openapi.miaodiyun.com/distributor/sendSMS");
                map.put("accountSid", "6998eca293f9ab9ae822a556dca9affc");
                map.put("authToken", "d22b144c1de959e4d3c72fbcd9df8d27");
                map.put("phone", mobileArr[i].trim());
//        map.put("templateid","247797");//短信验证码模板
//        map.put("templateid","251640");//短信验通知模板
                Random random = new Random();
                /*String code = String.valueOf(random.nextInt(1000000));*/
                String date = DateUtil.getDatetoString("yyyy-MM-dd HH:MM", new Date());

//        String param = "博鳌超级医院"+","+"任天赐"+","+date;
//        map.put("param",param);
                String smsContent = content;
                map.put("smsContent", "【中国同辐】" + smsContent);


                /*System.out.println("验证码为:"+code);*/

//        String data = getSendCodeMessage(map);
               String data = getSendNoticeMessage(map);
                System.out.println(data);
                JSONObject json = JSON.parseObject(data);
                if (json.getString("respCode").equals("0000")) {
                    System.out.println("发送成功");
                    DbAdapter db = new DbAdapter();
                    try {
                        db.executeUpdate("INSERT INTO SMSMessage(community,member,mobile,content,type,operator,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(mobileArr[i]) + "," + DbAdapter.cite(content + "成功") + ",0," + operator + "," + db.citeCurTime() + ")");
                    } finally {
                        db.close();
                    }
                } else {
                    System.out.println(json.getString("respDesc"));
                    DbAdapter db = new DbAdapter();
                    try {
                        db.executeUpdate("INSERT INTO SMSMessage(community,member,mobile,content,type,operator,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(mobileArr[i]) + "," + DbAdapter.cite(content + "失败") + ",0," + operator + "," + db.citeCurTime() + ")");
                    } finally {
                        db.close();
                    }
                }
                /*Filex.logs("sms.txt","发送："+mobile+"--"+mobileArr[i]+"\r\n内容："+content+"\r\n　　返回："+str);*/

            }


        }

        /*if(j == 0)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("INSERT INTO SMSMessage(community,member,mobile,content,type,operator,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(content) + ",0," + operator + "," + db.citeCurTime() + ")");
            } finally
            {
                db.close();
            }
        }*/
        Resource r = new Resource("/tea/resource/SMS");
        return r.getString(language,"Code." + type + "." + j);
    }

    public static void receive()
    {
        new Thread()
        {
            public void run()
            {
                while(true)
                {
                    try
                    {
                        Thread.sleep(5000L);
                        Enumeration e = CommunityOption.find("smstype","mas");
                        if(!e.hasMoreElements())
                            break;
                        while(e.hasMoreElements())
                        {
                            String community = (String) e.nextElement();
                            CommunityOption co = CommunityOption.find(community);
                            //db
                            Connection conn = DriverManager.getConnection("jdbc:mysql://" + co.get("masip") + ":3306/" + co.get("masdb") + "?useUnicode=true&characterEncoding=utf8",co.get("masuser"),co.get("maspwd"));
                            Statement db = conn.createStatement();
                            try
                            {
                                StringBuilder sb = new StringBuilder();
                                ResultSet rs = db.executeQuery("SELECT massmsid,extcode,sourceaddr,receivetime,messagecontent,msgfmt,requesttime,applicationid FROM sms_inbox WHERE applicationid=" + DbAdapter.cite(co.get("masid")));
                                while(rs.next())
                                {
                                    String smsid = rs.getString(1);
                                    String mobile = rs.getString(3);
                                    Date time = new Date(rs.getTimestamp(4).getTime());
                                    String str = rs.getString(5);
                                    sb.append(smsid + ",");
                                    //

                                }
                                db.executeUpdate("UPDATE sms_inbox SET applicationid=" + DbAdapter.cite(co.get("masid") + "_bak") + " WHERE massmsid IN(" + sb.toString() + "0)");
                                //db.executeUpdate("DELETE FROM sms_inbox WHERE massmsid IN(" + sb.toString() + "0)");
                            } catch(Exception ex)
                            {
                                ex.printStackTrace();
                            } finally
                            {
                                db.close();
                                conn.close();
                            }
//							APIClient handler = new APIClient();
//                            int j = handler.init(co.get("masip"),co.get("masuser"),co.get("maspwd"),co.get("masid"),co.get("masdb"));
//                            if(j != 0)
//                            {
//                                System.out.println("MAS: 初始化失败 " + j);
//                                Thread.sleep(10000L);
//                                continue;
//                            }
//                            MOItem[] mos = handler.receiveSM();
//                            if(mos == null)
//                            {
//                                System.out.println("MAS: 未初始化或接收失败");
//                                continue;
//                            }
//                            for(int i = 0;i < mos.length;i++)
//                            {
//                                Profile p = Profile.find((int) mos[i].getSmID());
//                                create(community,Profile.numtoid(mos[i].getMobile()),p.getMobile(),1,mos[i].getContent()); //自动回复
//                            }
                        }
                    } catch(SQLException ex)
                    {
                        System.out.println("接受短信：连接数据库出错");
                    } catch(Exception ex)
                    {
                        ex.printStackTrace();
                    }
                }
            }
        }.start();
    }

    public int getSmsmessage()
    {
        return smsmessage;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

    public boolean isExists()
    {
        return exists;
    }

    public static boolean isExists(int subnumber,Date time2,String mobile) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT subnumber FROM SMSMessage WHERE type=2 AND subnumber=" + subnumber + " AND time2<=" + db.cite(time2) + " AND mobile=" + DbAdapter.cite(mobile));
            return(db.next());
        } finally
        {
            db.close();
        }
    }

    public int getSubnumber()
    {
        return subnumber;
    }

    public int getType()
    {
        return type;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getMember()
    {
        return member;
    }

    public String getContent()
    {
        return content;
    }

    public String getCommunity()
    {
        return community;
    }

    public static String contentToHtml(TeaSession teasession,String name) throws SQLException
    {
        Resource r = new Resource("/tea/resource/SMS");
        CommunityOption obj = CommunityOption.find(teasession._strCommunity);
        String smscorp = obj.get("smscorp");
        if(smscorp == null)
        {
            smscorp = "";
        }
        String smssuffix = obj.get("smssuffix");
        if(smssuffix != null)
        {
            if(smssuffix.equals("1"))
            {
                Profile p = Profile.find(teasession._rv._strV);
                smssuffix = p.getName(teasession._nLanguage);
            }
            smscorp = " " + smssuffix + smscorp;
        }
        StringBuffer sb = new StringBuffer();
        sb.append("<textarea name='" + name + "' cols='50' rows='5'");
        if(name.equals("sms"))
        {
            sb.append(" disabled='true'");
        }
        sb.append(" onpropertychange='f_len(this)' oninput='f_len(this)'></textarea><br/>");
        //<!--每条短信长度-->
        //sb.append(r.getString(language, "1219725035420")).append(":<span id='smsc0' style='color:red'>" + smslen + "</span>　");
        //<!--短信条数-->
        sb.append(r.getString(teasession._nLanguage,"1172546424077")).append(":<span id='smsc1' style='color:red'>1</span>　");
        //<!--短信字数-->
        sb.append(r.getString(teasession._nLanguage,"1172746424077")).append(":<span id='smsc2' style='color:red'>0</span>　");
        sb.append(r.getString(teasession._nLanguage,"1234935952914")).append(":<span id='smsc3'> " + smscorp + "</span>　");
        sb.append("<script>");
        sb.append("function f_len(obj)");
        sb.append("{");
        sb.append("  var count=1;");
        sb.append("  var suf=smsc3.innerHTML.length;");
        sb.append("  var len=(obj?obj.value.length:0)+suf;");
        sb.append("  var sum=70;");
        sb.append("  if(len>sum){  count=parseInt(len/65); if(len%65!=0)count++; sum=count*65;  }");
        sb.append("  smsc1.innerHTML=count;");
        sb.append("  smsc2.innerHTML=len;"); //(len-suf)+'/'+(sum-suf)
        sb.append("}f_len();");
        sb.append("</script>");
        return sb.toString();
    }

    public static void main(String args[]) throws SQLException
    {
        /*SMSMessage.create("roadbridge","webmaster","15010",1,"测试中文...");*/
    	 String rs = SMSMessage.create("redcome2007","webmaster","15010780215",1,"1111");
    	  System.out.println(rs);
    }

    public static String getSendNoticeMessage (Map<String,String> map ){
        map.put("respDataType","JSON");//响应数据类型，JSON 或 XML 格式。默认为JSON
//        accountSid	必填	开发者主账号（ACCOUNT SID）。开发者账号唯一标识符
//        map.put("templateid	",map.get("templateid"));//可选	模板ID，和短信内容必传一个
//        String  smsContent = "您正在注册SP平台，验证码为"+map.get("code")+"，该验证码5分钟有效，请勿泄露他人。";
//        map.put("smsContent","JSON");//	可选	短信内容，和模板ID必传一个
        map.put("to",map.get("phone"));//	必填	发送手机号，多个手机号，用英文逗号隔开
        // 时间戳
        long timestamp = System.currentTimeMillis();
        map.put("timestamp",String.valueOf(timestamp));//	必填	时间戳(毫秒)，格式：1547005945480
        // 签名
//        String sig = DigestUtils.md5Digest(map.get("accountSid") + "" + timestamp);

        String sig = DigestUtils.md5Hex((map.get("accountSid")+map.get("authToken")+timestamp));
        map.put("sig",sig);//	必填	签名：MD5(ACCOUNT SID + AUTH TOKEN + timestamp)。共32位（小写）
        //        expandId	可选	短信扩展号
        //        param	可选	短信变量，多个变量用英文逗号隔开
        //        subCode	可选	中转子码
        //        accountId	可选	子账号ID
        map.put("smsType","100000");//	可选	短信类型（100000：验证码通知，100003：会员营销）
        String url = (String) map.get("url");
        map.remove("url");
        map.remove("authToken");
        map.remove("code");
        String body = createSign(map);
        String returnData = HttpUtil.post(url,body);
        return returnData;
    }

    public static String createSign(Map<String,String> parameters){
        List<String> keys = new ArrayList<String>(parameters.keySet());
        Collections.sort(keys);
        String prestr = "";
        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            if (!key.equals("key")){
                String value = parameters.get(key);
                if (i == keys.size() - 1) {//拼接时，不包括最后一个&字符
                    prestr = prestr + key + "=" + value;
                } else {
                    prestr = prestr + key + "=" + value + "&";
                }
            }

        }
        return prestr;
    }

}
