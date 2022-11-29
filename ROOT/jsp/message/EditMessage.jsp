<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String s = request.getParameter("URI");//getRequestURI();
                int i = Integer.parseInt(request.getParameter("Message"));
                tea.entity.member.Message message = tea.entity.member.Message.find(i);
                int k = message.getType();
                int l = message.getOptions();
                int i1 = message.getHint();
                String s4 = message.getMessageTo();
                String s6 = message.getMessageCc();
                String s7 = message.getMessageBcc();
                String s10 = message.getSubject(teasession._nLanguage);
                String s11 = message.getContent(teasession._nLanguage);
                int l1 = message.getPictureLen();
                int j2 = message.getVoiceLen();
                int k2 = message.getFileLen();

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditMessage")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<FORM name=foEdit METHOD=POST ACTION="<%=s%>" ENCtype=multipart/form-data onSubmit="return(submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
  <input type='hidden' name=Operation VALUE="">
  <input type='hidden' name=Message VALUE="<%=i%>">
  <%
if(teasession._rv.isWebMaster())
{
%>
  <input type="CHECKBOX" name=MsgOSendToAll value=null <%=getCheck(k == 1)%>>
  <%=r.getString(teasession._nLanguage, "MsgOSendToAll")%>
  <%
}%>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "ToMembers")%>:</td>
      <td><input type="TEXT" class="edit_input"  id=To name=To VALUE="" SIZE=40></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "CcMembers")%>:</td>
      <td><input type="TEXT" class="edit_input"  id=Cc name=Cc VALUE="" SIZE=40></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Bcc")%>:</td>
      <td><input type="TEXT" class="edit_input"  id=Bcc  name=Bcc VALUE="" SIZE=40></td>
    </tr>
    <%              boolean flag2 = false;%>
    <tr >
      <td><%=r.getString(teasession._nLanguage, "CGroup")%>:</td>
      <td><%
StringBuffer stringbuffer = new StringBuffer();
java.util.Enumeration enumer=tea.entity.node.SMSGroup.findByMember(teasession._rv.toString(),node.getCommunity()) ;
while(enumer.hasMoreElements())
{
  tea.entity.node.SMSGroup smsg=tea.entity.node.SMSGroup.find(((Integer)enumer.nextElement()).intValue());
  out.print("<input  id=CHECKBOX type=CHECKBOX name=G"+smsg.getId()+" value="+smsg.getId()+">"+smsg.getName());
  stringbuffer.append(smsg.getId() + ", ");
}
if(stringbuffer.length()>0)
{
  out.print(new tea.html.HiddenField("CGroup", stringbuffer.toString()));
}

        %>
        <%--

        Table table = new Table();
Row row3 = new Row();
Cell cell = new Cell();
                StringBuffer stringbuffer = new StringBuffer();
                String s19 = message.getMessageCGroup();
                String s17;
                for(Enumeration enumeration = CGroup.find(teasession._rv._strR); enumeration.hasMoreElements(); stringbuffer.append(s17 + ", "))
                {
                    s17 = (String)enumeration.nextElement();%>
          <input  id="CHECKBOX" type="CHECKBOX" name="G<%=s17%>"  id="G<%=s17%>" value=null <%=getCheck(s19.indexOf(s17) != -1)%>>
          <%                  String s23 = CGroup.getMember(s17);
                    CGroup cgroup = CGroup.find(s23, s17);
                    String s21 = cgroup.getName(teasession._nLanguage);
%>
          <FONT CLASS="CT" onClick="window.open('/servlet/Contacts?CGroup=<%=s17%>', 'label');"><%=s21%>
          <%                 flag2 = true;
                }

                String s18;
                for(Enumeration enumeration1 = CGroup.findCGroupLayerx(teasession._rv._strR); enumeration1.hasMoreElements(); stringbuffer.append(s18 + ", "))
                {
                    s18 = (String)enumeration1.nextElement();
                    %>
                    <TD><input  id="CHECKBOX" type="CHECKBOX" name="G<%=s18%>" <%=getCheck(s19.indexOf(s18) != -1)%>/></TD>
                    <%
                    String s24 = CGroup.getMember(s18);
                    CGroup cgroup1 = CGroup.find(s24, s18);
                    String s22 = cgroup1.getName(teasession._nLanguage);
                    cell.add(new Text(s22, "CT", "window.open('/servlet/Contacts?CGroup=" + s18 + "', 'label');"));
                    flag2 = true;
                }

                if(flag2)
                {
                    cell.add(new HiddenField("CGroup", stringbuffer.toString()));
                    row3.add(cell);
                    table.add(row3);
                }
				boolean flag3 = false;
--%>
    <tr id="messagecomunity">
      <td><%=r.getString(teasession._nLanguage, "Community")%>:</td>
      <td><%
        boolean flag3 = false;
        StringBuffer stringbuffer1 = new StringBuffer();
                String s27 = message.getMessageCommunity();
                String s26;
                for(java.util.Enumeration enumeration2 = Organizer.findOrganizing(teasession._rv); enumeration2.hasMoreElements(); stringbuffer1.append(s26 + ", "))
                {
                   s26 = (String)enumeration2.nextElement();%>
        <input  id="C<%=s26%>" type="CHECKBOX"  id="C<%=s26%>"  name="C<%=s26%>" value=null <%=getCheck(s27.indexOf(s26) != -1)%>>
        <A href="/servlet/Node?Community=<%=s26%>" TARGET="_blank"><%=r.getString(teasession._nLanguage, s26)%></A>
        <%                   flag3 = true;
                }
                if(flag3)
                {%>
        <input type='hidden' id=Community name=Community VALUE="<%=stringbuffer1.toString()%>">
        <%              }
                if(Associate.count(teasession._strCommunity,teasession._rv._strR) != 0)
                {%>
    <tr >
      <td><A href="/servlet/Associates" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Positions")%>:</A> </td>
      <td><%                  for(int k3 = 0; k3 < Associate.ASSOCIATE.length; k3++)
                    {%>
        <input  id="P" type="CHECKBOX" name=P<%=k3%> id=P<%=k3%> value=null>
        <%=r.getString(teasession._nLanguage, Associate.ASSOCIATE[k3])%>
        <%                  }%>
    <tr>
      <td><A href="/servlet/Associates" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Managers")%>:</A></td>
      <td><%
         tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(teasession._rv._strR,node.getCommunity());
  String role=  aur_obj.getRole();
  if(role!=null)
  {
    java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(role,"/");
    while(tokenizer_obj.hasMoreTokens())
    {
      int id=Integer.parseInt((String)tokenizer_obj.nextElement());
      tea.entity.admin.AdminRole ar_obj=tea.entity.admin.AdminRole.find(id);
      %>
        <input  id="CHECKBOX" type="CHECKBOX" name=M<%=id%> value="<%=id%>"   >
        <%=ar_obj.getName()%>
        <%}
        }%>
      </td>
    </tr>
    <%

                }
%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
      <td><input  id="MsgOSendEmail" type="CHECKBOX" name=MsgOSendEmail  id=MsgOSendEmail value=null <%=getCheck((l & 2) != 0)%>>
        <%=r.getString(teasession._nLanguage, "MsgOSendEmail")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Hint")%>:</td>
      <td>
      <%
      for(int i=0;i<12;i++)
      {
        out.print("<input id='radio' type='radio' name='Hint' value='"+i+"' ");
        if(i1==i)out.print(" checked='true'");
        out.print("><img src='/tea/image/hint/"+i+".gif'>");
      }
      %>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td><input type="TEXT" class="edit_input"  id=Subject  name=Subject VALUE="<%=s10%>" SIZE=80 MAXLENGTH=255></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td COLSPAN=6><input type="file" id="Picture"  name="Picture" class="edit_input"/>
        <input  id="ClearPicture" type="CHECKBOX" id=ClearPicture  name=ClearPicture value=null>
        <%=r.getString(teasession._nLanguage, "Clear")%></td>
    </tr>
    <tr  id="messageVoice">
      <td><%=r.getString(teasession._nLanguage, "Voice")%>:</td>
      <td COLSPAN=6><input type="file" id="Voice"  name="Voice" class="edit_input"/>
        <input  id="ClearVoice" type="CHECKBOX" id="ClearVoice"  name="ClearVoice" value=null>
        <%=r.getString(teasession._nLanguage, "Clear")%> <A HREF="/tea/html/0/recorder.html" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Record")%></A></td>
    </tr>
    <tr id="messageFile">
      <td><%=r.getString(teasession._nLanguage, "File")%>:</td>
      <td COLSPAN=6><input type="file" id="File"  name="File" class="edit_input"/>
        <input  id="ClearFile" type="CHECKBOX" id=ClearFile  name=ClearFile value=null>
        <%=r.getString(teasession._nLanguage, "Clear")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Content")%>:</td>
      <td><TEXTAREA id=Content  name=Content ROWS=16 COLS=80 class="edit_input"><%=HtmlElement.htmlToText(s11)%></TEXTAREA></td>
    </tr>
    <tr>
      <td></td>
      <td><br/>
        <input type=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "CBSend")%>" ID="CBSend" CLASS="CB" onClick="">
        <input type=BUTTON value="<%=r.getString(teasession._nLanguage, "CBDraft")%>" id="CBDraft" class="CB" onClick="window.open('javascript:document.foEdit.Operation.value=\'MsgSaveAsDraft\';foEdit.submit();', '_self')"></td>
    </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td ALIGN=LEFT><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td><%=r.getString(teasession._nLanguage, "Attachment")%>:</td>
            <td colspan=6><input type="file" id="File"  name="File" class="edit_input"/></td>
          </tr>
        </table></td>
      <td>&nbsp;</td>
      <td ALIGN=RIGHT><br/>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBAttach")%>" ID="CBAttach" CLASS="CB" onClick="window.open('javascript:document.foEdit.Operation.value=\'Attach\';foEdit.submit();', '_self')">
        <br/>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBRemove")%>" ID="CBRemove" CLASS="CB" onClick="window.open('javascript:document.foEdit.Operation.value=\'Remove\';foEdit.submit();', '_self')"></td>
      <td ALIGN=CENTER><%=MessageUI.getAttachmentListSelection(i, r, teasession)%>
        <%--<SELECT name="attachmentListSelect" SIZE="5">
<option value=""> ....����.... </SELECT></td></tr>--%>
  </table>
</FORM>
<SCRIPT>document.foEdit.To.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

