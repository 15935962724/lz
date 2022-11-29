<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/message/Messages");
String s = request.getParameter("Folder");
            if(s == null)
                s = "";
            String s1 = request.getParameter("MessageFolder");
            if(s1 == null)
                s1 = "";
            int i = Integer.parseInt(request.getParameter("Message"));
            tea.entity.member.Message message = tea.entity.member.Message.find(i);
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
            String s6 = null;

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Message2")%></h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <%          if(s.length() != 0)
            {%>
          <tr>
            <td ID=PathDiv><%=ts.hrefGlance(teasession._rv)%> ><A href="/servlet/ManageMessageFolders"><%=r.getString(teasession._nLanguage, "MessageFolders")%></A> ><A href="/servlet/Messages?Folder=<%=s%>"><%=r.getString(teasession._nLanguage, s)%></A>
              <%          } else
            if(s1.length() != 0)
            {
                String s30 = MessageFolder.getMember(s1);
                MessageFolder messagefolder = MessageFolder.find(s30, s1);
                String s32 = messagefolder.getName(teasession._nLanguage);%>
          <tr>
            <td ID=PathDiv><%=ts.hrefGlance(teasession._rv)%> ><A href="/servlet/ManageMessageFolders"><%=r.getString(teasession._nLanguage, "MessageFolders")%></A> ><A href="/servlet/MessageFolderContents?MessageFolder=<%=s1%>"><%=r.getString(teasession._nLanguage, s32)%></A>
              <%          }%>
              <%
            if(s2 != null && s2.length() != 0)
                s6 = (new Anchor("/servlet/NewMessage?receiver=" + s2, "_blank", new Text(s2))).toString();
            else
                s6 = ts.hrefGlanceWithName(rv, teasession._nLanguage).toString();
%>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "Sender")%>:<%=s6%>
              <%          String s7;
            if(s.equals("Draft"))
                s7 = r.getString(teasession._nLanguage, "CreateTime");
            else
                s7 = r.getString(teasession._nLanguage, "SendTime");
%>
          <tr>
            <td><%=s7%>:</td>
            <td><%=(new SimpleDateFormat("yyyy.MM.dd hh:mm aaa")).format(date)%></td>
          </tr>
          <%
            String s8 = message.getMessageTo();
            if(s8.length() != 0)
            {%>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "Receiver")%>:</td>
            <%              StringBuffer stringbuffer = new StringBuffer();
                String s12 = "";
                int l = 0;
                for(StringTokenizer stringtokenizer = new StringTokenizer(s8, ", "); stringtokenizer.hasMoreTokens();)
                {
                    String s21 = stringtokenizer.nextToken();
                    String s13;
                    if(s21.indexOf("@") != -1)
                        s13 = "<td><A HREF=\"/servlet/NewMessage?receiver="+s21+"\" TARGET=\"_blank\">"+s21+"</A>";
                    else
                        s13 = ts.hrefGlanceWithName(new RV(s21), teasession._nLanguage).toString();
                    if(l == 0)
                        stringbuffer.append(s13);
                    else
                        stringbuffer.append(", " + s13);
                    l++;
                }%>
            <td><%=stringbuffer.toString()%>
              <%            }
            String s9 = message.getMessageCc();
            if(s9 != null && s9.length() != 0)
            {%>
          <tr>
            <td ID=MessageTopDiv COLSPAN=2><%=r.getString(teasession._nLanguage, "CcMembers")%>:</td>
          </tr>
          <%              StringBuffer stringbuffer1 = new StringBuffer();
                String s15 = "";
                int i1 = 0;
                for(StringTokenizer stringtokenizer1 = new StringTokenizer(s9, ", "); stringtokenizer1.hasMoreTokens();)
                {
                    String s24 = stringtokenizer1.nextToken();
                    String s16;
                    if(s24.indexOf("@") != -1)
                        s16 = "<td><A HREF=\"/servlet/NewMessage?Receiver="+s24+"\" TARGET=\"_blank\">"+s24+"</A>";
                    else
                        s16 = ts.hrefGlanceWithName(new RV(s24), teasession._nLanguage).toString();
                    if(i1 == 0)
                        stringbuffer1.append(s16);
                    else
                        stringbuffer1.append(", " + s16);
                    i1++;
                }
%>
          <%=new Cell(stringbuffer1.toString())%>
          <%           }
            if(s.equals("Sent") || rv.toString().equals(teasession._rv.toString()))
            {
                String s10 = message.getMessageBcc();
                if(s10 != null && s10.length() != 0)
                {%>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "Bcc")%>:</td>
            <td><%                 StringBuffer stringbuffer2 = new StringBuffer();
                    String s17 = "";
                    int j1 = 0;
                    for(StringTokenizer stringtokenizer2 = new StringTokenizer(s10, ", "); stringtokenizer2.hasMoreTokens();)
                    {
                        String s25 = stringtokenizer2.nextToken();
                        String s18;
                        if(s25.indexOf("@") != -1)
                            s18 = "<td><A HREF=\"/servlet/NewMessage?Receiver="+s25+"\" TARGET=\"_blank\">"+s25+"</A>";
                        else
                            s18 = ts.hrefGlanceWithName(new RV(s25), teasession._nLanguage).toString();
                        if(j1 == 0)
                            stringbuffer2.append(s18);
                        else
                            stringbuffer2.append(", " + s18);
                        j1++;
                    }%>
              <%=new Cell(stringbuffer2.toString())%>
              <%               }
            }
            String s11 = message.getMessageCGroup();
            if(s11.length() != 0)
            {%>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "CGroup")%>:</td>
            <td><%              StringBuffer stringbuffer3 = new StringBuffer();
                String s19 = "";
                int k1 = 0;
                for(StringTokenizer stringtokenizer3 = new StringTokenizer(s11, ", "); stringtokenizer3.hasMoreTokens();)
                {
                    String s26 = stringtokenizer3.nextToken();
                    String s27 = CGroup.getMember(s26);
                    CGroup cgroup = CGroup.find(s27, s26);
                    String s29 = cgroup.getName(teasession._nLanguage);
                    Anchor anchor1 = new Anchor("/servlet/Contacts?CGroup=" + s26, "_blank", new Text(r.getString(teasession._nLanguage, s29)));
                    String s20 = anchor1.toString();
                    if(k1 == 0)
                        stringbuffer3.append(s20);
                    else
                        stringbuffer3.append(", " + s20);
                    k1++;
                }
                out.print(new Cell(stringbuffer3.toString()));
            }
            String s14 = message.getMessageCommunity();
            if(s14.length() != 0)
            {%>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "Community")%>:</td>
            <td><%              StringBuffer stringbuffer4 = new StringBuffer();
                String s22 = "";
                int l1 = 0;
                for(StringTokenizer stringtokenizer4 = new StringTokenizer(s14, ", "); stringtokenizer4.hasMoreTokens();)
                {
                    String s28 = stringtokenizer4.nextToken();
                    Anchor anchor = new Anchor("/servlet/Subscribers?Community=" + s28, "_blank", new Text(r.getString(teasession._nLanguage, s28)));
                    String s23 = anchor.toString();
                    if(l1 == 0)
                        stringbuffer4.append(s23);
                    else
                        stringbuffer4.append(", " + s23);
                    l1++;
                }
                out.print(new Cell(stringbuffer4.toString()));
            }
            boolean flag4 = false;
            RV rv1 = message.findSingleRVReceiver(rv);
            if(rv1 != null)
                flag4 = MessageRead.isRead(i, rv1);
            boolean flag5 = message.isMultipleReceiver(rv);
            boolean flag6 = message.getMessageCGroup().length() != 0;
            boolean flag7 = message.getMessageCommunity().length() != 0;
            if(flag4 && s1.length() == 0 && !s.equals("Draft"))
            {		java.util.Date date1 = MessageRead.getTime(i, rv1);
%>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "ReadTime")%>:</td>
            <td><%=(new SimpleDateFormat("yyyy.MM.dd hh.mm aaa")).format(date1)%></td>
          </tr>
          <%          }
            if((flag5 || flag6 || flag7 || s1.length() != 0) && !s.equals("Draft"))
            {%>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "ReadTime")%>:</td>
            <td><A href="/servlet/MessageReaders?Message=<%=i%>" TARGET="_blank"><%=r.getString(teasession._nLanguage, "MessageReaders")%></A>
              <%          }%>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
            <td><%=new HintImg(teasession._nLanguage, k)%> <%=s3%></td>
          </tr>
        </table>
        <HR SIZE=1>
        <br/>
        <%= s5%>
        <%         if(flag1)
            {%>
        <%=(new Image("/servlet/MessagePicture?Message=" + i))%>
        <%}if(flag2)
            {%>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBPlay")%>" ID="CBDownload" CLASS="CB" onClick="window.open('/servlet/MessageVoice?Message=<%=i%>', '_self');">
        <%          }if(flag3)
            {%>
        <A href="/servlet/MessageFile?Message=<%=i%>"><br/>
        <%=message.getFileName(teasession._nLanguage)%></A>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDownload")%>" ID="CBDownload" CLASS="CB" onClick="window.open('/servlet/MessageFile?Message=<%=i%>', '_self');">
        <%          }
            if(message.countAttachment() != 0)
            {
                int i2;
                for(Enumeration enumeration = message.findAttachment(); enumeration.hasMoreElements();)
                {    i2 = ((Integer)enumeration.nextElement()).intValue();
%>
        <A href="/servlet/MessageFile?Message=<%=i%>&Part=<%=i2%>"><br/>
        <%=message.getAttachmentFileName(i2, teasession._nLanguage)%></A>
        <%              }
            }%>
        <br/>
        <br/>
        <br/>
        <%
            if(s.length() != 0)
            {%>
        <FORM name=foDelete METHOD=GET action="/servlet/DeleteMessages">
          <input type='hidden' name=Operation VALUE="">
          <input type='hidden' name=MessageFolder VALUE="">
          <input type='hidden' name=Folder VALUE="<%=s%>">
          <input type='hidden' name=Messages VALUE="<%=i%>">
          <input type='hidden' name=<%=i%> VALUE="ON">
          <%              if(s.equals("Inbox") || s.equals("Sent") || s.equals("Trash"))
                {%>
          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBNewMessage")%>" ID="CBNewMessage" CLASS="CB" onClick="window.open('/servlet/NewMessage', '_blank');">
          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBForwardMessage")%>" ID="CBForwardMessage" CLASS="CB" onClick="window.open('/servlet/ForwardMessage?Message=<%=i%>', '_blank');">
          <%                  if(s.equals("Inbox") || s.equals("Trash") && !flag)
                    {%>
          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBReplyMessage")%>" ID="CBReplyMessage" CLASS="CB" onClick="window.open('/servlet/ReplyMessage?Message=<%=i%>', '_blank');">
          <%                     if(s2.length() == 0)
                       {%>
          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBAddToContact")%>" ID="CBAddToContact" CLASS="CB" onClick="window.open('/servlet/AddToContact?Member=<%=rv%>', '_blank');">
          <%                     }
                    }
                } else
                {%>
          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBSend")%>" ID="CBSend" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmSend")%>')){window.open('/servlet/DeleteMessages?Operation=Send&Folder=<%=s%>&Messages=<%=i%>&<%=i%>=ON', '_self');}">
          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "CBEdit")%>')){window.open('/servlet/EditMessage?Message=<%=i%>', '_self');}">
          <%              }
                if(!s.equals("Trash"))
                {%>
          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBTrash")%>" ID="CBTrash" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmTrash")%>')){window.open('/servlet/DeleteMessages?Operation=Trash&Folder=<%=s%>&Messages=<%=i%>&<%=i%>=ON', '_self');}">
          <%            	}%>
          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteMessages?Folder=<%=s%>&Messages=<%=i%>&<%=i%>=ON', '_self');}">
          <%              if(s.equals("Inbox") || s.equals("Trash") && !flag)
                {%>
          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBlock")%>" ID="CBBlock" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmBlock")%>')){window.open('/servlet/DeleteMessages?Operation=Block&Folder=<%=s%>&Messages=<%=i%>&<%=i%>=ON', '_self');}">
          <%              }%>
          <%=(MessageUI.getMessageFolderSelection(r, teasession))%>
        </FORM>
        <%              int j2 = message.findPrev(s, teasession._rv);
                int k2 = message.findNext(s, teasession._rv);
                if(j2 != 0 || k2 != 0)
                {%>
        <BR CLEAR=ALL>
        <HR SIZE=1>
        <%                  if(k2 != 0)
                    {%>
        <%=r.getString(teasession._nLanguage, "Previous")%>:
        <%                      Message message1 = Message.find(k2);%>
        <A href="/servlet/Message?Folder=<%=s%>&Message=<%=k2%>"><%=message1.getSubject(teasession._nLanguage)%></A> <br/>
        <%					}
                    if(j2 != 0)
                    {%>
        <%=r.getString(teasession._nLanguage, "Next")%>:
        <%                      Message message2 = Message.find(j2);%>
        <A href="/servlet/Message?Folder=<%=s%>&Message=<%=j2%>"><%=message2.getSubject(teasession._nLanguage)%></A> <br/>
        <%        }%>
        <br/></td>
    </tr>
    <%              }
            }
            if(s1.length() != 0)
            {%>
    <FORM name=foDelete METHOD=GET action="/servlet/DeleteMessageFolderContents">

    <input type='hidden' name=Operation VALUE="">
    <input type='hidden' name=MessageFolder0 VALUE="<%=s1%>">
    <input type='hidden' name=MessageFolder VALUE="<%=s%>">
    <input type='hidden' name=Messages VALUE="<%=i%>">
    <input type='hidden' name=<%=i%> VALUE="ON">
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBNewMessage")%>" ID="CBNewMessage" CLASS="CB" onClick="window.open('/servlet/NewMessage', '_blank');">
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBReplyMessage")%>" ID="CBReplyMessage" CLASS="CB" onClick="window.open('/servlet/ReplyMessage?Message=<%=i%>', '_blank');">
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBForwardMessage")%>" ID="CBForwardMessage" CLASS="CB" onClick="window.open('/servlet/ForwardMessage?Message=<%=i%>', '_blank');">
    <%                     if(s2.length() == 0)
                       {%>
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBAddToContact")%>" ID="CBAddToContact" CLASS="CB" onClick="window.open('/servlet/AddToContact?Member=<%=rv%>', '_blank');">
    <%                     }

                String s31 = MessageFolder.getMember(s1);
                int l2 = MessageFolder.getType(s1);
                boolean flag8 = s31.equals(teasession._rv._strR) && teasession._rv.isSupport();
                if(flag8 || l2 == 3)
                {%>
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteMessageFolderContents?MessageFolder=<%=s1%>&Messages=<%=i%>&<%=i%>=ON', '_self');}">
    <%            	}if(flag8 || l2 != 0)
                {%>
    <%=MessageUI.getMessageFolderSelection(r, teasession)%>
    <%              }if(flag8 || l2 == 3)
                {%>
    <input  id="CHECKBOX" type="CHECKBOX" name=DeleteOriginal>
    <%=r.getString(teasession._nLanguage, "DeleteOriginal")%>
    <%              }
                int i3 = MessageFolderContent.findPrev(s1, i);
                int j3 = MessageFolderContent.findNext(s1, i);
                if(i3 != 0 || j3 != 0)
                {%>
    <BR CLEAR=ALL>
    <HR SIZE=1>
    <%                  if(i3 != 0)
                    {%>
    <%=r.getString(teasession._nLanguage, "Previous")%>:
    <%                      Message message3 = Message.find(i3);%>
    <A href="/servlet/Message?MessageFolder=<%=s1%>&Message=<%=i3%>"><%=message3.getSubject(teasession._nLanguage)%></A> <br/>
    <%                  }
                    if(j3 != 0)
                    {%>
    <%=r.getString(teasession._nLanguage, "Next")%>:
    <%                      Message message4 = Message.find(j3);%>
    <A href="/servlet/MessageFolder?Folder=<%=s1%>&Message=<%=j3%>"><%=message4.getSubject(teasession._nLanguage)%></A> <br/>
    <%                  }%>
    <br/>
    <%              }
            }
%>

    </td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  <%----%>
  <div id="head6"><img height="6" src="about:blank" alt="ss"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

