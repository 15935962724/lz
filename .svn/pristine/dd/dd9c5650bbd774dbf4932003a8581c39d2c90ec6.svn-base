<%@page contentType="text/html;charset=UTF-8"%><%@page import="java.io.*" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<title>选择表情</title>
		<style type="text/css">
			<!--
body {
	background-color: #dde5fd;
	border: none;
	margin: 0px;
	padding: 0px;
}
--></style>
<script language="javascript">
function OK_onclick(src)
{
  var editor=opener.FreeTextBox1_editor;
  if(window.dialogArguments)
  {
    editor=dialogArguments.FreeTextBox1_editor;
  }
  editor.focus();
  editor.document.execCommand("InsertImage", false, src);
  window.close();
}
</script>
</head>
<body>
<table border="1" cellspacing="0" cellpadding="3" ID="Table1" style="MARGIN-TOP: 7px; BORDER-COLLAPSE: collapse" align=center>
<%
File fs[]=new File(application.getRealPath("/tea/image/face/")).listFiles();
for(int i=0;i<fs.length;i++)
{
  if(i%9==0)out.print("<tr>");
  out.print("<td><img src=/tea/image/face/"+fs[i].getName()+" border=0 onclick=OK_onclick(this.src); style=CURSOR:hand></td>");
}
%>
</table>

</body>
</html>
