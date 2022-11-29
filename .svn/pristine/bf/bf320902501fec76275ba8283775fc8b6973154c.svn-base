package tea.ui.node.type.sound;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.node.*;
import tea.htmlx.TimeSelection;

public class EditSound extends TeaServlet
{

    public void init() throws ServletException
    {
    }

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
            Node node = Node.find(teasession._nNode);
            String community = node.getCommunity();
            String subject = teasession.getParameter("goodsname");
            String text = teasession.getParameter("text");

            Date Issuedate = TimeSelection.makeTime(request.getParameter("counterdate")); // TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute"));
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
                int options1 = node1.getOptions1();
                int typealias = 0;

                try
                {
                    typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                } catch (Exception exception1)
                {
                }
                long options = node1.getOptions();
                // options &= 0xffdffbff;
                int defautllangauge = node1.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //56
                teasession._nNode = Node.create(father, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null,null);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
                node.setTime(Issuedate);
            }

            Sound sound = Sound.find(teasession._nNode, teasession._nLanguage);
            sound.setBigtype(request.getParameter("anclassid"));
            sound.setSmalltype(request.getParameter("nclassid"));
            sound.setPingpai(request.getParameter("pingpai"));
            sound.setCode(request.getParameter("isbn"));
            sound.setMedium(request.getParameter("jiezhi"));
            sound.setDishcount(request.getParameter("dieshu"));
            sound.setTypes(request.getParameter("ticai"));
            sound.setPolt(request.getParameter("qingjie"));
            sound.setTrait(request.getParameter("tese"));
            sound.setSynopsis(request.getParameter("note"));
            sound.setPlayer(request.getParameter("yanyuan"));
            sound.setDirect(request.getParameter("daoyan"));
            sound.setProduce(request.getParameter("chupin"));
            sound.setArea(request.getParameter("diqu"));
            sound.setCaption(request.getParameter("yuzhong"));
            sound.setIsrc(request.getParameter("isrc"));
            sound.setPrice(Float.parseFloat(request.getParameter("shichangjia")));
            sound.setPrice2(Float.parseFloat(request.getParameter("huiyuanjia")));
            sound.setPrice3(Float.parseFloat(request.getParameter("vipjia")));
            sound.setIntegral(request.getParameter("jifen"));
            String[] value = request.getParameterValues("other");

            if (value != null)
            {
                StringBuilder sb = new StringBuilder();
                for (int len = 0; len < value.length; len++)
                {
                    sb.append(value[len] + " ");
                }
                sound.setOther(sb.toString());
            }
            sound.set();
            super.delete(node);
            if (request.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditNode?node=" + teasession._nNode);
            } else
            {
                node.finished(teasession._nNode);
                String nexturl = request.getParameter("nexturl");
                if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("Sound?Edit=ON&Node=" + teasession._nNode);
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
