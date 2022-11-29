package tea.ui.member.email;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.EmailBox;
import tea.html.*;
import tea.htmlx.MessageUI;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditEmailBox extends TeaServlet
{

    public EditEmailBox()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/message/EditEmailBox.jsp?" + request.getQueryString());
            } else
            {
                int emailbox = Integer.parseInt(request.getParameter("emailbox"));
                String email = request.getParameter("email");
                if(!RequestHelper.isEmail(email))
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidEmailBox"));
                    return;
                }
                String smtpserver = request.getParameter("smtpserver");
                int smtpport = Integer.parseInt(request.getParameter("smtpport"));
                String s1 = request.getParameter("Pop3Server");
                String s3 = request.getParameter("Pop3Port");
                int j = 110;
                try
                {
                    j = Integer.parseInt(s3);
                } catch(Exception exception1)
                {}
                String s5 = request.getParameter("Pop3User");
                String s7 = request.getParameter("Pop3Passwd");
                int k = 0;
                if(request.getParameter("Pop3OAutoDelete") != null)
                {
                    k |= 1;
                }
                if(request.getParameter("Pop3OKeepCopy") != null)
                {
                    k |= 2;
                }
                if(request.getParameter("Pop3OAutoCheck") != null)
                {
                    k |= 4;
                    if(s1.length() == 0 || s3.length() == 0 || s5.length() == 0 || s7.length() == 0)
                    {
                        outText(teasession,response,super.r.getString(teasession._nLanguage,"IncompleteMailBoxAccountInformation"));
                        return;
                    }
                }
                if(s1.length() == 0)
                {
                    s1 = email.substring(email.indexOf('@') + 1);
                }
                if(s5.length() == 0)
                {
                    s5 = email.substring(0,email.indexOf('@'));
                }
                EmailBox.create(emailbox,teasession._strCommunity,teasession._rv._strR,email,smtpserver,smtpport,s1,j,s5,s7,k);
                response.sendRedirect("/jsp/message/EmailBoxs.jsp?community=" + teasession._strCommunity);
            }
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/email/EditEmailBox").add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/contact/CGroups");
    }
}
