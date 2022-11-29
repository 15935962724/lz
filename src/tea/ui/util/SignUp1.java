// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2003-6-8 9:38:17
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   SignUp1.java

package tea.ui.util;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Profile;
import tea.html.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
public class SignUp1 extends TeaServlet
{
    public SignUp1()
    {
    }
    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            PrintWriter printwriter = response.getWriter();
            printwriter.print(super.r.getString(teasession._nLanguage, "InfSignUp"));
            Form form = new Form("foSignUp", "POST", "SignUp2");
            form.setOnSubmit("return(submitIdentifier(this.MemberId,'" + super.r.getString(teasession._nLanguage, "InvalidMemberId") + "')" + "&&submitIdentifier(this.Password,'" + super.r.getString(teasession._nLanguage, "InvalidPassword") + "')" + "&&submitEqual(this.Confirm,this.Password,'" + super.r.getString(teasession._nLanguage, "InvalidConfirm") + "')" + "&&submitText(this.FirstName,'" + super.r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.LastName, '" + super.r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitEmail(this.Email,'" + super.r.getString(teasession._nLanguage, "InvalidEmail") + "')" + ");");
            form.add(new HiddenField("NextUrl", request.getParameter("NextUrl")));
            Table table = new Table();
            Text text = new Text("*");
            text.setFGColor("RED");
            Row row = new Row(new Cell(new Text(text + super.r.getString(teasession._nLanguage, "MemberId") + ":"), true));
            Cell cell = new Cell(new TextField("MemberId", "", 20, 20));
            row.add(cell);
            row.add(new Cell(new Text(text + super.r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
            row.add(new Cell(new TextField("Email", "", 40, 40)));
            table.add(row);
            Row row1 = new Row(new Cell(new Text(text + super.r.getString(teasession._nLanguage, "Password") + ":"), true));
            row1.add(new Cell(new PasswordField("Password", "", 20, 20)));
            row1.add(new Cell(new Text(text + super.r.getString(teasession._nLanguage, "ConfirmPassword") + ":"), true));
            row1.add(new Cell(new PasswordField("Confirm", "", 20, 20)));
            table.add(row1);
            Row row2 = new Row(new Cell(new Text(text + super.r.getString(teasession._nLanguage, "FirstName") + ":"), true));
            row2.add(new Cell(new TextField("FirstName", "", 20, 20)));
            row2.add(new Cell(new Text(text + super.r.getString(teasession._nLanguage, "LastName") + ":"), true));
            row2.add(new Cell(new TextField("LastName", "", 20, 20)));
            table.add(row2);
            Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Organization") + ":"), true));
            row3.add(new Cell(new TextField("Organization", "", 40, 40), 3));
           // table.add(row3);
            Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Address") + ":"), true));
            row4.add(new Cell(new TextArea("Address", "", 2, 60), 3));
            table.add(row4);
            Row row5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "City") + ":"), true));
            row5.add(new Cell(new TextField("City", "", 20, 20)));
            row5.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "State") + ":"), true));
            row5.add(new Cell(new TextField("State", "", 20, 20)));
           // table.add(row5);
            Row row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Zip") + ":"), true));
            row6.add(new Cell(new TextField("Zip", "", 20, 20)));
            row6.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Country") + ":"), true));
            row6.add(new Cell(new TextField("Country", "", 20, 20)));
          //  table.add(row6);
            Row row7 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Telephone") + ":"), true));
            row7.add(new Cell(new TextField("Telephone", "", 20, 20)));
            row7.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "Fax") + ":"), true));
            row7.add(new Cell(new TextField("Fax", "", 20, 20)));
            table.add(row7);
            Row row8 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Age") + ":"), true));
            DropDown dropdown = new DropDown("Age");
            for(int i = 0; i < Profile.AGE.length; i++)
                dropdown.addOption(i, Profile.AGE[i]);
            row8.add(new Cell(dropdown));
            row8.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "WebPage") + ":"), true));
            row8.add(new Cell(new TextField("WebPage", "", 40, 255)));
           // table.add(row8);
            form.add(table);
            form.add(new CheckBox("AddressTPublic", false));
            form.add(new Text(super.r.getString(teasession._nLanguage, "AddressTPublic")));
            form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
            printwriter.print(form);
            printwriter.print(new Script("document.foSignUp.MemberId.focus();"));
            printwriter.close();
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
        super.r.add("tea/ui/util/SignUp1");
    }
}
