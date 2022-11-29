package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.Profile;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class CancelMembership extends TeaServlet
{

    public CancelMembership()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if (!teasession._rv.isReal())
            {
                response.sendError(403);
                return;
            }
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/profile/CancelMembership.jsp" + qs);
                /*
                                Form form = new Form("foCancel", "POST", "CancelMembership");
                                form.setOnSubmit("return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmCancelMembership") + "'));");
                                form.add(new Text(super.r.getString(teasession._nLanguage, "Password") + ":"));
                                form.add(new PasswordField("Password"));
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(super.r.getString(teasession._nLanguage, "InfCancelMembership"));
                                printwriter.print(form);
                                printwriter.print(new Script("document.foCancel.Password.focus();"));
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();*/
            } else
            {
                String s = request.getParameter("Password");
                if (!Profile.isPassword(teasession._rv._strR, s))
                {
                    super.outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidPassword"));
                    return;
                }
                Profile.cancel(teasession._rv._strR, teasession._strCommunity);
                request.getSession(true).removeAttribute("tea.RV");
                super.outText(teasession, response, super.r.getString(teasession._nLanguage, "InfMembershipCanceled"));
            }
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/profile/CancelMembership");
    }
}
