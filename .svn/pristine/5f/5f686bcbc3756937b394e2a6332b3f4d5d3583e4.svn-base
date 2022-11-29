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

public class DeleteMessageFolder extends TeaServlet
{

    public DeleteMessageFolder()
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
            int messagefolder = Integer.parseInt(request.getParameter("messagefolder"));
            MessageFolder fm = MessageFolder.find(messagefolder);
            fm.delete(teasession._nLanguage);
            MessageFolder.deleteMessageFolderLayerx(messagefolder);
            MessageFolderContent.deleteAll(messagefolder);
            response.sendRedirect("ManageMessageFolders");
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
