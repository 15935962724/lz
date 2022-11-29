package tea.ui.node.type.service;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

import tea.entity.Http;
import tea.entity.node.*;
import tea.htmlx.TimeSelection;
import tea.entity.node.*;

public class EditService extends tea.ui.TeaServlet
{
    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            int options1 = 0;
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            
            Node node = Node.find(teasession._nNode);
            String subject = teasession.getParameter("Subject");
            String text = teasession.getParameter("text");
            Date issue = new Date(); // TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), "0", "0");
            boolean newbrother = teasession.getParameter("NewBrother") != null;
            boolean newnode = teasession.getParameter("NewNode") != null;
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
                options1 = node1.getOptions1();
                int typealias = 0;
                String community = node1.getCommunity();
                try
                {
                    typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                } catch (Exception exception1)
                {
                }
                long options = node1.getOptions();
                options &= 0xffdffbff;
                int defautllangauge = node1.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //65
                teasession._nNode = Node.create(father, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null,null);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
            }

            Service investor = Service.find(teasession._nNode, teasession._nLanguage);
            int minimum = Integer.parseInt(teasession.getParameter("minimum"));
            String unit = teasession.getParameter("unit");
            String synopsis = teasession.getParameter("synopsis");
            String price = teasession.getParameter("price");
            String quality = (teasession.getParameter("quality"));
            int point = Integer.parseInt(teasession.getParameter("point"));
            byte[] by = teasession.getBytesParameter("picture");
            String serShops="|";
            if(investor.serShops!=null&&!"".equals(investor.serShops))serShops=investor.serShops;
            String picture;
            if (by != null)
            {
                picture = write(node.getCommunity(), by, ".gif");
            } else if (teasession.getParameter("clear") != null)
            {
                picture = null;
            } else
            {
                picture = investor.getPicture();
            }
            by = teasession.getBytesParameter("picture2");
            String picture2;
            if (by != null)
            {
                picture2 = write(node.getCommunity(), by, ".gif");
            } else if (teasession.getParameter("clear2") != null)
            {
                picture2 = null;
            } else
            {
                picture2 = investor.getPicture2();
            }

            String time = teasession.getParameter("time");
            String thing = teasession.getParameter("thing");
            String tools = teasession.getParameter("tools");
            String type = teasession.getParameter("type");
            String xpinpai=teasession.getParameter("xpinpai");
            if(xpinpai==null||"".equals(xpinpai))xpinpai="0";
            String xxinghaoid=teasession.getParameter("xxinghao");
            if(xxinghaoid==null||"".equals(xxinghaoid))xxinghaoid="0";
            String pro=teasession.getParameter("selProvince");
            String cityid=teasession.getParameter("selCity");
            int cid=0;
            if(pro!=null&&!"".equals(pro)){
            		if(cityid!=null&&!"".equals(cityid)){
            			cid=Integer.parseInt(cityid);
                    }else{
                    	cid=Integer.parseInt(pro);
                    }
            }
            
            String selLocation=teasession.getParameter("selLocation");
            String selCommericial=teasession.getParameter("selCommericial");
            String selLandmark=teasession.getParameter("selLandmark");
            if (investor.isExists())
            {
                investor.set(minimum, unit, synopsis, new java.math.BigDecimal(price), quality, point, picture, picture2, time, thing, tools, type,serShops,cid,selLocation,selCommericial,selLandmark,Integer.parseInt(xpinpai),Integer.parseInt(xxinghaoid));
            } else
            {
                Service.create(teasession._nNode, teasession._nLanguage, minimum, unit, synopsis, new java.math.BigDecimal(price), quality, point, picture, picture2, time, thing, tools, type,serShops,cid,selLocation,selCommericial,selLandmark,Integer.parseInt(xpinpai),Integer.parseInt(xxinghaoid));
            }
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
                if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("Service?node=" + teasession._nNode + "&edit=ON");
                }
            }
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
