package tea.ui.node.type.download;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaSession;
import tea.entity.node.*;
import tea.htmlx.TimeSelection;
import java.sql.SQLException;
import com.sun.image.codec.jpeg.*;
import java.sql.SQLException;

public class EditDownload extends tea.ui.TeaServlet
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
            int options1 = 0;
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            String Subject = teasession.getParameter("Subject");
            String Keywords = teasession.getParameter("Keywords");
            // Date date5 = TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"),
            // teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"),
            // teasession.getParameter("IssueMinute"));
            String text = teasession.getParameter("text");
            boolean newnode = teasession.getParameter("NewNode") != null;
            if (newnode)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                options1 = node.getOptions1();
                String community = node.getCommunity();
                long options = node.getOptions();
                // options &= 0xffdffbff;
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //63
                teasession._nNode = Node.create(teasession._nNode, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, Subject, Keywords,"", text, null, "", 0, null, "", "", "", "", null,null);
				node=Node.find(teasession._nNode);
            } else
            {
                node.set(teasession._nLanguage, Subject, text);
                node.setKeywords(Keywords, teasession._nLanguage);
            }

            Download download = Download.find(teasession._nNode, teasession._nLanguage);
            // org.apache.jasper.runtime.JspRuntimeLibrary.introspect(download, request);
            byte by[] = teasession.getBytesParameter("picture");
            String picture = null;
            if (by != null)
            {
                picture = super.write(node.getCommunity(), by, ".gif");
            } else
            {
                picture = (teasession.getParameter("pictureurl"));
            }
            download.setPicture(picture);

            String small = null;
            by = teasession.getBytesParameter("small");
            if (by != null)
            {
                small = super.write(node.getCommunity(), by, ".gif");
            } else
            {
                small = (teasession.getParameter("smallurl"));
            }
            if (small.length() == 0)
            {
                java.io.File big = new java.io.File(getServletContext().getRealPath(picture));
                if (big.isFile() && big.canRead())
                {
                    small = picture.substring(0, picture.length() - 4) + "small.gif";
                    java.io.File smallfile = new java.io.File(getServletContext().getRealPath(small));
                    // tea.entity.member.SectionPicture.makeSmall(big, smallfile, 200, true);
                }
            }
            download.setSmall(small);

            download.setCommend(Integer.parseInt(teasession.getParameter("commend")));
            download.setDeveloper(teasession.getParameter("developer"));
            download.setLanguage(Integer.parseInt(teasession.getParameter("language")));
            int soft[] = new int[6];
            String article[] = new String[6];
            for (int index = 0; index < soft.length; index += 2)
            {
                soft[index] = Integer.parseInt(teasession.getParameter("software" + (index + 1)));
                soft[index + 1] = Integer.parseInt(teasession.getParameter("software" + (index + 2)));

                article[index] = (teasession.getParameter("article" + (index + 1))); // 连接
                article[index + 1] = (teasession.getParameter("article" + (index + 2))); // 名称
                if (article[index + 1].length() < 1)
                {
                    article[index + 1] = article[index];
                }
            }
            download.setArticle(article);
            download.setSoftware(soft);
            download.setSize(Integer.parseInt(teasession.getParameter("size")));
            /*
             * if(request.getParameter("autosize")!=null) try { String url=request.getParameter("url"); if(!url.startsWith("http")) { String tempurl=request.getRequestURL().toString(); url=tempurl.substring(0,tempurl.length()-request.getRequestURI().length())+url; } java.net.URLConnection urlconn = new java.net.URL(url).openConnection(); int len = urlconn.getContentLength(); if (len != -1) { download.setSize(len); } } catch (IOException ex1) { ex1.printStackTrace(); }
             */
            download.set();
            delete(node);
            String nexturl = teasession.getParameter("nexturl");
            if (teasession.getParameter("GoBack") != null)
            {
                String parm = "";
                if (nexturl != null)
                {
                    parm = "&nexturl=" + nexturl;
                }
                response.sendRedirect("EditNode?node=" + teasession._nNode + parm);
            } else
            {
                Node.find(teasession._nNode).finished(teasession._nNode);
                if (teasession.getParameter("urladdress") != null)
                {
                    String parm = "";
                    if (nexturl != null)
                    {
                        parm = "&nexturl=" + nexturl;
                    }
                    response.sendRedirect("/jsp/type/download/EditDownloadAddress.jsp?node=" + teasession._nNode + parm);
                } else if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
                }
            }
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } catch (IOException ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
