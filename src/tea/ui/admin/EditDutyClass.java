package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.net.*;

import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.site.*;

public class EditDutyClass extends TeaServlet
{
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			String act = teasession.getParameter("act");
			String nexturl = request.getParameter("nexturl");

			if (act!=null&&act.startsWith("bookinday"))
			{
				DutyClass obj=DutyClass.findByMember(teasession._strCommunity, teasession._rv._strV);
				obj.set(act, teasession._strCommunity, teasession._rv);
			}

			response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + URLEncoder.encode(nexturl, "UTF-8"));
		} catch (Exception ex)
		{
			ex.printStackTrace();
			response.sendError(400);
		}
	}

}
