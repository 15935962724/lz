package tea.ui.member.messagefolder;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.MessageFolder;
import tea.entity.member.MessageFolderContent;
import tea.http.MultipartRequest;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteMessageFolderContents extends TeaServlet
{

    public DeleteMessageFolderContents()
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
                response.sendRedirect("/servlet/StartLogin?node=" + h.node + "&nexturl=" + s);
                return;
            }
            if (!teasession._rv.isSupport())
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("Operation");
            if (s == null)
            {
                s = "";
            }
            String s1 = request.getParameter("MessageFolder0");
            if (s1 == null)
            {
                s1 = "";
            }
            String s2 = MessageFolder.getMember(s1);
            String s3 = request.getParameter("MessageFolder");
            if (s3 == null)
            {
                s3 = "";
            }
            String s4 = MessageFolder.getMember(s3);
            int i = MessageFolder.getType(s3);
            if (!s4.equals(teasession._rv._strR))
            {
                boolean flag = false;
                int j = 0;
                try
                {
                    j = Integer.parseInt(request.getParameter("UseAsMyOwnMessageFolder"));
                } catch (Exception exception1)
                {
                    flag = true;
                }
                if (!flag)
                {
                    if (j == 1)
                    {
                        MessageFolder.setUseAsMyOwnMessageFolder(teasession._rv._strR, s3);
                    } else
                    {
                        MessageFolder.deleteUseAsMyOwnMessageFolder(teasession._rv._strR, s3);
                        response.sendRedirect("ManageMessageFolders");
                        return;
                    }
                }
            }
            String as[] = request.getParameterValues("Messages");
            if (as != null)
            {
                boolean flag1 = teasession.getParameter("DeleteOriginal") != null;
                for (int k = 0; k < as.length; k++)
                {
                    int l = Integer.parseInt(as[k]);
                    if (s.equals("PutInFolder"))
                    {
                        MessageFolderContent.create(s4, s3, l);
                        if (flag1)
                        {
                            MessageFolderContent.delete(s2, s1, l);
                        }
                    } else
                    {
                        MessageFolderContent.delete(s4, s3, l);
                    }
                }

            }
            response.sendRedirect("MessageFolderContents?MessageFolder=" + s3);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
