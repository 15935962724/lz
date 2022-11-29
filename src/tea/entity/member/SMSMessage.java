package tea.entity.member;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Entity;
import tea.entity.Filex;
import tea.entity.site.CommunityOption;
import tea.entity.site.SMSEnterCode;
import tea.resource.Resource;
import tea.ui.TeaSession;

public class SMSMessage extends Entity
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
        Profile p = Profile.find(member);
        CommunityOption co = CommunityOption.find(community);
        //短信后缀
        String smssuffix = co.get("smssuffix");
        if(smssuffix != null)
        {
            if(smssuffix.equals("1")) //发送者姓名
                smssuffix = p.getName(language);
            content += " " + smssuffix;
        }
        int j = -1;
        int operator = 0;
        String type = co.get("smstype");
        if("netarc".equals(type))
        {
            operator = 1;
            try
            {
                // InputStream is = new URL("http://sms.netarc.cn/smsComputer/smsComputersend.asp?zh=" + co.get("smsuser") + "&mm=" + co.get("smspwd") + "&hm=" + mobile + "&nr=" + java.net.URLEncoder.encode(content,"GBK")).openStream();
                InputStream is = new URL("http://122.224.34.164:8080/smsComputer/smsComputersend.asp?zh=" + co.get("smsuser") + "&mm=" + co.get("smspwd") + "&hm=" + mobile + "&nr=" + java.net.URLEncoder.encode(content,"GBK") + "&dxlbid=19").openStream(); //接受快的dxlbid=19 dxlbid=3
                System.out.println("http://122.224.34.164:8080/smsComputer/smsComputersend.asp?zh=" + co.get("smsuser") + "&mm=" + co.get("smspwd") + "&hm=" + mobile + "&nr=" + java.net.URLEncoder.encode(content,"GBK") + "&dxlbid=19");

                j = is.read() - '0';
                is.close();
            } catch(IOException ex)
            {
                ex.printStackTrace();
            }
        } else if("mas".equals(type))
        {
            operator = 2;
//            APIClient handler = new APIClient();
//            j = handler.init(co.get("masip"),co.get("masuser"),co.get("maspwd"),co.get("masid"),co.get("masdb"));
//            System.out.println("初始化MAS:" + j);
//            if(j == 0)
//            {
//                int srcid = p.getProfile();
//                j = handler.sendSM(mobile.split(","),content,0L,srcid);
//            }
            try
            {
                Connection conn = DriverManager.getConnection("jdbc:mysql://" + co.get("masip") + ":3306/" + co.get("masdb") + "?useUnicode=true&characterEncoding=utf8",co.get("masuser"),co.get("maspwd"));
                Statement db = conn.createStatement();
                db.executeUpdate("INSERT INTO sms_outbox(sismsid,extcode,destaddr,messagecontent,reqdeliveryreport,msgfmt,sendmethod,requesttime,applicationid)VALUES("
                                 + "'" + System.currentTimeMillis() + "'" //UUID/GUID
                                 + ",'0'" //扩展码，指由该应用填写的内部扩展号码
                                 + "," + DbAdapter.cite(mobile.replace(',',';')) //接受手机,多个用“;”分号分割,最大不超过50个手机号码。
                                 + "," + DbAdapter.cite(content) //短信内容
                                 + ",1" //是否需要状态报告 0:不需要 1:需要
                                 + ",15" //消息类型 0-ASCII 4-Binary 8-usc2 15-gb2312 16-gb18030
                                 + ",0" //0-普通短信 1-普通短信立即显示 2-长短信组包 3-带结构短信
                                 + "," + DbAdapter.cite(new Date()) //发送时间
                                 + "," + DbAdapter.cite(co.get("masid")) //EC/SI应用的ID，即应用ID或插件的ID
                                 + ")");
                db.close();
                conn.close();
                j = 0;
            } catch(Exception ex)
            {
                ex.printStackTrace();
            }
        } else if("chufa".equals(type))
        {
            operator = 3;
            try
            {
				//String str = (String) Entity.open("http://chufa.lmobile.cn/submitdata/service.asmx/g_Submit?sname=" + co.get("cfuser") + "&spwd=" + co.get("cfpwd") + "&scorpid=&sprdid=1012808&sdst=" + mobile + "&smsg=" + java.net.URLEncoder.encode(content,"utf-8"));
            	String mobileArr[] = mobile.split(",");
            	for(int i=0;i<mobileArr.length;i++){
                    ArrayList arrayList = Profile.find1(" AND mobile=" + Database.cite(mobileArr[i].trim()) + " AND locking=1 ", 0, Integer.MAX_VALUE);
                    if(arrayList.size()>0){//手机号被锁了
                        Filex.logs("noSend.txt", mobileArr[i].trim()+" 被锁了");
                        return "";
                    }
					//String str = (String) Entity.open("http://cf.lmobile.cn/submitdata/Service.asmx/g_Submit?sname=" + co.get("cfuser") + "&spwd=" + co.get("cfpwd") + "&scorpid=&sprdid=1012818&sdst=" + mobileArr[i].trim() + "&smsg=" + java.net.URLEncoder.encode(content,"utf-8"));
					String str = (String) Entity.open("http://cf.51welink.com/submitdata/Service.asmx/g_Submit?sname=" + co.get("cfuser") + "&spwd=" + co.get("cfpwd") + "&scorpid=&sprdid=1012818&sdst=" + mobileArr[i].trim() + "&smsg=" + java.net.URLEncoder.encode(content,"utf-8"));
					Filex.logs("sms.txt","发送："+mobile+"--"+mobileArr[i]+"\r\n内容："+content+"\r\n　　返回："+str);
	                if(str.indexOf("<State>0</State>") == -1)
	                {
	                    Matcher m = Pattern.compile("<MsgState>(.+)</MsgState>").matcher(str);
	                    return m.find() ? m.group(1) : str;
	                }
	                j = 0;
	                if(j == 0)
	                {
	                    DbAdapter db = new DbAdapter();
	                    try
	                    {
	                        db.executeUpdate("INSERT INTO SMSMessage(community,member,mobile,content,type,operator,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(mobileArr[i]) + "," + DbAdapter.cite(content) + ",0," + operator + "," + db.citeCurTime() + ")");
	                    } finally
	                    {
	                        db.close();
	                    }
	                }
            	}
            } catch(IOException ex)
            {
                ex.printStackTrace();
            }
        } else if("trio".equals(type)) //60105022828
        {
            operator = 4;
            content = "RM0.00 " + content;
            StringBuilder sb = new StringBuilder(content.length() * 4);
            for(int i = 0;i < content.length();i++)
            {
                String v = Integer.toHexString(content.charAt(i)).toUpperCase();
                if(v.length() == 1)
                    sb.append("000");
                else if(v.length() == 2)
                    sb.append("00");
                else if(v.length() == 3)
                    sb.append("0");
                sb.append(v);
            }
            //
            try
            {
                HttpURLConnection conn = (HttpURLConnection)new URL("http://gateway.trio-mobile.com:81/cpm_i.aspx").openConnection();
                conn.setDoOutput(false);
                conn.setRequestMethod("GET");
                conn.setRequestProperty("trx_id","0");
                conn.setRequestProperty("passname",URLEncoder.encode(co.get("triouser"),"GBK"));
                conn.setRequestProperty("password",URLEncoder.encode(co.get("triopwd"),"GBK"));
                conn.setRequestProperty("short_code","36828");
                conn.setRequestProperty("originating_no","golf");
                conn.setRequestProperty("destination_no",mobile);
                conn.setRequestProperty("cp_ref_id","0");
                conn.setRequestProperty("bill_type","0");
                conn.setRequestProperty("bill_price","0");
                conn.setRequestProperty("content_type","2");
                conn.setRequestProperty("msg",URLEncoder.encode(sb.toString(),"GBK"));
                conn.setRequestProperty("bulk_fg","1");
                conn.connect();
                int code = conn.getResponseCode();
                System.out.println("trio-mobile code :" + code);
                j = Integer.parseInt(conn.getHeaderField("result"));
                System.out.println("trio-mobile result :" + j);
                if(j > 0)
                    j = 0;
                conn.disconnect();
            } catch(Exception ex)
            {
                ex.printStackTrace();
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

    /*
    * 到期短信 sendType  医院到期 1  厂商到期 2
    * */
    public static void sendExpireMessage(String community,String member,String mobile,int language,String content,int sendType) throws SQLException
    {
        Filex.logs("ExpireMessage.txt", "===========CREATE:"+community+","+member+","+mobile+","+content);
        CommunityOption co = CommunityOption.find(community);
        //短信后缀
        String smssuffix = co.get("smssuffix");
        if(smssuffix != null)
        {
            content += " " + smssuffix;
        }
        int operator = 3;
        String type = co.get("smstype");
            try {
                    String str = (String) Entity.open("http://cf.51welink.com/submitdata/Service.asmx/g_Submit?sname=" + co.get("cfuser") + "&spwd=" + co.get("cfpwd") + "&scorpid=&sprdid=1012818&sdst=" + mobile + "&smsg=" + java.net.URLEncoder.encode(content,"utf-8"));
                    Filex.logs("Expiresms.txt","发送："+mobile+"--\r\n内容："+content+"\r\n　　返回："+str);
                    DbAdapter db = new DbAdapter();
                    try {
                        db.executeUpdate("INSERT INTO SMSMessage(community,member,mobile,content,type,operator,time,subnumber)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(content) + ",0," + operator + "," + db.citeCurTime() + ","+sendType+")");
                    } finally {
                        db.close();
                    }
            } catch(IOException ex)
            {
                ex.printStackTrace();
            }
    }
}
