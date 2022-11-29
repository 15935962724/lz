<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.resource.Common" %>
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
int laid = 0;
if(teasession.getParameter("laid")!=null && teasession.getParameter("laid").length()>0)
	laid = Integer.parseInt(teasession.getParameter("laid"));
Latency laobj = Latency.find(laid);

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

<h1>潜在客户详细信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name=form1 METHOD=post  action="/jsp/admin/books/Editedit.jsp" onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

	<tr >
	    <td nowrap>潜在客户所有人:</td>
	    <td nowrap><%if(laobj.getHolder()!=null && laobj.getHolder().length()>0){out.print(laobj.getHolder());}else{out.print(teasession._rv);} %> </td>
	</tr>
	<tr>
		<td nowrap>潜在客户状态:</td>
		<td nowrap><%if(laobj.getStates()!=0)out.print(Latency.HOLDER[laobj.getStates()]); %></td>
	</tr>
	<tr >
	    <td nowrap>姓名：</td><td nowrap><%if(laobj.getFamily()!=null || laobj.getFirsts()!=null)out.print(laobj.getFamily()+laobj.getFirsts()); %></td>
	</tr>

	<tr>
		<td nowrap>电话：</td><td nowrap><%if(laobj.getTelephone()!=null)out.print(laobj.getTelephone()); %></td>
	</tr>
	<tr>
		<td nowrap>电子邮件：</td><td nowrap><%if(laobj.getEmail()!=null)out.print(laobj.getEmail()); %></td>
	</tr>
	<tr>
		<td nowrap>公司：</td><td nowrap><%if(laobj.getCorp()!=null)out.print(laobj.getCorp()); %></td>
	</tr>
	<tr>
		<td nowrap>分级：</td><td nowrap><%if(laobj.getGrade()!=0)out.print(Latency.GRADE[laobj.getGrade()]); %></td>
	</tr>
	<tr>
		<td nowrap>职务：</td><td nowrap><%if(laobj.getDuty()!=0)out.print(laobj.getDuty()); %></td>
	</tr>
	<tr>
		<td nowrap>国家/地区：</td><td nowrap><%if(laobj.getCountry()!=null)out.print(laobj.getCountry()); %></td>
	</tr>

	<tr>
		<td nowrap>洲/省：</td><td nowrap><%if(laobj.getProvince()!=0)out.print(laobj.getProvince()); %></td>
	</tr>
	<tr>
		<td nowrap>城市：</td><td nowrap><%if(laobj.getCity()!=null)out.print(laobj.getCity()); %></td>
	</tr>
	<tr>
		<td nowrap>街道：</td><td nowrap><%if(laobj.getStreet()!=null)out.print(laobj.getStreet()); %></td>
	</tr>
	<tr>
		<td nowrap>邮政编码：</td><td nowrap><%if(laobj.getPostalcode()!=0)out.print(laobj.getPostalcode()); %></td>
	</tr>
	<tr>
		<td nowrap>网址：</td><td nowrap><%if(laobj.getWebaddress()!=null)out.print(laobj.getWebaddress()); %></td>
	</tr>

	<tr>
		<td nowrap>员工数：</td><td nowrap><%if(laobj.getCounts()!=0)out.print(laobj.getCounts()); %></td>
	</tr>
	<tr>
		<td nowrap>潜在客户来源：</td><td nowrap><%if(laobj.getOrigin()!=0)out.print(Latency.ORIGIN[laobj.getOrigin()]); %></td>
	</tr>
	<tr>
		<td nowrap>年收入：</td><td nowrap>￥<%if(laobj.getIncome()!=0)out.print(laobj.getIncome()); %></td>
	</tr>
	<tr>
		<td nowrap>行业：</td><td nowrap><%if(laobj.getCalling()!=0)out.print(Common.SALES_CALLING[laobj.getCalling()]); %></td>
	</tr>
	<tr>
		<td nowrap>备注：</td><td nowrap><%if(laobj.getRemark()!=null)out.print(laobj.getRemark()); %></td>
	</tr>
	<tr>
		<td nowrap>创建人:</td><td nowrap><%if(laobj.getMember()!=null)out.print(laobj.getMember()); %></td>
	</tr>
	<tr>
		<td nowrap>创建时间:</td><td nowrap><%if(laobj.getTimes()!=null)out.print(laobj.getTimes()); %></td>
	</tr>
	<tr>
		<td nowrap>上次修改人:</td><td nowrap><%if(laobj.getMember1()!=null)out.print(laobj.getMember1()); %></td>
	</tr>
	<tr>
		<td nowrap>修改时间:</td><td nowrap><%if(laobj.getTimes1()!=null)out.print(laobj.getTimes1()); %></td>
	</tr>
</table>
<input type="button" value="返回" onclick="location='/jsp/admin/sales/latency.jsp'">
</FORM>
</body>
</html>



