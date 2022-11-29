<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if (!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(teasession._strCommunity))
{
    response.sendError(403);
    return;
}

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function flen(obj,text)
{
  if(obj.value<1||obj.value>1000)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>
<body>

<h1>申请延期的会员</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>会员:<input type=text ></td>
<td>余额:<input type=text > - <input type=text ></td>
<td>类型:<select type=text >
<option value="">------------<option ><180
<option >>180 或 已经延期
</select></td>
<td><input type=submit value=查询></td>
</tr>
</table>
<br>

<h2>列表 ( 2 )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td width=1>&nbsp;</td>
<td>会员</td>
<td>余额</td>
<td>类型</td>
<td>申请日期</td>
<td></td>
</tr>
<%
int pos=0;
java.util.Enumeration enumer=Code.find(teasession._strCommunity,"webmaster",pos,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  Code obj=(Code)enumer.nextElement();
  %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
<td><%=obj.getSymbol()+obj.getCode()%></td>
<td><%=obj.getMember()%></td>
<td><%=obj.getTime2ToString()%></td>
</tr>
<%
}
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
<td width=1>1</td>
<td>webmaster</td>
<td>1200.00</td>
<td><180</td>
<td>2007-05-17</td>
<td><input type=button value=批准 onclick="if(confirm('确认延期? 免费延期15天.')){location.reload();}" ></td>
</tr>

<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
<td width=1>2</td>
<td>ec</td>
<td>3200.00</td>
<td>>180 或 已经延期</td>
<td>2007-05-17</td>
<td><input type=button value=批准 onclick="if(confirm('确认延期? 将收取10%的费用.')){location.reload();}" ></td>
</tr>

</table>

<input type=button value=批准所有 onclick="if(confirm('确认延期?')){location.reload();}" >

<br>
<div id="head6"><img height="6" alt=""></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>1.是否大于180天,是按申请日期计算.</td></tr>
</table>

</body>
</html>
