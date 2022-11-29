package tea.ui.node.aded;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class PayAded0 extends TeaServlet
{

	public PayAded0()
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
			int i = Integer.parseInt(request.getParameter("Aded"));
			Aded aded = Aded.find(i);
			if (aded.getNode() != teasession._nNode || !aded.isCreator(teasession._rv) || aded.getStatus() != 0)
			{
				response.sendError(403);
				return;
			}
			Node node = Node.find(teasession._nNode);
			RV rv = node.getCreator();
			int j = aded.getAding();
			Ading.find(j);
			int k = 0;
			try
			{
				k = Integer.parseInt(request.getParameter("Shipping"));
			} catch (Exception _ex)
			{
			}
			int l = Integer.parseInt(request.getParameter("Currency"));
			String s = r.getString(teasession._nLanguage, Common.CURRENCY[l]);
			BigDecimal bigdecimal = new BigDecimal(request.getParameter("Price"));
			int i1 = 0;
			String s1 = null;
			if (k != 0)
			{
				Shipping shipping = Shipping.find(k);
				i1 = shipping.getPayMethod();
				s1 = shipping.getParameters();
			}
			String s2 = request.getParameter("CouponCode");
			int j1 = 0;
			if (s2.length() != 0)
			{
				j1 = Coupon.find(node.getCommunity(), rv._strR, l, 16384, s2);
				if (j1 == 0)
				{
					outText(teasession, response, r.getString(teasession._nLanguage, "InvalidCouponCode"));
					return;
				}
			}
			BigDecimal bigdecimal1 = new BigDecimal(0.0D);
			if (j1 != 0)
			{
				if (CouponMember.count(j1) != 0 && !CouponMember.isExisted(j1, teasession._rv._strR))
				{
					outText(teasession, response, r.getString(teasession._nLanguage, "InvalidCouponMember"));
					return;
				}
				Coupon coupon = Coupon.find(j1);
				BigDecimal bigdecimal2 = coupon.getMinimum();
				BigDecimal bigdecimal3 = coupon.getDiscount();
				if (bigdecimal2.compareTo(bigdecimal) > 0)
				{
					outText(teasession, response, r.getString(teasession._nLanguage, "InvalidCouponMinimum"));
					return;
				}
				switch (coupon.getType())
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
			Profile profile = Profile.find(rv._strR);
			Profile profile1 = Profile.find(teasession._rv._strR);
			if (l == 0 && i1 == Shipping.PAYMETHOD_ITRANSACT)
			{
				Form form = new Form("foPay", "POST", "https://secure.itransact.com/cgi-bin/mas/split.cgi");
				form.setOnSubmit("return(submitEmail(this.email,'" + r.getString(teasession._nLanguage, "InvalidEmail") + "')" + "&&submitText(this.first_name,'" + r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.last_name,'" + r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitText(this.address,'" + r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.city,'" + r.getString(teasession._nLanguage, "InvalidCity")
						+ "')" + "&&submitText(this.state,'" + r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.zip,'" + r.getString(teasession._nLanguage, "InvalidZip") + "')" + "&&submitText(this.country,'" + r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.phone,'" + r.getString(teasession._nLanguage, "InvalidTelephone") + "')" + ");");
				form.add(new HiddenField("vendor_id", s1));
				form.add(new HiddenField("home_page", "http://" + request.getServerName() + "/servlet/Aded?Aded=" + i));
				form.add(new HiddenField("mername", RequestHelper.makeName(teasession._nLanguage, profile.getFirstName(teasession._nLanguage), profile.getLastName(teasession._nLanguage))));
				form.add(new HiddenField("acceptcards", "1"));
				form.add(new HiddenField("altaddr", "0"));
				form.add(new HiddenField("nonum", "1"));
				form.add(new HiddenField("1-desc", RequestHelper.format(r.getString(teasession._nLanguage, "InfAdedRequest"), aded.getAlt(teasession._nLanguage))));
				form.add(new HiddenField("1-cost", bigdecimal.add(bigdecimal1)));
				form.add(new HiddenField("1-qty", "1"));
				Table table = new Table("Billing Address");
				Row row = new Row(new Cell(new Text("First Name:"), true));
				Cell cell = new Cell(new TextField("first_name", profile1.getFirstName(teasession._nLanguage), 15));
				cell.add(new Text("Last Name:"));
				cell.add(new TextField("last_name", profile1.getLastName(teasession._nLanguage), 15));
				row.add(cell);
				table.add(row);
				Row row2 = new Row(new Cell(new Text("Address:"), true));
				row2.add(new Cell(new TextField("address", profile1.getAddress(teasession._nLanguage), 30)));
				table.add(row2);
				Row row5 = new Row(new Cell(new Text("City:"), true));
				Cell cell3 = new Cell(new TextField("city", profile1.getCity(teasession._nLanguage), 15));
				cell3.add(new Text("State:"));
				cell3.add(new TextField("state", profile1.getState(teasession._nLanguage), 2));
				cell3.add(new Text("Zip:"));
				cell3.add(new TextField("zip", profile1.getZip(teasession._nLanguage), 5));
				row5.add(cell3);
				table.add(row5);
				Row row7 = new Row(new Cell(new Text("Country:"), true));
				row7.add(new Cell(new TextField("country", profile1.getCountry(teasession._nLanguage), 15)));
				table.add(row7);
				Row row10 = new Row(new Cell(new Text("Phone Number:"), true));
				row10.add(new Cell(new TextField("phone", profile1.getTelephone(teasession._nLanguage), 15)));
				table.add(row10);
				Row row12 = new Row(new Cell(new Text("E-Mail Address:"), true));
				row12.add(new Cell(new TextField("email", profile1.getEmail(), 30)));
				table.add(row12);
				form.add(table);
				form.add(new HiddenField("ret_addr", "http://" + request.getServerName() + "/servlet/PayAded1"));
				form.add(new HiddenField("passback", "Shipping"));
				form.add(new HiddenField("Shipping", k));
				form.add(new HiddenField("passback", "Node"));
				form.add(new HiddenField("Node", teasession._nNode));
				form.add(new HiddenField("passback", "Aded"));
				form.add(new HiddenField("Aded", i));
				form.add(new HiddenField("passback", "Currency"));
				form.add(new HiddenField("Currency", l));
				form.add(new HiddenField("passback", "Price"));
				form.add(new HiddenField("Price", bigdecimal));
				form.add(new HiddenField("passback", "Coupon"));
				form.add(new HiddenField("Coupon", j1));
				form.add(new HiddenField("passback", "Discount"));
				form.add(new HiddenField("Discount", bigdecimal1));
				form.add(new HiddenField("lookup", "first_name"));
				form.add(new HiddenField("lookup", "last_name"));
				form.add(new HiddenField("lookup", "address"));
				form.add(new HiddenField("lookup", "city"));
				form.add(new HiddenField("lookup", "state"));
				form.add(new HiddenField("lookup", "zip"));
				form.add(new HiddenField("lookup", "country"));
				form.add(new HiddenField("lookup", "phone"));
				form.add(new HiddenField("lookup", "email"));
				form.add(new Button(r.getString(teasession._nLanguage, "Continue")));
				PrintWriter printwriter = response.getWriter();
				printwriter.print(form);
				printwriter.close();
			} else
			{
				Form form1 = new Form("foPay", "POST", "PayAded1");
				form1.setOnSubmit("return(submitEmail(this.email,'" + r.getString(teasession._nLanguage, "InvalidEmail") + "')" + "&&submitText(this.first_name,'" + r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.last_name,'" + r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitText(this.address,'" + r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.city,'" + r.getString(teasession._nLanguage, "InvalidCity")
						+ "')" + "&&submitText(this.state,'" + r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.zip,'" + r.getString(teasession._nLanguage, "InvalidZip") + "')" + "&&submitText(this.country,'" + r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.phone,'" + r.getString(teasession._nLanguage, "InvalidTelephone") + "')" + ");");
				form1.add(new HiddenField("Node", teasession._nNode));
				form1.add(new HiddenField("Aded", i));
				form1.add(new HiddenField("Currency", l));
				form1.add(new HiddenField("Price", bigdecimal));
				form1.add(new HiddenField("Shipping", k));
				Object obj = new Table();
				Row row1 = new Row();
				Object obj1 = new Cell(new Text(r.getString(teasession._nLanguage, "AdedFee") + " : "));
				((TableElement) (obj1)).setAlign(3);
				row1.add(((HtmlElement) (obj1)));
				row1.add(new Cell(new Text(bigdecimal.toString())));
				((HtmlElement) (obj)).add(row1);
				if (j1 != 0)
				{
					Row row3 = new Row();
					row3.setFGColor("RED");
					Cell cell1 = new Cell(new Text(r.getString(teasession._nLanguage, "Coupon") + " : " + s2));
					cell1.setAlign(3);
					row3.add(cell1);
					row3.add(new Cell(new Text(bigdecimal1.toString())));
					((HtmlElement) (obj)).add(row3);
					Coupon coupon1 = Coupon.find(j1);
					Row row8 = new Row();
					Cell cell4 = new Cell(new Text(coupon1.getName(teasession._nLanguage)));
					cell4.setAlign(3);
					row8.add(cell4);
					row8.add(new Cell(new Text(coupon1.getText(teasession._nLanguage))));
					((HtmlElement) (obj)).add(row8);
				}
				form1.add(new HiddenField("Coupon", j1));
				form1.add(new HiddenField("Discount", bigdecimal1));
				Row row4 = new Row();
				Cell cell2 = new Cell(new Text(r.getString(teasession._nLanguage, "Total") + ":"));
				cell2.setAlign(3);
				row4.add(cell2);
				row4.add(new Cell(new Text(s + bigdecimal.add(bigdecimal1))));
				((HtmlElement) (obj)).add(row4);
				form1.add(((HtmlElement) (obj)));
				obj = new Table(r.getString(teasession._nLanguage, "BillingAddress"));
				row1 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Customer") + ":"), true));
				row1.add(new Cell(new Text(teasession._rv.toString())));
				((HtmlElement) (obj)).add(row1);
				obj1 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
				((HtmlElement) (obj1)).add(new Cell(new TextField("bEmail", profile1.getEmail(), 40, 40)));
				((HtmlElement) (obj)).add(((HtmlElement) (obj1)));
				row4 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "FirstName") + ":"), true));
				cell2 = new Cell(new TextField("bFirstName", profile1.getFirstName(teasession._nLanguage), 20, 20));
				cell2.add(new Text(r.getString(teasession._nLanguage, "LastName") + ":"));
				cell2.add(new TextField("bLastName", profile1.getLastName(teasession._nLanguage), 20, 20));
				row4.add(cell2);
				((HtmlElement) (obj)).add(row4);
				Row row6 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Organization") + ":"), true));
				row6.add(new Cell(new TextField("bOrganization", profile1.getOrganization(teasession._nLanguage), 40, 40)));
				((HtmlElement) (obj)).add(row6);
				Row row9 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Address") + ":"), true));
				row9.add(new Cell(new TextArea("bAddress", profile1.getAddress(teasession._nLanguage), 2, 40)));
				((HtmlElement) (obj)).add(row9);
				Row row11 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "City") + ":"), true));
				Cell cell5 = new Cell(new TextField("bCity", profile1.getCity(teasession._nLanguage), 20, 20));
				cell5.add(new Text(r.getString(teasession._nLanguage, "State") + ":"));
				cell5.add(new TextField("bState", profile1.getState(teasession._nLanguage), 20, 20));
				row11.add(cell5);
				((HtmlElement) (obj)).add(row11);
				Row row13 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Zip") + ":"), true));
				Cell cell6 = new Cell(new TextField("bZip", profile1.getZip(teasession._nLanguage), 20, 20));
				cell6.add(new Text(r.getString(teasession._nLanguage, "Country") + ":"));
				cell6.add(new TextField("bCountry", profile1.getCountry(teasession._nLanguage)));
				row13.add(cell6);
				((HtmlElement) (obj)).add(row13);
				Row row14 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Telephone") + ":"), true));
				Cell cell7 = new Cell(new TextField("bTelephone", profile1.getTelephone(teasession._nLanguage), 20, 20));
				cell7.add(new Text(r.getString(teasession._nLanguage, "Fax") + ":"));
				cell7.add(new TextField("bFax", profile1.getFax(teasession._nLanguage), 20, 20));
				row14.add(cell7);
				((HtmlElement) (obj)).add(row14);
				form1.add(((HtmlElement) (obj)));
				form1.add(new Button(r.getString(teasession._nLanguage, "Continue")));
				PrintWriter out = response.getWriter();
				out.print(form1);
				out.close();
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
		r.add("tea/ui/node/aded/PayAded0");
	}
}
