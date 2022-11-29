package tea.ui.node.type.poll;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Node;
import tea.entity.node.PollResult;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeletePollResult extends TeaServlet
{

    public DeletePollResult()
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
            PollResult pollresult = PollResult.find(Integer.parseInt(request.getParameter("PollResult")));
            int i = pollresult.getPoll();
            tea.entity.node.Poll p = tea.entity.node.Poll.find(i);
            int _nNode = p.getNode();
            Node node = Node.find(_nNode);
            if (!node.isCreator(teasession._rv) && !teasession._rv.equals(pollresult.getMember()))
            {
                response.sendError(403);
                return;
            }
            pollresult.delete();
            response.sendRedirect("PollResults?node=" + _nNode);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
