package tea.ui.node.type.landscape;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.node.*;
import tea.entity.*;
import tea.htmlx.TimeSelection;

public class EditLandscape extends TeaServlet
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
            if ((node.getOptions1() & 1) == 0)
            {
                if (teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                if (!node.isCreator(teasession._rv) && !AccessMember.find(teasession._nNode, teasession._rv._strV).isProvider(81))
                {
                    response.sendError(403);
                    return;
                }
            } else
            {
                if (teasession._rv == null)
                {
                    teasession._rv = RV.ANONYMITY;
                }
            }

            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/landscape/EditLandscape.jsp?" + request.getQueryString());
            } else
            {

                {
                    String name = teasession.getParameter("subject");
                    String text = teasession.getParameter("Text");
                    String Keywords = teasession.getParameter("keywords");
                    Date date4 = TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute"));
                    if (teasession.getParameter("NewNode") != null)
                    {
                        int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                        int options1 = node.getOptions1();
                        Category cat = Category.find(teasession._nNode); //81
                        int defautllangauge = node.getDefaultLanguage();
                        teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, cat.getCategory(), (options1 & 2) != 0, node.getOptions(), options1, defautllangauge, null, null, date4, node.getStyle(), node.getRoot(), 0, 0, null, teasession._nLanguage, name, Keywords,"", text, null, "", 0, null, "", "", "", "", null, null);
                    } else
                    {
                        node.set(teasession._nLanguage, name, text);
                        node.setKeywords(Keywords, teasession._nLanguage);
                        node.setTime(date4);
                    }

                    Landscape landscape = Landscape.find(teasession._nNode);

                    int distinction = 0;
                    try
                    {
                        distinction = Integer.parseInt(teasession.getParameter("distinction"));
                    } catch (NumberFormatException ex1)
                    {
                    }

                    int style = 0;
                    try
                    {
                        style = Integer.parseInt(teasession.getParameter("style"));
                    } catch (NumberFormatException ex1)
                    {
                    }

                    int weather = 0;
                    try
                    {
                        weather = Integer.parseInt(teasession.getParameter("weather"));
                    } catch (NumberFormatException ex1)
                    {
                    }

                    boolean homeland = new Boolean(teasession.getParameter("homeland")).booleanValue();

                    int area1 = 0;
                    try
                    {
                        area1 = Integer.parseInt(teasession.getParameter("area1"));
                    } catch (NumberFormatException ex1)
                    {
                    }

                    int area2 = 0;
                    try
                    {
                        area2 = Integer.parseInt(teasession.getParameter("area2"));
                    } catch (NumberFormatException ex1)
                    {
                    }

                    String logograph = teasession.getParameter("logograph");
                    if (logograph == null || logograph.length() == 0)
                    {
                        int start = text.indexOf("<");
                        while (start != -1 && start <= 200)
                        {
                            int end = text.indexOf(">", start);
                            if (end != -1)
                            {
                                text = text.substring(0, start) + text.substring(end + 1);
                            } else
                            {
                                text = text.substring(0, start);
                            }
                            start = text.indexOf("<");
                        }
                        logograph = text.substring(0, text.length() > 200 ? 200 : text.length());
                    }
                    String picture = null;
                    if (teasession.getParameter("ClearPicture") == null)
                    {
                        byte by[] = teasession.getBytesParameter("picture");
                        if (by != null)
                        {
                            picture = super.write(node.getCommunity(), by, ".gif");
                        } else
                        {
                            picture = landscape.getPicture(teasession._nLanguage);
                        }
                    }

                    landscape.set(distinction, weather, homeland, area1, area2, style, teasession._nLanguage, picture, logograph);

                    delete(node);

                }
                String nexturl = teasession.getParameter("nexturl");
                if ("back".equals(teasession.getParameter("act")))
                { // 上一步
                    response.sendRedirect("EditNode?node=" + teasession._nNode);
                } else
                {
                    node.finished(teasession._nNode);
                    if ("next".equals(teasession.getParameter("act")))
                    { // 下一步
                        response.sendRedirect("/jsp/type/correlative/EditCorrelative.jsp?types=48&types=81&Node=" + teasession._nNode);
                    } else
                    { // 完成
                        if (nexturl != null)
                        {
                            response.sendRedirect(nexturl);
                            return;
                        }
                        response.sendRedirect("Node?node=" + teasession._nNode);
                    }
                }
            }
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
