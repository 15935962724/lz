// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-24 9:47:58
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   ManageMessageFolders.java

package tea.ui.member.messagefolder;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.MessageFolder;
import tea.html.*;
import tea.htmlx.MessageUI;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ManageMessageFolders extends TeaServlet
{

    public ManageMessageFolders()
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
            response.sendRedirect("/jsp/message/ManageMessageFolders.jsp" + qs);
            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + super.r.getString(teasession._nLanguage, "ManageFolders"));
                        text.setId("PathDiv");
                        List list = new List();
                        ListItem listitem;
                        for(Enumeration enumeration = MessageFolder.find(teasession._rv._strR); enumeration.hasMoreElements(); list.add(listitem))
                        {
                            String s = (String)enumeration.nextElement();
                            MessageFolder messagefolder = MessageFolder.find(teasession._rv._strR, s);
                            listitem = new ListItem(new Anchor("MessageFolderContents?MessageFolder=" + s, "_self", new Text(messagefolder.getName(teasession._nLanguage))));
                            listitem.add(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditMessageFolder?MessageFolder=" + s + "', '_self');"));
                            if(messagefolder.isLayerExisted(teasession._nLanguage))
                                listitem.add(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('DeleteMessageFolder?MessageFolder=" + s + "', '_self');}"));
                            if(MessageFolder.getType(s) != 0)
                            {
                                listitem.add(new Button(1, "CB", "CBInviteSubscription", super.r.getString(teasession._nLanguage, "CBInviteSubscription"), "window.open('InviteMessage?MessageFolder=" + s + "', '_blank');"));
                                listitem.add(new Button(1, "CB", "CBMessageFolderSubscribers", super.r.getString(teasession._nLanguage, "CBMessageFolderSubscribers"), "window.open('MessageFolderSubscribers?MessageFolder=" + s + "', '_blank');"));
                            }
                        }

                        for(Enumeration enumeration1 = MessageFolder.findMessageFolderLayerx(teasession._rv._strR); enumeration1.hasMoreElements();)
                        {
                            String s1 = (String)enumeration1.nextElement();
                            String s2 = MessageFolder.getMember(s1);
                            MessageFolder messagefolder1 = MessageFolder.find(s2, s1);
                            if(MessageFolder.getType(s1) != 0)
                            {
                                ListItem listitem1 = new ListItem(new Anchor("MessageFolderContents?MessageFolder=" + s1, "_self", new Text(messagefolder1.getName(teasession._nLanguage))));
                                listitem1.add(new Button(1, "CB", "CBInviteSubscription", super.r.getString(teasession._nLanguage, "CBInviteSubscription"), "window.open('InviteMessage?MessageFolder=" + s1 + "', '_blank');"));
                                if((MessageFolder.getOptions(s1) & 1) != 0)
                                    listitem1.add(new Button(1, "CB", "CBMessageFolderSubscribers", super.r.getString(teasession._nLanguage, "CBMessageFolderSubscribers"), "window.open('MessageFolderSubscribers?MessageFolder=" + s1 + "', '_blank');"));
                                list.add(listitem1);
                            }
                        }

                        Cell cell = new Cell();
                        cell.add(text);
                        cell.add(list);
                        cell.add(new Text("<br>"));
                        cell.add(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditMessageFolder', '_self');"));
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
        super.r.add("tea/ui/member/contact/CGroups").add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/messagefolder/ManageMessageFolders");
    }
}
