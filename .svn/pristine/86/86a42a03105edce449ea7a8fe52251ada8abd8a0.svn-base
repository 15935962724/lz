package tea.ui.member.request;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Message;
import tea.entity.node.*;
import tea.html.Anchor;
import tea.html.Text;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class GrantAdRequests extends TeaServlet
{

	public GrantAdRequests()
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
			String as[] = request.getParameterValues("AdRequests");
			if (as != null)
			{
				for (int i = 0; i < as.length; i++)
					if (request.getParameter(as[i]) != null)
					{
						int j = Integer.parseInt(as[i]);
						Aded aded = Aded.find(j);
						RV rv = aded.getCreator();
						String s = Ading.find(aded.getAding()).getName(teasession._nLanguage);
						int k = aded.getNode();
						if (request.getParameter("Grant") != null)
						{
							aded.grant();
							String s1 = RequestHelper.format(r.getString(teasession._nLanguage, "InfPermitAd"), s);
							String s3 = r.getString(teasession._nLanguage, "ClickHere");
							Message.create(teasession._strCommunity, teasession._rv._strV, rv.toString(), teasession._nLanguage,s1, "" + new Anchor("http://" + request.getServerName() + "/servlet/Node?node=" + k, new Text(s3)));
						} else if (request.getParameter("Deny") != null)
						{
							aded.deny();
							String s2 = RequestHelper.format(r.getString(teasession._nLanguage, "InfProhibitAd"), s);
							String s4 = r.getString(teasession._nLanguage, "ClickHere");
							Message.create(teasession._strCommunity, teasession._rv._strV, rv.toString(),teasession._nLanguage, s2, "" + new Anchor("http://" + request.getServerName() + "/servlet/Node?node=" + k, new Text(s4)));
						}
					}
			}
			response.sendRedirect("/jsp/request/AdRequests.jsp?node=" + teasession._nNode);
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		r.add("tea/ui/member/request/GrantAdRequests");
	}
}
