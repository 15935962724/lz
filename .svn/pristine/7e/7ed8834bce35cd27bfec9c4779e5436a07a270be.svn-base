package tea.ui.util;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Message;
import tea.entity.member.Profile;
import tea.entity.site.*;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.service.Robot;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class RetrieveMemberId extends TeaServlet
{

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/util/RetrieveMemberId.jsp?" +request.getQueryString());
                /*
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(super.r.getString(teasession._nLanguage, "InfRetrieveMemberId"));
                                Form form = new Form("foRetrieve", "POST", "RetrieveMemberId");
                                form.setOnSubmit("return(submitEmail(this.Email,'" + super.r.getString(teasession._nLanguage, "InvalidEmail") + "'));");
                                form.add(new Text(super.r.getString(teasession._nLanguage, "EmailAddress") + ":"));
                                form.add(new TextField("Email"));
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                printwriter.print(form);
                                printwriter.print(new Script("document.foRetrieve.Email.focus();"));
                                printwriter.print(RequestHelper.format(super.r.getString(teasession._nLanguage, "InfFindMoreHelp"), License.getInstance().getWebSupport()));
                                printwriter.close();*/
                return;
            } else
            {
                String s = request.getParameter("Email");
                if (!RequestHelper.isEmail(s))
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidEmail"));
                    return;
                }
                String s1 = Profile.retrieveByEmail(s);
                if (s1.length() != 0)
                {
                    String s2 = License.getInstance().getWebSupport();
                    Community c=Community.find(teasession._strCommunity);
                    
                    int i = Message.create(teasession._strCommunity,s2, s1,teasession._nLanguage, super.r.getString(teasession._nLanguage, "RetrieveMemberId") + " - " + c.getName(teasession._nLanguage), super.r.getString(teasession._nLanguage, "InfMemberIdIs") + s1 + "\n" + RequestHelper.format(super.r.getString(teasession._nLanguage, "InfFindMoreHelp"), s2));
                    try
                    {
                        Robot.activateRoboty(i);
                    } catch (Exception _ex)
                    {}
                    outText(teasession, response, RequestHelper.format(super.r.getString(teasession._nLanguage, "InfMemberIdSent"), s));
                } else
                {
                    outText(teasession, response, RequestHelper.format(super.r.getString(teasession._nLanguage, "NotExist"), s));
                }
            }
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/util/RetrieveMemberId");
    }
}
