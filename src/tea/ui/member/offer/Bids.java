// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-24 15:03:39
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   Bids.java

package tea.ui.member.offer;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Bid;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Bids extends TeaServlet
{

    public Bids()
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
String qs=request.getQueryString();
qs=qs==null?"":"?"+qs;
response.sendRedirect("/jsp/offer/Bids.jsp"+qs);

            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Offers", super.r.getString(teasession._nLanguage, "Offers")) + ">" + super.r.getString(teasession._nLanguage, "Bargains"));
            text.setId("PathDiv");
            String s = request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;
            int j = Bid.countNodes(teasession._rv);
            Table table = new Table(j + super.r.getString(teasession._nLanguage, "Bargains"));
            Row row;
            for(Enumeration enumeration = Bid.findNodes(teasession._rv, i, 25); enumeration.hasMoreElements(); table.add(row))
            {
                int k = ((Integer)enumeration.nextElement()).intValue();
                Node node = Node.find(k);
                row = new Row(new Cell(node.getAncestor(teasession._nLanguage)));
            }

            PrintWriter printwriter = response.getWriter();
            printwriter.print(text);
            printwriter.print(table);
            printwriter.print(new FPNL(teasession._nLanguage, "Bids?Pos=", i, j));
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
        super.r.add("tea/ui/member/offer/Offers").add("tea/ui/member/offer/Bids");
    }
}
