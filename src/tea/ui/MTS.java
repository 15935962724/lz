package tea.ui;

import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import java.io.*;
import tea.entity.member.*;
import tea.entity.site.*;
import tea.service.*;

public class MTS extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        try
        {
            String act = h.get("act");
            String nexturl = h.get("nexturl");
            if("login".equals(act))
            {
                String member = h.get("LoginId");
                String password = h.get("Password");
                if(!Profile.isPassword(member,password))
                {
                    out.print("<script>alert('用户名或密码错误！');</script>");
                    return;
                }
                RV rv = new RV(member);
                Logs.create(h.community,rv,1,h.node,request.getRemoteAddr());
                OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
                Community c = Community.find(h.community);
                
                Profile p = Profile.find(member);
                session.setAttribute("tea.RV",rv);
                if(c.isSession())
                {
                    //session.setAttribute("tea.RV",rv);
                } else
                {
                    Cookie cs = new Cookie("tea.RV",java.net.URLEncoder.encode(member + "," + SMS.md5(String.valueOf(p.getTime().getTime())),"UTF-8"));
                    cs.setPath("/");
                    String sn = request.getServerName();
                    int j = sn.indexOf(".");
                    if(j != -1 && sn.charAt(sn.length() - 1) > 96)
                        cs.setDomain(sn.substring(j));
                    response.addCookie(cs);
                }
                out.print("<script>parent.location.replace('" + nexturl + "');</script>");
                return;
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

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/ui/node/type/sms/EditUser");
    }
}
