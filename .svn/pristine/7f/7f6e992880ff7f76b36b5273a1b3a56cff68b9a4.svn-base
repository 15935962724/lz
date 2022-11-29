package tea.ui.member.messagefolder;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class MessageFolderContents extends TeaServlet
{

    public MessageFolderContents()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" +teasession._nNode);
                return;
            }
            if(!teasession._rv.isSupport())
            {
                response.sendError(403);
                return;
            }
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/message/MessageFolderContents.jsp" + qs);

            /*
                        String s = request.getParameter("MessageFolder");
                        String s1 = MessageFolder.getMember(s);
                        int i = MessageFolder.getType(s);
                        boolean flag = s1.equals(teasession._rv._strR);
                        byte byte0 = 25;
                        if(flag)
                        {
                            MessageFolder messagefolder = MessageFolder.find(teasession._rv._strR, s);
                            String s2 = messagefolder.getName(teasession._nLanguage);
                            String s4 = request.getParameter("Pos");
                            int j = s4 != null ? Integer.parseInt(s4) : 0;
                            int l = MessageFolderContent.count(teasession._rv._strR, s);
                            Form form = new Form("foDelete", "GET", "DeleteMessageFolderContents");
                            form.add(new HiddenField("Operation", ""));
                            form.add(new HiddenField("MessageFolder0", s));
                            form.add(new HiddenField("MessageFolder", s));
                            Table table = new Table();
                            table.setId("MessageBodyInnerDiv");
                            table.setCellPadding(0);
                            table.setCaption(hrefGlance(teasession._rv) + ">" + new Anchor("ManageMessageFolders", super.r.getString(teasession._nLanguage, "ManageFolders")) + ">" + new Anchor("MessageFolderContents?MessageFolder=" + s, s2) + " &nbsp; " + l + " " + super.r.getString(teasession._nLanguage, "Messages"));
                            if(l != 0)
                            {
                                table.setTitle("&nbsp;\n" + super.r.getString(teasession._nLanguage, "Sender") + "\n" + super.r.getString(teasession._nLanguage, "Subject") + "\n" + super.r.getString(teasession._nLanguage, "Time") + "\n");
                                boolean flag1 = true;
                                Row row;
                                for(Enumeration enumeration = MessageFolderContent.find(teasession._rv._strR, s, j, byte0); enumeration.hasMoreElements(); table.add(row))
                                {
                                    int j1 = ((Integer)enumeration.nextElement()).intValue();
                                    Message message = Message.find(j1);
                                    RV rv = message.getFrom();
                                    String s6 = message.getFEmail();
                                    java.util.Date date = message.getTime();
                                    int l1 = message.getType();
                                    int j2 = message.getHint();
                                    message.getOptions();
                                    String s8 = message.getSubject(teasession._nLanguage);
                                    boolean flag4 = false;
                                    flag4 = MessageRead.isRead(j1, teasession._rv);
                                    row = new Row(new Cell(new CheckBox(Integer.toString(j1), false)));
                                    Cell cell2 = new Cell();
                                    Cell cell4 = new Cell();
                                    String s10 = "";
                                    if(s6 != null && s6.length() != 0)
                                        s10 = (new Anchor("NewMessage?Receiver=" + s6, "_blank", new Text(s6))).toString();
                                    else
                                        s10 = hrefGlanceWithName(rv, teasession._nLanguage,request.getContextPath()).toString();
                                    cell2.add(new Text("<font>" + s10 + "</font>"));
                                    cell4.add(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm aaa")).format(date) + "</font>"));
                                    cell2.setId(flag4 ? "MessageRead" : "MessageUnread");
                                    cell4.setId(flag4 ? "MessageRead" : "MessageUnread");
                                    row.add(cell2);
                                    Cell cell6 = new Cell(new Anchor("Message?MessageFolder=" + s + "&Message=" + j1, new Text(new HintImg(request.getContextPath(), j2) + " <font>" + s8 + "</font>")));
                                    cell6.setId(flag4 ? "MessageRead" : "MessageUnread");
                                    row.add(cell6);
                                    row.add(cell4);
                                    row.add(new HiddenField("Messages", Integer.toString(j1)));
                                    row.setId(flag1 ? "OddRow" : "EvenRow");
                                    flag1 = !flag1;
                                }

                            }
                            form.add(table);
                            form.add(new Text("<br><br><br>"));
                            form.add(new FPNL(teasession._nLanguage, "MessageFolderContents?MessageFolder=" + s + "&Pos=", j, l));
                            form.add(new Text("<br>"));
                            form.add(new Button(1, "CB", "CBNewMessage", super.r.getString(teasession._nLanguage, "CBNewMessage"), "window.open('NewMessage', '_blank');"));
                            if(l > 0)
                            {
                                form.add(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                                form.add(new Button(1, "CB", "CBDeleteAll", super.r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllMessageFolderContents?MessageFolder=" + s + "', '_self');}"));
                                form.add(MessageUI.getMessageFolderSelection(super.r, teasession));
                                form.add(new CheckBox("DeleteOriginal", false));
                                form.add(new Text(super.r.getString(teasession._nLanguage, "DeleteOriginal")));
                            }
                            Cell cell = new Cell();
                            cell.add(form);
                            Table table2 = MessageUI.getTable(cell, super.r, teasession, request);
                            PrintWriter printwriter = response.getWriter();
                            printwriter.print(table2);
                            printwriter.close();
                        } else
                        if(i != 0)
                        {
                            MessageFolder messagefolder1 = MessageFolder.find(s1, s);
                            String s3 = messagefolder1.getName(teasession._nLanguage);
                            String s5 = request.getParameter("Pos");
                            int k = s5 != null ? Integer.parseInt(s5) : 0;
                            int i1 = MessageFolderContent.count(s1, s);
                            Form form1 = new Form("foDelete", "GET", "DeleteMessageFolderContents");
                            form1.add(new HiddenField("Operation", ""));
                            form1.add(new HiddenField("MessageFolder0", s));
                            form1.add(new HiddenField("MessageFolder", s));
                            Table table1 = new Table();
                            table1.setId("MessageBodyInnerDiv");
                            table1.setCellPadding(0);
                            table1.setCaption(hrefGlance(new RV(s1, s1),request.getContextPath()) + ">" + new Anchor("ManageMessageFolders", super.r.getString(teasession._nLanguage, "ManageFolders")) + ">" + new Anchor("MessageFolderContents?MessageFolder=" + s, s3) + " &nbsp; " + i1 + " " + super.r.getString(teasession._nLanguage, "Messages"));
                            if(i1 != 0)
                            {
                                table1.setTitle("&nbsp;\n" + super.r.getString(teasession._nLanguage, "Sender") + "\n" + super.r.getString(teasession._nLanguage, "Subject") + "\n" + super.r.getString(teasession._nLanguage, "Time") + "\n");
                                boolean flag2 = true;
                                Row row1;
                                for(Enumeration enumeration1 = MessageFolderContent.find(s1, s, k, byte0); enumeration1.hasMoreElements(); table1.add(row1))
                                {
                                    int k1 = ((Integer)enumeration1.nextElement()).intValue();
                                    Message message1 = Message.find(k1);
                                    RV rv1 = message1.getFrom();
                                    String s7 = message1.getFEmail();
                                    java.util.Date date1 = message1.getTime();
                                    int i2 = message1.getType();
                                    int k2 = message1.getHint();
                                    message1.getOptions();
                                    String s9 = message1.getSubject(teasession._nLanguage);
                                    boolean flag5 = false;
                                    flag5 = MessageRead.isRead(k1, teasession._rv);
                                    row1 = new Row(new Cell(new CheckBox(Integer.toString(k1), false)));
                                    Cell cell3 = new Cell();
                                    Cell cell5 = new Cell();
                                    String s11 = "";
                                    if(s7 != null && s7.length() != 0)
                                        s11 = (new Anchor("NewMessage?Receiver=" + s7, "_blank", new Text(s7))).toString();
                                    else
                                        s11 = hrefGlanceWithName(rv1, teasession._nLanguage,request.getContextPath()).toString();
                                    cell3.add(new Text("<font>" + s11 + "</font>"));
                                    cell5.add(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm aaa")).format(date1) + "</font>"));
                                    cell3.setId(flag5 ? "MessageRead" : "MessageUnread");
                                    cell5.setId(flag5 ? "MessageRead" : "MessageUnread");
                                    row1.add(cell3);
                                    Cell cell7 = new Cell(new Anchor("Message?MessageFolder=" + s + "&Message=" + k1, new Text(new HintImg(request.getContextPath(), k2) + " <font>" + s9 + "</font>")));
                                    cell7.setId(flag5 ? "MessageRead" : "MessageUnread");
                                    row1.add(cell7);
                                    row1.add(cell5);
                                    row1.add(new HiddenField("Messages", Integer.toString(k1)));
                                    row1.setId(flag2 ? "OddRow" : "EvenRow");
                                    flag2 = !flag2;
                                }

                            }
                            form1.add(table1);
                            form1.add(new Text("<br><br><br>"));
                            boolean flag3 = MessageFolder.isUseAsMyOwnMessageFolder(teasession._rv._strR, s);
                            Text text = new Text(super.r.getString(teasession._nLanguage, "UseAsMyOwnMessageFolder") + ": " + new Radio("UseAsMyOwnMessageFolder", 1, flag3) + super.r.getString(teasession._nLanguage, "Yes") + " " + new Radio("UseAsMyOwnMessageFolder", 0, !flag3) + super.r.getString(teasession._nLanguage, "No") + " &nbsp;" + new Anchor("javascript:foDelete.submit();", super.r.getString(teasession._nLanguage, "Submit")));
                            form1.add(text);
                            form1.add(new Text("<br><br>"));
                            form1.add(new FPNL(teasession._nLanguage, "MessageFolderContents?MessageFolder=" + s + "&Pos=", k, i1));
                            form1.add(new Text("<br>"));
                            form1.add(new Button(1, "CB", "CBNewMessage", super.r.getString(teasession._nLanguage, "CBNewMessage"), "window.open('NewMessage', '_blank');"));
                            if(i1 != 0)
                            {
                                if(i == 3)
                                {
                                    form1.add(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                                    form1.add(new Button(1, "CB", "CBDeleteAll", super.r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllMessageFolderContents?MessageFolder=" + s + "', '_self');}"));
                                }
                                form1.add(MessageUI.getMessageFolderSelection(super.r, teasession));
                                if(i == 3)
                                {
                                    form1.add(new CheckBox("DeleteOriginal", false));
                                    form1.add(new Text(super.r.getString(teasession._nLanguage, "DeleteOriginal")));
                                }
                            }
                            Cell cell1 = new Cell();
                            cell1.add(form1);
                            Table table3 = MessageUI.getTable(cell1, super.r, teasession, request);
                            PrintWriter printwriter1 = beginOut(response, teasession);
                            printwriter1.print(table3);
                            endOut(printwriter1, teasession);
                        } else
                        {
                            outText(response, teasession._nLanguage, super.r.getString(teasession._nLanguage, "Unviewable"));
                            return;
                        }*/
        } catch(Exception ex)
        {
            ex.printStackTrace();
			response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/contact/CGroups").add("tea/ui/member/contact/Contacts").add("tea/ui/member/messagefolder/ManageMessageFolders");
    }
}
