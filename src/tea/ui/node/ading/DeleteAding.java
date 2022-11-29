package tea.ui.node.ading;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Ading;
import tea.entity.node.Node;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteAding extends TeaServlet
{

    public DeleteAding()
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
            Ading ading = Ading.find(Integer.parseInt(request.getParameter("ading")));
            Node node = Node.find(ading.getNode());
            if (!node.isCreator(teasession._rv) || !teasession._rv.isAdManager())
            {
                response.sendError(403);
                return;
            }
            ading.delete(teasession._nLanguage);
            response.sendRedirect("/jsp/ading/Adings.jsp?node=" + teasession._nNode);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
