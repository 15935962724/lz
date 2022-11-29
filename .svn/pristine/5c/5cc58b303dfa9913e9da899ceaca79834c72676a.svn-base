package tea.ui.member.request;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Message;
import tea.entity.site.JoinRequest;
import tea.html.Anchor;
import tea.html.Text;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class GrantJoinRequests extends TeaServlet
{

	public GrantJoinRequests()
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
			String s = request.getParameter("Community");
			if (!teasession._rv.isOrganizer(s))
			{
				response.sendError(403);
				return;
			}
			String as[] = request.getParameterValues("Members");
			if (as != null)
			{
				for (int i = 0; i < as.length; i++)
				{
					// if (request.getParameter(as[i]) != null)
					{
						String cmember = request.getParameter(as[i]);
						RV rv = new RV(as[i], cmember);
						if (request.getParameter("Grant") != null)
						{
							JoinRequest.grant(s, rv);
							String s1 = RequestHelper.format(r.getString(teasession._nLanguage, "InfPermitJoin"), s);
							String s3 = r.getString(teasession._nLanguage, "ClickHere");
							Message.create(teasession._strCommunity, teasession._rv._strV, rv.toString(),teasession._nLanguage, s1, "" + new Anchor("http://" + request.getServerName() + "/servlet/node?Community=" + s, new Text(s3)));
						} else if (request.getParameter("Deny") != null)
						{
							JoinRequest.deny(s, rv);
							String s2 = RequestHelper.format(r.getString(teasession._nLanguage, "InfProhibitJoin"), s);
							String s4 = r.getString(teasession._nLanguage, "ClickHere");
							Message.create(teasession._strCommunity, teasession._rv._strV, rv.toString(), teasession._nLanguage,s2, "" + new Anchor("http://" + request.getServerName() + "NewMessage?Receiver=" + teasession._rv._strR, new Text(s4)));
						}
					}
				}
			}
			String nexturl = request.getParameter("nexturl");
			if (nexturl == null)
			{
				nexturl = "JoinRequests?Community=" + s;
			}
			response.sendRedirect(nexturl);
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		r.add("tea/ui/member/request/GrantJoinRequests");
	}
}
