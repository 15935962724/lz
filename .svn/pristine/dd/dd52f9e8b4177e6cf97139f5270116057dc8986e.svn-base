package tea.ui.node.type.stamp;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaServlet;

public class EditStamp extends TeaServlet
{

    public EditStamp()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.sendRedirect("Node?node=" + request.getParameter("Node") + "&edit=ON");
    }
}
