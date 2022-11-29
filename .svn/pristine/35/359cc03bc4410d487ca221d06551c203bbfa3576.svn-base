package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

import tea.ui.TeaServlet;
import tea.entity.admin.*;
// bian ji chu chai
public class EditEvection extends TeaServlet
{

	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		tea.ui.TeaSession teasession = null;
		teasession = new tea.ui.TeaSession(request);
		try
		{
			String area = teasession.getParameter("area");
			Date time_k = null, time_j = null;

			if (teasession.getParameter("time_k") != null && teasession.getParameter("time_k").length() > 0)
			{

				time_k = Evection.sdf.parse(teasession.getParameter("time_k"));
			}
			if (teasession.getParameter("time_j") != null && teasession.getParameter("time_j").length() > 0)
			{
				time_j = Evection.sdf.parse(teasession.getParameter("time_j"));
			}
			int unid = Integer.parseInt(teasession.getParameter("unid"));
			int classes = 0;// Integer.parseInt(teasession.getParameter("classes"));
			Evection.create(area, time_k, time_j, unid, classes, teasession._strCommunity, teasession._rv);
			response.sendRedirect("/jsp/admin/manage/evection.jsp");
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
