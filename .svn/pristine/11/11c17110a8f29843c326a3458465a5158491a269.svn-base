package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Coupon;
import tea.html.*;
import tea.htmlx.CurrencySelection;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditCoupon extends TeaServlet
{

    public EditCoupon()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if (!teasession._rv.isAccountant())
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("Coupon");
            boolean flag = s == null;
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/profile/EditCoupon.jsp" + qs);
                /*
                                int i = 0;
                                int k = 0;
                                int i1 = 0;
                                BigDecimal bigdecimal = new BigDecimal(0.0D);
                                BigDecimal bigdecimal2 = new BigDecimal(0.0D);
                                String s1 = "";
                                String s3 = "";
                                String s5 = "";
                                if (!flag)
                                {
                                    Coupon coupon = Coupon.find(Integer.parseInt(s));
                                    i = coupon.getCurrency();
                                    k = coupon.getType();
                                    i1 = coupon.getOptions();
                                    bigdecimal = coupon.getMinimum();
                                    bigdecimal2 = coupon.getDiscount();
                                    s1 = coupon.getCode();
                                    s3 = coupon.getName(teasession._nLanguage);
                                    s5 = coupon.getText(teasession._nLanguage);
                                }
                                Form form = new Form("foEdit", "POST", "EditCoupon");
                                form.setOnSubmit("return(submitFloat(this.Minimum,'" + super.r.getString(teasession._nLanguage, "InvalidMinimum") + "')" + "&&submitFloat(this.Discount,'" + super.r.getString(teasession._nLanguage, "InvalidDiscount") + "')" + "&&submitText(this.Code,'" + super.r.getString(teasession._nLanguage, "InvalidCode") + "')" + "&&submitText(this.Name,'" +
                                                 super.r.getString(teasession._nLanguage, "InvalidName") + "')" + ");");
                                if (!flag)
                                {
                                    form.add(new HiddenField("Coupon", s));
                                }
                                Table table = new Table();
                                table.add(new CurrencySelection(teasession._nLanguage, i, false));
                                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Type") + ":"), true));
                                Cell cell = new Cell();
                                for (int l1 = 0; l1 < Coupon.COUPON_TYPE.length; l1++)
                                {
                                    cell.add(new Radio("Type", l1, l1 == k));
                                    cell.add(new Text(super.r.getString(teasession._nLanguage, Coupon.COUPON_TYPE[l1])));
                                }

                                row.add(cell);
                                table.add(row);
                                Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Options") + ":"), true));
                                Cell cell1 = new Cell();
                                cell1.add(new CheckBox("CouponOAccess", (i1 & 0x8000) != 0));
                                cell1.add(new Text(super.r.getString(teasession._nLanguage, "CouponOAccess")));
                                cell1.add(new CheckBox("CouponOAd", (i1 & 0x4000) != 0));
                                cell1.add(new Text(super.r.getString(teasession._nLanguage, "CouponOAd")));
                                cell1.add(new CheckBox("CouponOBuy", (i1 & 0x2000) != 0));
                                cell1.add(new Text(super.r.getString(teasession._nLanguage, "CouponOBuy")));
                                cell1.add(new CheckBox("CouponOBid", (i1 & 0x1000) != 0));
                                cell1.add(new Text(super.r.getString(teasession._nLanguage, "CouponOBid")));
                                cell1.add(new CheckBox("CouponOBargain", (i1 & 0x800) != 0));
                                cell1.add(new Text(super.r.getString(teasession._nLanguage, "CouponOBargain")));
                                row1.add(cell1);
                                table.add(row1);
                                Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Minimum") + ":"), true));
                                row2.add(new Cell(new TextField("Minimum", bigdecimal)));
                                table.add(row2);
                                Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Discount") + ":"), true));
                                row3.add(new Cell(new TextField("Discount", bigdecimal2)));
                                table.add(row3);
                                Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Code") + ":"), true));
                                row4.add(new Cell(new TextField("Code", s1, 20, 40)));
                                table.add(row4);
                                Row row5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Name") + ":"), true));
                                row5.add(new Cell(new TextField("Name", s3, 20, 255)));
                                table.add(row5);
                                Row row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Text") + ":"), true));
                                row6.add(new Cell(new TextArea("Text", s5, 8, 60)));
                                table.add(row6);
                                form.add(table);
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(form);
                                printwriter.print(new Script("document.foEdit.Text.focus();"));
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();
                 */
            } else
            {
                int j = Integer.parseInt(request.getParameter("Currency"));
                int l = Integer.parseInt(request.getParameter("Type"));
                int j1 = 0;
                if (request.getParameter("CouponOAccess") != null)
                {
                    j1 |= 0x8000;
                }
                if (request.getParameter("CouponOAd") != null)
                {
                    j1 |= 0x4000;
                }
                if (request.getParameter("CouponOBuy") != null)
                {
                    j1 |= 0x2000;
                }
                if (request.getParameter("CouponOBid") != null)
                {
                    j1 |= 0x1000;
                }
                if (request.getParameter("CouponOBargain") != null)
                {
                    j1 |= 0x800;
                }
                BigDecimal bigdecimal1 = null;
                try
                {
                    bigdecimal1 = new BigDecimal(request.getParameter("Minimum"));
                } catch (Exception _ex)
                {}
                BigDecimal bigdecimal3 = null;
                try
                {
                    bigdecimal3 = new BigDecimal(request.getParameter("Discount"));
                } catch (Exception _ex)
                {}
                String s2 = request.getParameter("Code");
                String s4 = request.getParameter("Name");
                String s6 = request.getParameter("Text");
                if (s6.length() == 0)
                {
                    s6 = null;
                }
                if (bigdecimal1 == null)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidMinimum"));
                    return;
                }
                if (bigdecimal3 == null)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidDiscount"));
                    return;
                }
                if (s2.length() == 0)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidCode"));
                    return;
                }
                if (s4.length() == 0)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidName"));
                    return;
                }
                String memberx = request.getParameter("memberx");
                BigDecimal bank = null;
                try
                {
                    bank = new java.math.BigDecimal(request.getParameter("bank"));
                } catch (Exception ex)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidBank"));
                    return;
                }
                boolean flag1 = false;
                if (flag)
                {
                    Coupon.create(teasession._strCommunity, teasession._rv._strR, j, l, j1, bigdecimal1, bigdecimal3, s2, teasession._nLanguage, s4, s6, memberx, bank);
                } else
                {
                    int k1 = Integer.parseInt(s);
                    Coupon coupon1 = Coupon.find(k1);
                    coupon1.set(j, l, j1, bigdecimal1, bigdecimal3, s2, teasession._nLanguage, s4, s6, memberx, bank);
                }
                response.sendRedirect("Coupons");
            }
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/profile/EditCoupon");
    }
}
