<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%@page import="jxl.*"%><%@page import="java.io.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String nexturl=request.getRequestURI()+request.getContextPath();//request.getParameter("nexturl");
String act="jituanyonghu";//request.getParameter("act");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.file.focus();">

<h1>导入骨科网医生信息Excel</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form NAME="form1" target="CR_ImportPreview" ACTION="/jsp/admin/import/CrImportPreview.jsp?community=<%=teasession._strCommunity%>" enctype="multipart/form-data" METHOD="post" onSubmit="return submitText(this.file,'无效-文件');">
  <input type="hidden" name="act" value="<%=act%>"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">

<h2>上传文件</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>Excel文件:</td>
    <td><input type="file" name="file" ></td>
    <td><input type="submit" value="预览" >
    <input type="submit" name="import" value="导入">

    </td>
  </tr>
</table>
<br>

<h2>导入预览</h2>
<iframe src="about:blank" name="CR_ImportPreview" width=90% height=400px frameborder="1" ></iframe>

</FORM>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td>注:</td></tr>
  <tr><td>1.第一行 和 第一列 不被导入</td></tr>
</table>

</body>
</HTML>

