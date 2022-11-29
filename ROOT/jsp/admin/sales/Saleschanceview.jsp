<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.admin.sales.*" %>
<%@ page import="java.util.*" %>

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

Date timek =null,timej=null;
if(teasession.getParameter("timek")!=null && teasession.getParameter("timek").length()>0)
	timek = Task.sdf.parse(teasession.getParameter("timek"));
if(teasession.getParameter("timej")!=null && teasession.getParameter("timej").length()>0)
	timej = Task.sdf.parse(teasession.getParameter("timej"));
int fettles =0;
if(teasession.getParameter("fettles")!=null && teasession.getParameter("fettles").length()>0)
	fettles = Integer.parseInt(teasession.getParameter("fettles"));
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1>客户机会表</h1>
<div id="head6"><img height="6"></div>


<form mothod="post" name="form2" action="/jsp/admin/sales/Saleschanceview.jsp">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td nowrap>时间:
		<input name="timek" size="7"  value="<%if(teasession.getParameter("timek")!=null)out.print(teasession.getParameter("timek")); %>" readonly><A href="###"><img onclick="showCalendar('form2.timek');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
		至<input name="timej" size="7"  value="<%if(teasession.getParameter("timej")!=null)out.print(teasession.getParameter("timej")); %>" readonly><A href="###"><img onclick="showCalendar('form2.timej');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
		&nbsp;完成状态:<select name="fettles">
			<%
				for(int i=0;i<Saleschance.TIMES.length;i++)
				{
					out.print("<option value="+i);
					if(fettles==i)
						out.print(" selected");
					out.print(">"+Saleschance.TIMES[i]);
					out.print("</option>");
				}
			 %>
		</select>
		&nbsp;<input type="submit" name="" value=" 查 询 ">
		</td>
	</tr>
</table>
</form>
<br>
<div id="head6"><img height="6"></div>
<form method="POST" action="/servlet/SaleschanceExcel" name="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td>最近业务机会</td>
<td>
	<input type="button" value="新建"  onClick="location='/jsp/admin/sales/saleschance.jsp'">
</td>
</tr>
<tr>
	<td>业务机会名称 </td>
	<td>客户名称</td>
	<td>结束时间</td>
</tr>
<%
	DbAdapter db = new DbAdapter();
	String sql = " and member ="+db.cite(teasession._rv.toString()); 
	if(timek!=null && timej!=null&& fettles==0)
	{
		sql = " and member ="+db.cite(teasession._rv.toString())+"  and "+db.cite(timek)+"<dates and dates<"+db.cite(timej)+"";
	}
	if(timek!=null && timej!=null&& fettles==1)
	{
		sql = " and member ="+db.cite(teasession._rv.toString())+"  and "+db.cite(timek)+"<timecreate and timecreate<"+db.cite(timej)+"";
	}
	java.util.Enumeration lame =Saleschance.findByCommunity(teasession._strCommunity,sql);
	while(lame.hasMoreElements())
	{
			int laid = ((Integer)lame.nextElement()).intValue();
			Saleschance tsdbj = Saleschance.find(laid);
			String name;
			String ming;
			if(tsdbj.getClienttype())
			{
				name=Workproject.find(tsdbj.getClientname()).getName(teasession._nLanguage);
				ming=Workproject.find(tsdbj.getClientname()).getName(teasession._nLanguage);
			}
			else
			{	
				name=Latency.find(tsdbj.getClientname()).getFamily();
				ming=Latency.find(tsdbj.getClientname()).getFirsts();
			}
			
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	 <td nowrap><a href="/jsp/admin/sales/saleschanceinfo.jsp?laid=<%=laid%>"><%=tsdbj.getbscname()%></a> </td>
	 <td nowrap><a href="/jsp/admin/sales/saleschanceinfo.jsp?laid=<%=laid%>"><%=name+ming%></a> </td>
	<td nowrap><%=tsdbj.getDatesToString()%></td>
</tr>
<%
	}
%>
<input type="hidden" name="sql" value="<%=sql %>">
  <input type="hidden" name="files" value="saleschance">
</table>
<input type="submit" name="exportall" value="导出Excel表">
</form>
</body>
</html>


