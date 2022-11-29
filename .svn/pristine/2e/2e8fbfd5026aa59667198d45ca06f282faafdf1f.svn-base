package tea.ui.node.access;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Shipping;
import tea.entity.node.Node;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class PayAccess extends TeaServlet
{

    public PayAccess()
    {
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

            response.sendRedirect("/jsp/access/PayAccess.jsp?" + request.getQueryString());
            /*
                        Node node = Node.find(teasession._nNode);
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                        int i = Integer.parseInt(request.getParameter("Currency"));
                        BigDecimal bigdecimal = new BigDecimal(request.getParameter("Price"));
                        printwriter.print(RequestHelper.format(super.r.getString(teasession._nLanguage, "InfConfirmPay"), super.r.getString(teasession._nLanguage, Common.CURRENCY[i]) + bigdecimal.toString()));
                        Form form = new Form("foSelect", "GET", "/servlet/PayAccess0");
                        form.add(new HiddenField("Node", teasession._nNode));
                        form.add(new HiddenField("Currency", i));
                        form.add(new HiddenField("Price", bigdecimal));
                        Shipping shipping;
                        for(Enumeration enumeration = Shipping.find(node.getCreator()._strR, i, 32768); enumeration.hasMoreElements(); form.add(new Text(shipping.getName(teasession._nLanguage))))
                        {
                            int j = ((Integer)enumeration.nextElement()).intValue();
                            shipping = Shipping.find(j);
                            form.add(new Radio("Shipping", Integer.toString(j), true));
                        }

                        form.add(new Text(super.r.getString(teasession._nLanguage, "CouponCode") + ":"));
                        form.add(new TextField("CouponCode"));
                        form.add(new Button(super.r.getString(teasession._nLanguage, "Continue")));
                        printwriter.print(form);
                        printwriter.close();
             */
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/access/PayAccess");
    }
}
