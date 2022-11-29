// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-22 18:17:07
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   ListingNodes.java

package tea.ui.member.node;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Listing;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ListingNodes extends TeaServlet
{

    public ListingNodes()
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
            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Nodes",super.r.getString(teasession._nLanguage,"Nodes")) + ">" + super.r.getString(teasession._nLanguage,"ListingNodes"));
            text.setId("PathDiv");
            String s = request.getParameter("Pos");
            if(s != null)
                response.sendRedirect("/jsp/node/ListingNodes.jsp?Pos=" + s);
            else
                response.sendRedirect("/jsp/node/ListingNodes.jsp");

        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/node/Nodes").add("tea/ui/member/node/ListingNodes");
    }
}
