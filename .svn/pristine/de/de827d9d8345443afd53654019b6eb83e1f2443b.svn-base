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
int doid =0;
if(teasession.getParameter("doid")!=null && teasession.getParameter("doid").length()>0)
	doid = Integer.parseInt(teasession.getParameter("doid"));
Document doobj = Document.find(doid);
String documentname =null,keyword=null,fileold=null,fileurl=null,remark=null;
int maplen=0;
if(doid>0)
{
	documentname = doobj.getDocumentname();
	keyword = doobj.getKeyword();
	fileold = doobj.getFileold();
	fileurl = doobj.getFileurl();
	remark = doobj.getRemark();
	if(fileurl!=null)
	{
		maplen=(int)new java.io.File(application.getRealPath(fileurl)).length();
	}
}
if(teasession.getParameter("delete")!=null)
{
	doobj.delete();
	response.sendRedirect("/jsp/admin/sales/document.jsp");
	return ;
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
<script type="text/javascript">
	function sub()
	{
		if(form1.documentname.value=="")
		{
			alert("文档名字不能为空!");
			return false;
		}
	}
</script>
<h1>文档编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<br>
<form name=form1 METHOD=post  action="/servlet/EditDocument" ENCtype=multipart/form-data onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type="hidden" name="doid" value="<%=doid %>">
<tr>
    <td nowrap>文档名称</td><td nowrap><input type="text" name="documentname" value="<%if(documentname!=null)out.print(documentname); %>"></td>
 </tr>
 <tr>
	<td nowrap>关键字</td><td nowrap><input type="text" name="keyword" value="<%if(keyword!=null)out.print(keyword); %>"></td>
</tr>
<tr>
	<td nowrap>上传文件</td><td nowrap><input type="file" name="fileold" value="">
	    <%
	    		if(maplen>0){
	    	 %> 
	        <input  id="CHECKBOX" type="CHECKBOX" name="clear" onClick="form1.fileold.disabled=this.checked;"/>
	       清空
	        <%} 
	        %>
	
	</td>
</tr>
<tr>
	<td nowrap>文档备注</td><td nowrap><textarea cols=37 rows=3 name="remark" wrap="yes" ><%if(remark!=null)out.print(remark); %></textarea></td>
</tr>
</table>

<input type="submit" value="提交"> &nbsp;&nbsp;<input type="button" value="返回" onclick="location='/jsp/admin/sales/document.jsp'">
</FORM>
</body>
</html>



