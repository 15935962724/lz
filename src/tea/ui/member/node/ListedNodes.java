// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-22 18:07:01
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   ListedNodes.java

package tea.ui.member.node;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Listed;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ListedNodes extends TeaServlet
{

    public ListedNodes()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            response.sendRedirect("/jsp/node/ListedNodes.jsp");
            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Nodes",super.r.getString(teasession._nLanguage,"Nodes")) + ">" + super.r.getString(teasession._nLanguage,"ListedNodes"));
            text.setId("PathDiv");
            String s = request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;
            int j = Listed.countNodes(teasession._rv);
            Table table = new Table();
            table = new Table(j + " " + super.r.getString(teasession._nLanguage,"ListedNodes"));
            Row row;
            for(Enumeration enumeration = Listed.findNodes(teasession._rv,i,25);enumeration.hasMoreElements();table.add(row))
            {
                int k = ((Integer) enumeration.nextElement()).intValue();
                row = new Row(new Cell(Node.find(k).getAncestor(teasession._nLanguage)));
            }

            PrintWriter printwriter = response.getWriter();
            printwriter.print(text);
            printwriter.print(table);
            printwriter.print(new FPNL(teasession._nLanguage,"ListedNodes?Pos=",i,j));
            printwriter.print(new Languages(teasession._nLanguage,request));
            printwriter.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/node/Nodes").add("tea/ui/member/node/ListedNodes");
    }
}
