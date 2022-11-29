package tea.ui.node.type.indict;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.node.*;

public class EditIndict extends tea.ui.TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            String subject = teasession.getParameter("subject");
            boolean newnode = teasession.getParameter("NewNode") != null;
            String text = teasession.getParameter("text");
            if (newnode)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                String community = node.getCommunity();
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //71
                teasession._nNode = Node.create(teasession._nNode, sequence, community, teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null,null);
            } else
            {
            }
            node.finished(teasession._nNode);
            Indict obj = Indict.find(teasession._nNode, teasession._nLanguage);
            String appellee = teasession.getParameter("appellee");
            if (appellee != null) // 前台会员投诉
            {
                if (teasession._nNode == node._nNode) // 在编辑的情况下才修改主题和内容
                {
                    node.set(teasession._nLanguage, subject, text);
                }
                obj.set(appellee, Integer.parseInt(teasession.getParameter("sorder")));
            } else
            // 后台很管理员处理
            {
                obj.set(teasession.getParameter("handler"), teasession.getParameter("result"));
            }
            String nexturl = request.getParameter("nexturl");
            if (nexturl != null && nexturl.length() > 0)
            {
                response.sendRedirect(nexturl);
            } else
            {
                response.sendRedirect("Indict?node=" + teasession._nNode);
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
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
