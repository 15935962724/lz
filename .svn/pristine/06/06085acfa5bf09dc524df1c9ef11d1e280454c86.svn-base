package tea.ui.member.node;

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

public class AdedNodes extends TeaServlet
{

    public AdedNodes()
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

            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Nodes", super.r.getString(teasession._nLanguage, "Nodes")) + ">" + super.r.getString(teasession._nLanguage, "AdedNodes"));
            text.setId("PathDiv");
            String s = request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;
            if (s != null)
            {
                response.sendRedirect("/jsp/node/AdedNodes.jsp?Pos=" + s);
            } else
            {
                response.sendRedirect("/jsp/node/AdedNodes.jsp");
            }
            /*
                         Table table = new Table();
                         int j = Aded.countNodes(teasession._rv);
                         table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "AdedNodes"));
                         if(j != 0)
                         {
                             Row row;
                             for(Enumeration enumeration = Aded.findNodes(teasession._rv, i, 25); enumeration.hasMoreElements(); table.add(row))
                             {
                int k = ((Integer)enumeration.nextElement()).intValue();
                row = new Row(new Cell(Node.find(k).getAncestor(teasession._nLanguage)));
                row.add(new Cell(new Anchor("Adeds?node=" + k, super.r.getCommandImg(teasession._nLanguage, "Detail"))));
                             }

                         }
                         PrintWriter printwriter = response.getWriter();
                         printwriter.print(text);
                         printwriter.print(table);
                         printwriter.print(new FPNL(teasession._nLanguage, "AdedNodes?Pos=", i, j));
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
        super.r.add("tea/ui/member/node/Nodes").add("tea/ui/member/node/AdedNodes");
    }
}
