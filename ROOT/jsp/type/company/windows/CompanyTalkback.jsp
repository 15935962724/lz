<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.node.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Company");

Node obj=Node.find(teasession._nNode);


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body  id="companysrhbody" >

<FORM target=_blank NAME=foEdit METHOD=POST action="/servlet/EditTalkback" ENCTYPE=multipart/form-data onSubmit="return(submitText(this.subject, '无效主题')&&(this.submit.disabled=true));">
<INPUT TYPE=HIDDEN NAME=node VALUE="<%=teasession._nNode%>">

<table width="90%" border="0" cellpadding="0" cellspacing="0" style="margin:10px auto;">
  <tr>
    <td>选项:</td>
    <TD>
      <INPUT  id=CHECKBOX type="CHECKBOX" NAME=MsgOSendMessage VALUE=null  >发送信息
      <INPUT  id=CHECKBOX type="CHECKBOX" NAME=MsgOSendEmail VALUE=null  >同时按E-MAIL发送</TD>
  </TR>
  <TR id="yinc">
    <td id="yinc">主题:</td>
    <TD id="yinc"><INPUT NAME="subject" TYPE=TEXT class="edit_input" SIZE=40 MAXLENGTH=255 value="关于qiqiwang的问题"></TD>
  </TR>
  <TR>
    <td id="yinc">内容:</td>
    <TD colspan="2"><TEXTAREA NAME="content" COLS=40 ROWS=5 class="edit_input" id="lynr" style="width:356px;height125px;"></TEXTAREA></TD>
  </TR>
  <tr>
    <td align="center" colspan="2">
	<INPUT TYPE=submit name="submit" VALUE="提交留言" class="mpan">
	<INPUT type="reset" value="重置" id="yinc">
    </td>
  </tr>
</table>


</FORM>



</body>
</html>
