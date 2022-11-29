// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2003-6-9 15:15:15
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   Organizers.java

package tea.ui.member.community;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.site.*;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Manager extends TeaServlet
{

    public Manager()
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
            if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s) && !teasession._rv.isManager(s))
            {
                response.sendError(403);
                return;
            }

            String s1 = request.getParameter("Pos");

            StringBuilder sb = new StringBuilder("?");
            if(s != null)
            {
                sb.append("Community=" + s);
                if(s1 != null)
                    sb.append("&Pos=" + s1);
            } else
            if(s1 != null)
                sb.append("Pos=" + s1);
            response.sendRedirect("/jsp/community/Manager.jsp" + sb.toString());
            /*
                        int i = s1 == null ? 0 : Integer.parseInt(s1);
                        int j = Organizer.count(s);
                        Form form = new Form("foDelete", "GET", "DeleteGrant");
                        form.add(new HiddenField("Community", s));
                        Table table = new Table();
                        table.setCaption(j + " " + super.r.getString(teasession._nLanguage, "InPower"));
                        if(j != 0)
                        {
                            boolean flag = true;
                            Row row;
                            for(Enumeration enumeration = GrantAccess.find(s, i, 25); enumeration.hasMoreElements(); table.add(row))
                            {
                                String s2 = (String)enumeration.nextElement();
                                row = new Row(new Cell(new CheckBox(s2, false)));
                                row.add(new Cell(getRvDetail(s2, teasession._nLanguage,request.getContextPath())));
                                row.add(new HiddenField("Organizers", s2));
                                row.setId(flag ? "OddRow" : "EvenRow");
                                flag = !flag;
                            }

                        }
                        form.add(table);
                        PrintWriter printwriter = response.getWriter();
                          printwriter.print(form);


                        printwriter.print(new FPNL(teasession._nLanguage, "Manager?Community=" + s + "&Pos=", i, j));
                        printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('NewAccess?Community=" + s + "', '_self');"));
                        if(j != 0)
                        {
                            printwriter.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                            printwriter.print(new Button(1, "CB", "CBDeleteAll", super.r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllGrant?Community=" + s + "', '_self');}"));
                        }

                        Table table1 = new Table();
                        table1.setCaption(j + " " + super.r.getString(teasession._nLanguage, "NoInPower"));
                        {
                            boolean flag = true;
                            Row row1;
                            for(Enumeration enumeration = GrantAccess.find(s, i, 25,false); enumeration.hasMoreElements(); table1.add(row1))
                            {
                                String s2 = (String)enumeration.nextElement();
                                row1 = new Row(new Cell(getRvDetail(s2, teasession._nLanguage,request.getContextPath())));
                                row1.add(new HiddenField("Organizers", s2));
                                row1.setId(flag ? "OddRow" : "EvenRow");
                                flag = !flag;
                            }

                        }
                        printwriter.print(table1);

                        printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();
             */
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/community/Communities").add("tea/ui/member/community/OrganizingCommunities").add("tea/ui/member/community/Organizers");
    }
}
