package tea.ui.member.order;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Trade;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class TradePayment extends TeaServlet
{

    public TradePayment()
    {
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/order/PurchaseOrders").add("tea/ui/member/order/SaleOrders").add("tea/ui/member/order/TradeServlet");
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if (teasession._rv.isReal() || teasession._rv.isAccountant())
            {
                String s = request.getParameter("Type");
                String s1 = request.getParameter("Status");
                String as[] = request.getParameterValues("Paid");
                if (as != null)
                {
                    for (int i = 0; i < as.length; i++)
                    {
                        if (as[i] != null)
                        {
                            int j = Integer.parseInt(as[i]);
                            Trade trade = Trade.find(as[i]);
                            int k1 = trade.getOptions();
                            k1 |= 0x4;
                            trade.setOptions(k1);
                        }
                    }

                }
                try
                {
                    String s2 = request.getParameter("Unpaid");
                    if (s2.length() != 0)
                    {
                        int k = Integer.parseInt(s2);
                        Trade trade1 = Trade.find(s2);
                        int l1 = trade1.getOptions();
                        l1 &= 0x1b;
                        trade1.setOptions(l1);
                    }
                } catch (Exception _ex)
                {}
                String as1[] = request.getParameterValues("Split");
                if (as1 != null)
                {
                    for (int l = 0; l < as1.length; l++)
                    {
                        if (as1[l] != null)
                        {
                            int i1 = Integer.parseInt(as1[l]);
                            Trade trade2 = Trade.find(as1[l]);
                            int i2 = trade2.getOptions();
                            i2 |= 0x8;
                            trade2.setOptions(i2);
                        }
                    }

                }
                try
                {
                    String s3 = request.getParameter("Unsplit");
                    if (s3.length() != 0)
                    {
                        int j1 = Integer.parseInt(s3);
                        Trade trade3 = Trade.find(s3);
                        int j2 = trade3.getOptions();
                        j2 &= 0x17;
                        trade3.setOptions(j2);
                    }
                } catch (Exception _ex)
                {}
                response.sendRedirect("SaleOrders?Type=" + s + "&Status=" + s1);
                return;
            } else
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidAuthorization"));
                return;
            }
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }
}
