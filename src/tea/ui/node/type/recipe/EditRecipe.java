package tea.ui.node.type.recipe;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaServlet;

public class EditRecipe extends TeaServlet
{

    public EditRecipe()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.sendRedirect("Node?node=" + request.getParameter("Node") + "&edit=ON");
    }
}
