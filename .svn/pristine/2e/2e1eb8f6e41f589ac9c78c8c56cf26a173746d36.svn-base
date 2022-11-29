package tea.ui.member.messagefolder;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.MessageFolder;
import tea.entity.member.MessageFolderContent;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteAllMessageFolderContents extends TeaServlet
{

    public DeleteAllMessageFolderContents()
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
            String s = request.getParameter("Operation");
            if (s == null)
            {
                s = "";
            }
            int messagefolder = Integer.parseInt(request.getParameter("messagefolder"));
            MessageFolder mf = MessageFolder.find(messagefolder);
            int i = mf.getType();
            String s2 = mf.getMember();
            if (s2.equals(teasession._rv._strR) && teasession._rv.isSupport() || i == 3)
            {
                MessageFolderContent.deleteAll(messagefolder);
            }
            response.sendRedirect("MessageFolderContents?messagefolder=" + messagefolder);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
