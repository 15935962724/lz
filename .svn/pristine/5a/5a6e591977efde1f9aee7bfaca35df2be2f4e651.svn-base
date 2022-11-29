package tea.ui.node.access;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Profile;
import tea.entity.member.Shipping;
import tea.entity.node.Node;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class OfferAccess0 extends TeaServlet
{

	public OfferAccess0()
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
			int i = 0;
			try
			{
				i = Integer.parseInt(request.getParameter("Shipping"));
			} catch (Exception _ex)
			{
			}
			int j = Integer.parseInt(request.getParameter("Currency"));
			BigDecimal bigdecimal = new BigDecimal(request.getParameter("Price"));
			int k = 0;
			String s = null;
			if (i != 0)
			{
				Shipping shipping = Shipping.find(i);
				k = shipping.getPayMethod();
				s = shipping.getParameters();
			}
			if (j == 0 && k == Shipping.PAYMETHOD_ITRANSACT)
			{
				Node node = Node.find(teasession._nNode);
				RV rv = node.getCreator();
				Profile profile = Profile.find(rv._strR);
				Profile profile2 = Profile.find(teasession._rv._strR);
				Form form1 = new Form("foPay", "POST", "https://secure.itransact.com/cgi-bin/mas/split.cgi");
				form1.setOnSubmit("return(submitEmail(this.email,'" + r.getString(teasession._nLanguage, "InvalidEmail") + "')" + "&&submitText(this.first_name,'" + r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.last_name,'" + r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitText(this.address,'" + r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.city,'" + r.getString(teasession._nLanguage, "InvalidCity")
						+ "')" + "&&submitText(this.state,'" + r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.zip,'" + r.getString(teasession._nLanguage, "InvalidZip") + "')" + "&&submitText(this.country,'" + r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.phone,'" + r.getString(teasession._nLanguage, "InvalidTelephone") + "')" + ");");
				form1.add(new HiddenField("vendor_id", s));
				form1.add(new HiddenField("home_page", "http://" + request.getServerName() + "/servlet/Node?node=" + teasession._nNode));
				form1.add(new HiddenField("mername", RequestHelper.makeName(teasession._nLanguage, profile.getFirstName(teasession._nLanguage), profile.getLastName(teasession._nLanguage))));
				form1.add(new HiddenField("acceptcards", "1"));
				form1.add(new HiddenField("altaddr", "0"));
				form1.add(new HiddenField("nonum", "1"));
				form1.add(new HiddenField("1-desc", RequestHelper.format(r.getString(teasession._nLanguage, "InfAccessRequest"), node.getSubject(teasession._nLanguage))));
				form1.add(new HiddenField("1-cost", bigdecimal));
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
				Cell cell2 = new Cell(new TextField("city", profile2.getCity(teasession._nLanguage), 15));
				cell2.add(new Text("State:"));
				cell2.add(new TextField("state", profile2.getState(teasession._nLanguage), 2));
				cell2.add(new Text("Zip:"));
				cell2.add(new TextField("zip", profile2.getZip(teasession._nLanguage), 5));
				row5.add(cell2);
				table.add(row5);
				Row row8 = new Row(new Cell(new Text("Country:"), true));
				row8.add(new Cell(new TextField("country", profile2.getCountry(teasession._nLanguage), 15)));
				table.add(row8);
				Row row10 = new Row(new Cell(new Text("Phone Number:"), true));
				row10.add(new Cell(new TextField("phone", profile2.getTelephone(teasession._nLanguage), 15)));
				table.add(row10);
				Row row11 = new Row(new Cell(new Text("E-Mail Address:"), true));
				row11.add(new Cell(new TextField("email", profile2.getEmail(), 30)));
				table.add(row11);
				form1.add(table);
				form1.add(new HiddenField("ret_addr", "http://" + request.getServerName() + "/servlet/OfferAccess1"));
				form1.add(new HiddenField("passback", "Shipping"));
				form1.add(new HiddenField("Shipping", i));
				form1.add(new HiddenField("passback", "Node"));
				form1.add(new HiddenField("Node", teasession._nNode));
				form1.add(new HiddenField("passback", "Currency"));
				form1.add(new HiddenField("Currency", j));
				form1.add(new HiddenField("passback", "Price"));
				form1.add(new HiddenField("Price", bigdecimal));
				form1.add(new HiddenField("lookup", "first_name"));
				form1.add(new HiddenField("lookup", "last_name"));
				form1.add(new HiddenField("lookup", "address"));
				form1.add(new HiddenField("lookup", "city"));
				form1.add(new HiddenField("lookup", "state"));
				form1.add(new HiddenField("lookup", "zip"));
				form1.add(new HiddenField("lookup", "country"));
				form1.add(new HiddenField("lookup", "phone"));
				form1.add(new HiddenField("lookup", "email"));
				form1.add(new Button(r.getString(teasession._nLanguage, "Continue")));
				PrintWriter printwriter = response.getWriter();
				printwriter.print(form1);
				printwriter.close();
			} else
			{
				Node node1 = Node.find(teasession._nNode);
				RV rv1 = node1.getCreator();
				Profile.find(rv1._strR);
				Profile profile1 = Profile.find(teasession._rv._strR);
				Form form = new Form("foPay", "POST", "OfferAccess1");
				form.setOnSubmit("return(submitEmail(this.email,'" + r.getString(teasession._nLanguage, "InvalidEmail") + "')" + "&&submitText(this.first_name,'" + r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.last_name,'" + r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitText(this.address,'" + r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.city,'" + r.getString(teasession._nLanguage, "InvalidCity")
						+ "')" + "&&submitText(this.state,'" + r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.zip,'" + r.getString(teasession._nLanguage, "InvalidZip") + "')" + "&&submitText(this.country,'" + r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.phone,'" + r.getString(teasession._nLanguage, "InvalidTelephone") + "')" + ");");
				form.add(new HiddenField("Node", teasession._nNode));
				form.add(new HiddenField("Currency", j));
				form.add(new HiddenField("Price", bigdecimal));
				form.add(new HiddenField("Shipping", i));
				Object obj = new Table(r.getString(teasession._nLanguage, "BillingAddress"));
				Row row = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Customer") + ":"), true));
				row.add(new Cell(new Text(teasession._rv.toString())));
				((HtmlElement) (obj)).add(row);
				Row row2 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
				row2.add(new Cell(new TextField("bEmail", profile1.getEmail(), 40, 40)));
				((HtmlElement) (obj)).add(row2);
				Row row3 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "FirstName") + ":"), true));
				Cell cell1 = new Cell(new TextField("bFirstName", profile1.getFirstName(teasession._nLanguage), 20, 20));
				cell1.add(new Text(r.getString(teasession._nLanguage, "LastName") + ":"));
				cell1.add(new TextField("bLastName", profile1.getLastName(teasession._nLanguage), 20, 20));
				row3.add(cell1);
				((HtmlElement) (obj)).add(row3);
				Row row6 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Organization") + ":"), true));
				row6.add(new Cell(new TextField("bOrganization", profile1.getOrganization(teasession._nLanguage), 40, 40)));
				((HtmlElement) (obj)).add(row6);
				Row row7 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Address") + ":"), true));
				row7.add(new Cell(new TextArea("bAddress", profile1.getAddress(teasession._nLanguage), 2, 40)));
				((HtmlElement) (obj)).add(row7);
				Row row9 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "City") + ":"), true));
				Cell cell3 = new Cell(new TextField("bCity", profile1.getCity(teasession._nLanguage), 20, 20));
				cell3.add(new Text(r.getString(teasession._nLanguage, "State") + ":"));
				cell3.add(new TextField("bState", profile1.getState(teasession._nLanguage), 20, 20));
				row9.add(cell3);
				((HtmlElement) (obj)).add(row9);
				Row row12 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Zip") + ":"), true));
				Cell cell4 = new Cell(new TextField("bZip", profile1.getZip(teasession._nLanguage), 20, 20));
				cell4.add(new Text(r.getString(teasession._nLanguage, "Country") + ":"));
				cell4.add(new TextField("bCountry", profile1.getCountry(teasession._nLanguage)));
				row12.add(cell4);
				((HtmlElement) (obj)).add(row12);
				Row row13 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Telephone") + ":"), true));
				Cell cell5 = new Cell(new TextField("bTelephone", profile1.getTelephone(teasession._nLanguage), 20, 20));
				cell5.add(new Text(r.getString(teasession._nLanguage, "Fax") + ":"));
				cell5.add(new TextField("bFax", profile1.getFax(teasession._nLanguage), 20, 20));
				row13.add(cell5);
				((HtmlElement) (obj)).add(row13);
				form.add(((HtmlElement) (obj)));
				form.add(new Button(r.getString(teasession._nLanguage, "Continue")));
				PrintWriter out = response.getWriter();
				out.print(form);
				out.close();
			}
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	private static Resource r = new Resource("tea/ui/node/access/OfferAccess0");

}
