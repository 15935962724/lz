<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
    <script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js" type=""></script>

<title>
uppsuc
</title>
<script type="">
function eco(){
window.opener.location.reload();
window.close();
}
</script>
</head>
<body bgcolor="#ffffff" id="bodynone" class="register">
<h1>消息</h1>
<table id="tablecenter">

<tr><td align="center"> 该会员已被取消酒店管理员的权限！</td>
</tr>



</table>
<center>
<input align="middle" type="button" value="关闭" onclick="eco();" />
</center>
</body>
</html>
