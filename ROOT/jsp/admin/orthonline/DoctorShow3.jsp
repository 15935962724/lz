<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);




%>
<script>
function f_p(igd)
{
  window.returnValue=igd;
  window.close();
}

</script>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>骨科医生登记表</title>
</head>

<body id="bodynone2">
<span id="p4">恭喜你成功提交登记表!</span>
<input id="p2" type="button" value="打印"  onClick="f_p('1');">&nbsp;
<input id="p1" type="button" value="导出并另存为"  onClick="f_p('2');">&nbsp;
<input id="p3" type="button" value="返回"  onClick="f_p('3');">


</body>
</html>
