package tea.ui.weibo;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.weibo.*;
import org.json.*;
import tea.entity.member.*;

public class OAuths extends HttpServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");

        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try
        {
            String url = "http://" + request.getServerName() + request.getRequestURI() + "?a=b&act=verifier&" + request.getQueryString();
            System.out.println(url);

            WConfig s = WConfig.find(h.community);
            if(act == null)
            {
                int type = h.getInt("type");

                //1.获取临时“令牌”
                String json = OAuth.oauth(h.community,(type == 1 ? "http://api.t.sina.com.cn/oauth/" : "http://open.t.qq.com/cgi-bin/") + "request_token?oauth_callback=" + OAuth.enc(url),false,null,null);
                if(json == null)
                    return;
                HashMap hm = OAuth.parse(json);
                String[] TOKEN = new String[2];
                TOKEN[0] = (String) hm.get("oauth_token");
                TOKEN[1] = (String) hm.get("oauth_token_secret");
                session.setAttribute("oauth",TOKEN);

                //2.让用户输入密码
                response.sendRedirect((type == 1 ? "http://api.t.sina.com.cn/oauth/authenticate?" : "http://open.t.qq.com/cgi-bin/authorize?") + "oauth_token=" + TOKEN[0]);
            } else if("verifier".equals(act))
            {
                String[] TOKEN = (String[]) session.getAttribute("oauth");
                int type = h.getInt("type");
                String verifier = h.get("oauth_verifier");

                //3.临时“令牌”+输入密码获得的“验证码” 转为  正式“令牌”和用户ID
                String json = OAuth.oauth(h.community,(type == 1 ? "http://api.t.sina.com.cn/oauth/" : "http://open.t.qq.com/cgi-bin/") + "access_token?oauth_verifier=" + verifier,false,null,TOKEN);
                HashMap<String,String> hm = OAuth.parse(json);
                TOKEN[0] = hm.get("oauth_token");
                TOKEN[1] = hm.get("oauth_token_secret");

                if("auth".equals(h.get("op")))
                {
                    s.set("qqtoken",s.qqtoken = TOKEN[0] + "|" + TOKEN[1]);
                    response.sendRedirect("/jsp/weibo/WConfigEdit.jsp?community=" + h.community);
                    return;
                }
                String userid = hm.get(type == 1 ? "user_id" : "name");

                //
                json = OAuth.oauth(h.community,type == 1 ? "http://api.t.sina.com.cn/account/verify_credentials.json" : "http://open.t.qq.com/api/user/other_info?format=json&name=" + userid,false,null,TOKEN);
                //System.out.println(json);
                JSONObject o = new JSONObject(json);
                o = o.getJSONObject("data");

                String domain = userid;
                if(type == 1)
                {
                    domain = o.getString("domain");
                    if(domain.length() < 1)
                        domain = userid;
                }

                String member = OAuth.OAUTH_TYPE[type] + domain;

                Profile p = Profile.find(member);
                if(p.getTime() != null)
                    p = Profile.create(member,TOKEN[0],h.community,null,request.getServerName());
                //p.set(type, userid, TOKEN[0], TOKEN[1]);

                RV rv = new RV(member);
                session.setAttribute("tea.RV",rv);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                response.sendRedirect("/");
//                Friend f = new Friend(0,userid);
//                a.member = s.member;
//                a.userid = userid;
//                a.type = type;
//                a.token = TOKEN[0];
//                a.secret = TOKEN[1];
//                if(type == 1)
//                {
//                    f.name = a.name = o.getString("domain");
//                    f.nick = a.nick = o.getString("name");
//                    a.avatar = o.getString("profile_image_url");
//                } else
//                {
//                    f.name = a.name = o.getString("name");
//                    f.nick = a.nick = o.getString("nick");
//                    a.avatar = o.getString("head");
//                    if(a.avatar.length() > 0)
//                        a.avatar += "/50";
//                }
//                f.avatar = a.avatar;

            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

}
