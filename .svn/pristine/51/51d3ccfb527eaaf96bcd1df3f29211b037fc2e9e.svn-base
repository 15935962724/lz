package tea.ui;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;

public class TSS extends HttpServlet
{

    public TSS()
    {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        String s = request.getParameter("Command");
        if (s == null)
        {
            s = "Node";
        }
        response.sendRedirect("/servlet/" + s + "?" + request.getQueryString());
    }
}
