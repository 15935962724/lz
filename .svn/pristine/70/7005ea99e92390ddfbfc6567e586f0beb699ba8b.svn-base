package tea.ui.node.aded;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.*;
import tea.entity.node.Aded;
import tea.entity.node.AdedCounter;
import javax.servlet.http.HttpServlet;

public class AdedServlet extends HttpServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            Http h = new Http(request);
            int i = h.getInt("aded");
            Aded aded = Aded.find(i);
            AdedCounter.find(i).click();
            response.sendRedirect(aded.getClickUrl(h.language));
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
}
