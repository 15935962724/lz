<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
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
String keyword = teasession.getParameter("keyword");
if(keyword==null)
{
	keyword="";
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

<h1>文档管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<input type="button" value="添加文档" onClick="location='/jsp/admin/sales/newdocument.jsp'">
<div id="head6"><img height="6" src="about:blank"></div>
<form name = "form2" METHOD=post enctype="multipart/form-data"  action="/jsp/admin/sales/document.jsp">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td nowrap>输入关键字以查找匹配的文档:&nbsp;&nbsp;<input type="text" name="keyword" value="<%=keyword %>">
		&nbsp;&nbsp;<input type="submit" value="搜索文档">
		</td>
	
	</tr>

</table>
</FORM>
<br>
<form method="POST" action="/servlet/EditExportExcel" name="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr id="tableonetr">
    <td nowrap>名称</td>
    <td nowrap>下载</td>
	<td nowrap>上传时间</td>
	<td nowrap>备注</td>
	<td nowrap>类型</td>
	<td nowrap>操作</td>
</tr>
<%
	String sql = " and keyword like N'%"+keyword+"%' ";
	java.util.Enumeration dome = Document.findByCommunity(teasession._strCommunity,sql);
	while(dome.hasMoreElements())
	{
		int doid =((Integer)dome.nextElement()).intValue();
		Document doobj = Document.find(doid);
 %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	 <td nowrap id= show><a href="/jsp/admin/sales/document_info.jsp?doid=<%=doid %>"><%=doobj.getDocumentname() %></a> </td>
	 <td nowrap><a href ="/jsp/include/DownFile.jsp?uri=<%=doobj.getFileurl() %>&name=<%=doobj.getFileold() %>"><%=doobj.getFileold() %></a></td>
	<td nowrap><%=doobj.getTimes() %></td>
	<td nowrap><%=doobj.getRemark() %></td>
	<td nowrap><%=doobj.getFileold().substring(doobj.getFileold().lastIndexOf(".")+1) %></td>
	<td nowrap><a href="/jsp/admin/sales/newdocument.jsp?doid=<%=doid %>">编辑</a> &nbsp;<a href="/jsp/admin/sales/newdocument.jsp?doid=<%=doid %>&delete=delete">删除</a> </td>
</tr>
<%
	}
 %>
</table>
 <input type="hidden" name="sql" value="<%=sql %>">
  <input type="hidden" name="files" value="document">
  
<input type="submit" name="exportall" value="导出Excel表" >
</form>
</body>
</html>



