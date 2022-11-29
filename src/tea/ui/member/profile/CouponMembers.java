// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-25 10:48:00
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   CouponMembers.java

package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Coupon;
import tea.entity.member.CouponMember;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class CouponMembers extends TeaServlet
{

    public CouponMembers()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
            String qs=request.getQueryString();
qs=qs==null?"":"?"+qs;
response.sendRedirect("/jsp/profile/CouponMembers.jsp"+qs);
/*
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            int i = Integer.parseInt(request.getParameter("Coupon"));
            Coupon coupon = Coupon.find(i);
            if(!coupon.getMember().equals(teasession._rv._strR) || !teasession._rv.isAccountant())
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("Pos");
            int j = s == null ? 0 : Integer.parseInt(s);
            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Profile", super.r.getString(teasession._nLanguage, "Profile")) + ">" + new Anchor("Coupons", super.r.getString(teasession._nLanguage, "Coupons")) + ">" + super.r.getString(teasession._nLanguage, "CouponMembers"));
            text.setId("PathDiv");
            int k = CouponMember.count(i);
            Table table = new Table();
            table.setCaption(k + " " + super.r.getString(teasession._nLanguage, "CouponMembers"));
            if(k != 0)
            {
                Row row;
                for(Enumeration enumeration = CouponMember.find(i, j, 25); enumeration.hasMoreElements(); table.add(row))
                {
                    String s1 = (String)enumeration.nextElement();
                    row = new Row();
                    row.add(new Cell(hrefGlance(s1,request.getContextPath())));
                    row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteCouponMember?Coupon=" + i + "&Member=" + s1 + "', '_self');}")));
                }

            }
            PrintWriter printwriter = response.getWriter();
            printwriter.print(text);
            printwriter.print(table);
            printwriter.print(new FPNL(teasession._nLanguage, "CouponMembers?Coupon=" + i + "&Pos=", j, k));
            printwriter.print(new Break());
            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('NewCouponMembers?Coupon=" + i + "', '_self');"));
            printwriter.close();*/
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
        super.r.add("tea/ui/member/profile/CouponMembers").add("tea/ui/member/profile/ProfileServlet").add("tea/ui/member/profile/Coupons");
    }
}
