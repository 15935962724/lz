package tea.ui.member.feedback;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Feedback;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteFeedback extends TeaServlet
{

    public DeleteFeedback()
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
            Feedback feedback = Feedback.find(Integer.parseInt(request.getParameter("Feedback")));
            String s = feedback.getMember();
            RV rv = feedback.getRV();
            if (!teasession._rv.isWebMaster() && !rv.equals(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            feedback.delete();
            response.sendRedirect("Feedbacks?Member=" + s);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
