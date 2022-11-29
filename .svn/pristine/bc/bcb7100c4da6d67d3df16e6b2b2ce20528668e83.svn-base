package tea.ui.weibo;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.weibo.*;

public class WConfigs extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.print("<script>var mt=parent.mt;</script>");
            TeaSession ts = new TeaSession(request);
            if(ts._rv == null)
            {
                out.print("<script>parent.location.replace('/servlet/StartLogin?node=" + h.node + "')</script>");
                return;
            }
            h.username = ts._rv._strV;

            WConfig t = WConfig.find(h.community);
            if("edit".equals(act))
            {
                t.sinaid = h.get("sinaid");
                t.sinakey = h.get("sinakey");
                t.sinasecret = h.get("sinasecret");
                t.sinatoken = h.get("sinatoken");
                //
                t.qqid = h.get("qqid");
                t.qqkey = h.get("qqkey");
                t.qqsecret = h.get("qqsecret");
                t.qqtoken = h.get("qqtoken");
                //
                t.topic = h.get("topic");
                t.url = h.get("url");
                String tmp = h.get("picture");
                if(tmp != null)
                    t.picture = tmp;
                //土豆
                t.tudouuser = h.get("tudouuser");
                t.tudoupassword = h.get("tudoupassword");
                t.tudoukey = h.get("tudoukey");

                t.login = h.getBool("login");
                t.set();
            } else if("voice".equals(act))
            {
                t.tudouuser = h.get("tudouuser");
                t.tudoupassword = h.get("tudoupassword");
                t.tudoukey = h.get("tudoukey");
                t.set();
            } else if("auth".equals(act))
            {
                out.print("<script>mt.show('/OAuth2s.do?community=" + h.community + "',1,'账号授权',600,400);parent.$('dialog_content').onpropertychange=function(){this.width=600;this.height=430;var s=this.style;if(s.cssText!='')s.cssText=''};</script>");
                return;
            } else if("auth2".equals(act))
            {
                out.print("<script>mt.show('/OAuths.do?community=" + h.community + "&type=2',1,'账号授权',600,400);parent.$('dialog_content').onpropertychange=function(){this.width=600;this.height=430;var s=this.style;if(s.cssText!='')s.cssText=''};</script>");
                return;
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
