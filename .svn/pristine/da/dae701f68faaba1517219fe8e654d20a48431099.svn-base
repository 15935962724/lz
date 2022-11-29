package tea.ui.node.type.literature;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.node.*;

public class EditLiterature extends TeaServlet
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
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            String subject = teasession.getParameter("subject");
            String text = teasession.getParameter("text");
            if (teasession.getParameter("NewNode") != null)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                Category obj = Category.find(teasession._nNode); //80
                teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, obj.getCategory(), (node.getOptions1() & 2) != 0, node.getOptions(), node.getOptions1(), node.getDefaultLanguage(), null, null, new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null,null);
                node.finished(teasession._nNode);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
            }

            Literature l = Literature.find(teasession._nNode, teasession._nLanguage);
            String subhead = teasession.getParameter("subhead");
            int chapter = Integer.parseInt(teasession.getParameter("chapter"));
            int section = Integer.parseInt(teasession.getParameter("section"));
            String cname = (teasession.getParameter("cname"));
            String sname = (teasession.getParameter("sname"));
            String author = teasession.getParameter("author");
            int pos = Integer.parseInt(teasession.getParameter("pos"));
            byte by[] = teasession.getBytesParameter("flash");
            String flash;
            if (by != null)
            {
                flash = write(node.getCommunity(), by, ".gif");
            } else if (teasession.getParameter("clear") != null)
            {
                flash = null;
            } else
            {
                flash = l.getFlash();
            }
            l.set(subhead, chapter, cname, section, sname, author, pos, flash);

            String nexturl = teasession.getParameter("nexturl");
            if (teasession.getParameter("GoBack") != null)
            {
                nexturl = "EditNode?node=" + teasession._nNode;
            } else if (nexturl == null)
            {
                nexturl = "Literature?node=" + teasession._nNode;
            }
            response.sendRedirect(nexturl);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
