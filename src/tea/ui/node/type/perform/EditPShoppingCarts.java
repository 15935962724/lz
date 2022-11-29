package tea.ui.node.type.perform;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.PShoppingCarts;

public class EditPShoppingCarts extends HttpServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            int id = 0;
            try
            {
                id = Integer.parseInt(teasession.getParameter("id"));
            } catch (NumberFormatException ex1)
            {
            }
            tea.entity.node.PShoppingCarts objPShoppingCarts = new PShoppingCarts(id);
            if (request.getParameter("delete") != null)
            {
                objPShoppingCarts.delete();
                response.sendRedirect("/jsp/type/perform/PShoppingCarts.jsp");
                return;
            }
            if (request.getParameter("clear") != null)
            {
                java.util.Enumeration enumeration = tea.entity.node.PShoppingCarts.findByMember(teasession._rv.toString(), false).elements();
                while (enumeration.hasMoreElements())
                {
                    tea.entity.node.PShoppingCarts.find(((Integer) enumeration.nextElement()).intValue()).delete();
                }
                response.sendRedirect("/jsp/type/perform/PShoppingCarts.jsp");
                return;
            }
            objPShoppingCarts.setTime(request.getParameter("time"));
            objPShoppingCarts.setPrice(Float.parseFloat(request.getParameter("price")));
            objPShoppingCarts.setCounts(Integer.parseInt(request.getParameter("counts")));
            objPShoppingCarts.setMember(teasession._rv.toString());
            objPShoppingCarts.setNode(teasession._nNode);
            objPShoppingCarts.set();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }

        String nexturl = request.getParameter("nexturl");
        if (nexturl != null)
        {
            response.sendRedirect(nexturl);
        } else
        {
            response.sendRedirect("/jsp/type/perform/PShoppingCarts.jsp");
        }
    }

    public void destroy()
    {
    }
}
