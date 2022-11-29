package tea.ui.member.profile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Associate;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteAssociate extends TeaServlet
{

    public DeleteAssociate()
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
            if (!teasession._rv.isHR())
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("Associate");
            Associate associate = Associate.find(teasession._rv._strR, s);
            associate.delete();
            response.sendRedirect("Associates");
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
