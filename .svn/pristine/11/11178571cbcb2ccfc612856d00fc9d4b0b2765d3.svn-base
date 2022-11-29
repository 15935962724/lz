package tea.ui.node.type.bargain;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.node.AccessMember;
import tea.entity.node.BargainPrice;
import tea.entity.node.Node;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteBargainPrice extends TeaServlet
{

	public DeleteBargainPrice()
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
			if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview() > 2)
			{
				response.sendError(403);
				return;
			}
			BargainPrice bargainprice = BargainPrice.find(teasession._nNode, Integer.parseInt(request.getParameter("Currency")));
			bargainprice.delete();
			response.sendRedirect("BargainPrices?node=" + teasession._nNode);
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
		}
	}
}
