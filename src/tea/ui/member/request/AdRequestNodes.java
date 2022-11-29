package tea.ui.member.request;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Aded;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class AdRequestNodes extends TeaServlet
{

    public AdRequestNodes()
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
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/request/AdRequestNodes.jsp" + qs);

            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Requests", super.r.getString(teasession._nLanguage, "Requests")) + ">" + super.r.getString(teasession._nLanguage, "AdRequestNodes"));
                        text.setId("PathDiv");
                        String s = request.getParameter("Pos");
                        int i = s != null ? Integer.parseInt(s) : 0;
                        int j = Aded.countRequestNodes(teasession._rv);
                        Table table = new Table();
                        table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "AdRequestNodes"));
                        if(j != 0)
                        {
                            Row row;
                            for(Enumeration enumeration = Aded.findRequestNodes(teasession._rv, i, 25); enumeration.hasMoreElements(); table.add(row))
                            {
                                int k = ((Integer)enumeration.nextElement()).intValue();
                                Node node = Node.find(k);
                                row = new Row(new Cell(node.getAncestor(teasession._nLanguage)));
                                row.add(new Cell(new Anchor("AdRequests?node=" + k, Integer.toString(Aded.countRequests(k)))));
                            }

                        }
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(table);
                        printwriter.print(new FPNL(teasession._nLanguage, "AdRequestNodes?Pos=", i, j));
                        printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();*/
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/request/Requests").add("tea/ui/member/request/AdRequestNodes");
    }
}
