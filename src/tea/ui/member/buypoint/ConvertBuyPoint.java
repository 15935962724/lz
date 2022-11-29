// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   ConvertBuyPoint.java

package tea.ui.member.buypoint;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.BuyPoint;
import tea.entity.member.BuyPointConvert;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ConvertBuyPoint extends TeaServlet
{

    public ConvertBuyPoint()
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
            if(!teasession._rv.isSupport())
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("RVendor");
            String s1 = request.getParameter("VVendor");
            RV rv = new RV(s,s1);
            String s2 = request.getParameter("Account");
            String s3 = request.getParameter("Password");
            String s4 = request.getParameter("OtherID");
            if(!BuyPointConvert.isExisted(s2,s3,s4,rv))
            {
                outText(teasession,response,r.getString(teasession._nLanguage,"InvalidAccount"));
                return;
            }
            int i = BuyPointConvert.find(s2,s3,s4,rv);
            BuyPointConvert buypointconvert = BuyPointConvert.find(i);
            Date date = buypointconvert.getTime();
            Date date1 = new Date(System.currentTimeMillis());
            int j = buypointconvert.getStatus();
            if(date1.after(date))
            {
                outText(teasession,response,r.getString(teasession._nLanguage,"AccountHasBeenExpired"));
                return;
            }
            if(j == 1)
            {
                outText(teasession,response,r.getString(teasession._nLanguage,"AccountHasBeenConverted"));
                return;
            }
            if(j == 0)
            {
                int k = 1;
                int l = buypointconvert.getConvertCurrency();
                BigDecimal bigdecimal = buypointconvert.getConvertPoint();
                BigDecimal bigdecimal1 = buypointconvert.getConvertedPoint().add(bigdecimal);
                buypointconvert.set(k,bigdecimal1,teasession._rv);
                if(BuyPoint.isExisted(rv,teasession._rv,l))
                {
                    int i1 = BuyPoint.find(rv,teasession._rv,l);
                    BuyPoint buypoint = BuyPoint.find(i1);
                    BigDecimal bigdecimal2 = buypoint.getCurrentPoint();
                    buypoint.set(bigdecimal2.add(bigdecimal));
                } else
                {
                    BuyPoint.create(rv,teasession._rv,l,bigdecimal,new BigDecimal(0.0D));
                }
            }
            response.sendRedirect("BuyPoints");
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
        r.add("tea/ui/member/contact/ConvertBuyPoint").add("tea/ui/member/buypoint/BuyPoints");
    }
}
