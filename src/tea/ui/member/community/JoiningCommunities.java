// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-23 8:52:10
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   JoiningCommunities.java

package tea.ui.member.community;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.site.JoinRequest;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class JoiningCommunities extends TeaServlet
{

    public JoiningCommunities()
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
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/community/JoiningCommunities.jsp" + qs);

            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Communities",super.r.getString(teasession._nLanguage,"Communities")) + ">" + super.r.getString(teasession._nLanguage,"JoiningCommunities"));
            text.setId("PathDiv");
            Table table = new Table();
            int i = JoinRequest.countJoining(teasession._rv);
            table.setCaption(i + " " + super.r.getString(teasession._nLanguage,"JoiningCommunities"));
            String s;
            for(Enumeration enumeration = JoinRequest.findJoining(teasession._rv);enumeration.hasMoreElements();table.add(new Row(new Cell(new Anchor("Node?Community=" + s,new Text(s))))))
                s = (String) enumeration.nextElement();

            PrintWriter printwriter = response.getWriter();
            printwriter.print(text);
            printwriter.print(table);
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
        super.r.add("tea/ui/member/community/Communities").add("tea/ui/member/community/JoiningCommunities");
    }
}
