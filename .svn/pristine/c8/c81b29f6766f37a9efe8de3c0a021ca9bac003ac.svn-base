package tea.ui.member.messagefolder;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.MessageFolder;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteMessageFolderSubscribers extends TeaServlet
{

    public DeleteMessageFolderSubscribers()
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
                response.sendRedirect("/servlet/StartLogin?community=" + teasession._strCommunity);
                return;
            }
            if (!teasession._rv.isSupport())
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("MessageFolder");
            String as[] = request.getParameterValues("MessageFolderSubscribers");
            if (as != null)
            {
                for (int i = 0; i < as.length; i++)
                {
                    if (request.getParameter(as[i]) != null)
                    {
                        MessageFolder.deleteSubscriber(s, as[i]);
                    }
                }

            }
            response.sendRedirect("MessageFolderSubscribers?MessageFolder=" + s);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
