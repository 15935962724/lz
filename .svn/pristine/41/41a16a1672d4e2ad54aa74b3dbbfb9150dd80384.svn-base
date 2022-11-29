package tea.ui.node.type.district;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import tea.entity.node.*;
import tea.ui.TeaSession;

/**
 * Servlet implementation class for Servlet: EditDistrict
 *
 */
public class EditDistrict extends HttpServlet
{
    public EditDistrict()
    {
        super();
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        try
        {
            Node node = Node.find(teasession._nNode);
            String subject = teasession.getParameter("subject");
            String content = teasession.getParameter("content");
            if (teasession.getParameter("NewNode") != null)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                Category cat = Category.find(teasession._nNode);
                int defautllangauge = node.getDefaultLanguage();
                teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), node.getStyle(), node.getRoot(), node.getKstyle(), node.getKroot(), null, teasession._nLanguage, subject, "","", content, null, "", 0, null, "", "", "", "", null, "");
                // node = Node.find(teasession._nNode);
            } else
            {
                node.set(teasession._nLanguage, subject, content);
            }

            int street = Integer.parseInt(request.getParameter("street"));
            District d = District.find(teasession._nNode, teasession._nLanguage);
            d.set(street);
            node.finished(teasession._nNode);
            response.sendRedirect("/servlet/District?node=" + teasession._nNode + "&language=" + teasession._nLanguage);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
