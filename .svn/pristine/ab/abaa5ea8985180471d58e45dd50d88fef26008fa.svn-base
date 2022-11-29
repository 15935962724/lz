package tea.ui.member.email;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.EmailBox;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteEmailBox extends TeaServlet
{

    public DeleteEmailBox()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            int id = Integer.parseInt(request.getParameter("emailbox"));
            EmailBox emailbox = EmailBox.find(id);
            emailbox.delete();
            response.sendRedirect("EmailBoxs");
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
