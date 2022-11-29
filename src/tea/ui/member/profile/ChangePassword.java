package tea.ui.member.profile;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Profile;
import tea.http.RequestHelper;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.resource.Resource;
import tea.service.SMS;
import tea.entity.csvclub.*;
import java.io.PrintWriter;

public class ChangePassword extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        TeaSession teasession = new TeaSession(request);
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Resource r = new Resource("/tea/resource/Photography");
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            if(!teasession._rv.isReal())
            {
                response.sendError(403);
                return;
            }
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/user/ChangePassword.jsp");
            } else
            {
                out.print("<script>var mt=parent.mt;</script>");
                String s = request.getParameter("old");
                String s1 = request.getParameter("password");
                String community = request.getParameter("community");
                String action = request.getParameter("action");
                String member = request.getParameter("member");
                String email = request.getParameter("email");
                if("csvclub".equals(teasession._strCommunity) && "ChangePasswordMd5".equals(action) && Profile.isPasswordMd5(member,email))
                {
                    Profile p2 = Profile.find(member);
                    p2.setPassword(SMS.md5_16(s1));
                    Csvdogdvuser csvobj = Csvdogdvuser.find(member);
                    csvobj.updatepassword(member,SMS.md5_16(s1));
                    response.sendRedirect("/jsp/info/Succeed.jsp");
                    return;
                }
                if("csvclub".equals(teasession._strCommunity) && !Profile.isPassword(teasession._rv._strR,SMS.md5_16(s)))
                {
                    outText(teasession,response,r.getString(teasession._nLanguage,"InvalidOldPassword"));
                    return;
                } else if(!Profile.isPassword(teasession._rv._strR,s))
                {
                    out.print("<script>mt.show('" + r.getString(teasession._nLanguage,"InvalidOldPassword") + "');</script>");
                    return;
                }
                if(!RequestHelper.isIdentifier(s1))
                {
                    out.print("<script>mt.show('" + r.getString(teasession._nLanguage,"InvalidPassword") + "');</script>");
                    return;
                }
                Profile p = Profile.find(teasession._rv._strR);

                if("csvclub".equals(teasession._strCommunity))
                {
                    p.setPassword(SMS.md5_16(s1));
                    Csvdogdvuser csvobj = Csvdogdvuser.find(member);
                    csvobj.updatepassword(member,SMS.md5_16(s1));
                    response.sendRedirect("/jsp/info/Succeed.jsp");
                } else
                {
                    p.setPassword(s1);
                    out.print("<script>mt.show('" + r.getString(teasession._nLanguage,"4998537487") + "',1,'parent.location.reload()');</script>");
                }
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
        r.add("tea/ui/member/profile/ChangePassword");
    }
}
