<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.eon.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();

EonNode en=EonNode.find(teasession._nNode);
String member=en.getMember();

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="">
function f_act(id,act)
{
  if(act=='memberdelete')
  {
    if(!confirm('确认删除?'))
    {
      return;
    }
    form1.action="/servlet/EditEonNode";
  }
  form1.old.value=id;
  form1.act.value=act;
  form1.submit();
}

</script>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "设置服务人")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/jsp/eon/EditEonNodeMember.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<input type="hidden" name="old">
<input type="hidden" name="act">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
  <td>序号</td>
  <td>用户</td>
  <td>操作</td>
</tr>
<%
String ms[]=member.split("/");
for(int i=1;i<ms.length;i++)
{
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>"+i);
  out.print("<td>"+ms[i]);
  out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=f_act('"+ms[i]+"','memberedit')>");
  out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=f_act('"+ms[i]+"','memberdelete')>");
}
%>
</table>

<input type=button value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onclick=f_act('','membernew')>

</form>


</body>
</html>
