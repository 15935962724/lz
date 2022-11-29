package tea.ui.node.type.supply;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaServlet;

public class EditSupply extends TeaServlet
{

    public EditSupply()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.sendRedirect("Node?node=" + request.getParameter("Node") + "&edit=ON");
    }
}
