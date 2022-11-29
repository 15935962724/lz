<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.entity.admin.sales.*" %>

<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>潜在客户管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<div id="head6"><img height="6" src="about:blank"></div>

<br>
<form method="POST" action="/servlet/EditExportExcel" name="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr id="tableonetr">
    <td nowrap>名称</td>
	<td nowrap>公司</td>
	<td nowrap>电话</td>
	<td nowrap>操作</td>
</tr>
<%
	java.util.Enumeration lame = Latency.findByCommunity(teasession._strCommunity," AND type!=1");
    if(!lame.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
	while(lame.hasMoreElements())
	{
			int laid = ((Integer)lame.nextElement()).intValue();
			Latency laobj = Latency.find(laid);

%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	 <td nowrap><a href="/jsp/admin/sales/latency_info.jsp?laid=<%=laid %>"><%=laobj.getFamily()+" "+laobj.getFirsts() %></a> </td>
	<td nowrap><%=laobj.getCorp() %></td>
	<td nowrap><%=laobj.getTelephone()%></td>
	<td nowrap><a href="/jsp/admin/sales/newlatency.jsp?laid=<%=laid %>">编辑</a> &nbsp;<a href="/jsp/admin/sales/newlatency.jsp?laid=<%=laid %>&delete=delete">删除</a> </td>
</tr>
<%
	}
%>
 <input type="hidden" name="sql" value="">
  <input type="hidden" name="files" value="latency">
</table>
<br>
<input type="submit" name="exportall" value="导出Excel表" >&nbsp;&nbsp;
<input type="button" value="添加潜在客户" onClick="location='/jsp/admin/sales/newlatency.jsp?sun=add'">
  </form>

</body>
</html>



