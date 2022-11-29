package tea.ui.node.aded;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Aded;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class AdedPicture extends TeaServlet
{

    public AdedPicture()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            response.sendRedirect(Aded.find(Integer.parseInt(request.getParameter("Aded"))).getPicture(teasession._nLanguage));
            //outStream(response, Aded.find(Integer.parseInt(request.getParameter("Aded"))).getPicture(teasession._nLanguage));
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
}
