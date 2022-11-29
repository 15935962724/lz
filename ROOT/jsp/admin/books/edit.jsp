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

int sortid = 0;
if(teasession.getParameter("id")!=null)
{
	sortid = Integer.parseInt(teasession.getParameter("id"));
}
Sort obj = Sort.find(sortid);
String sortname=null;
if(sortid>0)
{
	sortname = obj.getSortname();
}

if(teasession.getParameter("delete")!=null)
{
	int id = Integer.parseInt(teasession.getParameter("delete"));
	Sort dobj = Sort.find(id);
	dobj.delete();
	response.sendRedirect("/jsp/admin/books/sort.jsp");
	return;
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
<script>
	function sub()
	{
		if(form1.sortname.value=="")
		{
			alert("请填写主题!");
			return false;
		}
	
	}
</script>

<h1>增加图书类别</h1>
<div id="head6"><img height="6" src="about:blank"></div>
     
<form name=form1 METHOD=post  action="/jsp/admin/books/Editedit.jsp" onsubmit="return sub(this);">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <input type="hidden" name="id" value="<%=sortid %>">
     <tr id="tableonetr">
    	<td nowrap> 类别名称:<input type="text" value="<%if(sortname!=null){out.print(sortname);} %>" name="sortname" size="25" maxlength="100">
    	<input type="submit" value="确定">&nbsp;&nbsp;  <input type="button" value="返回" class="BigButton" onclick="location='sort.jsp'">
    	
    	</td>
    </tr>   
    
</table>
</form>



</body>
</html>



