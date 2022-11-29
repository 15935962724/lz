package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Shipping;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditShipping extends TeaServlet
{

    public EditShipping()
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
            String s = request.getParameter("Shipping");
            boolean flag = s == null;
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/profile/EditShipping.jsp" + qs);
                /*
                                 int i = 0;
                                 int k = 8192;
                                 BigDecimal bigdecimal = new BigDecimal(0.0D);
                                 BigDecimal bigdecimal2 = new BigDecimal(0.0D);
                                 BigDecimal bigdecimal4 = new BigDecimal(0.0D);
                                 String s1 = "";
                                 String s3 = "";
                                 if (!flag)
                                 {
                   Shipping shipping = Shipping.find(Integer.parseInt(s));
                   i = shipping.getCurrency();
                   k = shipping.getOptions();
                   bigdecimal = shipping.getPerShipment();
                   bigdecimal2 = shipping.getPerItem();
                   bigdecimal4 = shipping.getTaxRate();
                   s1 = shipping.getName(teasession._nLanguage);
                   s3 = shipping.getText(teasession._nLanguage);
                                 }
                                 Form form = new Form("foEdit", "POST", "EditShipping");
                                 form.setOnSubmit("return(submitFloat(this.PerShipment,'" + super.r.getString(teasession._nLanguage, "InvalidPerShipment") + "')" + "&&submitFloat(this.PerItem,'" + super.r.getString(teasession._nLanguage, "InvalidPerItem") + "')" + "&&submitFloat(this.TaxRate,'" + super.r.getString(teasession._nLanguage, "InvalidTaxRate") + "')" + "&&submitText(this.Name,'" + super.r.getString(teasession._nLanguage, "InvalidName") + "')" + ");");
                                 if (!flag)
                   form.add(new HiddenField("Shipping", s));
                                 Table table = new Table();
                                 table.add(new CurrencySelection(teasession._nLanguage, i, false));
                                 Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Options") + ":"), true));
                                 Cell cell = new Cell();
                                 cell.add(new CheckBox("ShippingOAccess", (k & 0x8000) != 0));
                                 cell.add(new Text(super.r.getString(teasession._nLanguage, "ShippingOAccess")));
                                 cell.add(new CheckBox("ShippingOAd", (k & 0x4000) != 0));
                                 cell.add(new Text(super.r.getString(teasession._nLanguage, "ShippingOAd")));
                                 cell.add(new CheckBox("ShippingOBuy", (k & 0x2000) != 0));
                                 cell.add(new Text(super.r.getString(teasession._nLanguage, "ShippingOBuy")));
                                 cell.add(new CheckBox("ShippingOBid", (k & 0x1000) != 0));
                                 cell.add(new Text(super.r.getString(teasession._nLanguage, "ShippingOBid")));
                                 cell.add(new CheckBox("ShippingOBargain", (k & 0x800) != 0));
                                 cell.add(new Text(super.r.getString(teasession._nLanguage, "ShippingOBargain")));
                                 cell.add(new CheckBox("ShippingOPercentage", (k & 2) != 0));
                                 cell.add(new Text(super.r.getString(teasession._nLanguage, "ShippingOPercentage")));
                                 cell.add(new CheckBox("ShippingOTax", (k & 1) != 0));
                                 cell.add(new Text(super.r.getString(teasession._nLanguage, "ShippingOTax")));
                                 row.add(cell);
                                 table.add(row);
                                 Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "PerShipment") + ":"), true));
                                 row1.add(new Cell(new TextField("PerShipment", bigdecimal)));
                                 table.add(row1);
                                 Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "PerItem") + ":"), true));
                                 row2.add(new Cell(new TextField("PerItem", bigdecimal2)));
                                 table.add(row2);
                                 Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "TaxRate") + ":"), true));
                                 Cell cell1 = new Cell(new TextField("TaxRate", bigdecimal4));
                                 cell1.add(new Text("%"));
                                 row3.add(cell1);
                                 table.add(row3);
                                 Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Name") + ":"), true));
                                 row4.add(new Cell(new TextField("Name", s1)));
                                 table.add(row4);
                                 Row row5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Text") + ":"), true));
                                 row5.add(new Cell(new TextArea("Text", s3, 8, 60)));
                                 table.add(row5);
                                 form.add(table);
                                 form.add(new Go(teasession._nLanguage, 0));
                                 PrintWriter printwriter = response.getWriter();
                                 printwriter.print(form);
                                 printwriter.print(new Script("document.foEdit.Text.focus();"));
                                 printwriter.print(new Languages(teasession._nLanguage, request));
                                 printwriter.close();*/
                return;
            }
            int j = Integer.parseInt(request.getParameter("Currency"));
            int l = 0;
            if (request.getParameter("ShippingOAccess") != null)
            {
                l |= 0x8000;
            }
            if (request.getParameter("ShippingOAd") != null)
            {
                l |= 0x4000;
            }
            if (request.getParameter("ShippingOBuy") != null)
            {
                l |= 0x2000;
            }
            if (request.getParameter("ShippingOBid") != null)
            {
                l |= 0x1000;
            }
            if (request.getParameter("ShippingOBargain") != null)
            {
                l |= 0x800;
            }
            if (request.getParameter("ShippingOPercentage") != null)
            {
                l |= 2;
            }
            if (request.getParameter("ShippingOTax") != null)
            {
                l |= 1;
            }
            BigDecimal bigdecimal1 = null;
            try
            {
                bigdecimal1 = new BigDecimal(request.getParameter("PerShipment"));
            } catch (Exception _ex)
            {}
            BigDecimal bigdecimal3 = null;
            try
            {
                bigdecimal3 = new BigDecimal(request.getParameter("PerItem"));
            } catch (Exception _ex)
            {}
            BigDecimal bigdecimal5 = null;
            try
            {
                bigdecimal5 = new BigDecimal(request.getParameter("TaxRate"));
            } catch (Exception _ex)
            {}
            String s2 = request.getParameter("Name");
            String s4 = request.getParameter("Text");
            if (s4.length() == 0)
            {
                s4 = null;
            }
            if (bigdecimal1 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidPerShipment"));
                return;
            }
            if (bigdecimal3 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidPerItem"));
                return;
            }
            if (bigdecimal5 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidTaxRate"));
                return;
            }
            if (s2 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidName"));
                return;
            }
            int i1 = 0;
            if (flag)
            {
                i1 = Shipping.create(teasession._strCommunity, teasession._rv._strR, j, l, bigdecimal1, bigdecimal3, teasession._nLanguage, s2, s4, bigdecimal5);
            } else
            {
                i1 = Integer.parseInt(s);
                Shipping shipping1 = Shipping.find(i1);
                shipping1.set(j, l, bigdecimal1, bigdecimal3, teasession._nLanguage, s2, s4, bigdecimal5);
            }
            if (request.getParameter("GoNext") != null)
            {
                response.sendRedirect("EditShipping1?Shipping=" + i1);
                return;
            }
            if (request.getParameter("GoFinish") != null)
            {
                response.sendRedirect("Shippings");
                return;
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
        super.r.add("tea/ui/member/profile/EditShipping");
    }
}
