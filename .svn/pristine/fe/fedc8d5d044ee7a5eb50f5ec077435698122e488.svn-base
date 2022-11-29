package tea.ui.member.community;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.site.Community;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteCommunity extends TeaServlet
{

    public DeleteCommunity()
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
            if (!teasession._rv.isWebMaster())
            {
                response.sendError(403);
                return;
            }
            Community community = Community.find(request.getParameter("community"));
            community.delete(teasession._nLanguage);
//            java.io.File file = new java.io.File(getServletContext().getRealPath( "/tea/image/section/" + community._strCommunity + ".css"));
//            file.delete();
            response.sendRedirect("Communities");
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
