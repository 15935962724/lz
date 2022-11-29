// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-24 18:01:27
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   Shippings.java

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
import tea.entity.member.Shipping;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Shippings extends TeaServlet
{

    public Shippings()
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
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/profile/Shippings.jsp" + qs);
            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Profile", super.r.getString(teasession._nLanguage, "Profile")) + ">" + super.r.getString(teasession._nLanguage, "Shippings"));
                        text.setId("PathDiv");
                        Table table = new Table();
                        table.setCellSpacing(5);
                        int i = Shipping.count(teasession._rv._strR);
                        table.setCaption(i + " " + super.r.getString(teasession._nLanguage, "Shippings"));
                        if(i != 0)
                        {
                            table.setTitle(super.r.getString(teasession._nLanguage, "Name") + "\n" + super.r.getString(teasession._nLanguage, "Currency") + "\n" + super.r.getString(teasession._nLanguage, "Options") + "\n" + super.r.getString(teasession._nLanguage, "PerShipment") + "\n" + super.r.getString(teasession._nLanguage, "PerItem") + "\n" + super.r.getString(teasession._nLanguage, "TaxRate") + "\n" + super.r.getString(teasession._nLanguage, "PayMethod"));
                            Row row;
                            for(Enumeration enumeration = Shipping.find(teasession._rv._strR); enumeration.hasMoreElements(); table.add(row))
                            {
                                int j = ((Integer)enumeration.nextElement()).intValue();
                                Shipping shipping = Shipping.find(j);
                                int k = shipping.getCurrency();
                                int l = shipping.getOptions();
                                row = new Row(new Cell(new Text(shipping.getName(teasession._nLanguage))));
                                row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Common.CURRENCY[k]))));
                                Cell cell = new Cell();
                                if((l & 2) != 0)
                                    cell.add(new Text(super.r.getString(teasession._nLanguage, "ShippingOPercentage")));
                                if((l & 1) != 0)
                                    cell.add(new Text(super.r.getString(teasession._nLanguage, "ShippingOTax")));
                                row.add(cell);
                                row.add(new Cell(new Text(shipping.getPerShipment().toString())));
                                row.add(new Cell(new Text(shipping.getPerItem().toString())));
                                row.add(new Cell(new Text(shipping.getTaxRate().toString())));
                                row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Shipping.PAYMETHOD[k][shipping.getPayMethod()]))));
                                if(teasession._rv.isAccountant())
                                {
                                    row.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditShipping?Shipping=" + j + "', '_self');")));
                                    row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteShipping?Shipping=" + j + "', '_self');}")));
                                }
                            }

                        }
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(table);
                        printwriter.print(new Break());
                        if(teasession._rv.isAccountant())
                            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditShipping', '_self');"));
                        printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();
                        return;*/
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        //super.r.add("tea/ui/member/profile/ProfileServlet").add("tea/ui/member/profile/Shippings").add("tea/ui/member/profile/EditShipping");
    }
}
