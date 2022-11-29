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
String record = teasession.getParameter("record");




		int unit = 0;
		if(teasession.getParameter("unit")!=null && teasession.getParameter("unit").length()>0)
			unit = Integer.parseInt(teasession.getParameter("unit"));
		int booksort = 0;
		if(teasession.getParameter("booksort")!=null && teasession.getParameter("booksort").length()>0)
			booksort = Integer.parseInt(teasession.getParameter("booksort"));
		
		String bookname = teasession.getParameter("bookname");	
		String author = teasession.getParameter("author");
		String number = teasession.getParameter("number");
		String concern = teasession.getParameter("concern");
		String times = teasession.getParameter("times");
		String locus = teasession.getParameter("locus");
		int com = 0;
		if(teasession.getParameter("com")!=null && teasession.getParameter("com").length()>0)
		{
			com = Integer.parseInt(teasession.getParameter("com"));
		}
	
		String sql ="";
		
		DbAdapter db = new DbAdapter();
		try
		{
			if(unit==-1 && booksort!=0)
			{
				sql =" and booksort = "+booksort+"  and bookname like "+db.cite("%"+bookname+"%")+" and author like "+db.cite("%"+author+"%")+" and number like "+db.cite("%"+number+"%")+" and concern like "+db.cite("%"+concern+"%")+" and times = '"+times+"' and locus like "+db.cite("%"+locus+"%")+" ";
			}
			if(booksort==0 && unit!=-1)
			{
				sql =" and   unit = "+unit+" and bookname like "+db.cite("%"+bookname+"%")+" and author like "+db.cite("%"+author+"%")+" and number like "+db.cite("%"+number+"%")+" and concern like "+db.cite("%"+concern+"%")+" and times = '"+times+"' and locus like "+db.cite("%"+locus+"%")+" ";
			}
			if(unit==-1 && booksort==0)
			{
				sql ="  and bookname like "+db.cite("%"+bookname+"%")+" and author like "+db.cite("%"+author+"%")+" and number like "+db.cite("%"+number+"%")+" and concern like "+db.cite("%"+concern+"%")+" and times = '"+times+"' and locus like "+db.cite("%"+locus+"%")+" ";
			}
			if(unit!=-1 && booksort!=0)
			{
				 sql =" and   unit = "+unit+" and booksort = "+booksort+" and bookname like "+db.cite("%"+bookname+"%")+" and author like "+db.cite("%"+author+"%")+" and number like "+db.cite("%"+number+"%")+" and concern like "+db.cite("%"+concern+"%")+" and times = '"+times+"' and locus like "+db.cite("%"+locus+"%")+" ";
			}
		}finally
		{
		db.close();
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



<h1> 新建图书  </h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name=form1 METHOD=post  action="/servlet/EditBooks" onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
   		<td nowrap>部门</td>
   		<td nowrap>书名</td>
		<td nowrap>类别</td>
   		<td nowrap>作者</td>
   		<td nowrap>出版社</td>	
   		<td nowrap>存放地点</td>	
   		<td nowrap>借阅状态</td>	
   		<td nowrap>操作</td>		
	</tr>
	<%

		 java.util.Enumeration em=Books.findByCommunity(teasession._strCommunity,sql);
		 while(em.hasMoreElements())
		 {
		 	int id = ((Integer)em.nextElement()).intValue();
		 	Books obj = Books.find(id);
		 	AdminUnit obj_au=  AdminUnit.find(obj.getUnit());
		 	Sort objs = Sort.find(obj.getBooksort());
	 %>
	   <tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   		<td nowrap><%=obj_au.getName() %></td>
   		<td nowrap><%=obj.getBookname() %></td>
		<td nowrap><%=objs.getSortname() %></td>
   		<td nowrap><%=obj.getAuthor() %></td>
   		<td nowrap><%=obj.getConcern() %></td>	
   		<td nowrap><%=obj.getLocus() %></td>	
   		<td nowrap><%if(obj.getFettle()==1){out.print("以借出");}if(obj.getFettle()==2){out.print("未借出");}%></td>	
   		<%
   			if(record.equals("record"))
   			{
   		 %>
   		<td nowrap><a href ="/jsp/admin/books/newbook.jsp?id=<%=id %>">编辑</a> <a href="/jsp/admin/books/record.jsp?listdelete=<%=id %>" onClick="return window.confirm('您确定要删除此内容吗？');">删除</a></td>		
		<%
			}
			if(record.equals("see")){
		 %>
		 	<td nowrap><a href ="/jsp/admin/books/detail.jsp?id=<%=id %>" target="_blank">详情</a> </td>		
		<%
			}
		%>
	</tr>
	<%
		}
	 %>
</table>
<%
	if(record.equals("record"))
	{
 %>
<input type="button" value="返回" onclick="location='record.jsp'">
<%
	}
	if(record.equals("see"))
	{
 %>
 <input type="button" value="返回" onclick="location='see.jsp'">
 <%
 	}
 %>
</FORM>
</body>
</html>



