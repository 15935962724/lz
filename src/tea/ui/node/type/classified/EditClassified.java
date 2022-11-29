package tea.ui.node.type.classified;

import java.io.IOException; //import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.ui.*;

public class EditClassified extends TeaServlet
{

	public EditClassified()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}
			Node node = Node.find(teasession._nNode);
			if (!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode, teasession._rv._strV).getPurview()<2)
			{
				response.sendError(403);
				return;
			}

			if (request.getMethod().equals("GET"))
			{
				response.sendRedirect("/jsp/type/classified/EditClassified.jsp?" + request.getQueryString());
				return;
			} else
			{
				Classified classified = Classified.find(teasession._nNode);
				String s = request.getParameter("Contact").trim();
				String s1 = request.getParameter("Email").trim();
				String s2 = request.getParameter("Organization");
				String s3 = request.getParameter("Address");
				String s4 = request.getParameter("City");
				String s5 = request.getParameter("State");
				String s6 = request.getParameter("Zip");
				String s7 = request.getParameter("Country");
				String s8 = request.getParameter("Telephone");
				String s9 = request.getParameter("Fax");
				String s10 = request.getParameter("WebPage");
				int i = Integer.parseInt(request.getParameter("WebLanguage"));
				classified.set(teasession._nLanguage, s, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, i);

				node.set(teasession._nLanguage, request.getParameter("Name"), request.getParameter("Text"));
				delete(node);
				if (request.getParameter("GoBack") != null)
				{
					response.sendRedirect("EditNode?node=" + teasession._nNode);
				} else
				{
					response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
				}
			}
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		// super.r.add("tea/ui/node/type/classified/EditClassified");
	}
}
