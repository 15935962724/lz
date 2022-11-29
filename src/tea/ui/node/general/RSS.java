package tea.ui.node.general;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.ui.*;
import java.text.*;

public class RSS extends HttpServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/xml; charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            if(node.getTime() == null)
            {
                return;
            }
            Community community = Community.find(node.getCommunity());
            teasession._nLanguage = 1;
            SimpleDateFormat sdf = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss 'GMT'",Locale.ENGLISH);
            String url = "http://" + request.getServerName();
            if(request.getServerPort() != 80)
            {
                url += ":" + request.getServerPort();
            }

            out.print("<?xml version=\"1.0\" encoding=\"utf-8\"?><?xml-stylesheet type=\"text/css\" href=\"/tea/rss.css\"?><rss version=\"2.0\"><channel><title>" + community.getName(teasession._nLanguage) + " " + node.getSubject(teasession._nLanguage) + "</title>");
            Enumeration enumer = Node.findSons(teasession._nNode,null,0,30);
            while(enumer.hasMoreElements())
            {
                int node_id = ((Integer) enumer.nextElement()).intValue();
                Node obj = Node.find(node_id);
                String text = obj.getText(teasession._nLanguage);
                int start = text.indexOf("<");
                while(start != -1 && start <= 200)
                {
                    int end = text.indexOf(">",start);
                    if(end != -1)
                    {
                        text = text.substring(0,start) + text.substring(end + 1);
                    } else
                    {
                        text = text.substring(0,start);
                    }
                    start = text.indexOf("<");
                }
                if(text.length() > 200)
                {
                    text = text.substring(0,200) + " ...";
                }
                text = text.replaceAll("&nbsp;"," ").replaceAll("\\r\\n"," ");
                out.print("<item><title>" + obj.getSubject(teasession._nLanguage) + "</title><link>" + url + "/servlet/Node?node=" + node_id + "</link><description><![CDATA[" + text.replace('　',' ') + "]]></description><pubDate>" + sdf.format(obj.getTime()) + "</pubDate></item>");
            }
            out.print("</channel></rss>");
        } catch(Exception ex)
        {
            ex.printStackTrace();
			response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
