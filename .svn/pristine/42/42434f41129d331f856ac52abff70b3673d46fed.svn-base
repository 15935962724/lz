package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Shipping;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditShipping1 extends TeaServlet
{

    public EditShipping1()
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
            int i = Integer.parseInt(request.getParameter("Shipping"));
            Shipping shipping = Shipping.find(i);
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/profile/EditShipping1.jsp" + qs);
                /*
                                int j = shipping.getCurrency();
                                Form form = new Form("foEdit", "POST", "EditShipping1");
                                form.add(new HiddenField("Shipping", Integer.toString(i)));
                                Table table = new Table();
                                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "PayMethod") + ":"), true));
                                DropDown dropdown = new DropDown("PayMethod", shipping.getPayMethod());
                                for (int l = 0; l < Shipping.PAYMETHOD[j].length; l++)
                                {
                                    dropdown.addOption(l, super.r.getString(teasession._nLanguage, Shipping.PAYMETHOD[j][l]));
                                }

                                row.add(new Cell(dropdown));
                                table.add(row);
                                Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Parameters") + ":"), true));
                                row1.add(new Cell(new PasswordField("Parameters", shipping.getParameters(), 20, 255)));
                                table.add(row1);
                                form.add(table);
                                form.add(new Go(teasession._nLanguage, 1));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(form);
                                printwriter.print(new Script("document.foEdit.Parameters.focus();"));
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();
                 */
            } else
            {
                int k = Integer.parseInt(request.getParameter("PayMethod"));
                String s = request.getParameter("Parameters");
                shipping.set(k, s);
                if (request.getParameter("GoBack") != null)
                {
                    response.sendRedirect("EditShipping?Shipping=" + i);
                } else
                {
                    response.sendRedirect("Shippings");
                }
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
        super.r.add("tea/ui/member/profile/EditShipping").add("tea/ui/member/profile/EditShipping1");
    }
}
