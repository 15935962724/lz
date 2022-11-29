<%@page contentType="text/html;charset=UTF-8" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
String name=request.getParameter("name");
String community=request.getParameter("community");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
function fupdate()
{
//
var obj=document.getElementById("history");
sendx("/servlet/Msn;jsessionid=<%=session.getId()%>?name=<%=name%>&community=<%=community%>",function(data){ obj.innerHTML=data; self.scrollBy(0,10240);} );
//setInterval(fupdate(),20000);
}
</script>
</head>
<body onload="setInterval('fupdate()',5000);" onunload="sendx('/servlet/Msn?logout=On&community=<%=community%>&name=<%=name%>');top.opener=null;top.close();" onbeforeunload="return '';" >
<div id="history"></div>
<!-- table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>
</td>
</tr>
</table-->
</body>

