<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.entity.admin.sales.*" %>
<%@ page import="java.io.File" %>

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

int doid = 0;
int big = 0;
if(teasession.getParameter("doid")!=null && teasession.getParameter("doid").length()>0)
	doid = Integer.parseInt(teasession.getParameter("doid"));
Document doobj = Document.find(doid);
if(doobj.getFileurl()!=null)
	 big =(int)new java.io.File(application.getRealPath(doobj.getFileurl())).length();

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

<h1>文档详细信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr>
    <td nowrap>文档名称：</td><td nowrap><%if(doobj.getDocumentname()!=null)out.print(doobj.getDocumentname()); %></td>
 </tr>
 <tr>
    <td nowrap>文件扩展名：</td><td nowrap><%if(doobj.getFileold()!=null)out.print(doobj.getFileold().substring(doobj.getFileold().lastIndexOf(".")+1)); %></td>
 </tr>
<tr>
    <td nowrap>文件大小：</td><td nowrap><%if(big>0)out.print(big+"字节"); %></td>
</tr>
<tr>
     <td nowrap>备注：</td><td nowrap><%if(doobj.getRemark()!=null)out.print(doobj.getRemark()); %></td>
</tr>
<tr>
      <td nowrap>关键字：</td><td nowrap><%if(doobj.getKeyword()!=null)out.print(doobj.getKeyword()); %></td>
</tr>
<tr>
       <td nowrap>文件下载：</td><td nowrap><%if(doobj.getFileold()!=null)out.print("<a href =\"/jsp/include/DownFile.jsp?uri="+doobj.getFileurl()+"&name="+doobj.getFileold()+"\">"+doobj.getFileold()+"</a><br>"); %></td>
 </tr>
 <tr>
       <td nowrap>创建人：</td><td nowrap><%=doobj.getMember() %></td>
 </tr>
 <tr>
       <td nowrap>创建时间：</td><td nowrap><%=doobj.getTimes() %></td>
 </tr>
 <tr>
       <td nowrap>修改人：</td><td nowrap><%if(doobj.getMemberamend()!=null & doobj.getMemberamend().length()>0){out.print(doobj.getMemberamend());}else{out.print("暂无");} %></td>
 </tr>
 <tr>
       <td nowrap>修改时间：</td><td nowrap><%if(doobj.getTimeamend()!=null){out.print(doobj.getTimeamend());}else{out.print("暂无");} %></td>
 </tr>
</table>

<input type="button" value="返回" onclick="location='/jsp/admin/sales/document.jsp'">

</body>
</html>



