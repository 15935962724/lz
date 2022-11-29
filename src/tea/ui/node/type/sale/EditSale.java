package tea.ui.node.type.sale;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.htmlx.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditSale extends TeaServlet
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
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect(request.getContextPath() + "/jsp/type/sale/EditSale.jsp?" + request.getQueryString());
            } else
            {
                Node node = Node.find(teasession._nNode);
                String name = teasession.getParameter("subject");
                boolean newbrother = teasession.getParameter("NewBrother") != null;
                boolean newnode = teasession.getParameter("NewNode") != null;
                String text = teasession.getParameter("text");
                if (newnode || newbrother)
                {
                    int father;
                    father = teasession._nNode;
                    if (newbrother)
                    {
                        father = Node.find(father).getFather();
                    }
                    Node node1 = Node.find(father);
                    int sequence = Node.getMaxSequence(father) + 10;
                    long options = node1.getOptions();
                    int options1 = node1.getOptions1();
                    int typealias = 0;
                    String community = node1.getCommunity();
                    try
                    {
                        typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                    } catch (Exception exception1)
                    {
                    }
                    int defautllangauge = node1.getDefaultLanguage();
                    Category cat = Category.find(teasession._nNode);
                    teasession._nNode = Node.create(father, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, name, "","", text, null, "", 0, null, "", "", "", "", null, null);
                } else
                {
                    node.set(teasession._nLanguage, name, text);
                }

                Sale report = Sale.find(teasession._nNode, teasession._nLanguage);
                String path = null;
                byte[] picture = teasession.getBytesParameter("picture");
                if (picture != null)
                {
                    path = request.getContextPath() + write(node.getCommunity(), picture, ".gif");
                } else if (teasession.getParameter("clear") != null)
                {
                    path = null;
                } else
                {
                    path = report.getPicture();
                }

                report.set(teasession.getParameter("capability"), path, teasession.getParameter("price"), Integer.parseInt(teasession.getParameter("area")));
                String nexturl = teasession.getParameter("nexturl");
                node.finished(teasession._nNode);
                if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                    return;
                }
                response.sendRedirect("Node?node=" + teasession._nNode);
            }
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        // out.close();
    }

    // Clean up resources
    public void destroy()
    {
    }
}
