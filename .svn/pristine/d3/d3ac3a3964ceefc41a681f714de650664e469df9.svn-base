// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-24 11:32:09
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   CGroups.java

package tea.ui.member.contact;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.CGroup;
import tea.html.*;
import tea.htmlx.MessageUI;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class CGroups extends TeaServlet
{
    public CGroups()
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
            if(!teasession._rv.isSupport())
            {
                response.sendError(403);
                return;
            }
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/message/CGroups.jsp" + qs);
            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + super.r.getString(teasession._nLanguage, "CGroups"));
                        text.setId("PathDiv");
                        List list = new List();
                        ListItem listitem;
                        for(Enumeration enumeration = CGroup.find(teasession._rv._strR); enumeration.hasMoreElements(); list.add(listitem))
                        {
                            String s = (String)enumeration.nextElement();
                            CGroup cgroup = CGroup.find(teasession._rv._strR, s);
                            listitem = new ListItem(new Anchor("Contacts?CGroup=" + s, "_blank", new Text(cgroup.getName(teasession._nLanguage))));
                            listitem.add(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditCGroup?CGroup=" + s + "', '_self');"));
                            if(cgroup.isLayerExisted(teasession._nLanguage))
                                listitem.add(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('DeleteCGroup?CGroup=" + s + "', '_self');}"));
                        }

                        ListItem listitem1;
                        for(Enumeration enumeration1 = CGroup.findCGroupLayerx(teasession._rv._strR); enumeration1.hasMoreElements(); list.add(listitem1))
                        {
                            String s1 = (String)enumeration1.nextElement();
                            String s2 = CGroup.getMember(s1);
                            CGroup cgroup1 = CGroup.find(s2, s1);
                            listitem1 = new ListItem(new Anchor("Contacts?CGroup=" + s1, "_blank", new Text(cgroup1.getName(teasession._nLanguage))));
                        }

                        Cell cell = new Cell();
                        cell.add(text);
                        cell.add(list);
                        cell.add(new Text("<br>"));
                        cell.add(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditCGroup', '_self');"));
                        cell.add(new Text("<br>"));
                        tea.html.Table table = MessageUI.getTable(cell, super.r, teasession, request);
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(table);
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
        super.r.add("tea/ui/member/contact/CGroups").add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/email/EmailBoxs");
    }
}
