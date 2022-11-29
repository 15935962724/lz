package tea.ui.member.community;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.site.Subscriber;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteAllSubscribers extends TeaServlet
{

    public DeleteAllSubscribers()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("Community");
            if (!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
            {
                response.sendError(403);
                return;
            }
            Subscriber.deleteByCommunity(s);
            response.sendRedirect("Subscribers?Community=" + s);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
