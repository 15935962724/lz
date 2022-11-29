package tea.ui.member.community;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.site.Organizer;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteOrganizers extends TeaServlet
{

    public DeleteOrganizers()
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
            String s = request.getParameter("community");
            if (!teasession._rv.isWebMaster())
            {
                response.sendError(403);
                return;
            }
            String as[] = request.getParameterValues("Organizers");
            if (as != null)
            {
                for (int i = 0; i < as.length; i++)
                {
                    Organizer obj = new Organizer(s, as[i]);
                    obj.delete();
                }
            }
            String nexturl = request.getParameter("nexturl");
            if (nexturl == null)
            {
                nexturl = request.getContextPath() + "/jsp/community/Organizers.jsp?community=" + s;
            }
            response.sendRedirect(nexturl);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
