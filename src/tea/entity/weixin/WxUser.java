package tea.entity.weixin;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;
import java.util.regex.*;
import org.json.*;
import tea.db.*;
import java.net.*;
import tea.entity.*;
import javax.net.ssl.*;
import javax.servlet.http.*;
import java.security.KeyStore;
import tea.entity.util.*;
import tea.entity.stat.Ip;

public class WxUser extends Entity
{
    public long wxuser; //用户ID
    public String community; //社区
    public int wxgroup; //所属组
    public String userid; //公众号的原始ID
    public String openid; //唯一加密串
    public String unionid;
    public String weixinid; //微信号
    public String mobile; //手机号
    public String email; //电子邮箱
    public String nickname; //名称
    public static final String[] GENDER_TYPE =
            {"--","男","女"};
    public int gender; //性别 
    public String remarkname; //备注名
    public String avatar; //头像
    public String location; //地区
    public String signature; //签名
    public int status; //关注状态: 1=已关注，2=已冻结，4=未关注
    public Date utime; //更新时间
    public Date dtime; //取消关注时间
    public String ip; //IP地址
    public String xff;
    public String ua;
    public int card; //IP地区
    public int hits; //分享次数
    public int score; //总得分
    //邮政
    public String nodes = "|";
    public String steering; //
    public Date time; //关注时间

    public WxUser(long wxuser)
    {
        this.wxuser = wxuser;
    }

    private WxUser(String openid)
    {
        this.openid = openid;
        //this.wxuser = (long) (tea.entity.util.SCA.random() * -1000000000L);
    }

    public static WxUser find(String community,long wxuser) throws SQLException
    {
        return find(wxuser);
    }

    public static WxUser find(long wxuser) throws SQLException
    {
        WxUser t = (WxUser) _cache.get(wxuser);
        if(t == null)
        {
            ArrayList al = find(" AND wxuser=" + wxuser,0,1);
            t = al.size() < 1 ? new WxUser(wxuser) : (WxUser) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT wxuser,community,wxgroup,userid,openid,unionid,weixinid,mobile,email,nickname,gender,remarkname,avatar,location,signature,utime,dtime,ip,xff,ua,card,hits,score,nodes,time FROM wxuser WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxUser t = new WxUser(rs.getLong(i++));
                t.community = rs.getString(i++);
                t.wxgroup = db.getInt(i++);
                t.userid = rs.getString(i++);
                t.openid = rs.getString(i++);
                t.unionid = rs.getString(i++);
                t.weixinid = rs.getString(i++);
                t.mobile = rs.getString(i++);
                t.email = rs.getString(i++);
                t.nickname = rs.getString(i++);
                t.gender = rs.getInt(i++);
                t.remarkname = rs.getString(i++);
                t.avatar = rs.getString(i++);
                t.location = rs.getString(i++);
                t.signature = rs.getString(i++);
                t.utime = db.getDate(i++);
                t.dtime = db.getDate(i++);
                t.ip = rs.getString(i++);
                t.xff = rs.getString(i++);
                t.ua = rs.getString(i++);
                t.card = rs.getInt(i++);
                t.hits = rs.getInt(i++);
                t.score = rs.getInt(i++);
                t.nodes = rs.getString(i++);
                t.time = db.getDate(i++);
                _cache.put(t.wxuser,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM wxuser WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        if("".equals(remarkname))
            remarkname = null;
        String sql;
        if(time == null)
        {
            time = new Date();
            sql = "INSERT INTO wxuser(wxuser,community,wxgroup,userid,openid,unionid,weixinid,mobile,email,nickname,gender,remarkname,avatar,location,signature,utime,dtime,ip,xff,ua,card,hits,score,nodes,time)VALUES(" + (wxuser = Seq.get()) + "," + DbAdapter.cite(community) + "," + wxgroup + "," + DbAdapter.cite(userid) + "," + DbAdapter.cite(openid) + "," + DbAdapter.cite(unionid) + "," + DbAdapter.cite(weixinid) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(nickname) + "," + gender + "," + DbAdapter.cite(remarkname) + "," + DbAdapter.cite(avatar) + "," + DbAdapter.cite(location) + "," + DbAdapter.cite(signature) + "," + DbAdapter.cite(utime) + "," + DbAdapter.cite(dtime) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(xff) + "," +
                    DbAdapter.cite(ua) + "," + card + "," + hits +
                    "," + score + "," + DbAdapter.cite(nodes) + "," + DbAdapter.cite(time) + ")";
        } else
        {
            sql = "UPDATE wxuser SET wxgroup=" + wxgroup + ",userid=" + DbAdapter.cite(userid) + ",openid=" + DbAdapter.cite(openid) + ",unionid=" + DbAdapter.cite(unionid) + ",weixinid=" + DbAdapter.cite(weixinid) + ",mobile=" + DbAdapter.cite(mobile) + ",email=" + DbAdapter.cite(email) + ",nickname=" + DbAdapter.cite(nickname) + ",gender=" + gender + ",remarkname=" + DbAdapter.cite(remarkname) + ",avatar=" + DbAdapter.cite(avatar) + ",location=" + DbAdapter.cite(location) + ",signature=" + DbAdapter.cite(signature) + ",utime=" + DbAdapter.cite(utime) + ",dtime=" + DbAdapter.cite(dtime) + ",ip=" + DbAdapter.cite(ip) + ",xff=" + DbAdapter.cite(xff) + ",ua=" + DbAdapter.cite(ua) + ",card=" + card + ",hits=" + hits + ",score=" + score + ",nodes=" + DbAdapter.cite(nodes) + ",time=" +
                  DbAdapter.cite(time) +
                  " WHERE community=" + DbAdapter.cite(community) + " AND wxuser=" + wxuser;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate((int) wxuser,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(wxuser);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate((int) wxuser,"DELETE FROM wxuser WHERE community=" + DbAdapter.cite(community) + " AND wxuser=" + wxuser);
        } finally
        {
            db.close();
        }
        _cache.remove(wxuser);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate((int) wxuser,"UPDATE wxuser SET " + f + "=" + DbAdapter.cite(v) + " WHERE wxuser=" + wxuser);
        } finally
        {
            db.close();
        }
        //_cache.remove(wxuser);
    }

    //
    public static WxUser find(String openid) throws SQLException
    {
        ArrayList al = find(" AND openid=" + DbAdapter.cite(openid),0,1);
        return al.size() < 1 ? new WxUser(openid) : (WxUser) al.get(0);
    }

    public void set(HttpServletRequest request) throws SQLException
    {
        if(weixinid == null)
        {
            ip = request.getRemoteAddr();
            xff = request.getHeader("x-forwarded-for"); //06-08 17:56新加
        }
        card = Ip.find(xff == null ? ip : xff).card;
        ua = request.getHeader("user-agent");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate((int) wxuser,"UPDATE wxuser SET ip=" + DbAdapter.cite(ip) + ",xff=" + DbAdapter.cite(xff) + ",card=" + card + ",ua=" + DbAdapter.cite(ua) + " WHERE wxuser=" + wxuser);
        } finally
        {
            db.close();
        }
    }

    //
    public String getAnchor()
    {
        StringBuilder htm = new StringBuilder();
        htm.append("<table><tr><td style='border:0;' rowspan='2'><img src='" + MT.f(avatar,"/tea/image/avatar.gif") + "' width='50' /></td>");
        htm.append("<td style='border:0;'><a href='/jsp/weixin/WxUserView.jsp?wxuser=" + wxuser + "'>" + f(remarkname == null ? nickname : remarkname + "(" + nickname + ")") + "</a>");
        if(gender != 0)
            htm.append(" <span class='icon16_common " + (gender == 1 ? "man_blue" : "woman_orange") + "'></span>");
        htm.append("<tr><td style='border:0;color:#7B7B7B'>" + f(signature) + "</td></tr>");
        htm.append("</table>");
        return htm.toString();
    }

    protected static String f(String str)
    {
        if(str == null)
            return "";
        String[] SYMBOL =
                {"/::)","/::~","/::B","/::|","/:8-)","/::<","/::$"
                ,"/::X","/::Z","/::'(","/::-|","/::@","/::P","/::D"
                ,"/::O","/::(","/::+","/:--b","/::Q","/::T"
                ,"/:,@P","/:,@-D","/::d","/:,@o","/::g","/:|-)","/::!"
                ,"/::L","/::>","/::,@","/:,@f","/::-S","/:?","/:,@x"
                ,"/:,@@","/::8","/:,@!","/:!!!","/:xx","/:bye"
                ,"/:wipe","/:dig","/:handclap","/:&-(","/:B-)","/:<@","/:@>"
                ,"/::-O","/:>-|","/:P-(","/::'|","/:X-)","/::*","/:@x"
                ,"/:8*","/:pd","/:<W>","/:beer","/:basketb","/:oo"
                ,"/:coffee","/:eat","/:pig","/:rose","/:fade","/:showlove","/:heart"
                ,"/:break","/:cake","/:li","/:bome","/:kn","/:footb","/:ladybug"
                ,"/:shit","/:moon","/:sun","/:gift","/:hug","/:strong"
                ,"/:weak","/:share","/:v","/:@)","/:jj","/:@@","/:bad"
                ,"/:lvu","/:no","/:ok","/:love","/:<L>","/:jump","/:shake"
                ,"/:<O>","/:circle","/:kotow","/:turn","/:skip","/:oY"};
        String[] NAME =
                {"微笑","撇嘴","色","发呆","得意","流泪","害羞","闭嘴","睡","大哭","尴尬","发怒","调皮","龇牙","惊讶",
                "难过","酷","冷汗","抓狂","吐","偷笑","可爱","白眼","傲慢","饥饿","困","惊恐","流汗","憨笑","大兵",
                "奋斗","咒骂","疑问","嘘","晕","折磨","衰","骷髅","敲打","再见","擦汗","抠鼻","鼓掌","糗大了","坏笑",
                "左哼哼","右哼哼","哈欠","鄙视","委屈","快哭了","阴险","亲亲","吓","可怜","菜刀","西瓜","啤酒","篮球","乒乓",
                "咖啡","饭","猪头","玫瑰","凋谢","示爱","爱心","心碎","蛋糕","闪电","炸弹","刀","足球","瓢虫","便便",
                "月亮","太阳","礼物","拥抱","强","弱","握手","胜利","抱拳","勾引","拳头","差劲","爱你","no","ok",
                "爱情","飞吻","跳跳","发抖","怄火","转圈","磕头","回头","跳绳","挥手","激动","街舞","献吻","左太极","右太极"
        };
        DecimalFormat DF3 = new DecimalFormat("000");
        for(int i = 0;i < SYMBOL.length;i++)
        {
            str = str.replace(SYMBOL[i],"<img src='/tea/image/face/" + DF3.format(i) + ".gif' alt='" + NAME[i] + "'>");
        }

        StringBuilder sb = new StringBuilder();
        char[] arr = str.toCharArray();
        for(int i = 0;i < arr.length;i++)
        {
            if(arr[i] == 55356)
                sb.append("<span class='emoji emoji" + Integer.toHexString(arr[++i] + 70656) + "'></span>");
            else if(arr[i] == 55357) //d83d
                sb.append("<span class='emoji emoji" + Integer.toHexString(arr[++i] + 71680) + "'></span>");
            else
                sb.append(arr[i]);
        }
        return sb.toString();
    }

    public JSONObject send(String msgtype,String content) throws IOException,JSONException,SQLException
    {
        WeiXin wx = WeiXin.find(community);
        int type = getType();
        if(!"text".equals(msgtype) && !msgtype.endsWith("news"))
        {
            content = wx.upload(type,content);
        }
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("  \"touser\":\"" + openid + "\",");
        sb.append("  \"msgtype\":\"" + msgtype + "\",");
        sb.append("  \"agentid\":\"" + 0 + "\",");
        sb.append("  \"" + msgtype + "\":{\"");
        if("text".equals(msgtype))
            sb.append("content");
        else if(msgtype.endsWith("news"))
            sb.append("articles");
        else
            sb.append("media_id");
        sb.append("\":").append(msgtype.endsWith("news") ? content : Attch.cite(content));
        sb.append("  }");
        sb.append("}");
        return wx.api(type,type == 2 ? "message/send" : "message/custom/send",sb.toString());
    }

    int getType() throws SQLException
    {
        WeiXin wx = WeiXin.find(community);
        for(int i = 0;i < WeiXin.USER_TYPE.length;i++)
        {
            if(userid.equals(wx.userid[i]))
                return i;
        }
        return 0;
    }

    public XMLObject sendRedPack(String name,String remark,float total) throws Exception
    {
        //签名
        int price = (int) (total * 100);
        WeiXin wx = WeiXin.find(community);
        String par = "act_name=" + name //活动名称,没看到作用
                     + "&client_ip=" + "127.0.0.1" //Ip地址
                     + "&logo_imgurl=" + "http://www.baidu.com/img/bd_logo1.png" //商户logo,暂不开放
                     + "&max_value=" + price //最大红包金额
                     + "&mch_billno=" + System.currentTimeMillis() + wxuser //商户订单号
                     + "&mch_id=" + wx.partnerid //商户号
                     + "&min_value=" + price //最小红包金额
                     + "&nick_name=" + name //提供方名称,没看到作用
                     + "&nonce_str=" + "WeiXin" + tea.entity.util.SCA.random() //随机字符串
                     + "&re_openid=" + openid //
                     + "&remark=" + remark //备注,没看到作用
                     + "&send_name=" + name //商户名称*
                     //没看到作用
                     //+ "&share_content=" + "快来参加猜灯谜活动" //分享文案
                     //+ "&share_imgurl=" + "http://p1.qhimg.com/t016951262e124afd79.png" //分享的图片,暂不开放
                     //+ "&share_url=" + "http://www.haosou.com/" //分享链接
                     //+ "&sign=" //
                     //+ "&sub_mch_id=" //子商户号
                     + "&total_amount=" + price //付款金额
                     + "&total_num=" + 1 //红包发放总人数
                     + "&wishing=" + remark //红包祝福语*
                     + "&wxappid=" + wx.appid[1]; //商户appid
        StringBuilder xml = new StringBuilder("<xml>");
        xml.append("<sign>" + Enc.MD5((par + "&key=" + wx.partnerkey).getBytes("UTF-8")).toUpperCase() + "</sign>");
        Matcher m = Pattern.compile("([\\w]+)=([^&]+)").matcher(par);
        while(m.find())
            xml.append("<" + m.group(1) + "><![CDATA[" + m.group(2) + "]]></" + m.group(1) + ">");
        xml.append("</xml>");
        //证书
        File f = new File(System.getProperty("java.io.tmpdir"),wx.partnerid + ".p12");
        if(f.exists())
        {
            char[] pwd = wx.partnerid.toCharArray();
            KeyStore ks = KeyStore.getInstance("PKCS12");
            FileInputStream is = new FileInputStream(f);
            try
            {
                ks.load(is,pwd);
            } finally
            {
                is.close();
            }
            KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm()); //SunX509
            kmf.init(ks,pwd);

            SSLContext sc = SSLContext.getInstance("TLS");
            sc.init(kmf.getKeyManagers(),null,null);
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        }
        String str = new String((byte[]) Http.open("https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack","_charset=null; ",xml.toString())[1],"utf-8");
        Filex.logs("WxUser_red.txt",wxuser + ":" + str);
        XMLObject x = new XMLObject(str).getXMLObject("xml");
        "SUCCESS".equals(x.getString("result_code")); //x.getString("return_msg");
        return x;
    }

    //CA证书出错，请登录微信支付商户平台下载证书
    public XMLObject getRedPack(String code) throws Exception
    {
        //签名
        WeiXin wx = WeiXin.find(community);
        String par = "appid=" + wx.appid[1] //商户appid
                     + "&bill_type=MCHT" //
                     + "&mch_billno=" + code //商户订单号
                     + "&mch_id=" + wx.partnerid //商户号
                     + "&nonce_str=" + "WeiXin" + SCA.random(); //随机字符串
        StringBuilder xml = new StringBuilder("<xml>");
        xml.append("<sign>" + Enc.MD5((par + "&key=" + wx.partnerkey).getBytes("UTF-8")).toUpperCase() + "</sign>");
        Matcher m = Pattern.compile("([\\w]+)=([^&]+)").matcher(par);
        while(m.find())
            xml.append("<" + m.group(1) + "><![CDATA[" + m.group(2) + "]]></" + m.group(1) + ">");
        xml.append("</xml>");
        //证书
        File f = new File(System.getProperty("java.io.tmpdir"),wx.partnerid + ".p12");
        if(f.exists())
        {
            char[] pwd = wx.partnerid.toCharArray();
            KeyStore ks = KeyStore.getInstance("PKCS12");
            FileInputStream is = new FileInputStream(f);
            try
            {
                ks.load(is,pwd);
            } finally
            {
                is.close();
            }
            KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm()); //SunX509
            kmf.init(ks,pwd);

            SSLContext sc = SSLContext.getInstance("TLS");
            sc.init(kmf.getKeyManagers(),null,null);
            par = Http.USER_AGENT; //要加此句,否则第一次会报:证书错误
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        }
        String str = new String((byte[]) Http.open("https://api.mch.weixin.qq.com/mmpaymkttransfers/gethbinfo","_charset=null; ",xml.toString())[1],"utf-8");
        Filex.logs("WxUser_red.txt",wxuser + ":" + str);
        XMLObject x = new XMLObject(str).getXMLObject("xml");
        //err_code=NOT_FOUND, return_msg=指定单号数据不存在
        return x;
    }

    public String send(String content) throws SQLException,IOException,JSONException
    {
        String str = (String) WeiXin.find(community).open(0,"singlesend","tofakeid=" + wxuser + "&content=" + Http.enc(content) + "&imgcode=&type=1&f=json&t=ajax-response&random=" + tea.entity.util.SCA.random() + "&lang=zh_CN")[1];
        JSONObject js = new JSONObject(str).getJSONObject("base_resp");
        int ret = js.getInt("ret");
        if(ret == 0)
            return null;
        else
        {
            Filex.logs("WxUser.log","发送： 用户：" + wxuser + " 内容：" + content + " 返回：" + str);
            String info = js.getString("err_msg");
            if(ret == 10700)
                info = "不能发送，对方不是你的粉丝！";
            else if(ret == 10706)
                info = "由于该用户24小时未与你互动，你不能再主动发消息给他。直到用户下次主动发消息给你才可以对其进行回复。";
            return info;
        }
    }

    public void info() throws SQLException,JSONException,IOException
    {
        WeiXin wx = WeiXin.find(community);
        JSONObject jm = wx.api(userid.equals(wx.userid[0]) ? 0 : 1,"user/info?openid=" + openid + "&lang=zh_CN",null);
        if(!jm.isNull("errcode") && jm.getInt("errcode") == 40003) //{"errcode":40003,"errmsg":"invalid openid"}
            return;
        if(jm.getInt("subscribe") == 0) //取消关注
        {
            if(wxuser > 0 && wxgroup != 80)
            {
                Filex.logs("WxUser_=80.txt",this.toString() + " ===");
            }
            wxgroup = 80;
            if(time == null)
                set();
            else
                set("wxgroup",String.valueOf(wxgroup));
            return;
        } else if(wxgroup == 80)
            wxgroup = 0;
        nickname = jm.getString("nickname");
        nickname = MT.f(new String(nickname.getBytes("GBK"),"GBK"),50);
        if(nickname.length() < 1)
            nickname = "--";
        gender = jm.getInt("sex");
        location = jm.getString("country") + " " + jm.getString("province") + " " + jm.getString("city");
        avatar = jm.getString("headimgurl");
        if(avatar != null)
            avatar = avatar.length() < 1 ? null : avatar + "64";
        unionid = jm.getString("unionid");
        set();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate((int) wxuser,"UPDATE wxuser SET time=" + DbAdapter.cite(time = new Date(jm.getLong("subscribe_time") * 1000)) + " WHERE community=" + DbAdapter.cite(community) + " AND wxuser=" + wxuser);
        } finally
        {
            db.close();
        }
    }

    static long last = 0;
    public static void refresh() throws SQLException,IOException,JSONException
    {
        ArrayList al = find(" AND wxgroup!=80 AND nickname IS NULL",0,1000); // AND wxuser>" + last + " ORDER BY wxuser
        Filex.logs("WxUser_ref.txt","size:" + al.size());
        for(int i = 0;i < al.size();i++)
        {
            WxUser wu = (WxUser) al.get(i);
            Filex.logs("WxUser_ref.txt","　　id:" + wu.wxuser);
            last = wu.wxuser;
            wu.info();
        }
    }

//    public static void refresh(String community) throws SQLException
//    {
//        Filex.logs("WxUser.log","开始更新...");
//        String htm = null;
//        try
//        {
//            //用户列表
//            htm = (String) open(community,"contactmanage?t=user/index&pagesize=10&pageidx=0&type=0&lang=zh_CN",null);
//            int s = htm.indexOf("wx.cgiData=") + 11;
//            htm = htm.substring(s,htm.indexOf(").contacts,",s)) + "}";
//            htm = htm.replaceAll("\\(|\\)\\.groups","");
//            JSONObject root = new JSONObject(htm);
//            //组
//            StringBuilder ids = new StringBuilder();
//            JSONArray jgs = root.getJSONObject("groupsList").getJSONArray("groups");
//            for(int i = 0;i < jgs.length();i++)
//            {
//                JSONObject jg = jgs.optJSONObject(i);
//                WxGroup wg = WxGroup.find(community,jg.getInt("id"));
//                wg.name = jg.getString("name");
//                wg.cnt = jg.getInt("cnt");
//                wg.set();
//                ids.append(wg.wxgroup).append(",");
//            }
//            WxGroup wg = WxGroup.find(community,80);
//            if(wg.time == null)
//            {
//                wg.name = "取消关注";
//                wg.set();
//            }
//            ArrayList wus = WxUser.find(" AND community=" + DbAdapter.cite(community) + " AND wxuser<0",0,Integer.MAX_VALUE);
//            DbAdapter db = new DbAdapter();
//            try
//            {
//                db.executeUpdate("UPDATE WxGroup SET deleted=1 WHERE community=" + DbAdapter.cite(community) + " AND wxgroup NOT IN(" + ids.toString() + "80)");
//
//                //用户
//                JSONArray jus = root.getJSONObject("friendsList").getJSONArray("contacts");
//                for(int i = 0;i < jus.length();i++)
//                {
//                    JSONObject ju = jus.optJSONObject(i);
//                    WxUser wu = WxUser.find(community,ju.getLong("id"));
//                    if(wu.time == null)
//                    {
//                        wu.setFake(wus);
//                        continue;
//                    }
//                    wu.wxgroup = ju.getInt("group_id");
//                    wu.nickname = ju.getString("nick_name");
//                    wu.remarkname = ju.getString("remark_name");
//                    wu.set();
//                }
//            } finally
//            {
//                db.close();
//            }
//            //最新消息
//            htm = (String) open(community,"message?t=message/list&count=20&day=7&lang=zh_CN",null);
//            s = htm.indexOf("({\"msg_item\":[") + 13;
//            htm = htm.substring(s,htm.indexOf("}).msg_item",s));
//            JSONArray ja = new JSONArray(htm);
//            for(int i = 0;i < ja.length();i++)
//            {
//                JSONObject jm = ja.getJSONObject(i);
//                WxUser wu = WxUser.find(community,jm.getLong("fakeid"));
//                if(wu.time == null)
//                {
//                    wu.setFake(wus);
//                    continue;
//                }
//                wu.set("nickname",String.valueOf(wu.nickname = jm.getString("nick_name")));
//                if(WxMessenger.count(" AND fuser=" + wu.wxuser + " AND time>" + DbAdapter.cite(new Date(System.currentTimeMillis() - 86400000 * 2)) + " AND source IS NULL") > 0)
//                {
//                    wu.refresh();
//                }
//            }
//            //
//            wus = WxUser.find(" AND community=" + DbAdapter.cite(community) + " AND wxuser>0 AND(utime IS NULL OR utime<" + DbAdapter.cite(new Date(System.currentTimeMillis() - 86400000)) + ")",0,Integer.MAX_VALUE);
//            for(int i = 0;i < wus.size();i++)
//            {
//                WxUser wu = (WxUser) wus.get(i);
//                //头像
//                byte[] by = (byte[]) open(community,"getheadimg?fakeid=" + wu.wxuser + "&lang=zh_CN",null);
//                Filex.write(Http.REAL_PATH + "/res/" + community + "/wxuser/" + wu.wxuser + ".jpg",by);
//                //详细
//                if(wu.wxgroup != 80 || !wu.openid.startsWith("gh_"))
//                {
//                    htm = (String) open(community,"getcontactinfo","fakeid=" + wu.wxuser + "&f=json&ajax=1&t=ajax-getcontactinfo&random=" + tea.entity.util.SCA.random() + "&lang=zh_CN");
//                    JSONObject ju = new JSONObject(htm);
//                    JSONObject br = ju.getJSONObject("base_resp");
//                    if(br.getInt("ret") != 0)
//                    {
//                        //{"base_resp":{"ret":1,"err_msg":"invalid bizpay url"}}
//                    } else
//                    {
//                        ju = ju.getJSONObject("contact_info");
//                        wu.wxgroup = ju.getInt("group_id");
//                        wu.nickname = ju.getString("nick_name");
//                        wu.gender = ju.getInt("gender");
//                        wu.remarkname = ju.getString("remark_name");
//                        wu.location = ju.getString("country") + " " + ju.getString("province") + " " + ju.getString("city");
//                        wu.signature = ju.getString("signature");
//                    }
//                }
//                wu.utime = new Date();
//                wu.set();
//                wu.refresh();
//            }
//        } catch(Throwable ex)
//        {
//            ex.printStackTrace();
//            System.out.println(htm);
//        }
//    }
//
//    //查找关链
//    void setFake(ArrayList wus) throws IOException,SQLException
//    {
//        String htm = (String) open(community,"singlesendpage?tofakeid=" + wxuser + "&t=message/send&action=index&lang=zh_CN",null);
//        for(int j = 0;j < wus.size();j++)
//        {
//            WxUser t = (WxUser) wus.get(j);
//            if(htm.contains(t.openid))
//            {
//                t.set("wxuser",String.valueOf(wxuser));
//                DbAdapter db = new DbAdapter();
//                try
//                {
//                    db.executeUpdate("UPDATE WxMessenger SET fuser=" + wxuser + " WHERE fuser=" + t.wxuser);
//                } finally
//                {
//                    db.close();
//                }
//                break;
//            }
//        }
//    }
//
//    //补充发送的数据
//    public void refresh() throws SQLException,IOException,JSONException
//    {
//        String htm = (String) open(community,"singlesendpage?tofakeid=" + wxuser + "&t=message/send&action=index&lang=zh_CN",null);
//        int s = htm.indexOf("wx.cgiData = ") + 13;
//        htm = htm.substring(s,htm.indexOf("]}};",s) + 3);
//        JSONArray jms = new JSONObject(htm).getJSONObject("msg_items").getJSONArray("msg_item");
//        for(int j = 0;j < jms.length();j++)
//        {
//            JSONObject jm = jms.getJSONObject(j);
//            int id = jm.getInt("id");
//            System.out.println(id);
//            long wxuser = jm.getLong("fakeid");
//            int status = jm.getInt("msg_status");
//            int type = jm.getInt("type");
//            Date time = new Date(jm.getLong("date_time") * 1000);
//            //
//            ArrayList wms = WxMessenger.find(" AND community=" + DbAdapter.cite(community) + (status == 4 ? " AND(seq=" + id + " OR fuser=" + wxuser + " AND type=" + type + " AND seq=0 AND DATEDIFF(ss," + DbAdapter.cite(time) + ",time)IN(0,1,2,3)) ORDER BY DATEDIFF(ss," + DbAdapter.cite(time) + ",time)" : " AND seq=" + id),0,1);
//            WxMessenger wm = wms.size() < 1 ? new WxMessenger(id) : (WxMessenger) wms.get(0);
//            wm.type = type;
//            wm.seq = id;
//            if(wm.type == 3 || wm.type == 4) //声音
//            {
//                wm.url = "/res/" + community + "/wxmessenger/" + id + (wm.type == 3 ? ".mp3" : ".flv");
//                File f = new File(Http.REAL_PATH + wm.url);
//                if(!f.exists())
//                {
//                    byte[] by = (byte[]) open(community,"get" + WxMessenger.TYPE_CODE[wm.type] + "data?msgid=" + id + "&fileid=&lang=zh_CN",null);
//                    Filex.write(f.getPath(),by);
//                }
//            }
//            if(wm.time == null)
//            {
//                if(status == 4)
//                    continue;
//                wm.community = community;
//                if(!jm.isNull("content"))
//                {
//                    wm.content = jm.getString("content").replaceAll("&lt;","<").replaceAll("&gt;",">").replaceAll("&quot;","\"").replaceAll("&#39;","'").replaceAll("&amp;","&");
//                }
//                wm.fuser = wxuser;
//                wm.tuser = this.wxuser;
//                wm.status = status;
//                wm.time = time;
//            }
//            wm.source = jm.getString("source");
//            wm.set();
//        }
//    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{wxuser:" + wxuser);
        sb.append(",wxgroup:" + wxgroup);
        sb.append(",openid:" + Attch.cite(openid));
        sb.append(",nickname:" + Attch.cite(nickname));
        sb.append(",gender:" + gender);
        sb.append(",location:" + Attch.cite(location));
        sb.append(",signature:" + Attch.cite(signature));
        sb.append(",ip:" + Attch.cite(ip));
        sb.append(",card:" + card);
        sb.append("}");
        return sb.toString();
    }
}
