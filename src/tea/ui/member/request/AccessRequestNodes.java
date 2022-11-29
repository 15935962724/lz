package tea.ui.member.request;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.AccessRequest;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class AccessRequestNodes extends TeaServlet
{

    public AccessRequestNodes()
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
            response.sendRedirect("/jsp/request/AccessRequestNodes.jsp" + qs);
            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Requests", super.r.getString(teasession._nLanguage, "Requests")) + ">" + super.r.getString(teasession._nLanguage, "AccessRequestNodes"));
                        text.setId("PathDiv");
                        String s = request.getParameter("Pos");
                        int i = s != null ? Integer.parseInt(s) : 0;
                        int j = AccessRequest.countNodes(teasession._rv);
                        Table table = new Table();
                        table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "AccessRequestNodes"));
                        if(j != 0)
                        {
                            Row row;
                            for(Enumeration enumeration = AccessRequest.findNodes(teasession._rv, i, 25); enumeration.hasMoreElements(); table.add(row))
                            {
                                int k = ((Integer)enumeration.nextElement()).intValue();
                                Node node = Node.find(k);
                                row = new Row(new Cell(node.getAncestor(teasession._nLanguage)));
                                row.add(new Cell(new Anchor("AccessRequests?node=" + k, Integer.toString(AccessRequest.count(k)))));
                            }

                        }
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(table);
                        printwriter.print(new FPNL(teasession._nLanguage, "AccessRequestNodes?Pos=", i, j));
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
        super.r.add("tea/ui/member/request/Requests").add("tea/ui/member/request/AccessRequestNodes");
    }
}
