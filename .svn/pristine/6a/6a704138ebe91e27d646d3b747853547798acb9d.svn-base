package tea.ui.member.request;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Message;
import tea.entity.member.ProfileRequest;
import tea.html.Anchor;
import tea.html.Text;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class GrantProfileRequests extends TeaServlet
{

    public GrantProfileRequests()
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
            String as[] = request.getParameterValues("ProfileRequests");
            if (as != null)
            {
                for (int i = 0; i < as.length; i++)
                {
                    if (request.getParameter(as[i]) != null)
                    {
                        RV rv = new RV(as[i]);
                        if (request.getParameter("Grant") != null)
                        {
                            ProfileRequest.grant(teasession._rv._strR, rv);
                            String s = RequestHelper.format(r.getString(teasession._nLanguage, "InfPermitProfile"), teasession._rv._strR);
                            String s2 = r.getString(teasession._nLanguage, "ClickHere");
                            Message.create(teasession._strCommunity, teasession._rv._strV, rv.toString(), teasession._nLanguage, s, "" + new Anchor("http://" + request.getServerName() + "/jsp/access/Glance.jsp?Member=" + teasession._rv._strR, new Text(s2)));
                        } else if (request.getParameter("Deny") != null)
                        {
                            ProfileRequest.deny(teasession._rv._strR, rv);
                            String s1 = RequestHelper.format(r.getString(teasession._nLanguage, "InfProhibitProfile"), teasession._rv._strR);
                            String s3 = r.getString(teasession._nLanguage, "ClickHere");
                            try
                            {
                                s1 = new String(s1.getBytes(), "ISO-8859-1");
                                s3 = new String(s3.getBytes(), "ISO-8859-1");
                            } catch (Exception exception2)
                            {
                            }
                            Message.create(teasession._strCommunity, teasession._rv._strV, rv.toString(), teasession._nLanguage, s1, "" + new Anchor("http://" + request.getServerName() + "/servlet/NewMessage?Receiver=" + teasession._rv._strR, new Text(s3)));
                        }
                    }
                }
            }
            response.sendRedirect("ProfileRequests?community=" + teasession._strCommunity);
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/request/GrantProfileRequests");
    }
}
