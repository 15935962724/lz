package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.*;

public class EditOut extends TeaServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}
	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		TeaSession teasession = new TeaSession(request);
		if (teasession._rv == null)
		{
			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
			return;
		}
		String act = teasession.getParameter("act");
		String nexturl = request.getParameter("nexturl");
		try
		{
			if ("deleteout".equals(act))
			{
				Outs obj = Outs.findByMember(teasession._strCommunity, teasession._rv._strV);
				obj.delete();
			} else if ("editout".equals(act))
			{
				String cause = teasession.getParameter("cause");
				String time_w = teasession.getParameter("time_w");
				String time_h = teasession.getParameter("time_h");
				// int bumen =Integer.parseInt(teasession.getParameter("bumen"));
				String names = teasession.getParameter("name");
				String a[] = names.split(":");
				String name = a[0];
				int bumen = 0;// Integer.parseInt(a[1]);
				int unitid = 0;// Integer.parseInt(a[2]);
				int un = 0;// Integer.parseInt(teasession.getParameter("un"));
				int cl = 0;// Integer.parseInt(teasession.getParameter("cl"));
				// int unitid = Integer.parseInt(teasession.getParameter("unitid"));//用户的部门id
				Outs.create(unitid, name, cause, time_w, time_h, bumen, teasession._strCommunity, teasession._rv, un, cl);
			}
			response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + URLEncoder.encode(nexturl, "UTF-8"));
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}

	}

	// Clean up resources
	public void destroy()
	{
	}
}
