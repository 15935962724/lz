package tea.entity.weixin;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import java.util.regex.*;

import org.json.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.util.*;

public class WeiXin
{
    static
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Profile SET deleted=0 WHERE deleted IS NULL");
            db.executeUpdate("sp_rename 'WeiXin.welcome','welcome0'");
            for(int i = 0;i < 3;i++)
                db.executeUpdate("UPDATE weixin SET welcome" + i + "='您好，欢迎关注我们，后续有精彩内容会第一时间发给您。' WHERE welcome" + i + " IS NULL");
        } catch(Throwable ex)
        {} finally
        {
            db.close();
        }
    }

    protected static Cache c = new Cache(50);
    public String community; //社区
    public int[] wtype = new int[3]; //没用到
    public String[] welcome =
            {"您好，欢迎关注我们，后续有精彩内容会第一时间发给您。","您好，欢迎关注我们，后续有精彩内容会第一时间发给您。","您好，欢迎关注我们，后续有精彩内容会第一时间发给您。"}; //欢迎语
    public String notfound = "如没有及时回复，请留下你的意见，我们会第一时间处理，谢谢！"; //未找到
    public static final String[] USER_TYPE =
            {"订阅号","服务号","企业号"};
    public String[] userid = new String[3]; //原始ID,账号的openid
    //
    public String[] user = new String[3]; //微信用户
    public String[] password = new String[3]; //微信密码
    public String[] cookie = new String[3]; //微信Cookie
    public int[] token = new int[3]; //微信令牌
    public String[] ticket = new String[3];
    //
    public String[] appid = new String[3]; //App key
    public String[] appsecret = new String[3]; //App Secret
    public String[] apptoken = new String[3]; //access_token,有效期:2小时
    public String partnerid; //商户号
    public String partnerkey; //商户密钥
    public String paysignkey; //支付专用签名
    public WeiXin(String community)
    {
        this.community = community;
    }

    public static WeiXin find(String community) throws SQLException
    {
        WeiXin t = (WeiXin) c.get(community);
        if(t == null)
        {
            ArrayList al = find(" AND community=" + DbAdapter.cite(community),0,1);
            t = al.size() < 1 ? new WeiXin(community) : (WeiXin) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT community,wtype0,wtype1,wtype2,welcome0,welcome1,welcome2,notfound,userid0,userid1,userid2,user0,user1,user2,password0,password1,password2,cookie0,cookie1,cookie2,token0,token1,token2,ticket0,ticket1,ticket2,appid0,appid1,appid2,appsecret0,appsecret1,appsecret2,apptoken0,apptoken1,apptoken2,partnerid,partnerkey,paysignkey FROM weixin WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WeiXin t = new WeiXin(rs.getString(i++));
                t.wtype[0] = rs.getInt(i++);
                t.wtype[1] = rs.getInt(i++);
                t.wtype[2] = rs.getInt(i++);
                t.welcome[0] = rs.getString(i++);
                t.welcome[1] = rs.getString(i++);
                t.welcome[2] = rs.getString(i++);
                t.notfound = rs.getString(i++);
                t.userid[0] = rs.getString(i++);
                t.userid[1] = rs.getString(i++);
                t.userid[2] = rs.getString(i++);
                t.user[0] = rs.getString(i++);
                t.user[1] = rs.getString(i++);
                t.user[2] = rs.getString(i++);
                t.password[0] = rs.getString(i++);
                t.password[1] = rs.getString(i++);
                t.password[2] = rs.getString(i++);
                t.cookie[0] = rs.getString(i++);
                t.cookie[1] = rs.getString(i++);
                t.cookie[2] = rs.getString(i++);
                t.token[0] = rs.getInt(i++);
                t.token[1] = rs.getInt(i++);
                t.token[2] = rs.getInt(i++);
                t.ticket[0] = rs.getString(i++);
                t.ticket[1] = rs.getString(i++);
                t.ticket[2] = rs.getString(i++);
                t.appid[0] = rs.getString(i++);
                t.appid[1] = rs.getString(i++);
                t.appid[2] = rs.getString(i++);
                t.appsecret[0] = rs.getString(i++);
                t.appsecret[1] = rs.getString(i++);
                t.appsecret[2] = rs.getString(i++);
                t.apptoken[0] = rs.getString(i++);
                t.apptoken[1] = rs.getString(i++);
                t.apptoken[2] = rs.getString(i++);
                t.partnerid = rs.getString(i++);
                t.partnerkey = rs.getString(i++);
                t.paysignkey = rs.getString(i++);
                c.put(t.community,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM weixin WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql = "UPDATE weixin SET wtype0=" + wtype[0] + ",wtype1=" + wtype[1] + ",wtype2=" + wtype[2] + ",welcome0=" + DbAdapter.cite(welcome[0]) + ",welcome1=" + DbAdapter.cite(welcome[1]) + ",welcome2=" + DbAdapter.cite(welcome[2]) + ",notfound=" + DbAdapter.cite(notfound)
                     + ",userid0=" + DbAdapter.cite(userid[0]) + ",userid1=" + DbAdapter.cite(userid[1]) + ",userid2=" + DbAdapter.cite(userid[2])
                     + ",user0=" + DbAdapter.cite(user[0]) + ",user1=" + DbAdapter.cite(user[1]) + ",user2=" + DbAdapter.cite(user[2])
                     + ",password0=" + DbAdapter.cite(password[0]) + ",password1=" + DbAdapter.cite(password[1]) + ",password2=" + DbAdapter.cite(password[2])
                     + ",cookie0=" + DbAdapter.cite(cookie[0]) + ",cookie1=" + DbAdapter.cite(cookie[1]) + ",cookie2=" + DbAdapter.cite(cookie[2])
                     + ",token0=" + token[0] + ",token1=" + token[1] + ",token2=" + token[2] + ",ticket0=" + DbAdapter.cite(ticket[0]) + ",ticket1=" + DbAdapter.cite(ticket[1]) + ",ticket2=" + DbAdapter.cite(ticket[2])
                     + ",appid0=" + DbAdapter.cite(appid[0]) + ",appid1=" + DbAdapter.cite(appid[1]) + ",appid2=" + DbAdapter.cite(appid[2])
                     + ",appsecret0=" + DbAdapter.cite(appsecret[0]) + ",appsecret1=" + DbAdapter.cite(appsecret[1]) + ",appsecret2=" + DbAdapter.cite(appsecret[2])
                     + ",apptoken0=" + DbAdapter.cite(apptoken[0]) + ",apptoken1=" + DbAdapter.cite(apptoken[1]) + ",apptoken2=" + DbAdapter.cite(apptoken[2])
                     + ",partnerid=" + DbAdapter.cite(partnerid) + ",partnerkey=" + DbAdapter.cite(partnerkey) + ",paysignkey=" + DbAdapter.cite(paysignkey) + " WHERE community=" + DbAdapter.cite(community);
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(0,sql);
            if(j < 1)
                db.executeUpdate(0,
                                 "INSERT INTO weixin(community,wtype0,wtype1,wtype2,welcome0,welcome1,welcome2,notfound,userid0,userid1,userid2,user0,user1,user2,password0,password1,password2,cookie0,cookie1,cookie2,token0,token1,token2,ticket0,ticket1,ticket2,appid0,appid1,appid2,appsecret0,appsecret1,appsecret2,apptoken0,apptoken1,apptoken2,partnerid,partnerkey,paysignkey)VALUES(" +
                                 DbAdapter.cite(community) + "," + wtype[0] + "," + wtype[1] + "," + wtype[2] + "," + DbAdapter.cite(welcome[0]) + "," + DbAdapter.cite(welcome[1]) + "," + DbAdapter.cite(welcome[2]) + "," + DbAdapter.cite(notfound) + "," +
                                 DbAdapter.cite(userid[0]) + "," + DbAdapter.cite(userid[1]) + "," + DbAdapter.cite(userid[2]) + "," +
                                 DbAdapter.cite(user[0]) + "," + DbAdapter.cite(user[1]) + "," + DbAdapter.cite(user[2]) + "," + DbAdapter.cite(password[0]) + "," + DbAdapter.cite(password[1]) + "," +
                                 DbAdapter.cite(password[2]) + "," + DbAdapter.cite(cookie[0]) + "," + DbAdapter.cite(cookie[1]) + "," + DbAdapter.cite(cookie[2]) + "," + token[0] + "," + token[1] + "," + token[2] + "," +
                                 DbAdapter.cite(ticket[0]) + "," + DbAdapter.cite(ticket[1]) + "," + DbAdapter.cite(ticket[2]) + "," + DbAdapter.cite(appid[0]) + "," + DbAdapter.cite(appid[1]) + "," + DbAdapter.cite(appid[2]) + "," + DbAdapter.cite(appsecret[0]) + "," + DbAdapter.cite(appsecret[1]) + "," + DbAdapter.cite(appsecret[2]) + "," +
                                 DbAdapter.cite(apptoken[0]) + "," + DbAdapter.cite(apptoken[1]) + "," + DbAdapter.cite(apptoken[2]) + "," + DbAdapter.cite(partnerid) + "," + DbAdapter.cite(partnerkey) + "," + DbAdapter.cite(paysignkey) + ")");
        } finally
        {
            db.close();
        }
        c.remove(community);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"DELETE FROM weixin WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        c.remove(community);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"UPDATE weixin SET " + f + "=" + DbAdapter.cite(v) + " WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        c.remove(community);
    }

    //上传媒体文件
    public String upload(int i,String file) throws SQLException,JSONException,IOException
    {
        String type = file.substring(file.lastIndexOf(".") + 1);
        if("jpg".contains(type))
            type = "image";
        else if("amr|mp3".contains(type))
            type = "voice";
        else if("mp4".contains(type))
            type = "video";
        else
            type = "file";
        file = Http.enc(Http.REAL_PATH + file);
        JSONObject jo = api(i,"media/upload?type=" + type,"media=file://" + file);
        int err = jo.isNull("errcode") ? 0 : jo.getInt("errcode");
        if(err == 40005) //无效文件类型，微信校验文件内容
        {
            type = "file";
            jo = api(i,"media/upload?type=" + type,"media=file://" + file);
        }
        return jo.isNull("media_id") ? null : jo.getString("media_id");
    }

    //上传图片
    //https://mp.weixin.qq.com/cgi-bin/getimgdata?mode=large&source=file&fileId=200092999&token=111083507&lang=zh_CN
    public int filetransfer(int i,String pic) throws IOException,SQLException,JSONException
    {
        File f = null;
        if(pic.contains("://"))
        {
            byte[] by = (byte[]) Http.open(pic,null);
            if(by == null || by.length < 1)
                return 0;
            f = File.createTempFile("wx_",".jpg");
            Filex.write(pic = f.getPath(),by);
        }
        Object t = (Object) Http.open("https://mp.weixin.qq.com/cgi-bin/filetransfer?action=upload_material&f=json&writetype=doublewrite&groupid=1&ticket_id=" + user[i] + "&ticket=" + ticket[i] + "&token=" + token[i] + "&lang=zh_CN",cookie[i],"Filename=jjjj.jpg&folder=/cgi-bin/uploads&file=file://" + Http.enc(pic) + "&Upload=Submit Query")[1];
        Filex.logs("WeiXin.txt","上传图片：" + pic + "　返回：" + t);
        JSONObject ja = new JSONObject(t.toString());
        int ret = ja.getJSONObject("base_resp").getInt("ret");
        if((ret == -2 || ret == -18) && login(i,null) == null) //{"base_resp":{"ret":-18,"err_msg":"redis ticket invalid"}}
        {
            return filetransfer(i,pic);
        }
        if(f != null)
            f.delete();
        return ja.getInt("content"); //{"base_resp":{"ret":0,"err_msg":"ok"},"location":"bizfile","type":"image","content":"200093011"}
    }

    String sig; //验证码的Cookie
    public String login(int i,String verify) throws IOException,SQLException
    {
        Object[] arr = open(i,"login?lang=zh_CN","&username=" + Http.enc(user[i]) + "&pwd=" + Enc.MD5(password[i]) + "&imgcode=" + verify + "&f=json");
        try
        {
            JSONObject jo = new JSONObject((String) arr[1]);
            JSONObject base = jo.getJSONObject("base_resp");
            int err = base.getInt("ret");
            //{"Ret": 400,"ErrMsg": "","ShowVerifyCode": 0,"ErrCode": -6}
            //{"base_resp":{"ret":-23,"err_msg":"acct\/password error"}}
            if(err == -8 || err == -27) //需要输入验证码
            {
                arr = (Object[]) open(i,"verifycode?username=" + Http.enc(user[i]) + "&r=" + System.currentTimeMillis(),null);
                sig = (String) arr[0];
                Filex.write(Http.REAL_PATH + "/res/" + community + "/verify.jpg",(byte[]) arr[1]);
                return "-8";
            }
            if(err != 0)
            {
                String[] errs =
                        {"","系统错误。","帐号或密码错误","密码错误。","不存在该帐户。","访问受限。","需要输入验证码","此帐号已绑定私人微信号，不可用于公众平台登录。","邮箱已存在。"};
                return err + "：" + base.getString("err_msg");
            }
            cookie[i] = (String) arr[0];
            //{"Ret": 302,"ErrMsg": "/cgi-bin/home?t=home/index&lang=zh_CN&token=73950239","ShowVerifyCode": 0,"ErrCode": 0}
            //{"base_resp":{"ret":0,"err_msg":"ok"},"redirect_url":"\/cgi-bin\/home?t=home\/index&lang=zh_CN&token=1933820220"}
            String url = jo.getString("redirect_url");
            Filex.logs("qdr.txt", "--"+url);
            token[i] = Integer.parseInt(url.substring(url.lastIndexOf("&token=") + 7));
            //
            String htm = (String) open(i,"settingpage?t=setting/index&action=index",null)[1];
            Matcher m = Pattern.compile(">(gh_[^<]+)<").matcher(htm);
            if(m.find())
                userid[i] = m.group(1);
            int j = htm.indexOf("data:{") + 5;
            htm = htm.substring(j,htm.indexOf('}',j) + 1).replace('\'','"').replaceAll("\",\"|\\.join\\(\"\"\\)|\\|\\|new Date\\(\\)\\.getTime\\(\\)/1000","");
            jo = new JSONObject(htm);
            user[i] = jo.getString("user_name");
            ticket[i] = jo.getString("ticket");
        } catch(Throwable ex)
        {
            ex.printStackTrace();
            return ex.toString();
        }
        set();
        return null;
    }

    public Object[] open(int i,String act,String data) throws SQLException,IOException
    {
        if(data != null)
            data += "&token=" + token[i];
        else
            act += "&token=" + token[i];
        Filex.logs("WeiXin.log",act + "　参数：" + data);
        Object[] obj = Http.open("https://mp.weixin.qq.com/cgi-bin/" + act,cookie[i] + sig,data);
        if((obj[1] instanceof String))
        {
            String htm = ((String) obj[1]);
            if(htm.startsWith("{\"base_resp\":{\"ret\":"))
            {
                Filex.logs("WeiXin.log","　　返回：" + htm);
                try
                {
                    JSONObject base = new JSONObject(htm).getJSONObject("base_resp");
                    int err = base.getInt("ret");
                    if(err == -1) //{"base_resp":{"ret":-1,"err_msg":"system error"}}
                    {
                        Thread.sleep(1000);
                        return open(i,act,data);
                    }
                } catch(Throwable ex)
                {
                    ex.printStackTrace();
                }
            }
            if((htm.contains("page_timeout") || htm.contains("Request is denied!")) && login(i,null) == null) //{"ret":"-20000", "msg":"Request is denied! "}
                return open(i,act,data);
        }
        return obj;
    }

    public JSONObject api(int i,String act,String par) throws IOException,JSONException,SQLException
    {
        if(MT.f(apptoken[i]).length() < 1)
        {
            JSONObject js = new JSONObject((String) Http.open(i == 2 ? "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=" + appid[i] + "&corpsecret=" + appsecret[i] : "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appid[i] + "&secret=" + appsecret[i],null));
            if(js.isNull("access_token")) //{"errcode":40013,"errmsg":"invalid appid"},{"errmsg":"user limited","errcode":50002}
                return js;
            set("apptoken" + i,apptoken[i] = js.getString("access_token"));
        }
        if(!act.startsWith("pay/") && !act.startsWith("cgi-bin/"))
            act = "cgi-bin/" + act;
        String url = "https://" + (i == 2 ? "qyapi" : "api") + ".weixin.qq.com/" + act + (act.contains("?") ? '&' : '?') + "access_token=" + apptoken[i];
        Object obj = Http.open(url,null,par)[1];
        if(obj == null)
            obj = "{errcode:-1,errmsg:\"NullPointerException\"}";
        String str = obj instanceof String ? (String) obj : new String((byte[]) obj);
        Filex.logs("WeiXin.txt","\n  请求:" + url + "\n  数据:" + par + "\n  返回:" + str);
        JSONObject js = new JSONObject(str);
        int err = js.isNull("errcode") ? 0 : js.getInt("errcode");
        if(err == 40001 || err == 42001) //无效 || 超时
        {
            apptoken[i] = null;
            return api(i,act,par);
        }
        return js;
    }

    //支付
    public String getPaySign(String trade,String body,float total,String ip,String notifyUrl) throws UnsupportedEncodingException
    {
        String nonceStr = "WeiXin" + tea.entity.util.SCA.random();
        long timeStamp = System.currentTimeMillis() / 1000;
        String par = "bank_type=WX&body=" + body.replace('&','＆') + "&fee_type=1&input_charset=UTF-8&notify_url=" + notifyUrl + "&out_trade_no=" + trade + "&partner=" + partnerid + "&spbill_create_ip=" + ip + "&total_fee=" + (int) (total * 100);
        //扩展包
        String pack = Http.enc(par).replaceAll("%26","&").replaceAll("%3D","=") + "&sign=" + Enc.MD5((par + "&key=" + partnerkey).getBytes("UTF-8")).toUpperCase();
        //微信签名
        String paySign = Enc.SHA1("appid=" + appid[1] + "&appkey=" + paysignkey + "&noncestr=" + nonceStr + "&package=" + pack + "&timestamp=" + timeStamp);
        StringBuilder sb = new StringBuilder();
        sb.append("{appId:\"" + appid[1]); //公众号ID
        sb.append("\",timeStamp:\"" + timeStamp); //时间戳
        sb.append("\",nonceStr:\"" + nonceStr); //随机串
        sb.append("\",package:\"" + pack); //扩展包
        sb.append("\",signType:\"" + "SHA1"); //微信签名方式:1.sha1
        sb.append("\",paySign:\"" + paySign); //微信签名
        sb.append("\"}");
        return sb.toString();
    }

    /**
     *
     * @param trade 订单号
     * @param body 商品名称
     * @param total 总价
     * @param ip 客户端IP地址
     * @param notifyUrl 通知地址
     * @param openid 用户标识，存在：手机版支付，null：电脑版支付
     * @return String
     */
    public String getPaySign(String trade,String body,float total,String ip,String notifyUrl,String openid) throws Exception
    {
        String type = "NATIVE",nonceStr = "WeiXin" + tea.entity.util.SCA.random();
        long timeStamp = System.currentTimeMillis() / 1000;
        //签名
        String par = "appid=" + appid[1] + "&body=" + body + "&mch_id=" + partnerid + "&nonce_str=" + nonceStr + "&notify_url=" + notifyUrl;
        if(openid != null) //文档:网页支付此参必传，测试:不传也通过
        {
            par += "&openid=" + openid;
            type = "JSAPI";
        }
        par += "&out_trade_no=" + trade + "&spbill_create_ip=" + ip + "&total_fee=" + (int) (total * 100) + "&trade_type=" + type + "&key=" + partnerkey;

        par = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<xml><appid>" + appid[1] + "</appid><mch_id>" + partnerid + "</mch_id><nonce_str>" + nonceStr + "</nonce_str><sign>" + Enc.MD5((par).getBytes("UTF-8")).toUpperCase() + "</sign><body><![CDATA[" + body + "]]></body>";
        if(openid != null)
            par += "<openid>" + openid + "</openid>";
        par += "<out_trade_no>" + trade + "</out_trade_no><total_fee>" + (int) (total * 100) + "</total_fee><spbill_create_ip>" + ip + "</spbill_create_ip><notify_url>" + notifyUrl + "</notify_url><trade_type>" + type + "</trade_type></xml>";

        //统一下单
        String htm = new String((byte[]) Http.open("https://api.mch.weixin.qq.com/pay/unifiedorder",null,par)[1],"utf-8");
        Filex.logs("WeiXin_pay.txt","请求:" + par + "\n返回:" + htm);
        XMLObject xml = new XMLObject(htm).getXMLObject("xml");
        if(!"SUCCESS".equals(xml.getString("result_code")))
            return xml.getString("return_msg") + "　" + xml.getString("err_code_des");
        //
        if("NATIVE".equals(type))
            return xml.getString("code_url");
        String pack = "prepay_id=" + xml.getString("prepay_id"); //扩展包

        //签名
        par = "appId=" + appid[1] + "&nonceStr=" + nonceStr + "&package=" + pack + "&signType=MD5&timeStamp=" + timeStamp + "&key=" + partnerkey;

        StringBuilder sb = new StringBuilder();
        sb.append("{appId:\"" + appid[1]); //公众号ID
        sb.append("\",nonceStr:\"" + nonceStr); //随机串
        sb.append("\",package:\"" + pack); //扩展包
        sb.append("\",signType:\"" + "MD5"); //微信签名方式
        sb.append("\",timeStamp:\"" + timeStamp); //时间戳
        sb.append("\",paySign:\"" + Enc.MD5(par).toUpperCase()); //微信签名
        sb.append("\"}");
        return sb.toString();
    }

    //收货地址
    public String getAddrSign()
    {
        String nonceStr = "WeiXin" + tea.entity.util.SCA.random();
        long timeStamp = System.currentTimeMillis() / 1000;
        String par = "accesstoken=" + apptoken[1] + "&appId=" + appid[1] + "&noncestr=" + nonceStr + "&timestamp=" + timeStamp + "&url=http://192.168.2.87/test/defend.jsp";
        StringBuilder sb = new StringBuilder();
        sb.append("{appId:\"" + appid[1]);
        sb.append("\",timeStamp:\"" + timeStamp);
        sb.append("\",nonceStr:\"" + nonceStr);
        sb.append("\",signType:\"" + "SHA1");
        sb.append("\",scope:\"" + "jsapi_address");
        sb.append("\",addrSign:\"" + Enc.SHA1(par));
        sb.append("\"}");
        return sb.toString();
    }

    public static String f(HashMap hm)
    {
        String[] arr = new String[hm.size()];
        Iterator it = hm.keySet().iterator();
        for(int i = 0;it.hasNext();i++)
        {
            String name = (String) it.next();
            arr[i] = "sign".equals(name) ? "" : "&" + name + "=" + hm.get(name);
        }
        Arrays.sort(arr);

        StringBuilder sb = new StringBuilder();
        for(int i = 0;i < arr.length;i++)
        {
            sb.append(arr[i]);
        }
        return sb.substring(1);
    }

    //发货通知
    public JSONObject delivernotify(String openid,String out_trade_no,String transid,boolean deliver_status,String deliver_msg) throws SQLException,JSONException,IOException
    {
        StringBuilder sb = new StringBuilder();
        deliver_msg = Http.enc(deliver_msg);
        //String deliver_msg = Http.enc("我叫小刘");
        //int deliver_status = 1;
        long deliver_timestamp = new Date().getTime() / 1000;
        //String openid = "okKB3jpmf8cMfZfeswTK_TbJVmDw";
        //String out_trade_no = "GOLF-1403070115703";
        //String transid = "1219120401201406183256295878";
        String str = Enc.SHA1("appid=" + appid[1] + "&appkey=" + paysignkey + "&deliver_msg=" + deliver_msg + "&deliver_status=" + (deliver_status ? 1 : 0) + "&deliver_timestamp=" + deliver_timestamp + "&openid=" + openid + "&out_trade_no=" + out_trade_no + "&transid=" + transid);

        HashMap hm = new HashMap();
        hm.put("appid",appid[1]);
        hm.put("openid",openid);
        hm.put("transid",transid);
        hm.put("out_trade_no",out_trade_no);
        hm.put("deliver_timestamp",deliver_timestamp);
        hm.put("deliver_status",(deliver_status ? 1 : 0));
        hm.put("deliver_msg",deliver_msg);
        hm.put("app_signature",str);
        hm.put("sign_method","sha1");
        sb.append("{");
        Iterator it = hm.keySet().iterator();
        for(int i = 0;it.hasNext();i++)
        {
            String name = (String) it.next();
            if(i > 0)
                sb.append(",");
            sb.append("\"" + name + "\":\"" + hm.get(name) + "\"");
        }
        sb.append("}");
        System.out.println(str);
        System.out.println(sb.toString());
        JSONObject js = api(1,"pay/delivernotify",sb.toString());
        //String info = "OK";
        //if(js.getInt("errcode") != 0)
        //    info = "错误：" + js.getInt("errcode") + "<br/>描述：" + js.getString("errmsg");
        //System.out.println(info);
        return js;
    }

    public String[] appticket = new String[3];
    int apptime;
    public String getJsSign(Http h) throws SQLException,JSONException,IOException
    {
        String url = "http://" + h.request.getServerName() + h.request.getRequestURI();
        String qs = SCA.qs(h.request);
        if(qs != null)
            url += "?" + qs;
        return getJsSign(url,1);
    }

    public String getJsSign(String url,int type) throws SQLException,JSONException,IOException
    {
        int cur = (int) (System.currentTimeMillis() / 1000);
        if(appticket[type] == null || apptime < cur)
        {
            JSONObject jo = api(type,type == 2 ? "get_jsapi_ticket" : "ticket/getticket?type=jsapi",null);
            Filex.logs("ytweixin.txt", String.valueOf(jo.getInt("errcode")));
            if(jo.getInt("errcode") == 50002)
                return null;
            apptime = cur + jo.getInt("expires_in"); //7200s
            appticket[type] = jo.getString("ticket");
        }
        String nonceStr = "WeiXin" + tea.entity.util.SCA.random();
        String par = "jsapi_ticket=" + appticket[type] + "&noncestr=" + nonceStr + "&timestamp=" + cur + "&url=" + url;
        return "{debug:false,appId:'" + appid[type] + "',timestamp:" + cur + ",nonceStr:'" + nonceStr + "',signature:'" + Enc.SHA1(par) + "',jsApiList:['showOptionMenu','hideOptionMenu','showMenuItems','hideMenuItems','onMenuShareTimeline','onMenuShareAppMessage','openLocation','getLocation','chooseImage','previewImage','uploadImage','downloadImage','getLocalImgData']}";
    }

    public static String f(JSONObject jo) throws JSONException
    {
        int err = jo.getInt("errcode");
        return err == 0 ? null : "编号：" + err + "<br/>错误：" + jo.getString("errmsg");
    }

}

//StringBuilder sb=new StringBuilder();
//sb.append("<xml><OpenId><![CDATA[okKB3jpmf8cMfZfeswTK_TbJVmDw]]></OpenId>");
//sb.append("<AppId><![CDATA[wx4a8e6fe2881269af]]></AppId>");
//sb.append("<IsSubscribe>1</IsSubscribe>");
//sb.append("<TimeStamp>1403070158</TimeStamp>");
//sb.append("<NonceStr><![CDATA[xdHtUg8KhSHWzOoM]]></NonceStr>");
//sb.append("<AppSignature><![CDATA[7224e014af3093baaffb2700b5b7aef8055ec60f]]></AppSignature>");
//sb.append("<SignMethod><![CDATA[sha1]]></SignMethod>");
//sb.append("</xml>");
