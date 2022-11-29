package tea.ui.member.feedback;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.*;
import tea.ui.*;


public class DeleteAllFeedbacks extends TeaServlet
{

    public DeleteAllFeedbacks()
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
            String s = request.getParameter("Member");
            Feedback.deleteByMember(teasession._strCommunity, s);
            response.sendRedirect("Feedbacks?Member=" + s);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
