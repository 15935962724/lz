package tea.ui.node.type.poll;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteAllPollResults extends TeaServlet
{

	public DeleteAllPollResults()
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
			if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview() < 2)
			{
				response.sendError(403);
				return;
			}
			PollResult.deleteByPoll(teasession._nNode);
			response.sendRedirect("PollResults?node=" + teasession._nNode);
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
		}
	}
}
