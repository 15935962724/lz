<%@page import="tea.entity.MT"%>
<%@page import="java.util.List"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.Database"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.ShopOrderRecipient"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Http h = new Http(request,response);
	if(h.member<1)
	{
	  response.sendRedirect("/html/folder/14102033-1.htm?community="+h.community);
	  return;
	}
	int member = h.member;
	StringBuffer sql=new StringBuffer(),par=new StringBuffer();
	int id = h.getInt("id");
	if(id > 0)
		ShopOrderRecipient.delete(id);
	
	par.append("?community="+h.community);
	par.append("&member="+member);
	sql.append(" AND member="+member);
	
	String consignees=h.get("consignees","");
	if(consignees.length()>0){
	  sql.append(" AND consignees LIKE "+DbAdapter.cite("%"+consignees+"%"));
	}
	
	int sum=ShopOrderRecipient.count(sql.toString());
	
	int pos=h.getInt("pos");
	par.append("&pos=");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>选择收货人</title>
	<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
	<script src="/tea/jquery.js" type="text/javascript"></script>
</head>

<body>

<form name="form1" action="?">
	<input type="hidden" name="id" value="" />
	<table><tr>
		<td>收货人：</td><td><input type="text" name="consignees" /></td><td><input type="submit" value="查询"/></td>
	</tr></table>
</form>

<table id="tablecenter" cellspacing="0">
	<tr id="tableonetr">
	  <td nowrap>用户名</td>
	  <td nowrap>手机号</td>
	  <td>操作</td>
	</tr>
	<%
if(sum<1){
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else{
	ArrayList list = ShopOrderRecipient.find(sql.toString(),pos,7);
  	for(int i=0;i<list.size();i++){
  		ShopOrderRecipient sor = (ShopOrderRecipient)list.get(i);
%>
	<tr>
		<td><a href="javascript:;" onclick="parent.sof.mt.receive('<%= sor.getId() %>','<%= sor.getConsignees() %>','<%=sor.getMobile() %>');parent.mt.close();"><%=sor.getConsignees() %></a></td>
		<td><%=sor.getMobile() %></td>
		<td><button type="button" class="btn btn-link" onclick="f_act('<%=sor.getId() %>')">删除</button></td>
	</tr>
<%	}
}%>
	<tr>
		<td colspan='3' align='right'><%="共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,7)%></td>
	</tr>
</table>
<script src="/tea/mt.js" type="text/javascript"></script>
<script type="text/javascript">
function f_act(id)
{
  form1.id.value=id;
  form1.submit();
}
</script>
</body>
</html>