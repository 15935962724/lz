// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-22 16:57:33
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   TalkbackedNodes.java

package tea.ui.member.node;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Node;
import tea.entity.node.Talkback;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class TalkbackedNodes extends TeaServlet
{

    public TalkbackedNodes()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Nodes", super.r.getString(teasession._nLanguage, "Nodes")) + ">" + super.r.getString(teasession._nLanguage, "TalkbackedNodes"));
            text.setId("PathDiv");
            String s = request.getParameter("Pos");

            if(s!=null)
                response.sendRedirect("/jsp/node/TalkbackedNodes.jsp?Pos="+s);
                else
                    response.sendRedirect("/jsp/node/TalkbackedNodes.jsp");

            int i = s != null ? Integer.parseInt(s) : 0;
            int j = Talkback.countEdNodes(teasession._rv);
            Table table = new Table();
            table = new Table(j + " " + super.r.getString(teasession._nLanguage, "TalkbackedNodes"));
            Row row;
            for(Enumeration enumeration = Talkback.findEdNodes(teasession._rv, i, 25); enumeration.hasMoreElements(); table.add(row))
            {
                int k = ((Integer)enumeration.nextElement()).intValue();
                row = new Row(new Cell(Node.find(k).getAncestor(teasession._nLanguage)));
                row.add(new Cell(new Anchor("Talkbacks?node=" + k, super.r.getCommandImg(teasession._nLanguage, "Detail"))));
            }

            PrintWriter printwriter = response.getWriter();
            printwriter.print(text);
            printwriter.print(table);
            printwriter.print(new FPNL(teasession._nLanguage, "TalkbackedNodes?Pos=", i, j));
            printwriter.print(new Languages(teasession._nLanguage, request));
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
        super.r.add("tea/ui/member/node/Nodes").add("tea/ui/member/node/TalkbackedNodes");
    }
}
