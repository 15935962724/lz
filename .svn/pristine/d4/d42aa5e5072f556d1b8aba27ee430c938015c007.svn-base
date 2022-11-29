<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%@page import="jxl.*"%><%@page import="java.io.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String nexturl=teasession.getParameter("nexturl");
String act="importprofile9000";

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<script>


function f_sub()
{
	
	if(form1.file.value=="")
	{
		alert("请上传导入文件");
		return false;
	}
	form1.submit();
}
</script>
<body onLoad="form1.file.focus();" id="bodynone">

<h1>导入会员</h1>
<div id="head6"><img height="6" src="about:blank"></div>

 
<FORM NAME="form1" target="CR_ImportPreview" ACTION="/jsp/user/WestracMemberImportsData.jsp" enctype="multipart/form-data" METHOD="post" onSubmit="return submitText(this.file,'无效-文件');">
 
  <input type="hidden" name="act" value="<%=act%>"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  
    

<h2>上传文件</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD>Excel文件:</TD>
    <TD><input type="file" name="file" ></TD>
    <TD><input type="submit" value="预览" >
    <input type="submit" name="import" value="导入">
    <input type="button" name="Download" value="下载模板" onclick="window.open('/jsp/user/GolfTemplate.xls','CR_ImportPreview');">
    <input type="button" value="取消" onClick="window.close();">
    </TD>
  </tr>
</table>
<br>

<h2>导入预览</h2>
<iframe src="about:blank" name="CR_ImportPreview" width=90% height=350px frameborder="1" ></iframe>

</FORM>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR><TD>注：1.第一行 和 第一列 不被导入</TD></tr>

</table>

</body>
</html>
