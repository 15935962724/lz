package tea.ui.node.type.earthkavass;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.node.*;
import tea.entity.*;

public class EditEarthKavass extends HttpServlet
{
    private static final String CONTENT_TYPE = "text/html; charset=GBK";

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            if (teasession._rv == null)
            {
                teasession._rv = RV.ANONYMITY;
            }
            Node node = Node.find(teasession._nNode);
            String subject = teasession.getParameter("Subject");
            String text = teasession.getParameter("Text");
            if (teasession.getParameter("NewNode") != null)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                int defautllangauge = node.getDefaultLanguage();
                Category obj = Category.find(teasession._nNode);
                teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, obj.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, subject, null,"", text, null, "", 0, null, "", "", "", "", null,null);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
            }
            EarthKavass obj = EarthKavass.find(teasession._nNode, teasession._nLanguage);
            obj.set(teasession.getParameter("name"), teasession.getParameter("address"), teasession.getParameter("zip"), teasession.getParameter("phone"), teasession.getParameter("fax"), teasession.getParameter("email"));
            node.finished(teasession._nNode);
            response.sendRedirect("EarthKava?node=" + teasession._nNode);
        } catch (IOException ex)
        {
            ex.printStackTrace();
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
