<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
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
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>出差登记</h1>

<div id="head6"><img height="6" src="about:blank"></div>


<input type="button" value="返回上一页" onClick="history.back();">
　  <br />
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>出差地区</td>
         <td nowrap>开始日期</td>
         <td nowrap>结束日期</td>
       </tr>
       <%
      		java.util.Enumeration enumer = Evection.findByCommunity(teasession._strCommunity," and l.member = '"+teasession._rv+"' and l.type=1");
      		while(enumer.hasMoreElements())
      		{
      			int id = ((Integer)enumer.nextElement()).intValue();
      			Evection obj = Evection.find(id);


	   %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%=obj.getArea() %></td>
       		<td nowrap><%=obj.sdf.format(obj.getTime_k())  %></td>
       		<td nowrap><%=obj.sdf.format(obj.getTime_j())  %></td>
       		<td nowrap>
       			<% 
       				if(obj.getType()==1) 
       				{
       					out.print("<a href =\"/jsp/admin/manage/Disposal.jsp?evetype="+id+"\">返回</a>");
       				}
       			 %>
       		</td>
       	</tr>

<%
	}
 %>
</table>


</body>
</html>




