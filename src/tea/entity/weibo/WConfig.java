package tea.entity.weibo;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;

public class WConfig
{
    protected static Cache c = new Cache(50);
    public String community; //微博的相关的配置
    public String topic; //话题
    //新浪
    public String sinaid; //新浪账号
    public String sinakey; //App key
    public String sinasecret; //App Secret
    public String sinatoken; //
    public String sinaurl; //
    //腾讯
    public String qqid; //腾讯账号
    public String qqkey; //App key
    public String qqsecret; //App Secret
    public String qqtoken; //
    public String qqurl; //
    //默认
    public String url; //链接
    public String picture; //图
    //土豆
    public String tudouuser;
    public String tudoupassword;
    public String tudoukey;

    public boolean login; //是否允许登录/注册

    public WConfig(String community)
    {
        this.community = community;
    }

    public static WConfig find(String community) throws SQLException
    {
        WConfig t = (WConfig) c.get(community);
        if(t == null)
        {
            ArrayList al = find(" AND community=" + DbAdapter.cite(community),0,1);
            t = al.size() < 1 ? new WConfig(community) : (WConfig) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT community,topic,sinaid,sinakey,sinasecret,sinatoken,sinaurl,qqid,qqkey,qqsecret,qqtoken,qqurl,url,picture,tudouuser,tudoupassword,tudoukey,login FROM wconfig WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WConfig t = new WConfig(rs.getString(i++));
                t.topic = rs.getString(i++);
                t.sinaid = rs.getString(i++);
                t.sinakey = rs.getString(i++);
                t.sinasecret = rs.getString(i++);
                t.sinatoken = rs.getString(i++);
                t.sinaurl = rs.getString(i++);
                //
                t.qqid = rs.getString(i++);
                t.qqkey = rs.getString(i++);
                t.qqsecret = rs.getString(i++);
                t.qqtoken = rs.getString(i++);
                t.qqurl = rs.getString(i++);
                t.url = rs.getString(i++);
                t.picture = rs.getString(i++);
                //
                t.tudouuser = rs.getString(i++);
                t.tudoupassword = rs.getString(i++);
                t.tudoukey = rs.getString(i++);
                //
                t.login = rs.getBoolean(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM wconfig WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate(0,"UPDATE wconfig SET topic=" + DbAdapter.cite(topic) + ",sinaid=" + DbAdapter.cite(sinaid) + ",sinakey=" + DbAdapter.cite(sinakey) + ",sinasecret=" + DbAdapter.cite(sinasecret) + ",sinatoken=" + DbAdapter.cite(sinatoken) + ",sinaurl=" + DbAdapter.cite(sinaurl) + ",qqid=" + DbAdapter.cite(qqid) + ",qqkey=" + DbAdapter.cite(qqkey) + ",qqsecret=" + DbAdapter.cite(qqsecret) + ",qqtoken=" + DbAdapter.cite(qqtoken) + ",qqurl=" + DbAdapter.cite(qqurl) + ",url=" + DbAdapter.cite(url) + ",picture=" + DbAdapter.cite(picture) + ",tudouuser=" + DbAdapter.cite(tudouuser) + ",tudoupassword=" + DbAdapter.cite(tudoupassword) + ",tudoukey=" + DbAdapter.cite(tudoukey) + ",login=" + DbAdapter.cite(login) + " WHERE community=" + DbAdapter.cite(community));
            if(i < 1)
            {
                db.executeUpdate(0,"INSERT INTO wconfig(community,topic,sinaid,sinakey,sinasecret,sinatoken,sinaurl,qqid,qqkey,qqsecret,qqtoken,qqurl,url,picture,tudouuser,tudoupassword,tudoukey,login)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(topic) + "," + DbAdapter.cite(sinaid) + "," + DbAdapter.cite(sinakey) + "," + DbAdapter.cite(sinasecret) + "," + DbAdapter.cite(sinatoken) + "," + DbAdapter.cite(sinaurl) + "," + DbAdapter.cite(qqid) + "," + DbAdapter.cite(qqkey) + "," + DbAdapter.cite(qqsecret) + "," + DbAdapter.cite(qqtoken) + "," + DbAdapter.cite(qqurl) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(tudouuser) + "," + DbAdapter.cite(tudoupassword) + "," + DbAdapter.cite(tudoukey) + "," + DbAdapter.cite(login) + ")");
            }
        } finally
        {
            db.close();
        }
        c.remove(community);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM wconfig WHERE community=" + DbAdapter.cite(community));
        c.remove(community);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"UPDATE wconfig SET " + f + "=" + DbAdapter.cite(v) + " WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        c.remove(community);
    }

    //自动授权
    public void token() throws IOException,SQLException
    {
        Enumeration e = DNS.findByCommunity(community,0);
        if(!e.hasMoreElements())
            return;
        String domain = (String) e.nextElement();
        Filex.logs("OAuth2s.txt","自动授权 开始：" + domain);
        String url = Http.enc("http://" + domain + "/OAuth2s.do?community=" + community);
        url = (String) Http.open("https://api.weibo.com/oauth2/authorize",null,"action=submit&withOfficalFlag=0&ticket=&isLoginSina=&response_type=token&regCallback=&redirect_uri=" + url + "&client_id=" + sinakey + "&state=&from=&userId=" + Http.enc(tudouuser) + "&passwd=" + tudoupassword)[1]; //奇怪，这里为何没有自动重定向！
        Filex.logs("OAuth2s.txt","自动授权：" + url);
        if(url.contains("第三方授权错误"))
            return;
        String[] arr = url.substring(url.indexOf('#') + 1).split("&");
        HashMap<String,String> hm = new HashMap();
        for(int i = 0;i < arr.length;i++)
        {
            int j = arr[i].indexOf('=');
            hm.put(arr[i].substring(0,j),arr[i].substring(j + 1));
        }
        hm.get("expires_in"); //access_token的生命周期，单位是秒数。
        set("sinatoken",sinatoken = hm.get("access_token"));
    }

}
