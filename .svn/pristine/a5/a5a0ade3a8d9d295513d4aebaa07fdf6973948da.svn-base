package tea.ui.node.type.travel;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.node.*;

public class EditTravel extends TeaServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");

        tea.ui.TeaSession teasession = null;
        try
        {
            teasession = new tea.ui.TeaSession(request);
            Node node = Node.find(teasession._nNode);
            String subject = teasession.getParameter("subject");
            String keywords = teasession.getParameter("keywords");
            String text = teasession.getParameter("text");
            if (teasession.getParameter("NewNode") != null)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                String community = node.getCommunity();

                Category cat = Category.find(teasession._nNode); //79
                int defautllangauge = node.getDefaultLanguage();
                teasession._nNode = Node.create(teasession._nNode, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0,  null, teasession._nLanguage, subject, keywords,"", text, null, "", 0, null, "", "", "", "", null, null);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
                node.setKeywords(keywords, teasession._nLanguage);
            }
            Date leavetime = null;
            if (teasession.getParameter("leavetimeYear") != null)
            {
                leavetime = Travel.sdf.parse(teasession.getParameter("leavetimeYear") + "-" + teasession.getParameter("leavetimeMonth") + "-" + teasession.getParameter("leavetimeDay"));
            }
            Date stoptime = null; // 截至时间
            if (teasession.getParameter("stoptimeYear") != null)
            {
                stoptime = Travel.sdf.parse(teasession.getParameter("stoptimeYear") + "-" + teasession.getParameter("stoptimeMonth") + "-" + teasession.getParameter("stoptimeDay"));
            }

            String leavetext = teasession.getParameter("leavetext");
            int counts = Integer.parseInt(teasession.getParameter("counts"));
            float price = Float.parseFloat(teasession.getParameter("price"));
            String priceexplain = teasession.getParameter("priceexplain");
            String priceinclude = teasession.getParameter("priceinclude");
            String pricenone = teasession.getParameter("pricenone");
            String routing = teasession.getParameter("routing");
            String service = teasession.getParameter("service");
            String explain = teasession.getParameter("explain");
            String account = teasession.getParameter("account");
            int hostel = Integer.parseInt(teasession.getParameter("hostel"));
            int flight = Integer.parseInt(teasession.getParameter("flight"));
            String principal = teasession.getParameter("principal");
            String picture = null;
            String picture1 = null;
            int leixing = Integer.parseInt(teasession.getParameter("leixing")); // 类型
            String zhoubie = teasession.getParameter("zhoubie"); // 洲别

            String tj_guojia = teasession.getParameter("guojia"); // 途径国家
            String tj_chengshi = teasession.getParameter("chengshi"); // 城市
            String tj_jingdian = teasession.getParameter("jingdian"); // 景点
            String locu = teasession.getParameter("locu"); // 出发地点
            String daycount = teasession.getParameter("daycount"); // 行程天数
            String airways = teasession.getParameter("airways"); // 航空公司
            Travel obj = Travel.find(teasession._nNode, teasession._nLanguage);
            byte by[] = teasession.getBytesParameter("picture");
            if (teasession.getParameter("clear") != null)
            {
                picture = null;
            } else if (by == null)
            {
                picture = obj.getPicture();
            } else
            {
                picture = write(node.getCommunity(), by, ".gif");

            }
            byte by1[] = teasession.getBytesParameter("picture1");
            if (teasession.getParameter("clear1") != null)
            {
                picture1 = null;
            } else if (by1 == null)
            {
                picture1 = obj.getPicture1();
            } else
            {
                picture1 = write(node.getCommunity(), by1, ".gif");
            }
            obj.set(leavetime, leavetext, counts, price, priceexplain, priceinclude, pricenone, routing, service, explain, locu, daycount, airways, stoptime, zhoubie, tj_guojia, tj_chengshi, tj_jingdian, leixing, account, hostel, flight, principal, picture, picture1);
            node.finished(teasession._nNode);
            String nexturl = teasession.getParameter("nexturl");
            if (nexturl == null)
            {
                nexturl = "Travel?node=" + teasession._nNode;
            }
            if (teasession.getParameter("GoBackSuper") != null)
            {
                nexturl = request.getContextPath() + "/servlet/EditNode?node=" + teasession._nNode;
            } else if (teasession.getParameter("GoNext") != null)
            { // 选择线路
                nexturl = request.getContextPath() + "/jsp/type/travel/EditTravelCorrelative.jsp?types=81&types=49&Node=" + teasession._nNode;
            }

            response.sendRedirect(nexturl);
        } catch (Exception ex)
        {
            ex.printStackTrace();
            outText(teasession, response, ex.getMessage());
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
