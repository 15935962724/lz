package tea.ui.member.message;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.StringTokenizer;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.html.*;
import tea.htmlx.HintImg;
import tea.htmlx.MessageUI;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class MessageServlet extends TeaServlet
{

    public MessageServlet()
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
            response.sendRedirect("/jsp/message/Message.jsp" + qs);

            /*
                         String s = request.getParameter("Folder");
                         if(s == null)
                s = "";
                         String s1 = request.getParameter("MessageFolder");
                         if(s1 == null)
                s1 = "";
                         int i = Integer.parseInt(request.getParameter("Message"));
                         Message message = Message.find(i);
                         RV rv = message.getFrom();
                         boolean flag = teasession._rv._strR.equals(rv._strR);
                         String s2 = message.getFEmail();
                         java.util.Date date = message.getTime();
                         if(date == null)
                         {
                response.sendError(403);
                return;
                         }
                         int j = message.getType();
                         int k = message.getHint();
                         message.getOptions();
                         String s3 = message.getSubject(teasession._nLanguage);
                         String s4 = message.getContent(teasession._nLanguage);
                         String s5 = Text.toHTML(s4);
                         boolean flag1 = message.getPictureFlag();
                         boolean flag2 = message.getVoiceFlag();
                         boolean flag3 = message.getFileFlag();
                         MessageRead.read(i, teasession._rv);
                         Table table = new Table();
                         String s6 = null;
                         if(s2 != null && s2.length() != 0)
                s6 = (new Anchor("NewMessage?Receiver=" + s2, "_blank", new Text(s2))).toString();
                         else
                s6 = hrefGlanceWithName(rv, teasession._nLanguage,request.getContextPath()).toString();
                         Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Sender") + ":"), true));
                         row.add(new Cell(s6));
                         table.add(row);
                         String s7;
                         if(s.equals("Draft"))
                s7 = super.r.getString(teasession._nLanguage, "CreateTime");
                         else
                s7 = super.r.getString(teasession._nLanguage, "SendTime");
                         Row row1 = new Row(new Cell(new Text(s7 + ":"), true));
                         row1.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm aaa")).format(date) + "</font>")));
                         table.add(row1);
                         String s8 = message.getMessageTo();
                         if(s8.length() != 0)
                         {
                Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Receiver") + ":"), true));
                StringBuilder stringbuffer = new StringBuilder();
                String s12 = "";
                int l = 0;
                for(StringTokenizer stringtokenizer = new StringTokenizer(s8, ", "); stringtokenizer.hasMoreTokens();)
                {
                    String s21 = stringtokenizer.nextToken();
                    String s13;
                    if(s21.indexOf("@") != -1)
                        s13 = (new Anchor("NewMessage?Receiver=" + s21, "_blank", new Text(s21))).toString();
                    else
                        s13 = hrefGlanceWithName(new RV(s21), teasession._nLanguage).toString();
                    if(l == 0)
                        stringbuffer.append(s13);
                    else
                        stringbuffer.append(", " + s13);
                    l++;
                }

                row2.add(new Cell("<font>" + stringbuffer.toString() + "</font>"));
                table.add(row2);
                         }
                         String s9 = message.getMessageCc();
                         if(s9 != null && s9.length() != 0)
                         {
                Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "CcMembers") + ":"), true));
                StringBuilder stringbuffer1 = new StringBuilder();
                String s15 = "";
                int i1 = 0;
                for(StringTokenizer stringtokenizer1 = new StringTokenizer(s9, ", "); stringtokenizer1.hasMoreTokens();)
                {
                    String s24 = stringtokenizer1.nextToken();
                    String s16;
                    if(s24.indexOf("@") != -1)
                        s16 = (new Anchor("NewMessage?Receiver=" + s24, "_blank", new Text(s24))).toString();
                    else
                        s16 = hrefGlanceWithName(new RV(s24), teasession._nLanguage).toString();
                    if(i1 == 0)
                        stringbuffer1.append(s16);
                    else
                        stringbuffer1.append(", " + s16);
                    i1++;
                }

                row3.add(new Cell("<font>" + stringbuffer1.toString() + "</font>"));
                table.add(row3);
                         }
                         if(s.equals("Sent") || rv.toString().equals(teasession._rv.toString()))
                         {
                String s10 = message.getMessageBcc();
                if(s10 != null && s10.length() != 0)
                {
                    Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Bcc") + ":"), true));
                    StringBuilder stringbuffer2 = new StringBuilder();
                    String s17 = "";
                    int j1 = 0;
                    for(StringTokenizer stringtokenizer2 = new StringTokenizer(s10, ", "); stringtokenizer2.hasMoreTokens();)
                    {
                        String s25 = stringtokenizer2.nextToken();
                        String s18;
                        if(s25.indexOf("@") != -1)
                            s18 = (new Anchor("NewMessage?Receiver=" + s25, "_blank", new Text(s25))).toString();
                        else
                            s18 = hrefGlanceWithName(new RV(s25), teasession._nLanguage).toString();
                        if(j1 == 0)
                            stringbuffer2.append(s18);
                        else
                            stringbuffer2.append(", " + s18);
                        j1++;
                    }

                    row4.add(new Cell("<font>" + stringbuffer2.toString() + "</font>"));
                    table.add(row4);
                }
                         }
                         String s11 = message.getMessageCGroup();
                         if(s11.length() != 0)
                         {
                Row row5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "CGroup") + ":"), true));
                StringBuilder stringbuffer3 = new StringBuilder();
                String s19 = "";
                int k1 = 0;
                for(StringTokenizer stringtokenizer3 = new StringTokenizer(s11, ", "); stringtokenizer3.hasMoreTokens();)
                {
                    String s26 = stringtokenizer3.nextToken();
                    String s27 = CGroup.getMember(s26);
                    CGroup cgroup = CGroup.find(s27, s26);
                    String s29 = cgroup.getName(teasession._nLanguage);
                    Anchor anchor1 = new Anchor("Contacts?CGroup=" + s26, "_blank", new Text(super.r.getString(teasession._nLanguage, s29)));
                    String s20 = anchor1.toString();
                    if(k1 == 0)
                        stringbuffer3.append(s20);
                    else
                        stringbuffer3.append(", " + s20);
                    k1++;
                }

                row5.add(new Cell(stringbuffer3.toString()));
                table.add(row5);
                         }
                         String s14 = message.getMessageCommunity();
                         if(s14.length() != 0)
                         {
                Row row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Community") + ":"), true));
                StringBuilder stringbuffer4 = new StringBuilder();
                String s22 = "";
                int l1 = 0;
                for(StringTokenizer stringtokenizer4 = new StringTokenizer(s14, ", "); stringtokenizer4.hasMoreTokens();)
                {
                    String s28 = stringtokenizer4.nextToken();
                    Anchor anchor = new Anchor("Subscribers?Community=" + s28, "_blank", new Text(super.r.getString(teasession._nLanguage, s28)));
                    String s23 = anchor.toString();
                    if(l1 == 0)
                        stringbuffer4.append(s23);
                    else
                        stringbuffer4.append(", " + s23);
                    l1++;
                }

                row6.add(new Cell(stringbuffer4.toString()));
                table.add(row6);
                         }
                         boolean flag4 = false;
                         RV rv1 = message.findSingleRVReceiver(rv);
                         if(rv1 != null)
                flag4 = MessageRead.isRead(i, rv1);
                         boolean flag5 = message.isMultipleReceiver(rv);
                         boolean flag6 = message.getMessageCGroup().length() != 0;
                         boolean flag7 = message.getMessageCommunity().length() != 0;
                         if(flag4 && s1.length() == 0 && !s.equals("Draft"))
                         {
                Row row7 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "ReadTime") + ":"), true));
                Cell cell = new Cell();
                java.util.Date date1 = MessageRead.getTime(i, rv1);
                cell.add(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh.mm aaa")).format(date1) + "</font> "));
                row7.add(cell);
                table.add(row7);
                         }
                         if((flag5 || flag6 || flag7 || s1.length() != 0) && !s.equals("Draft"))
                         {
                Row row8 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "ReadTime") + ":"), true));
                Cell cell1 = new Cell();
                cell1.add(new Anchor("MessageReaders?Message=" + i, "_blank", new Text(super.r.getString(teasession._nLanguage, "MessageReaders"))));
                row8.add(cell1);
                table.add(row8);
                         }
                         Row row9 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Subject") + ":"), true));
                         row9.add(new Cell(new Text(new HintImg(teasession._nLanguage, k) + " <font>" + s3 + "</font>")));
                         table.add(row9);
                         Cell cell2 = new Cell();
                         if(s.length() != 0)
                         {
                Text text = new Text(hrefGlance(teasession._rv) + "> " + new Anchor("MessageFolders", super.r.getString(teasession._nLanguage, "MessageFolders")) + "> " + new Anchor("Messages?Folder=" + s, new Text(super.r.getString(teasession._nLanguage, s))));
                text.setId("PathDiv");
                cell2.add(text);
                         } else
                         if(s1.length() != 0)
                         {
                String s30 = MessageFolder.getMember(s1);
                MessageFolder messagefolder = MessageFolder.find(s30, s1);
                String s32 = messagefolder.getName(teasession._nLanguage);
                Text text1 = new Text(hrefGlance(teasession._rv) + "> " + new Anchor("ManageMessageFolders", super.r.getString(teasession._nLanguage, "ManageFolders")) + "> " + new Anchor("MessageFolderContents?MessageFolder=" + s1, new Text(super.r.getString(teasession._nLanguage, s32))));
                text1.setId("PathDiv");
                cell2.add(text1);
                         }
                         cell2.add(table);
                         cell2.add(new Text("<HR SIZE=1>"));
                         cell2.add(new Text("<br>"));
                         cell2.add(new Text("<font>" + s5 + "</font>"));
                         if(flag1)
                cell2.add(new Image("MessagePicture?Message=" + i));
                         if(flag2)
                cell2.add(new Button(1, "CB", "CBPlay", super.r.getString(teasession._nLanguage, "CBPlay"), "window.open('MessageVoice?Message=" + i + "', '_self');"));
                         if(flag3)
                         {
                cell2.add(new Anchor("MessageFile?Message=" + i, "<br>" + message.getFileName(teasession._nLanguage)));
                cell2.add(new Button(1, "CB", "CBDownload", super.r.getString(teasession._nLanguage, "CBDownload"), "window.open('MessageFile?Message=" + i + "', '_self');"));
                         }
                         if(message.countAttachment() != 0)
                         {
                int i2;
                for(Enumeration enumeration = message.findAttachment(); enumeration.hasMoreElements(); cell2.add(new Anchor("MessageFile?Message=" + i + "&Part=" + i2, "<br>" + message.getAttachmentFileName(i2, teasession._nLanguage))))
                    i2 = ((Integer)enumeration.nextElement()).intValue();

                         }
                         cell2.add(new Text("<br><br><br>"));
                         if(s.length() != 0)
                         {
                Form form = new Form("foDelete", "GET", "DeleteMessages");
                form.add(new HiddenField("Operation", ""));
                form.add(new HiddenField("MessageFolder", ""));
                form.add(new HiddenField("Folder", s));
                form.add(new HiddenField("Messages", "" + i));
                form.add(new HiddenField("" + i, "ON"));
                if(s.equals("Inbox") || s.equals("Sent") || s.equals("Trash"))
                {
                    form.add(new Button(1, "CB", "CBNewMessage", super.r.getString(teasession._nLanguage, "CBNewMessage"), "window.open('NewMessage', '_blank');"));
                    form.add(new Button(1, "CB", "CBForwardMessage", super.r.getString(teasession._nLanguage, "CBForwardMessage"), "window.open('ForwardMessage?Message=" + i + "', '_blank');"));
                    if(s.equals("Inbox") || s.equals("Trash") && !flag)
                    {
                        form.add(new Button(1, "CB", "CBReplyMessage", super.r.getString(teasession._nLanguage, "CBReplyMessage"), "window.open('ReplyMessage?Message=" + i + "', '_blank');"));
                        if(s2.length() == 0)
                            form.add(new Button(1, "CB", "CBAddToContact", super.r.getString(teasession._nLanguage, "CBAddToContact"), "window.open('AddToContact?Member=" + rv + "', '_blank');"));
                    }
                } else
                {
                    form.add(new Button(1, "CB", "CBSend", super.r.getString(teasession._nLanguage, "CBSend"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmSend") + "')){window.open('DeleteMessages?Operation=Send&Folder=" + s + "&Messages=" + i + "&" + i + "=ON" + "', '_self');}"));
                    form.add(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditMessage?Message=" + i + "', '_self');"));
                }
                if(!s.equals("Trash"))
                    form.add(new Button(1, "CB", "CBTrash", super.r.getString(teasession._nLanguage, "CBTrash"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmTrash") + "')){window.open('DeleteMessages?Operation=Trash&Folder=" + s + "&Messages=" + i + "&" + i + "=ON" + "', '_self');}"));
                form.add(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteMessages?Folder=" + s + "&Messages=" + i + "&" + i + "=ON" + "', '_self');}"));
                if(s.equals("Inbox") || s.equals("Trash") && !flag)
                    form.add(new Button(1, "CB", "CBBlock", super.r.getString(teasession._nLanguage, "CBBlock"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmBlock") + "')){window.open('DeleteMessages?Operation=Block&Folder=" + s + "&Messages=" + i + "&" + i + "=ON" + "', '_self');}"));
                form.add(MessageUI.getMessageFolderSelection(super.r, teasession));
                cell2.add(form);
                int j2 = message.findPrev(s, teasession._rv);
                int k2 = message.findNext(s, teasession._rv);
                if(j2 != 0 || k2 != 0)
                {
                    cell2.add(new Break(2));
                    cell2.add(new Text("<HR SIZE=1>"));
                    if(k2 != 0)
                    {
                        cell2.add(new Text(super.r.getString(teasession._nLanguage, "Previous") + ": "));
                        Message message1 = Message.find(k2);
                        cell2.add(new Anchor("Message?Folder=" + s + "&Message=" + k2, message1.getSubject(teasession._nLanguage)));
                        cell2.add(new Break());
                    }
                    if(j2 != 0)
                    {
                        cell2.add(new Text(super.r.getString(teasession._nLanguage, "Next") + ": "));
                        Message message2 = Message.find(j2);
                        cell2.add(new Anchor("Message?Folder=" + s + "&Message=" + j2, message2.getSubject(teasession._nLanguage)));
                        cell2.add(new Break());
                    }
                    cell2.add(new Break());
                }
                         }
                         if(s1.length() != 0)
                         {
                Form form1 = new Form("foDelete", "GET", "DeleteMessageFolderContents");
                form1.add(new HiddenField("Operation", ""));
                form1.add(new HiddenField("MessageFolder0", s1));
                form1.add(new HiddenField("MessageFolder", s1));
                form1.add(new HiddenField("Messages", "" + i));
                form1.add(new HiddenField("" + i, "ON"));
                form1.add(new Button(1, "CB", "CBNewMessage", super.r.getString(teasession._nLanguage, "CBNewMessage"), "window.open('NewMessage', '_blank');"));
                form1.add(new Button(1, "CB", "CBReplyMessage", super.r.getString(teasession._nLanguage, "CBReplyMessage"), "window.open('ReplyMessage?Message=" + i + "', '_blank');"));
                form1.add(new Button(1, "CB", "CBForwardMessage", super.r.getString(teasession._nLanguage, "CBForwardMessage"), "window.open('ForwardMessage?Message=" + i + "', '_blank');"));
                if(s2.length() == 0)
                    form1.add(new Button(1, "CB", "CBAddToContact", super.r.getString(teasession._nLanguage, "CBAddToContact"), "window.open('AddToContact?Member=" + rv + "', '_blank');"));
                String s31 = MessageFolder.getMember(s1);
                int l2 = MessageFolder.getType(s1);
                boolean flag8 = s31.equals(teasession._rv._strR) && teasession._rv.isSupport();
                if(flag8 || l2 == 3)
                    form1.add(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteMessageFolderContents?MessageFolder=" + s1 + "&Messages=" + i + "&" + i + "=ON" + "', '_self');}"));
                if(flag8 || l2 != 0)
                    form1.add(MessageUI.getMessageFolderSelection(super.r, teasession));
                if(flag8 || l2 == 3)
                {
                    form1.add(new CheckBox("DeleteOriginal", false));
                    form1.add(new Text(super.r.getString(teasession._nLanguage, "DeleteOriginal")));
                }
                cell2.add(form1);
                int i3 = MessageFolderContent.findPrev(s1, i);
                int j3 = MessageFolderContent.findNext(s1, i);
                if(i3 != 0 || j3 != 0)
                {
                    cell2.add(new Break(2));
                    cell2.add(new Text("<HR SIZE=1>"));
                    if(i3 != 0)
                    {
                        cell2.add(new Text(super.r.getString(teasession._nLanguage, "Previous") + ": "));
                        Message message3 = Message.find(i3);
                        cell2.add(new Anchor("Message?MessageFolder=" + s1 + "&Message=" + i3, message3.getSubject(teasession._nLanguage)));
                        cell2.add(new Break());
                    }
                    if(j3 != 0)
                    {
                        cell2.add(new Text(super.r.getString(teasession._nLanguage, "Next") + ": "));
                        Message message4 = Message.find(j3);
                        cell2.add(new Anchor("Message?MessageFolder=" + s1 + "&Message=" + j3, message4.getSubject(teasession._nLanguage)));
                        cell2.add(new Break());
                    }
                    cell2.add(new Break());
                }
                         }
                         Table table1 = MessageUI.getTable(cell2, super.r, teasession, request);
                         PrintWriter printwriter = response.getWriter();
                         printwriter.print(table1);
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
        // super.r.add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/message/MessageServlet").add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/contact/CGroups").add("tea/ui/member/messagefolder/ManageMessageFolders");
    }
}
