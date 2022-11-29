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
int laid=0;
if(teasession.getParameter("laid")!=null && teasession.getParameter("laid").length()>0)
{
	 laid = Integer.parseInt(teasession.getParameter("laid"));
}
	Saleschance tsdbj = Saleschance.find(laid);
	tsdbj.setTimelook();
	String name;
	if(tsdbj.getClienttype()){
		Workproject wp=Workproject.find(tsdbj.getClientname());
			name=wp.getName(teasession._nLanguage);
	}
	else
	{
	Latency l=Latency.find(tsdbj.getClientname());
			name=l.getFamily()+l.getFirsts();
}
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

<h1>客户机会显示</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name=form1 METHOD=post  action="/servlet/SaleschanceServlet" onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type ="hidden" name="laid" value="<%=laid %>">
	<tr >
	    <td nowrap>潜在客户所有人:</td>
	    <td nowrap><%=teasession._rv%></td>
	</tr>
	<tr>
		<td nowrap>业务机会名称:</td>
		<td nowrap><% if(tsdbj.getbscname()!=null)out.print(tsdbj.getbscname()); %></td>
	</tr>
	<tr >
	    <td nowrap>客户名称：</td><td nowrap><%=name%></td>
	</tr>

	<tr>
		<td nowrap>类型：</td><td nowrap><%out.print(Saleschance.TYPES[tsdbj.getType()]); %></td>
	</tr>
	<tr>
		<td nowrap>结束时间：</td><td nowrap><% if(tsdbj.getDates()!=null)out.print(tsdbj.getDatesToString()); %></td>
	</tr>
	<tr>
		<td nowrap>阶段：</td><td nowrap><%out.print(Saleschance.MOMENTS[tsdbj.getMoment()]);%></td>
	</tr>
	<tr>
		<td nowrap>可能性 (%)：</td><td nowrap><% if(tsdbj.getChance()!=null)out.print(tsdbj.getChance()); %></td>
	</tr>
	<tr>
		<td nowrap>金额：</td><td nowrap><% if(tsdbj.getMoney()!=null&&tsdbj.getMoney().length()>0)out.print("￥"+Saleschance.df.format(Double.parseDouble(tsdbj.getMoney()))) ;%></td>
	</tr>
	<tr>
		<td nowrap>潜在客户来源</td><td nowrap><% if(tsdbj.getLatencyclient()!=0)out.print(Saleschance.ORIGIN[tsdbj.getLatencyclient()]);%></td>
	</tr>
	<tr>
		<td nowrap>下一步</td><td nowrap><% if(tsdbj.getNexts()!=null)out.print(tsdbj.getNexts()); %></td>
	</tr>
	<tr>
		<td nowrap>备注</td>
		<td nowrap><% if(tsdbj.getRemark()!=null)out.print(tsdbj.getRemark()); %></td>
	</tr>
	<tr>
		<td nowrap>创建人：</td><td nowrap><% if(tsdbj.getbschanceholder()!=null)out.print(tsdbj.getbschanceholder()); %>,<%if(tsdbj.getDates()!=null) out.print(tsdbj.getDatesToString());%></td>
	</tr>
	<tr>
		<td nowrap>上次修改人：</td><td nowrap><%if(tsdbj.getBsupdatename()!=null)out.print(tsdbj.getBsupdatename());%></td>
	</tr>
</table>
<input type="button" value="编辑"  onClick="location='/jsp/admin/sales/saleschance.jsp?laid=<%=laid %>'">
<input type="submit" value="删除" name="submit" >
<input type="button" value="取消"  onclick="location='/jsp/admin/sales/Saleschanceview.jsp'">
</FORM>
</body>
</html>



