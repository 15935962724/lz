// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   XPurchaseOrders.java

package tea.ui.member.order;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Trade;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class XPurchaseOrders extends TeaServlet
{

    public XPurchaseOrders()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if(!teasession._rv.isPurchaser())
            {
                response.sendError(403);
                return;
            }
            Text text = new Text(hrefGlance(teasession._rv) + ">" + r.getString(teasession._nLanguage, "PurchaseOrders"));
            text.setId("PathDiv");
            List list = new List();
            for(int i = 0; i < Trade.TRADE_STATUS.length; i++)
            {
                int j = Trade.count(true, teasession._rv, i,teasession._strCommunity);
                if(j != 0)
                    list.add(new ListItem(new Anchor("PurchaseOrders?Status=" + i, j + " " + r.getString(teasession._nLanguage, Trade.TRADE_STATUS[i]) + " " + r.getString(teasession._nLanguage, "PurchaseOrders"))));
            }

            PrintWriter printwriter = response.getWriter();
            printwriter.print(text);
            printwriter.print(list);
            printwriter.print(new Languages(teasession._nLanguage, request));
            printwriter.close();
        }
        catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/order/XPurchaseOrders");
    }
}
