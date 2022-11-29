package tea.ui.node.type.author;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.entity.node.Node;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteAuthor extends TeaServlet
{

    public DeleteAuthor()
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
            Author author = Author.find(Integer.parseInt(request.getParameter("Author")));
            Node node = Node.find(author.getNode());
            if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview()<2)
            {
                response.sendError(403);
                return;
            }
            author.delete(teasession._nLanguage);
            response.sendRedirect("Node?node=" + teasession._nNode);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
