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
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>


<h1>增加图书类别</h1>
<div id="head6"><img height="6" src="about:blank"></div>
     
<input type="button" value="图书类别添加" onClick="location='/jsp/admin/books/edit.jsp'" >
<br>
<h1>图书类别管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
   		<td nowrap>序号</td>
   		<td nowrap>图书类别</td>
   		<td nowrap>操作</td>
    </tr>
    <%
    	java.util.Enumeration me = Sort.findByCommunity(teasession._strCommunity,"");
    	int i = 1;
    	while(me.hasMoreElements()){
    	int id = ((Integer)me.nextElement()).intValue();
    	Sort obj = Sort.find(id);
     %>
    <tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   		<td nowrap><%=i %></td>
   		<td nowrap><%=obj.getSortname() %></td>
   		<td nowrap><a href="/jsp/admin/books/edit.jsp?id=<%=id %>">编辑</a> <a href="/jsp/admin/books/edit.jsp?delete=<%=id %>" onClick="return window.confirm('您确定要删除此内容吗？');">删除</a></td>
   		
    </tr>   
    <%
    	i++;
    	}
     %>    
</table>

</body>
</html>



