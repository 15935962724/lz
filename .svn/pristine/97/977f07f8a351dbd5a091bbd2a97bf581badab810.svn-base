package tea.ui.node.type.travel;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.TravelShopping;

public class EditTravelShopping extends HttpServlet
{
    private static final String CONTENT_TYPE = "text/html; charset=UTF-8";

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");

        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            javax.servlet.http.HttpSession session = request.getSession(true);
            if (request.getParameter("add") != null) //加入购物车
            {
                java.util.Enumeration enumer = TravelShopping.findBySessionid(session.getId());
                while (enumer.hasMoreElements())
                {
                    int ts = ((Integer) enumer.nextElement()).intValue();
                    TravelShopping obj = TravelShopping.find(ts);
                    if (obj.getNode() == teasession._nNode)
                    {
                        obj.setCounts(obj.getCounts() + 1);
                        response.sendRedirect("/jsp/type/travel/TravelShoppings.jsp?node=" + teasession._nNode);
                        return;
                    }
                }
                TravelShopping.create(session.getId(), teasession._nNode, 1);
                response.sendRedirect("/jsp/type/travel/TravelShoppings.jsp?node=" + teasession._nNode);
                return;
            }
            if (request.getParameter("delete") != null) //删除购物车
            {
                String ts[] = request.getParameterValues("travelshopping");
                if (ts != null)
                {
                    for (int index = 0; index < ts.length; index++)
                    {
                        TravelShopping.find(Integer.parseInt(ts[index])).delete();
                    }
                }
                response.sendRedirect("/jsp/type/travel/TravelShoppings.jsp?node=" + teasession._nNode);
                return;
            }
            if (request.getParameter("alter") != null) //修改数量
            {
                String tss[] = request.getParameterValues("travelshopping");
                if (tss != null)
                {
                    for (int index = 0; index < tss.length; index++)
                    {
                        int ts = Integer.parseInt(tss[index]);
                        int counts = Integer.parseInt(request.getParameter(String.valueOf(ts)));
                        TravelShopping.find(ts).setCounts(counts);
                    }
                }
                response.sendRedirect("/jsp/type/travel/TravelShoppings.jsp?node=" + teasession._nNode);
                return;
            }
            String name = request.getParameter("name");
            boolean sex = new Boolean(request.getParameter("sex")).booleanValue();
            String address = request.getParameter("address");
            String postalcode = request.getParameter("postalcode");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            int payment = Integer.parseInt(request.getParameter("payment"));
            String paramrequest = request.getParameter("request");
            int id = Integer.parseInt(request.getParameter("travelshopping"));
            TravelShopping ts = TravelShopping.find(id);
            java.util.Date time = ts.getTime();
            if (time == null)
            {
                time = new java.util.Date();
            }
            ts.set(name, sex, address, postalcode, phone, email, payment, paramrequest, time, teasession._nLanguage);
            String nexturl = request.getParameter("nexturl");
            if (nexturl == null)
            {
                nexturl = request.getContextPath() + "/jsp/type/travel/SubmitTravelOrder.jsp?node=" + teasession._nNode + "&travelshopping=" + id;
            }
            response.sendRedirect(nexturl);
            return;
        } catch (Exception ex)
        {
            throw new ServletException(ex);
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
