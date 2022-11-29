package tea.ui.node.section;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.RV;
import tea.entity.node.*;
import tea.ui.*;
import tea.entity.member.*;

public class DeleteSection extends TeaServlet
{

	public DeleteSection()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			int i = Integer.parseInt(request.getParameter("section"));
			Section obj = Section.find(i);
			int j = obj.getNode();
			int status = obj.getStatus();
			Node node = Node.find(j);
			if (!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode, teasession._rv).getPurview() < 3)
			{
				response.sendError(403);
				return;
			}
			RV rv = teasession._rv;
			if (rv == null)
			{
				rv = new RV("<" + request.getRemoteAddr() + ">");
			}
			obj.delete(teasession._nLanguage);
			Logs.create(teasession._strCommunity, rv, 7, i, "");
			String nexturl = request.getParameter("nexturl");
			if (nexturl == null)
			{
				nexturl = "/jsp/section/Sections.jsp?node=" + teasession._nNode + "&status=" + status;
			}
			response.sendRedirect(nexturl);
		} catch (Exception ex)
		{
			response.sendError(400, ex.toString());
			ex.printStackTrace();
		}
	}
}
