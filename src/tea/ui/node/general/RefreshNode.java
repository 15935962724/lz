package tea.ui.node.general;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import java.sql.SQLException;
import tea.entity.node.*;

public class RefreshNode extends TeaServlet
{
	// Initialize global variables
	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}

	// Process the HTTP Get request
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
			if (!node.isCreator(teasession._rv) && !teasession._rv.isManager(node.getCommunity()) && AccessMember.find(teasession._nNode, teasession._rv._strV).getPurview() < 2)
			{
				response.sendError(403);
				return;
			}
			node.setTime(new java.util.Date());
			String nexturl = request.getParameter("nexturl");
			if (nexturl == null)
			{
				nexturl = request.getContextPath() + "/servlet/Node?node=" + teasession._nNode;
			}
			response.sendRedirect(nexturl);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	// Clean up resources
	public void destroy()
	{
	}
}
