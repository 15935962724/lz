<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.DbAdapter" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

tea.resource.Resource r=new tea.resource.Resource();

String nexturl=request.getRequestURI()+"?"+request.getQueryString();

Node node=Node.find(teasession._nNode);
if(node.getCreator()==null)
{
  response.sendError(404);
  return;
}
MessageBoard mb=MessageBoard.find(teasession._nNode,teasession._nLanguage);


%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script>
function f_foEdit()
{
  if(foEdit.content.value=='')
  {
    alert('请填写回复内容');
    return false;
  }
}
</script>
<h1>留言板回复管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/servlet/EditMessageBoard">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
<INPUT TYPE=HIDDEN NAME=nexturl VALUE="<%=nexturl%>">
<INPUT TYPE=HIDDEN NAME=act VALUE="deletereply">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td class="th">主题:</td><td><%=node.getSubject(teasession._nLanguage)%></td>
<tr><td class="th">用户名:</td><td><%=node.getCreator()%></td>
<%
String name=mb.getName();
if(name!=null)
{
  out.print("<tr><td class='th'>姓名:</td><td>"+name);
}
String phone=mb.getPhone();
if(phone!=null)
{
  out.print("<tr><td class='th'>电话号码:</td><td>"+phone);
}
String mobile=mb.getMobile();
if(mobile!=null)
{
  out.print("<tr><td class='th'>手机号:</td><td>"+mobile);
}
String email=mb.getEmail();
if(email!=null)
{
  out.print("<tr><td class='th'>E-Mail:</td><td>"+email);
}
out.print("<tr><td class='th'>性别:</td><td>"+(mb.getSex()==0?"男":"女"));
out.print("<tr><td class='th'>年龄:</td><td>"+mb.getAge());
%>
<tr><td class="th">回复次数:</td><td><%=MessageBoardReply.count(teasession._nNode,teasession._nLanguage)%></td>
<tr><td class="th">发表时间:</td><td><%=node.getTimeToString()%></td>
<tr><td colspan="2"><%=node.getText(teasession._nLanguage)%></td></tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
int count=MessageBoardReply.count(teasession._nNode,teasession._nLanguage);
if(count>0)
{
java.util.Enumeration e=MessageBoardReply.find(teasession._nNode,teasession._nLanguage);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  MessageBoardReply mbr=MessageBoardReply.find(id);

%>
<tr id="tableonetr"><td style="text-align:left;"><input name=messageboardreply type=checkbox value="<%=id%>" >　回复人:<%=mbr.getMember()%>　时间:<%=mbr.getTimeToString()%></td>
<tr><td><%=mbr.getText()%></td></tr>
<tr><td>&nbsp;</td></tr>
<%}%>
<tr>
  <td><input type="checkbox" onClick="if(form1.messageboardreply){form1.messageboardreply.checked=this.checked;for(var i=form1.messageboardreply.length;i>0;i--)form1.messageboardreply[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"全选")%>
    　<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="return(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'));"></td>
</tr>
<%}%>
</table>
</FORM>

<FORM NAME=foEdit METHOD=POST action="/servlet/EditMessageBoard"  onSubmit="return f_foEdit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
<INPUT TYPE=HIDDEN NAME=nexturl VALUE="<%=nexturl%>">
<INPUT TYPE=HIDDEN NAME=act VALUE="editreply">
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr>
    <TD> </TD>
    <td id="MessageBoardSelcet"><input id="radio" type="radio" name=TextOrHtml value=0 ><%=r.getString(teasession._nLanguage, "TEXT")%>
      <input id="radio" type="radio" name=TextOrHtml value=1 checked="checked" >HTML</td>
</tr>
<TR>
    <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
    <TD nowrap><textarea name="content"  rows="8" cols="70" class="edit_input"></textarea>
    </TD>
</TR>
<TR>
    <td nowrap><%=r.getString(teasession._nLanguage, "Options")%>:</TD>
    <TD nowrap><input type="radio" name="hidden" value="false" checked /><%=r.getString(teasession._nLanguage, "所有人可见")%>
    <input type="radio" name="hidden" value="true" /><%=r.getString(teasession._nLanguage, "只有留言者可见")%>
   <!--  &nbsp;<input type="checkbox" name="send" value="true" checked/>同时回复到该会员的内部邮箱中 -->
    </TD>
</TR>
</TABLE>

<INPUT TYPE=SUBMIT onClick="return(submitText(foEdit.Text, '<%=r.getString(teasession._nLanguage,"InvalidParameter")%>'));" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input type="button" value="返回" onclick="history.back()"/>
</FORM>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

