// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-23 17:35:33
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   EmailBoxs.java

package tea.ui.member.email;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.EmailBox;
import tea.html.*;
import tea.htmlx.MessageUI;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EmailBoxs extends TeaServlet
{

    public EmailBoxs()
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
            response.sendRedirect("/jsp/message/EmailBoxs.jsp" + qs);
            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + super.r.getString(teasession._nLanguage, "EmailBoxs"));
                        text.setId("PathDiv");
                        List list = new List();
                        ListItem listitem;
                        for(Enumeration enumeration = EmailBox.find(teasession._rv._strR); enumeration.hasMoreElements(); list.add(listitem))
                        {
                            String s = (String)enumeration.nextElement();
                            EmailBox.find(teasession._rv._strR, s);
                            byte byte0 = -1;
                            listitem = new ListItem(new Anchor("Emails?EmailBox=" + s, new Text((byte0 != -1 ? Integer.toString(byte0) : "") + " " + s)));
                            listitem.add(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditEmailBox?EmailBox=" + s + "', '_self');"));
                            listitem.add(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteEmailBox?EmailBox=" + s + "', '_self');}"));
                        }

                        Cell cell = new Cell();
                        cell.add(text);
                        cell.add(list);
                        cell.add(new Text("<br>"));
                        cell.add(new Button(1, "CB", "CBNewEmailBox", super.r.getString(teasession._nLanguage, "CBNewEmailBox"), "window.open('EditEmailBox', '_self');"));
                        cell.add(new Text("<br>"));
                        tea.html.Table table = MessageUI.getTable(cell, super.r, teasession, request);
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(table);
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
        super.r.add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/contact/CGroups");
    }
}
