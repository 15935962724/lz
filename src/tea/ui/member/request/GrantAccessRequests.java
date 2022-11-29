package tea.ui.member.request;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Message;
import tea.entity.node.AccessRequest;
import tea.entity.node.*;
import tea.html.Anchor;
import tea.html.Text;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class GrantAccessRequests extends TeaServlet
{

	public GrantAccessRequests()
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
			Node node = Node.find(teasession._nNode);
			if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview() < 2)
			{
				response.sendError(403);
				return;
			}
			String as[] = request.getParameterValues("AccessRequests");
			if (as != null)
			{
				String s = Node.find(teasession._nNode).getSubject(teasession._nLanguage);
				for (int i = 0; i < as.length; i++)
				{
					// if (request.getParameter(as[i]) != null)
					{
						RV rv = new RV(as[i], node.getCommunity());
						if (request.getParameter("Grant") != null)
						{
							AccessRequest.grant(teasession._nNode, rv);
							String s1 = RequestHelper.format(r.getString(teasession._nLanguage, "InfPermitAccess"), s);
							String s3 = r.getString(teasession._nLanguage, "ClickHere");

							Message.create(teasession._strCommunity, teasession._rv._strV, rv.toString(), teasession._nLanguage, s1, "" + new Anchor("http://" + request.getServerName() + "/servlet/Node?node=" + teasession._nNode, new Text(s3)));
						} else if (request.getParameter("Deny") != null)
						{
							AccessRequest.deny(teasession._nNode, rv);
							String s2 = RequestHelper.format(r.getString(teasession._nLanguage, "InfProhibitAccess"), s);
							String s4 = r.getString(teasession._nLanguage, "ClickHere");
							Message.create(teasession._strCommunity, teasession._rv._strV, rv.toString(), teasession._nLanguage, s2, "" + new Anchor("http://" + request.getServerName() + "/servlet/Node?node=" + teasession._nNode, new Text(s4)));
						}
					}
				}
			}
			response.sendRedirect("/jsp/request/AccessRequests.jsp?node=" + teasession._nNode);
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		r.add("tea/ui/member/request/GrantAccessRequests");
	}
}
