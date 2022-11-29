package tea.entity.integral;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.*;
import tea.entity.admin.mov.*;
import java.math.BigDecimal;

public class EditIntegral extends TeaServlet
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
			    String community = request.getParameter("community");
				try
				{


				 if("Integral".equals(act))
				 {

				 }

				 response.sendRedirect(nexturl+"&community="+community);
				 return;

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
