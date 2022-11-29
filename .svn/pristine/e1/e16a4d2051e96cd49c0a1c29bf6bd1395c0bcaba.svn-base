// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-21 15:14:37
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   Requests.java

package tea.ui.member.request;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.ProfileRequest;
import tea.entity.node.*;
import tea.entity.site.JoinRequest;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Requests extends TeaServlet
{

    public Requests()
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
            response.sendRedirect("/jsp/request/Requests.jsp");
            // Text text = new Text(hrefGlance(teasession._rv) + ">" + super.r.getString(teasession._nLanguage, "Requests"));
            // text.setId("PathDiv");
            // List list = new List();
            // if(teasession._rv.isSupport())
            // list.add(new ListItem(new Anchor("ProfileRequests", ProfileRequest.countRequests(teasession._rv._strR) + " " + super.r.getString(teasession._nLanguage, "ProfileRequests"))));
            // list.add(new ListItem(new Anchor("JoinRequestCommunities", JoinRequest.countRequestCommunities(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "JoinRequestCommunities"))));
            // list.add(new ListItem(new Anchor("AdRequestNodes", Aded.countRequestNodes(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "AdRequestNodes"))));
            // list.add(new ListItem(new Anchor("AccessRequestNodes", AccessRequest.countNodes(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "AccessRequestNodes"))));
            // list.add(new ListItem(new Anchor("NodeRequestNodes", Node.countRequestNodes(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "NodeRequestNodes"))));
            // PrintWriter printwriter = response.getWriter();
            // printwriter.print(text);
            // printwriter.print(list);
            // printwriter.print(new Languages(teasession._nLanguage, request));
            // printwriter.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/request/Requests");
    }
}
