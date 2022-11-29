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
int id = 0;
if(teasession.getParameter("id")!=null)
	id = Integer.parseInt(teasession.getParameter("id"));
Books obj = Books.find(id);

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

<h1>图书详细信息  </h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr >
   		<td nowrap>部门：</td>
   		<td nowrap><%
			AdminUnit obj_au=  AdminUnit.find(obj.getUnit());
			out.print(obj_au.getName());
   		 %></td>
    </tr>
    <tr>
   		<td nowrap>书名：</td>
   		<td nowrap><%=obj.getBookname() %></td>
    </tr>
    <tr>
   		<td nowrap>图书类别:</td>
   		<td nowrap>
   		<%
   			Sort sobj = Sort.find(obj.getBooksort());
   			out.print(sobj.getSortname());
   		 %>
   		</td>
    </tr>  
   <tr>
    	<td nowrap>作者:</td>
    	<td nowrap><%=obj.getAuthor() %></td>
    </tr>   
    <tr>
    	<td nowrap>图书编号:</td>
    	<td nowrap><%=obj.getNumber() %></td>
    </tr>  
    <tr>
    	<td nowrap>出版社:</td>
    	<td nowrap><%=obj.getConcern() %></td>
    </tr> 
      <tr>
    	<td nowrap>出版社日期：</td>
    	<td nowrap><%=obj.getTimes().toString().substring(0,10) %></td>
    </tr> 
    <tr>
    	<td nowrap>存放地点:</td>
    	<td nowrap><%=obj.getLocus() %></td>
    </tr> 
     <tr>
    	<td nowrap>数量:</td>
    	<td nowrap><%=obj.getAmount() %></td>
    </tr> 
     <tr>
    	<td nowrap>价格:</td>
    	<td nowrap><%=obj.getPrice() %></td>
    </tr> 
     <tr>
    	<td nowrap>内容简介:</td>
    	<td nowrap><%=obj.getContent() %></td>
    </tr> 
     <tr>
    	<td nowrap>借阅范围:</td>
    	<td nowrap><%if(obj.getBound()==1){out.print("本部门");}if(obj.getBound()==2){out.print("全体");} %></td>
    </tr> 
     <tr>
    	<td nowrap>借阅状态:</td>
    	<td nowrap><%if(obj.getFettle()==1){out.print("已借出");}if(obj.getFettle()==2){out.print("未借出");} %></td>
    </tr> 
     <tr>
    	<td nowrap>借阅人:</td>
    	<td nowrap><%=obj.getHuman() %></td>
    </tr>
 	<tr>
    	<td nowrap>备注:</td>
    	<td nowrap><%=obj.getRemark() %></td>
    </tr> 
	
</table>
 <input type="submit" value="关闭" onClick="javascript:window.close();">
</body>
</html>



