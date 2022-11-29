package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.BuyInstruction;
import tea.html.*;
import tea.htmlx.CurrencySelection;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditBuyInstruction extends TeaServlet
{

    public EditBuyInstruction()
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
            String s = request.getParameter("BuyInstruction");
            boolean flag = s == null;
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/profile/EditBuyInstruction.jsp" + qs);

                int i = 0;
                String s1 = "";
                if (!flag)
                {
                    BuyInstruction buyinstruction = BuyInstruction.find(Integer.parseInt(s));
                    i = buyinstruction.getCurrency();
                    s1 = buyinstruction.getText(teasession._nLanguage);
                }
                Form form = new Form("foEdit", "POST", "EditBuyInstruction");
                if (!flag)
                {
                    form.add(new HiddenField("BuyInstruction", s));
                }
                Table table = new Table();
                table.add(new CurrencySelection(teasession._nLanguage, i, !flag));
                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Text") + ":"), true));
                row.add(new Cell(new TextArea("Text", s1, 8, 60)));
                table.add(row);
                form.add(table);
                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                PrintWriter printwriter = response.getWriter();
                printwriter.print(form);
                printwriter.print(new Script("document.foEdit.Text.focus();"));
                printwriter.print(new Languages(teasession._nLanguage, request));
                printwriter.close();
            } else
            {
                int j = Integer.parseInt(request.getParameter("Currency"));
                String s2 = request.getParameter("Text");
                if (flag)
                {
                    BuyInstruction.create(teasession._rv._strR, j, teasession._nLanguage, s2);
                } else
                {
                    BuyInstruction buyinstruction1 = BuyInstruction.find(Integer.parseInt(s));
                    buyinstruction1.set(teasession._nLanguage, s2);
                }
                response.sendRedirect("BuyInstructions");
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
        super.r.add("tea/ui/member/profile/EditBuyInstruction");
    }
}
