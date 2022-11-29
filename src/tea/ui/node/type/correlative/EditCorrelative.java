package tea.ui.node.type.correlative;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaSession;
import tea.entity.*;
import tea.entity.node.*;

public class EditCorrelative extends HttpServlet
{
	private static final String CONTENT_TYPE = "text/html; charset=UTF-8";

	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			int id = Integer.parseInt(request.getParameter("correlative"));
			if (request.getParameter("delete") != null)
			{
				Correlative lc = Correlative.find(id);
				lc.delete();
			} else
			{
				int type = Integer.parseInt(request.getParameter("type"));
				int cnode = Integer.parseInt(request.getParameter("cnode"));
				int options = 0;
				try
				{
					if (request.getParameter("options") != null)
					{
						options = Integer.parseInt(request.getParameter("options"));
					}
				} catch (NumberFormatException ex1)
				{
				}
				float price = 0.0F;
				try
				{
					if (request.getParameter("price") != null)
					{
						price = Float.parseFloat(request.getParameter("price"));
					}
				} catch (NumberFormatException ex2)
				{
				}
				String other = request.getParameter("other");
				String synopsis = request.getParameter("synopsis");
				String content = request.getParameter("content");

				if (id == 0)
				{
					Correlative.create(teasession._nNode, cnode, type, options, price, other, teasession._nLanguage, synopsis, content);
				} else
				{
					Correlative lc = Correlative.find(id);
					lc.set(teasession._nNode, cnode, type, options, price, other, teasession._nLanguage, synopsis, content);
				}
			}
			String nexturl = request.getParameter("nexturl");
			if (nexturl != null)
			{
				response.sendRedirect(nexturl);
			} else
			{
				response.sendRedirect("/jsp/type/correlative/EditCorrelative.jsp?node=" + teasession._nNode + request.getParameter("types"));
			}
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
