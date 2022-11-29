package tea.ui.node.type.environmental;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import java.text.ParseException;
import tea.entity.*;
import java.sql.SQLException;

public class EditEnvironmental extends HttpServlet
{
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
                teasession._rv = new tea.entity.RV("ANONYMITY", "Home");
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
                teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, obj.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null,  new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, null,"", text, null, "", 0, null, "", "", "", "", null,null);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
            }
            Date ploytime = null;
            try
            {
                ploytime = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(teasession.getParameter("ploytime"));
            } catch (ParseException ex1)
            {
            }
            Environmental obj = Environmental.find(teasession._nNode, teasession._nLanguage);

            obj.set(Boolean.valueOf(teasession.getParameter("classes")).booleanValue(), teasession.getParameter("address"), teasession.getParameter("postalcode"), teasession.getParameter("phone"), teasession.getParameter("fax"), teasession.getParameter("polyname"), Integer.parseInt(teasession.getParameter("type")), teasession.getParameter("ployadd"), ploytime, teasession.getParameter("ploycon"), teasession.getParameter("ploy"), teasession.getParameter("point"),
                    teasession.getParameter("object"), teasession.getParameter("sponsor"), request.getParameterValues("vemark"), teasession.getParameter("vouchname"), teasession.getParameter("vouchcom"), teasession.getParameter("vouchduty"), teasession.getParameter("vouchtele"), teasession.getParameter("comm"), teasession.getParameter("comtele"), teasession.getParameter("conname"), teasession.getParameter("vouch"));
            node.finished(teasession._nNode);
            response.sendRedirect("Environmental?node=" + teasession._nNode);
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
