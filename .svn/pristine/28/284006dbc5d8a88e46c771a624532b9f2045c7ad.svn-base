package tea.ui.node.access;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.Node;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.node.AccessRequest;

public class PayAccess0 extends TeaServlet
{

    public PayAccess0()
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
            int j = Integer.parseInt(request.getParameter("Currency"));
            Node node = Node.find(teasession._nNode);
            RV rv = node.getCreator();
            String s2 = request.getParameter("CouponCode");
            int l = 0;
//            if (s2.length() != 0)
            {
                l = Coupon.find(teasession._strCommunity,rv._strR, j, 32768, s2);
                if (l == 0)
                {
                    outText(teasession,response, super.r.getString(teasession._nLanguage, "InvalidCouponCode"));
                    return;
                } else
                {
                    tea.entity.node.AccessPrice ap_obj = tea.entity.node.AccessPrice.find(teasession._nNode, j);
                    Coupon co_obj = Coupon.find(l);
                    if (co_obj.getBank().compareTo(ap_obj.getPrice()) < 0)
                    {
                        outText(teasession,response, super.r.getString(teasession._nLanguage, "BalanceLack"));
                        return;
                    } else
                    {
                        co_obj.setBank(  co_obj.getBank().subtract(ap_obj.getPrice()));
                        AccessRequest.grant(teasession._nNode, teasession._rv);
                        response.sendRedirect("Node?node=" + teasession._nNode);
                    }
                }
            }

            // response.sendRedirect("/jsp/access/PayAccess0.jsp?"+request.getQueryString());
            /*
                        TeaSession teasession = new TeaSession(request);
                        if(teasession._rv == null)
                        {
                            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                            return;
                        }
                        int i = 0;
                        try
                        {
                            i = Integer.parseInt(request.getParameter("Shipping"));
                        }
                        catch(Exception _ex) { }
                        int j = Integer.parseInt(request.getParameter("Currency"));
                        String s = super.r.getString(teasession._nLanguage, Common.CURRENCY[j]);
                        BigDecimal bigdecimal = new BigDecimal(request.getParameter("Price"));
                        int k = 0;
                        String s1 = null;
                        if(i != 0)
                        {
                            Shipping shipping = Shipping.find(i);
                            k = shipping.getPayMethod();
                            s1 = shipping.getParameters();
                        }
                        Node node = Node.find(teasession._nNode);
                        RV rv = node.getCreator();
                        String s2 = request.getParameter("CouponCode");
                        int l = 0;
                        if(s2.length() != 0)
                        {
                            l = Coupon.find(rv._strR, j, 32768, s2);
                            if(l == 0)
                            {
                                outText(teasession,response, super.r.getString(teasession._nLanguage, "InvalidCouponCode"));
                                return;
                            }
                        }
                        BigDecimal bigdecimal1 = new BigDecimal(0.0D);
                        if(l != 0)
                        {
                            if(CouponMember.count(l) != 0 && !CouponMember.isExisted(l, teasession._rv._strR))
                            {
                                outText(teasession,response, super.r.getString(teasession._nLanguage, "InvalidCouponMember"));
                                return;
                            }
                            Coupon coupon = Coupon.find(l);
                            BigDecimal bigdecimal2 = coupon.getMinimum();
                            BigDecimal bigdecimal3 = coupon.getDiscount();
                            if(bigdecimal2.compareTo(bigdecimal) > 0)
                            {
                                outText(teasession,response, super.r.getString(teasession._nLanguage, "InvalidCouponMinimum"));
                                return;
                            }
                            switch(coupon.getType())
                            {
                            case 0: // '\0'
                                bigdecimal1 = bigdecimal3;
                                break;

                            case 1: // '\001'
                            case 2: // '\002'
                            case 3: // '\003'
                                bigdecimal1 = bigdecimal.multiply(bigdecimal3);
                                break;
                            }
                            bigdecimal1 = bigdecimal1.negate().setScale(2, 4);
                        }
                        if(j == 0 && k == Shipping.PAYMETHOD_ITRANSACT)
                        {
                            Profile profile = Profile.find(rv._strR);
                            Profile profile2 = Profile.find(teasession._rv._strR);
                            Form form1 = new Form("foPay", "POST", "https://secure.itransact.com/cgi-bin/mas/split.cgi");
                            form1.setOnSubmit("return(submitEmail(this.email,'" + super.r.getString(teasession._nLanguage, "InvalidEmail") + "')" + "&&submitText(this.first_name,'" + super.r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.last_name,'" + super.r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitText(this.address,'" + super.r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.city,'" + super.r.getString(teasession._nLanguage, "InvalidCity") + "')" + "&&submitText(this.state,'" + super.r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.zip,'" + super.r.getString(teasession._nLanguage, "InvalidZip") + "')" + "&&submitText(this.country,'" + super.r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.phone,'" + super.r.getString(teasession._nLanguage, "InvalidTelephone") + "')" + ");");
                            form1.add(new HiddenField("vendor_id", s1));
                            form1.add(new HiddenField("home_page", "http://" + request.getServerName() + "/servlet/Node?node=" + teasession._nNode));
                            form1.add(new HiddenField("mername", RequestHelper.makeName(teasession._nLanguage, profile.getFirstName(teasession._nLanguage), profile.getLastName(teasession._nLanguage))));
                            form1.add(new HiddenField("acceptcards", "1"));
                            form1.add(new HiddenField("altaddr", "0"));
                            form1.add(new HiddenField("nonum", "1"));
                            form1.add(new HiddenField("1-desc", RequestHelper.format(super.r.getString(teasession._nLanguage, "InfAccessRequest"), node.getSubject(teasession._nLanguage))));
                            form1.add(new HiddenField("1-cost", bigdecimal.add(bigdecimal1)));
                            form1.add(new HiddenField("1-qty", "1"));
                            Table table = new Table("Billing Address");
                            Row row1 = new Row(new Cell(new Text("First Name:"), true));
                            Cell cell = new Cell(new TextField("first_name", profile2.getFirstName(teasession._nLanguage), 15));
                            cell.add(new Text("Last Name:"));
                            cell.add(new TextField("last_name", profile2.getLastName(teasession._nLanguage), 15));
                            row1.add(cell);
                            table.add(row1);
                            Row row4 = new Row(new Cell(new Text("Address:"), true));
                            row4.add(new Cell(new TextField("address", profile2.getAddress(teasession._nLanguage), 30)));
                            table.add(row4);
                            Row row5 = new Row(new Cell(new Text("City:"), true));
                            Cell cell3 = new Cell(new TextField("city", profile2.getCity(teasession._nLanguage), 15));
                            cell3.add(new Text("State:"));
                            cell3.add(new TextField("state", profile2.getState(teasession._nLanguage), 2));
                            cell3.add(new Text("Zip:"));
                            cell3.add(new TextField("zip", profile2.getZip(teasession._nLanguage), 5));
                            row5.add(cell3);
                            table.add(row5);
                            Row row9 = new Row(new Cell(new Text("Country:"), true));
                            row9.add(new Cell(new TextField("country", profile2.getCountry(teasession._nLanguage), 15)));
                            table.add(row9);
                            Row row11 = new Row(new Cell(new Text("Phone Number:"), true));
                            row11.add(new Cell(new TextField("phone", profile2.getTelephone(teasession._nLanguage), 15)));
                            table.add(row11);
                            Row row12 = new Row(new Cell(new Text("E-Mail Address:"), true));
                            row12.add(new Cell(new TextField("email", profile2.getEmail(teasession._nLanguage), 30)));
                            table.add(row12);
                            form1.add(table);
                            form1.add(new HiddenField("ret_addr", "http://" + request.getServerName() + "/servlet/PayAccess1"));
                            form1.add(new HiddenField("passback", "Shipping"));
                            form1.add(new HiddenField("Shipping", i));
                            form1.add(new HiddenField("passback", "Node"));
                            form1.add(new HiddenField("Node", teasession._nNode));
                            form1.add(new HiddenField("passback", "Currency"));
                            form1.add(new HiddenField("Currency", j));
                            form1.add(new HiddenField("passback", "Price"));
                            form1.add(new HiddenField("Price", bigdecimal));
                            form1.add(new HiddenField("passback", "Coupon"));
                            form1.add(new HiddenField("Coupon", l));
                            form1.add(new HiddenField("passback", "Discount"));
                            form1.add(new HiddenField("Discount", bigdecimal1));
                            form1.add(new HiddenField("lookup", "first_name"));
                            form1.add(new HiddenField("lookup", "last_name"));
                            form1.add(new HiddenField("lookup", "address"));
                            form1.add(new HiddenField("lookup", "city"));
                            form1.add(new HiddenField("lookup", "state"));
                            form1.add(new HiddenField("lookup", "zip"));
                            form1.add(new HiddenField("lookup", "country"));
                            form1.add(new HiddenField("lookup", "phone"));
                            form1.add(new HiddenField("lookup", "email"));
                            form1.add(new Button(super.r.getString(teasession._nLanguage, "Continue")));
                            PrintWriter printwriter = response.getWriter();
                            printwriter.print(form1);
                            printwriter.close();
                        } else
                        {
                            Profile.find(rv._strR);
                            Profile profile1 = Profile.find(teasession._rv._strR);
                            Form form = new Form("foPay", "POST", "PayAccess1");
                            form.setOnSubmit("return(submitEmail(this.email,'" + super.r.getString(teasession._nLanguage, "InvalidEmail") + "')" + "&&submitText(this.first_name,'" + super.r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.last_name,'" + super.r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitText(this.address,'" + super.r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.city,'" + super.r.getString(teasession._nLanguage, "InvalidCity") + "')" + "&&submitText(this.state,'" + super.r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.zip,'" + super.r.getString(teasession._nLanguage, "InvalidZip") + "')" + "&&submitText(this.country,'" + super.r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.phone,'" + super.r.getString(teasession._nLanguage, "InvalidTelephone") + "')" + ");");
                            form.add(new HiddenField("Node", teasession._nNode));
                            form.add(new HiddenField("Currency", j));
                            form.add(new HiddenField("Price", bigdecimal));
                            form.add(new HiddenField("Shipping", i));
                            Object obj = new Table();
                            Row row = new Row();
                            Object obj1 = new Cell(new Text(super.r.getString(teasession._nLanguage, "AccessFee") + " : "));
                            ((TableElement) (obj1)).setAlign(3);
                            row.add(((HtmlElement) (obj1)));
                            row.add(new Cell(new Text(bigdecimal.toString())));
                            ((HtmlElement) (obj)).add(row);
                            if(l != 0)
                            {
                                Row row2 = new Row();
                                row2.setFGColor("RED");
                                Cell cell1 = new Cell(new Text(super.r.getString(teasession._nLanguage, "Coupon") + " : " + s2));
                                cell1.setAlign(3);
                                row2.add(cell1);
                                row2.add(new Cell(new Text(bigdecimal1.toString())));
                                ((HtmlElement) (obj)).add(row2);
                                Coupon coupon1 = Coupon.find(l);
                                Row row7 = new Row();
                                Cell cell4 = new Cell(new Text(coupon1.getName(teasession._nLanguage)));
                                cell4.setAlign(3);
                                row7.add(cell4);
                                row7.add(new Cell(new Text(coupon1.getText(teasession._nLanguage))));
                                ((HtmlElement) (obj)).add(row7);
                            }
                            form.add(new HiddenField("Coupon", l));
                            form.add(new HiddenField("Discount", bigdecimal1));
                            Row row3 = new Row();
                            Cell cell2 = new Cell(new Text(super.r.getString(teasession._nLanguage, "Total") + ":"));
                            cell2.setAlign(3);
                            row3.add(cell2);
                            row3.add(new Cell(new Text(s + bigdecimal.add(bigdecimal1))));
                            ((HtmlElement) (obj)).add(row3);
                            form.add(((HtmlElement) (obj)));
                            obj = new Table(super.r.getString(teasession._nLanguage, "BillingAddress"));
                            row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Customer") + ":"), true));
                            row.add(new Cell(new Text(teasession._rv.toString())));
                            ((HtmlElement) (obj)).add(row);
                            obj1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
                            ((HtmlElement) (obj1)).add(new Cell(new TextField("bEmail", profile1.getEmail(teasession._nLanguage), 40, 40)));
                            ((HtmlElement) (obj)).add(((HtmlElement) (obj1)));
                            row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "FirstName") + ":"), true));
                            cell2 = new Cell(new TextField("bFirstName", profile1.getFirstName(teasession._nLanguage), 20, 20));
                            cell2.add(new Text(super.r.getString(teasession._nLanguage, "LastName") + ":"));
                            cell2.add(new TextField("bLastName", profile1.getLastName(teasession._nLanguage), 20, 20));
                            row3.add(cell2);
                            ((HtmlElement) (obj)).add(row3);
                            Row row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Organization") + ":"), true));
                            row6.add(new Cell(new TextField("bOrganization", profile1.getOrganization(teasession._nLanguage), 40, 40)));
                            ((HtmlElement) (obj)).add(row6);
                            Row row8 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Address") + ":"), true));
                            row8.add(new Cell(new TextArea("bAddress", profile1.getAddress(teasession._nLanguage), 2, 40)));
                            ((HtmlElement) (obj)).add(row8);
                            Row row10 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "City") + ":"), true));
                            Cell cell5 = new Cell(new TextField("bCity", profile1.getCity(teasession._nLanguage), 20, 20));
                            cell5.add(new Text(super.r.getString(teasession._nLanguage, "State") + ":"));
                            cell5.add(new TextField("bState", profile1.getState(teasession._nLanguage), 20, 20));
                            row10.add(cell5);
                            ((HtmlElement) (obj)).add(row10);
                            Row row13 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Zip") + ":"), true));
                            Cell cell6 = new Cell(new TextField("bZip", profile1.getZip(teasession._nLanguage), 20, 20));
                            cell6.add(new Text(super.r.getString(teasession._nLanguage, "Country") + ":"));
                            cell6.add(new TextField("bCountry", profile1.getCountry(teasession._nLanguage)));
                            row13.add(cell6);
                            ((HtmlElement) (obj)).add(row13);
                            Row row14 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Telephone") + ":"), true));
                            Cell cell7 = new Cell(new TextField("bTelephone", profile1.getTelephone(teasession._nLanguage), 20, 20));
                            cell7.add(new Text(super.r.getString(teasession._nLanguage, "Fax") + ":"));
                            cell7.add(new TextField("bFax", profile1.getFax(teasession._nLanguage), 20, 20));
                            row14.add(cell7);
                            ((HtmlElement) (obj)).add(row14);
                            form.add(((HtmlElement) (obj)));
                            form.add(new Button(super.r.getString(teasession._nLanguage, "Continue")));
                            obj = beginOut(response, teasession);
                            ((PrintWriter) (obj)).print(form);
                            endOut(((PrintWriter) (obj)), teasession);
                        }
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
        super.r.add("tea/ui/node/access/PayAccess0");
    }
}
