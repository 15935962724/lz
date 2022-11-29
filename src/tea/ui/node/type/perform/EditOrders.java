package tea.ui.node.type.perform;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class EditOrders extends HttpServlet
{

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
            tea.entity.node.Orders orders = tea.entity.node.Orders.find(teasession._rv.toString(), new Date());
            orders.setAddress(teasession.getParameter("SendAddr_must"));
            orders.setPostalcode(teasession.getParameter("SendPost_must"));
            orders.setLinkman(teasession.getParameter("SendLink_must"));
            orders.setPhone(teasession.getParameter("SendTel_must"));
            orders.setPayment(teasession.getParameter("SendBType1"));
            orders.setWaittime(Integer.parseInt(teasession.getParameter("Waittime")));
            orders.setSendtime(teasession.getParameter("SendTime"));
            orders.setInvoice(teasession.getParameter("SendBType"));
            orders.setTax(teasession.getParameter("SendTax"));
            orders.setAccounts(teasession.getParameter("SendAcc"));
            orders.setInvoicerise(teasession.getParameter("SendBill"));
            orders.setInvoiceaddress(teasession.getParameter("SendBAddr"));
            orders.setRemark(teasession.getParameter("SendRemark"));
            orders.setMail(teasession.getParameter("SendMail"));
            orders.set();
            tea.entity.node.PShoppingCarts.setOrders(teasession._rv.toString(), orders.getTime());
            String nexturl = teasession.getParameter("nexturl");
            if (nexturl != null)
            {
                response.sendRedirect(nexturl);
            } else
            {
                response.sendRedirect("/jsp/type/perform/PShoppingCarts.jsp");
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
