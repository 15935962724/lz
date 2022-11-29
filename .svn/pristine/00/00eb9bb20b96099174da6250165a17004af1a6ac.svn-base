// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-27 12:53:38
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   CheckoutCart2.java

package tea.ui.member.offer;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.html.*;
import tea.htmlx.FileInput;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class CheckoutCart2 extends TeaServlet
{

    public CheckoutCart2()
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
            BigDecimal bigdecimal = null;
            try
            {
                bigdecimal = new BigDecimal(request.getParameter("ListTotal"));
            } catch(Exception _ex)
            {}
            if(bigdecimal == null)
            {
                outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidListTotal"));
                return;
            }
            BigDecimal bigdecimal1 = null;
            try
            {
                bigdecimal1 = new BigDecimal(request.getParameter("SubTotal"));
            } catch(Exception _ex)
            {}
            if(bigdecimal1 == null)
            {
                outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidSubTotal"));
                return;
            }
            BigDecimal bigdecimal2 = null;
            try
            {
                bigdecimal2 = new BigDecimal(request.getParameter("Sh"));
            } catch(Exception _ex)
            {}
            if(bigdecimal2 == null)
            {
                outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidShipping"));
                return;
            }
            BigDecimal bigdecimal3 = null;
            try
            {
                bigdecimal3 = new BigDecimal(request.getParameter("Tax"));
            } catch(Exception _ex)
            {}
            if(bigdecimal3 == null)
            {
                outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidTax"));
                return;
            }
            int i = 0;
            int j = 0;
            i = Integer.parseInt(request.getParameter("PayByPoint"));
            j = Integer.parseInt(request.getParameter("BuyPoint"));
            BuyPoint buypoint = BuyPoint.find(j);
            String s = request.getParameter("Vendor");
            int k = Integer.parseInt(request.getParameter("Currency"));
            if(k == 6 && i == 1)
            {
                outText(teasession,response,super.r.getString(teasession._nLanguage,"NotAllowed"));
                return;
            }
            String s1 = request.getParameter("CouponCode");
            int l = 0;
            if(s1.length() != 0)
            {
                l = Coupon.find(teasession._strCommunity,s,k,8192,s1);
                if(l == 0)
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidCouponCode"));
                    return;
                }
            }
            BigDecimal bigdecimal4 = new BigDecimal(0.0D);
            if(l != 0)
            {
                if(CouponMember.count(l) != 0 && !CouponMember.isExisted(l,teasession._rv._strR))
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidCouponMember"));
                    return;
                }
                Coupon coupon = Coupon.find(l);
                BigDecimal bigdecimal5 = coupon.getMinimum();
                BigDecimal bigdecimal6 = coupon.getDiscount();
                if(bigdecimal5.compareTo(bigdecimal1) > 0)
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidCouponMinimum"));
                    return;
                }
                switch(coupon.getType())
                {
                case 0: // '\0'
                    bigdecimal4 = bigdecimal6;
                    break;

                case 1: // '\001'
                    bigdecimal4 = bigdecimal.multiply(bigdecimal6);
                    break;

                case 2: // '\002'
                    bigdecimal4 = bigdecimal1.multiply(bigdecimal6);
                    break;

                case 3: // '\003'
                    bigdecimal4 = bigdecimal2.multiply(bigdecimal6);
                    break;
                }
                bigdecimal4 = bigdecimal4.negate().setScale(2,4);
            }
            int i1 = Integer.parseInt(request.getParameter("Shipping"));
            String s2 = super.r.getString(teasession._nLanguage,Common.CURRENCY[k]);
            response.setHeader("Expires","0");
            response.setHeader("Cache-Control","no-cache");
            response.setHeader("Pragma","no-chache");
            Profile profile = Profile.find(teasession._rv._strR);
            String s3 = profile.getEmail();
            String s4 = profile.getFirstName(teasession._nLanguage);
            String s5 = profile.getLastName(teasession._nLanguage);
            String s6 = profile.getOrganization(teasession._nLanguage);
            String s7 = profile.getAddress(teasession._nLanguage);
            String s8 = profile.getCity(teasession._nLanguage);
            String s9 = profile.getState(teasession._nLanguage);
            String s10 = profile.getZip(teasession._nLanguage);
            String s11 = profile.getCountry(teasession._nLanguage);
            String s12 = profile.getTelephone(teasession._nLanguage);
            String s13 = profile.getFax(teasession._nLanguage);
            BigDecimal bigdecimal7 = new BigDecimal(0.0D);
            Table table = new Table();
            table.setCellSpacing(3);
            table.setTitle(super.r.getString(teasession._nLanguage,"TradeSubject") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage,"Price") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage,"Quantity") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage,"Total") + "\n");
            Shipping shipping = Shipping.find(i1);
            shipping.getPayMethod();
            shipping.getParameters();
            Form form = new Form("foCheckout","POST","CheckoutCart3");
            form.setMultiPart(true);
            form.setOnSubmit("return(submitEmail(this.bEmail,'" + super.r.getString(teasession._nLanguage,"InvalidEmailAddress") + "')" + "&&submitText(this.bFirstName,'" + super.r.getString(teasession._nLanguage,"InvalidFirstName") + "')" + "&&submitText(this.bLastName,'" + super.r.getString(teasession._nLanguage,"InvalidLastName") + "')" + "&&submitText(this.bAddress,'" + super.r.getString(teasession._nLanguage,"InvalidAddress") + "')" + "&&submitText(this.bCity,'" + super.r.getString(teasession._nLanguage,"InvalidCity") + "')" + "&&submitText(this.bState,'" + super.r.getString(teasession._nLanguage,"InvalidState") + "')" + "&&submitText(this.bCountry,'" + super.r.getString(teasession._nLanguage,"InvalidCountry") + "')" + "&&submitText(this.bTelephone,'" +
                             super.r.getString(teasession._nLanguage,"InvalidTelephone") + "')" + ");");
            form.add(new HiddenField("Vendor",s));
            form.add(new HiddenField("Currency",k));
            form.add(new HiddenField("Shipping",i1));
            int j1 = 0;
            do
            {
                String s14 = request.getParameter("Buy" + j1);
                if(s14 == null)
                    break;
                String s15 = request.getParameter("Node" + j1);
                String s16 = request.getParameter("Nodex" + j1);
                String s17 = request.getParameter("SKU" + j1);
                String s18 = request.getParameter("SerialNumber" + j1);
                int k1 = Integer.parseInt(request.getParameter("Quality" + j1));
                String s19 = request.getParameter("Subject" + j1);
                String s20 = request.getParameter("Subjectx" + j1);
                BigDecimal bigdecimal9 = new BigDecimal(request.getParameter("Price" + j1));
                int l1 = Integer.parseInt(request.getParameter("Quantity" + j1));
                int i2 = Integer.parseInt(request.getParameter("ConvertCurrency" + j1));
                BigDecimal bigdecimal10 = new BigDecimal(request.getParameter("ConvertPoint" + j1));
                BigDecimal bigdecimal11 = bigdecimal9.multiply(new BigDecimal(l1));
                bigdecimal7 = bigdecimal7.add(bigdecimal11);
                Row row7 = new Row(new Cell("<font>" + (new Text(s19)).toString() + " &nbsp;" + (new Text(s20)).toString() + "</font>"));
                row7.add(new Cell(new Text("  ")));
                row7.add(new Cell(new Text(s2 + bigdecimal9)));
                row7.add(new Cell(new Text("  ")));
                Cell cell9 = new Cell(new Text(Integer.toString(l1)));
                cell9.setAlign(2);
                row7.add(cell9);
                row7.add(new Cell(new Text("  ")));
                row7.add(new Cell(new Text(s2 + bigdecimal11)));
                table.add(row7);
                form.add(new HiddenField("Buy" + j1,s14));
                form.add(new HiddenField("Node" + j1,s15));
                form.add(new HiddenField("Nodex" + j1,s16));
                form.add(new HiddenField("SKU" + j1,s17));
                form.add(new HiddenField("SerialNumber" + j1,s18));
                form.add(new HiddenField("Quality" + j1,Integer.toString(k1)));
                form.add(new HiddenField("Subject" + j1,s19));
                form.add(new HiddenField("Subjectx" + j1,s20));
                form.add(new HiddenField("Price" + j1,bigdecimal9.toString()));
                form.add(new HiddenField("Quantity" + j1,Integer.toString(l1)));
                form.add(new HiddenField("ConvertCurrency" + j1,Integer.toString(i2)));
                form.add(new HiddenField("ConvertPoint" + j1,bigdecimal10.toString()));
                j1++;
            } while(true);
            if(bigdecimal7.compareTo(bigdecimal1) != 0)
            {
                outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidSubTotal"));
                return;
            }
            Object obj = new Row();
            Object obj1 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Shipping") + ":"),6);
            ((TableElement) obj1).setAlign(3);
            ((HtmlElement) obj).add((HtmlElement) obj1);
            Cell cell = new Cell(new Text(s2 + bigdecimal2));
            cell.setAlign(3);
            ((HtmlElement) obj).add(cell);
            ((HtmlElement) obj).add(new HiddenField("Sh",bigdecimal2));
            table.add((HtmlElement) obj);
            if(bigdecimal3.compareTo(new BigDecimal(0.0D)) != 0)
            {
                Row row = new Row();
                Cell cell1 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Tax") + "(" + shipping.getTaxRate().toString() + "%)" + ":"),6);
                cell1.setAlign(3);
                row.add(cell1);
                Cell cell3 = new Cell(new Text(s2 + bigdecimal3));
                cell3.setAlign(3);
                row.add(cell3);
                table.add(row);
            }
            form.add(new HiddenField("Tax",bigdecimal3));
            if(l != 0)
            {
                Row row1 = new Row();
                row1.setFGColor("RED");
                Cell cell2 = new Cell(new Text("<font>" + super.r.getString(teasession._nLanguage,"Coupon") + "(" + s1 + ")" + ":" + "</font>"),6);
                cell2.setAlign(3);
                row1.add(cell2);
                Cell cell4 = new Cell(new Text(s2 + " " + bigdecimal4.toString()));
                cell4.setAlign(3);
                row1.add(cell4);
                table.add(row1);
                Coupon coupon1 = Coupon.find(l);
                Row row2 = new Row();
                Cell cell6 = new Cell(new Text("<font>" + coupon1.getName(teasession._nLanguage) + "</font>"),6);
                cell6.setAlign(3);
                row2.add(cell6);
                table.add(row2);
                Row row5 = new Row();
                Cell cell8 = new Cell(new Text("<font>" + coupon1.getText(teasession._nLanguage) + "</font>"),6);
                row5.add(cell8);
                table.add(row5);
            }
            form.add(new HiddenField("Coupon",l));
            form.add(new HiddenField("Discount",bigdecimal4));
            form.add(new HiddenField("ListTotal",bigdecimal));
            form.add(new HiddenField("SubTotal",bigdecimal1));
            form.add(new HiddenField("PayByPoint",i));
            form.add(new HiddenField("BuyPoint",j));
            form.add(new HiddenField("CouponCode",s1));
            BigDecimal bigdecimal8 = bigdecimal1.add(bigdecimal2).add(bigdecimal3).add(bigdecimal4);
            form.add(new HiddenField("Total",bigdecimal8));
            Object obj2 = new Row();
            Object obj3 = new Cell(new Text(super.r.getString(teasession._nLanguage,"Total") + ":"),6);
            ((TableElement) obj3).setAlign(3);
            ((HtmlElement) obj2).add((HtmlElement) obj3);
            Cell cell5 = new Cell(new Text(s2 + bigdecimal8));
            cell5.setAlign(3);
            ((HtmlElement) obj2).add(cell5);
            table.add((HtmlElement) obj2);
            if(i == 0 && buypoint.getCurrentPoint().compareTo(new BigDecimal(0.0D)) == 1)
            {
                Row row3 = new Row();
                Cell cell7 = new Cell(new Text(super.r.getString(teasession._nLanguage,"YourCurrentPoint") + ":  "),4);
                cell7.add(new Text("<font> " + buypoint.getCurrentPoint().toString() + "</font>"));
                row3.add(cell7);
                table.add(row3);
            }
            form.add(table);
            form.add(new Text("<HR SIZE=1>"));
            obj = new Table(super.r.getString(teasession._nLanguage,"BillingAddress"));
            obj1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Customer") + ":"),true));
            ((HtmlElement) obj1).add(new Cell(new Text(teasession._rv.toString())));
            ((HtmlElement) obj).add((HtmlElement) obj1);
            obj2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"EmailAddress") + ":"),true));
            ((HtmlElement) obj2).add(new Cell(new TextField("bEmail",s3,40,40)));
            ((HtmlElement) obj).add((HtmlElement) obj2);
            obj3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"FirstName") + ":"),true));
            Object obj4 = new Cell(new TextField("bFirstName",s4,20,20));
            ((HtmlElement) obj4).add(new Text(super.r.getString(teasession._nLanguage,"LastName") + ":"));
            ((HtmlElement) obj4).add(new TextField("bLastName",s5,20,20));
            ((HtmlElement) obj3).add((HtmlElement) obj4);
            ((HtmlElement) obj).add((HtmlElement) obj3);
            Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Organization") + ":"),true));
            row4.add(new Cell(new TextField("bOrganization",s6,40,40)));
            ((HtmlElement) obj).add(row4);
            Row row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Address") + ":"),true));
            row6.add(new Cell(new TextArea("bAddress",s7,2,40)));
            ((HtmlElement) obj).add(row6);
            Object obj5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"City") + ":"),true));
            Object obj6 = new Cell(new TextField("bCity",s8,20,20));
            ((HtmlElement) obj6).add(new Text(super.r.getString(teasession._nLanguage,"State") + ":"));
            ((HtmlElement) obj6).add(new TextField("bState",s9,20,20));
            ((HtmlElement) obj5).add((HtmlElement) obj6);
            ((HtmlElement) obj).add((HtmlElement) obj5);
            Object obj7 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Zip") + ":"),true));
            Object obj8 = new Cell(new TextField("bZip",s10,20,20));
            ((HtmlElement) obj8).add(new Text(super.r.getString(teasession._nLanguage,"Country") + ":"));
            ((HtmlElement) obj8).add(new TextField("bCountry",s11));
            ((HtmlElement) obj7).add((HtmlElement) obj8);
            ((HtmlElement) obj).add((HtmlElement) obj7);
            Object obj9 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Telephone") + ":"),true));
            Cell cell10 = new Cell(new TextField("bTelephone",s12,20,20));
            cell10.add(new Text(super.r.getString(teasession._nLanguage,"Fax") + ":"));
            cell10.add(new TextField("bFax",s13,20,20));
            ((HtmlElement) obj9).add(cell10);
            ((HtmlElement) obj).add((HtmlElement) obj9);
            form.add((HtmlElement) obj);
            form.add(new CheckBox("TradeOUpdateProfile",false));
            form.add(new Text(super.r.getString(teasession._nLanguage,"TradeOUpdateProfile")));
            obj = new Table(super.r.getString(teasession._nLanguage,"ShippingAddress"));
            obj1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"EmailAddress") + ":"),true));
            ((HtmlElement) obj1).add(new Cell(new TextField("sEmail",s3,40,40)));
            ((HtmlElement) obj).add((HtmlElement) obj1);
            obj2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"FirstName") + ":"),true));
            obj3 = new Cell(new TextField("sFirstName",s4,20,20));
            ((HtmlElement) obj3).add(new Text(super.r.getString(teasession._nLanguage,"LastName") + ":"));
            ((HtmlElement) obj3).add(new TextField("sLastName",s5,20,20));
            ((HtmlElement) obj2).add((HtmlElement) obj3);
            ((HtmlElement) obj).add((HtmlElement) obj2);
            obj4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Organization") + ":"),true));
            ((HtmlElement) obj4).add(new Cell(new TextField("sOrganization",s6,40,40)));
            ((HtmlElement) obj).add((HtmlElement) obj4);
            row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Address") + ":"),true));
            row4.add(new Cell(new TextArea("sAddress",s7,2,40)));
            ((HtmlElement) obj).add(row4);
            row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"City") + ":"),true));
            obj5 = new Cell(new TextField("sCity",s8,20,20));
            ((HtmlElement) obj5).add(new Text(super.r.getString(teasession._nLanguage,"State") + ":"));
            ((HtmlElement) obj5).add(new TextField("sState",s9,20,20));
            row6.add((HtmlElement) obj5);
            ((HtmlElement) obj).add(row6);
            obj6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Zip") + ":"),true));
            obj7 = new Cell(new TextField("sZip",s10,20,20));
            ((HtmlElement) obj7).add(new Text(super.r.getString(teasession._nLanguage,"Country") + ":"));
            ((HtmlElement) obj7).add(new TextField("sCountry",s11));
            ((HtmlElement) obj6).add((HtmlElement) obj7);
            ((HtmlElement) obj).add((HtmlElement) obj6);
            obj8 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Telephone") + ":"),true));
            obj9 = new Cell(new TextField("sTelephone",s12,20,20));
            ((HtmlElement) obj9).add(new Text(super.r.getString(teasession._nLanguage,"Fax") + ":"));
            ((HtmlElement) obj9).add(new TextField("sFax",s13,20,20));
            ((HtmlElement) obj8).add((HtmlElement) obj9);
            ((HtmlElement) obj).add((HtmlElement) obj8);
            form.add((HtmlElement) obj);
            form.add(new CheckBox("TradeOShipToBilling",true));
            form.add(new Text(super.r.getString(teasession._nLanguage,"TradeOShipToBilling")));
            form.add(new Text("<HR SIZE=1>"));
            obj = new Table();
            ((HtmlElement) obj).add(new FileInput(teasession._nLanguage,"Voice"));
            obj1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage,"Remark") + ":"),true));
            ((HtmlElement) obj1).add(new Cell(new TextArea("Remark","",6,60)));
            ((HtmlElement) obj).add((HtmlElement) obj1);
            form.add((HtmlElement) obj);
            form.add(new Button(super.r.getString(teasession._nLanguage,"Continue")));
            obj2 = beginOut(response,teasession);
            ((PrintWriter) obj2).print(form);
            ((PrintWriter) obj2).print(new Script("document.foCheckout.bEmail.focus();"));
            ((PrintWriter) obj2).print(new Languages(teasession._nLanguage,request));
            endOut((PrintWriter) obj2,teasession);
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
        super.r.add("tea/ui/member/offer/CheckoutCart2").add("tea/ui/member/offer/Offers");
    }
}
