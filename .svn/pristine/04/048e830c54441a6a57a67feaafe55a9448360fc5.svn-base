<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.member.Member"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@page import="java.util.List"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
Http h=new Http(request,response);

int trade=h.getInt("trade");
%>
</head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<body>
	<table id="tablecenter" cellspacing="0">
		<tr id="tableonetr">
			<td>操作人</td>
			<td>流程</td>
			<td>时间</td>
		</tr>
		<%
			List<Refundview> rvlist = Refundview.find(" AND trade = "+trade + "order by rdate desc", 0, 100);
		for(int i=0;i<rvlist.size();i++){
			Refundview rv = rvlist.get(i);
			Member mb = Member.find(rv.member);
			out.print("<tr><td>"+mb.username+"</td><td>"+Refundview.TSTATE_TYPE[rv.tstate]+"</td><td>"+MT.f(rv.rdate,1)+"</td></tr>");
		}
		%>
	</table>
</body>
</html>