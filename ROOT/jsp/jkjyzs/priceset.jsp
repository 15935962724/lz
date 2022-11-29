<%@page import="tea.entity.admin.sales.PriceSet"%>
<%@page import="tea.entity.node.PriceDistrict"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
int id=h.getInt("id");
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function cprice(a,b){
	sendx("/jsp/admin/edn_ajax.jsp?act=setprice&price="+b+"&node="+a,function(data){
		location.href="?id=<%=id%>";
	});
}
</script>
</head>
<body>
<h1>价格设置</h1><!--列表-->
<form>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td class="td">杂志名称</td>
  <td class="td">设置价格</td>
</tr>
<tr>
  <td class="td">健康杂志</td>
  <td class="td"><input type="text" value="<%=PriceSet.find(14050306).price %>" onchange="cprice(14050306,this.value)">元</td>
</tr>
<tr>
  <td class="td">健康少年画报</td>
  <td class="td"><input type="text" value="<%=PriceSet.find(14050307).price %>" onchange="cprice(14050307,this.value)">元</td>
</tr>
<tr>
  <td class="td">内部双月刊</td>
  <td class="td"><input type="text" value="<%=PriceSet.find(14050308).price %>" onchange="cprice(14050308,this.value)">元</td>
</tr>
</table>
</form>
</body>
</html>
