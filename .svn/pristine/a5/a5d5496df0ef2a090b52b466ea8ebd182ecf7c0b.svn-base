package tea.ui.util;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class EditHide extends HttpServlet
{
    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");

        tea.entity.util.Hide hide = new tea.entity.util.Hide();
        String filename = request.getParameter("filename");
        String community = request.getParameter("community");
        String hidename = request.getParameter("hidename");
        if (request.getParameter("Show") != null)
        {
            hide.delete(filename, community, hidename);
        } else
        {
            hide.set(filename, community, hidename);
        }
        java.io.PrintWriter out = response.getWriter();
        out.println("<script>window.close();</script>");
        out.close();
    }

    //Clean up resources
    public void destroy()
    {
    }
}
