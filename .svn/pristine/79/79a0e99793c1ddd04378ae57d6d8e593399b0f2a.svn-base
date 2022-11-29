package tea.ui.member.community;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Node;
import tea.entity.site.Provider;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Providers extends TeaServlet
{

    public Providers()
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
            String s = request.getParameter("Community");
            if (!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
            {
                response.sendError(403);
                return;
            }
            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Communities", super.r.getString(teasession._nLanguage, "Communities")) + ">" + new Anchor("OrganizingCommunities", super.r.getString(teasession._nLanguage, "OrganizingCommunities")) + ">" + s + ":" + super.r.getString(teasession._nLanguage, "Providers"));
            String s1 = request.getParameter("Pos");

            StringBuilder sb = new StringBuilder("?");
            if (s != null)
            {
                sb.append("Community=" + s);
                if (s1 != null)
                {
                    sb.append("&Pos=" + s1);
                }
            } else
            {
                if (s1 != null)
                {
                    sb.append("Pos=" + s1);
                }
            }
            response.sendRedirect("/jsp/community/Providers.jsp" + sb.toString());
/*
            int i = s1 == null ? 0 : Integer.parseInt(s1);
            Form form = new Form("foDelete", "GET", "DeleteProviders");
            form.add(new HiddenField("Community", s));
            int j = Provider.count(s);
            Table table = new Table();
            table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "Providers"));
            if (j != 0)
            {
                boolean flag = true;
                Row row;
                for (Enumeration enumeration = Provider.find(s, i, 25); enumeration.hasMoreElements(); table.add(row))
                {
                    String s2 = (String) enumeration.nextElement();
                    Provider provider = Provider.find(s, s2);
                    int k = provider.getProviders0();
                    int l = provider.getProviders1();
                    row = new Row(new Cell(new CheckBox(s2, false)));
                    row.add(new Cell(getRvDetail(s2, teasession._nLanguage,request.getContextPath())));
                    row.add(new HiddenField("Providers", s2));
                    Cell cell = new Cell();
                    for (int i1 = 0; i1 < Node.NODE_TYPE.length; i1++)
                    {
                        if (((i1 < 32 ? k : l) & 1 << i1 % 32) != 0)
                        {
                            cell.add(new Text(super.r.getString(teasession._nLanguage, Node.NODE_TYPE[i1]) + " "));
                        }
                    }

                    row.add(cell);
                    row.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditProvider?Community=" + s + "&Member=" + s2 + "', '_self');")));
                    row.setId(flag ? "OddRow" : "EvenRow");
                    flag = !flag;
                }

            }
            form.add(table);
            PrintWriter printwriter = response.getWriter();
            printwriter.print(text);
            printwriter.print(form);
            printwriter.print(new FPNL(teasession._nLanguage, "Providers?Community=" + s + "&Pos=", i, j));
            printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditProvider?Community=" + s + "', '_self');"));
            if (j != 0)
            {
                printwriter.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                printwriter.print(new Button(1, "CB", "CBDeleteAll", super.r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllProviders?Community=" + s + "', '_self');}"));
            }
            printwriter.print(new Languages(teasession._nLanguage, request));
            printwriter.close();
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
        super.r.add("tea/ui/member/community/Communities").add("tea/ui/member/community/OrganizingCommunities").add("tea/ui/member/community/Providers");
    }
}
