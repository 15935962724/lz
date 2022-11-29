<%@page contentType="text/html;charset=UTF-8"  %><%@ page import="tea.ui.*" %><%@ page import="tea.db.*" %><%@ page import="tea.entity.admin.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=request.getParameter("community");

StringBuffer sql=new StringBuffer();
String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
}

String index=request.getParameter("index");
String sql_param=request.getParameter("sql");
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="">
window.name='unitselect';

var parent_window = window.dialogArguments;
function fclick(theDate)
{
   parent_window.<%=index%>.value=theDate;
   window.close();
}
</script>
</head>
<body>

<div id="head6"><img height="6" src="about:blank"></div>
<form action="<%=request.getRequestURI()%>" target="unitselect">
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="index" value="<%=index%>"/>
<%
if(sql_param!=null)
{
  out.print("<input type=hidden name=sql value=\""+sql_param+"\" >");
  sql.append(sql_param);
}
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>名称:<input type="text" name="name" value="<%if(name!=null)out.print(name);%>"/></td>
<td><input type="submit" value="GO"/></td>
</tr>
</table>
</form>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id=tableonetr>
    <td width="1"><script type="">var index=0;</script></td>
    <td>名称</td>
    <td>电话</td>
    <td>传真</td>
  </tr>

<%


java.util.Enumeration enumeration = AdminUnit.findByCommunity(community,sql.toString());
while(enumeration.hasMoreElements())
{
  AdminUnit obj=(AdminUnit)enumeration.nextElement();
  int id=obj.getId();

%>
<tr onclick="fclick('<%=id%>');" onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" style="cursor:hand ">
<td nowrap="nowrap"  width="1"><script type="">document.write(++index);</script></td>
<td><%=obj.getName()%></td>
<td><%=obj.getTel()%></td>
<td><%=obj.getFax()%></td>
</tr>
<%}%>

</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%//=new Languages(teasession._nLanguage,request)%></div>
</html>


