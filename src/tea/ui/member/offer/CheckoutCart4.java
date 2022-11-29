// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   CheckoutCart4.java

package tea.ui.member.offer;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Shipping;
import tea.html.Anchor;
import tea.html.Text;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class CheckoutCart4 extends TeaServlet
{

    public CheckoutCart4()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            int i = Integer.parseInt(request.getParameter("Currency"));
            Integer.parseInt(request.getParameter("Shipping"));
            int j = Integer.parseInt(request.getParameter("Paymethod"));
            int k = Integer.parseInt(request.getParameter("Trade"));
            BigDecimal bigdecimal = null;
            try
            {
                bigdecimal = new BigDecimal(request.getParameter("Total"));
            } catch(Exception _ex)
            {}
            if(bigdecimal == null)
            {
                outText(teasession,response,r.getString(teasession._nLanguage,"InvalidTotal"));
                response.sendRedirect("Node?node=17");
            }
            if(i == 0 && j == Shipping.PAYMETHOD_ITRANSACT)
            {
                String s = request.getParameter("signature");
                if(s == null || !s.startsWith("-----BEGIN PGP SIGNED MESSAGE-----"))
                    return;
                request.getParameter("email");
                request.getParameter("first_name");
                request.getParameter("last_name");
                request.getParameter("organization");
                request.getParameter("address");
                request.getParameter("city");
                request.getParameter("state");
                request.getParameter("zip");
                request.getParameter("country");
                request.getParameter("phone");
                request.getParameter("fax");
            } else
            {
                return;
            }
            response.setHeader("Expires","0");
            response.setHeader("Cache-Control","no-cache");
            response.setHeader("Pragma","no-chache");
            PrintWriter printwriter = response.getWriter();
            printwriter.print(RequestHelper.format(r.getString(teasession._nLanguage,"InfAfterTrade"),new Anchor("Trade?Trade=" + k,new Text(Integer.toString(k)))));
            printwriter.print(RequestHelper.format(r.getString(teasession._nLanguage,"InfAfterTrade1"),new Text(bigdecimal.toString())));
            printwriter.print(new Anchor("Node",r.getCommandImg(teasession._nLanguage,"Continue")));
            printwriter.close();
            return;
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/offer/CheckoutCart4");
    }
}
