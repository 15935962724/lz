package tea.ui.member.buypoint;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.BuyPointTitle;
import tea.html.*;
import tea.htmlx.Languages;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditBuyPointTitle extends TeaServlet
{

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/buypoint/EditBuyPointTitle").add("tea/ui/member/buypoint/BuyPoints");
    }

    public EditBuyPointTitle()
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
            String s = request.getParameter("Operation");
            if (s == null)
            {
                s = "";
            }
            if (request.getMethod().equals("GET") || s.equals("Edit") || s.equals("Delete"))
            {
                BuyPointTitle buypointtitle = null;
                boolean flag = false;
                int j = 0;
                try
                {
                    j = Integer.parseInt(request.getParameter("BuyPointTitle"));
                } catch (Exception _ex)
                {}
                if (j == 0)
                {
                    flag = true;
                } else
                {
                    buypointtitle = BuyPointTitle.find(j);
                    if (s.equals("Delete"))
                    {
                        if (!teasession._rv._strR.equals(buypointtitle.getMember()))
                        {
                            response.sendError(403);
                            return;
                        }
                        buypointtitle.delete();
                        flag = true;
                        response.sendRedirect("EditBuyPointTitle");
                    }
                }
                Form form = new Form("foEdit", "POST", "EditBuyPointTitle");
                form.add(new HiddenField("Operation", ""));
                form.setOnSubmit("return(submitText(this.Title, '" + r.getString(teasession._nLanguage, "InvalidTitle") + "')" + ");");
                Table table = new Table();
                table.setCellPadding(3);
                Row row = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Title") + ":"), true));
                Cell cell = new Cell();
                cell.add(new TextField("Title", flag ? "" : buypointtitle.getTitle(), 40, 255));
                row.add(cell);
                table.add(row);
                Row row1 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "AccountTitle") + ":"), true));
                Cell cell1 = new Cell();
                cell1.add(new TextField("AccountTitle", flag ? "" : buypointtitle.getAccountTitle(), 40, 255));
                row1.add(cell1);
                table.add(row1);
                Row row2 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "PasswordTitle") + ":"), true));
                Cell cell2 = new Cell();
                cell2.add(new TextField("PasswordTitle", flag ? "" : buypointtitle.getPasswordTitle(), 40, 255));
                row2.add(cell2);
                table.add(row2);
                Row row3 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "OtherIDTitle") + ":"), true));
                Cell cell3 = new Cell();
                cell3.add(new TextField("OtherIDTitle", flag ? "" : buypointtitle.getOtherIDTitle(), 40, 255));
                row3.add(cell3);
                table.add(row3);
                form.add(table);
                form.add(new Button(r.getString(teasession._nLanguage, "Submit")));
                DropDown dropdown = new DropDown("BuyPointTitle", "");
                dropdown.addOption(0, "------------");
                int k;
                String s5;
                for (Enumeration enumeration = BuyPointTitle.find(teasession._rv._strR); enumeration.hasMoreElements(); dropdown.addOption(k, s5))
                {
                    k = ((Integer) enumeration.nextElement()).intValue();
                    BuyPointTitle buypointtitle2 = BuyPointTitle.find(k);
                    s5 = buypointtitle2.getTitle();
                }

                if (s.equals("Edit"))
                {
                    dropdown.setCurrentValue(Integer.toString(j));
                }
                form.add(new Break());
                form.add(new Break());
                form.add(new Text(dropdown.toString()));
                form.add(new Anchor("javascript:document.foEdit.Operation.value='Edit';foEdit.submit();", r.getCommandImg(teasession._nLanguage, "Edit")));
                form.add(new Anchor("javascript:document.foEdit.Operation.value='Delete';foEdit.submit();", r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "'));"));
                PrintWriter printwriter = response.getWriter(); // beginOut(response, teasession);
                printwriter.print(form);
                printwriter.print(new Languages(teasession._nLanguage, request));
                printwriter.close(); //printwriter.close();
                return;
            }
            int i = 0;
            try
            {
                i = Integer.parseInt(teasession.getParameter("BuyPointTitle"));
            } catch (Exception _ex)
            {}
            String s1 = teasession.getParameter("Title");
            String s2 = teasession.getParameter("AccountTitle");
            String s3 = teasession.getParameter("PasswordTitle");
            String s4 = teasession.getParameter("OtherIDTitle");
            if (i == 0)
            {
                BuyPointTitle.create(teasession._rv._strR, teasession._nLanguage, s1, s2, s3, s4);
            } else
            {
                BuyPointTitle buypointtitle1 = BuyPointTitle.find(i);
                buypointtitle1.set(s1, s2, s3, s4);
            }
            response.sendRedirect("EditBuyPointTitle");
            return;
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }
}
