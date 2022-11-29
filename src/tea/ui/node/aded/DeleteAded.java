package tea.ui.node.aded;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Aded;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteAded extends TeaServlet
{

    public DeleteAded()
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
            Aded aded = Aded.find(Integer.parseInt(request.getParameter("aded")));
            aded.delete(teasession._nLanguage);
            response.sendRedirect("/jsp/aded/Adeds.jsp?node=" + teasession._nNode);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
