package tea.ui.node.listing;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeletePickNode extends TeaServlet
{

	public DeletePickNode()
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
			int listing = Integer.parseInt(request.getParameter("listing"));
			int picknode = Integer.parseInt(request.getParameter("picknode"));

			PickNode obj = PickNode.find(picknode);
			listing = obj.listing;

			int j = Listing.find(listing).getNode();
			Node node = Node.find(j);
			if (!node.isCreator(teasession._rv) && AccessMember.find(j, teasession._rv._strV).getPurview() < 2)
			{
				response.sendError(403);
				return;
			}
			obj.delete();
			response.sendRedirect("/jsp/listing/Picks.jsp?node=" + teasession._nNode + "&listing=" + j);
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
		}
	}
}
