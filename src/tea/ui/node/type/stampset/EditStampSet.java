package tea.ui.node.type.stampset;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaServlet;

public class EditStampSet extends TeaServlet
{

    public EditStampSet()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.sendRedirect("Node?node=" + request.getParameter("Node") + "&edit=ON");
    }
}
