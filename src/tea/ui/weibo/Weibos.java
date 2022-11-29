package tea.ui.weibo;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.text.*;
import java.util.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.weibo.*;
import java.sql.SQLException;
import tea.entity.node.access.NodeAccessWhere;

//200:ok  304:已存在  404:不存在  403:没有权限
public class Weibos extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act");
        PrintWriter out = response.getWriter();
        try
        {
            if("config".equals(act))
            {
                //
                WMobile wm = new WMobile(0);
                wm.manufacturer = h.get("manufacturer");
                wm.product = h.get("product");
                wm.version = h.get("version");
                wm.deviceid = h.get("deviceid");
                wm.number = h.get("number");
                wm.display = h.get("display");
                wm.ip = request.getRemoteAddr();
                //String city = NodeAccessWhere.findByIp(wm.ip);
                //wm.city = city.substring(0,(city.startsWith("内蒙古")||city.startsWith("黑龙江"))?3?2);
                wm.time = new Date();
                wm.set();
                //
                WConfig c = WConfig.find(h.community);
                out.print("{code:200,sinaid:" + cite(c.sinaid) + ",sinakey:" + cite(c.sinakey) + ",sinasecret:" + cite(c.sinasecret) + ",sinatoken:" + cite(c.sinatoken) + ",qqid:" + cite(c.qqid) + ",qqkey:" + cite(c.qqkey) + ",qqsecret:" + cite(c.qqsecret) + ",qqtoken:" + cite(c.qqtoken) + ",login:" + c.login + "}");
            } else if("reg".equals(act))
            {
                String name = h.get("name");
                int type = h.getInt("type"); //1:账号, 2:手机号
                if(exists(name,type))
                {
                    out.print("{code:304}");
                    return;
                }
                String password = h.get("password");
                if(type == 2)
                {
                    //name = Long.toString(System.currentTimeMillis(),36);
                    name = new DecimalFormat("000000").format(SeqTable.getSeqNo(h.community));
                }
                Profile p = Profile.create(name,password,h.community,null,request.getServerName());
                String tmp = h.get("mobile");
                if(tmp != null)
                    p.setMobile(tmp);

                out.print("{code:200,member:" + p.getProfile() + "}");
            } else if("login".equals(act))
            {
                int profile = 0;
                int type = h.getInt("type");
                DbAdapter db = new DbAdapter(1);
                try
                {
                    db.executeQuery("SELECT profile FROM Profile WHERE " + (type == 2 ? "mobile" : "member") + "=" + DbAdapter.cite(h.get("name")) + " AND password=" + DbAdapter.cite(h.get("password")));
                    if(db.next())
                        profile = db.getInt(1);
                    else
                    {
                        out.print("{code:404}");
                        return;
                    }
                } finally
                {
                    db.close();
                }
                out.print("{code:" + (profile > 0 ? 200 : 403) + ",member:" + profile + "}");
            } else if("exists".equals(act))
            {
                out.print("{code:" + (exists(h.get("name"),h.getInt("type")) ? 200 : 403) + "}");
            } else
            {
                int member = h.getInt("member");
                String password = h.get("password");
                Profile p = Profile.find(member);
                if(!password.equals(p.getPassword()))
                    return;
                if("waccountadd".equals(act))
                {
                    String userid = h.get("userid");
                    int type = h.getInt("type");
                    ArrayList al = WAccount.find(" AND member=" + member + " AND userid=" + DbAdapter.cite(userid) + " AND type=" + type,0,1);
                    WAccount t = al.size() < 1 ? new WAccount(0) : (WAccount) al.get(0);
                    t.member = member;
                    t.userid = userid;
                    t.name = h.get("name");
                    t.type = type;
                    t.nick = h.get("nick");
                    t.token = h.get("token");
                    //t.secret = h.get("secret");
                    t.avatar = h.get("avatar");
                    t.following = h.getInt("following");
                    t.follower = h.getInt("follower");
                    t.micro = h.getInt("micro");
                    t.favorite = h.getInt("favorite");
                    t.set();
                    out.print("{code:200,waccount:" + t.waccount + "}");
                } else if("waccountdel".equals(act))
                {
                    int waccount = h.getInt("waccount");
                    WAccount t = WAccount.find(waccount);
                    if(t.member == member)
                        t.delete();
                    out.print("{code:200}");
                } else if("waccounts".equals(act))
                {
                    System.out.println("ANDROID 事件：" + act + " 104");
                    ArrayList al = WAccount.find(" AND member=" + member + " ORDER BY follower DESC",0,200);
                    out.print("[");
                    for(int i = 0;i < al.size();i++)
                    {
                        if(i > 0)
                            out.print(",");
                        WAccount t = (WAccount) al.get(i);
                        out.print("{waccount:" + t.waccount);
                        out.print(",userid:\"" + t.userid + "\"");
                        out.print(",name:\"" + t.name + "\"");
                        out.print(",type:" + t.type);
                        out.print(",nick:\"" + t.nick + "\"");
                        out.print(",token:\"" + t.token + "\"");
                        //out.print(",secret:\"" + t.secret + "\"");
                        out.print(",avatar:\"" + t.avatar + "\"");
                        out.print("}");
                    }
                    out.print("]");
                    System.out.println("ANDROID 事件：" + act + " 123");
                }
            }
        } catch(Exception e)
        {
            e.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    public static String cite(String str)
    {
        return "\"" + str + "\"";
    }

    public boolean exists(String member,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT member FROM Profile WHERE " + (type == 2 ? "mobile" : "member") + "=" + DbAdapter.cite(member));
            return db.next();
        } finally
        {
            db.close();
        }
    }

}
