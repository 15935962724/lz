package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Coupon;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Coupons extends TeaServlet
{

    public Coupons()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            response.sendRedirect("/jsp/profile/Coupons.jsp?" + request.getQueryString());
            /*
                        TeaSession teasession = new TeaSession(request);
                        if(teasession._rv == null)
                        {
                            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                            return;
                        }
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Profile", super.r.getString(teasession._nLanguage, "Profile")) + ">" + super.r.getString(teasession._nLanguage, "Coupons"));
                        text.setId("PathDiv");
                        Table table = new Table();
                        table.setCellSpacing(5);
                        int i = Coupon.count(teasession._rv._strR);
                        table.setCaption(i + " " + super.r.getString(teasession._nLanguage, "Coupons"));
                        if(i != 0)
                        {
                            table.setTitle(super.r.getString(teasession._nLanguage, "Name") + "\n" + super.r.getString(teasession._nLanguage, "Currency") + "\n" + super.r.getString(teasession._nLanguage, "Type") + "\n" + super.r.getString(teasession._nLanguage, "Minimum") + "\n" + super.r.getString(teasession._nLanguage, "Discount") + "\n" + super.r.getString(teasession._nLanguage, "Code"));
                            Row row;
                            for(Enumeration enumeration = Coupon.find(teasession._rv._strR); enumeration.hasMoreElements(); table.add(row))
                            {
                                int j = ((Integer)enumeration.nextElement()).intValue();
                                Coupon coupon = Coupon.find(j);
                                int k = coupon.getCurrency();
                                int l = coupon.getType();
                                row = new Row(new Cell(new Text("<font>" + coupon.getName(teasession._nLanguage) + "</font>")));
                                row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Common.CURRENCY[k]))));
                                row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Coupon.COUPON_TYPE[l]))));
                                row.add(new Cell(new Text(coupon.getMinimum().toString())));
                                row.add(new Cell(new Text(coupon.getDiscount().toString())));
                                row.add(new Cell(new Text(coupon.getCode())));
                                if(teasession._rv.isAccountant())
                                {
                                    row.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditCoupon?Coupon=" + j + "', '_self');")));
                                    row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteCoupon?Coupon=" + j + "', '_self');}")));
                                    row.add(new Cell(new Button(1, "CB", "CBCouponMembers", super.r.getString(teasession._nLanguage, "CBCouponMembers"), "window.open('CouponMembers?Coupon=" + j + "', '_self');")));
                                }
                            }

                        }
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(table);
                        printwriter.print(new Break());
                        if(teasession._rv.isAccountant())
                            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditCoupon', '_self');"));
                        printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();*/
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/profile/ProfileServlet").add("tea/ui/member/profile/Coupons");
    }
}
