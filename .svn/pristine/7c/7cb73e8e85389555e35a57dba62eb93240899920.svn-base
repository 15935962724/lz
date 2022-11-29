package tea.ui.member.community;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.site.Manager;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteAllManager extends TeaServlet
{

    public DeleteAllManager()
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
            String s = request.getParameter("Community");
            if (!teasession._rv.isWebMaster())
            {
                response.sendError(403);
                return;
            }
            Manager.deleteByCommunity(s);
            response.sendRedirect("Manager?Community=" + s);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
