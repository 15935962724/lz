// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-20 9:21:40
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   JoinRequests.java

package tea.ui.member.request;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.site.JoinRequest;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class JoinRequests extends TeaServlet
{

    public JoinRequests()
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
            String s = request.getParameter("Community");
            if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
            {
                response.sendError(403);
                return;
            }

            String s1 = request.getParameter("Pos");

            if(s != null)
                response.sendRedirect("/jsp/request/JoinRequests.jsp?Community=" + s);
            if(s1 != null)
                response.sendRedirect("/jsp/request/JoinRequests.jsp?Pos=" + s1);

            // Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Requests", super.r.getString(teasession._nLanguage, "Requests")) + ">" + new Anchor("JoinRequestCommunities", super.r.getString(teasession._nLanguage, "JoinRequestCommunities")) + ">" + super.r.getString(teasession._nLanguage, "JoinRequests"));
            // text.setId("PathDiv");
            // int i = s1 != null ? Integer.parseInt(s1) : 0;
            // Form form = new Form("foGrant", "POST", "GrantJoinRequests");
            // int j = JoinRequest.countRequests(s);
            // form.add(new Text(j + " " + super.r.getString(teasession._nLanguage, "JoinRequests")));
            // if(j != 0)
            // {
            // form.add(new HiddenField("Community", s));
            // form.add(new HiddenField("Pos", Integer.toString(i)));
            // Table table = new Table();
            // Row row;
            // for(Enumeration enumeration = JoinRequest.findRequests(s, i, 25); enumeration.hasMoreElements(); table.add(row))
            // {
            // RV rv = (RV)enumeration.nextElement();
            // form.add(new HiddenField("JoinRequests", rv.toString()));
            // row = new Row(new Cell(new CheckBox(rv.toString(), true)));
            // row.add(new Cell(getRvDetail(rv, teasession._nLanguage,request.getContextPath())));
            // }
            //
            // form.add(table);
            // form.add(new GrantDeny(teasession._nLanguage));
            // }
            // PrintWriter printwriter = response.getWriter();
            // printwriter.print(text);
            // printwriter.print(form);
            // printwriter.print(new FPNL(teasession._nLanguage, "JoinRequests?Community=" + s + "&Pos=", i, j));
            // printwriter.print(new Languages(teasession._nLanguage, request));
            //            printwriter.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/request/Requests").add("tea/ui/member/request/JoinRequests");
    }
}
