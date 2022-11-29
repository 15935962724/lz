<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String menuid=request.getParameter("id");
String nexturl=request.getParameter("nexturl");

int ciocompany=-1;

CioCompany cc=CioCompany.find(ciocompany);
String name=cc.getName();
String contact=cc.getContact();
String tel=cc.getTel();
String mobile=cc.getMobile();
String email=cc.getEmail();
String remark=cc.getRemark();
String attach=cc.getAttach();


Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_action(act,ccid)
{
  switch(act)
  {
    case "go":
    form1.action="?";
    form1.method="get";
    break;
    case "delete":
    if(!confirm("确认删除?"))
    {
      return false;
    }
    break;
  }
  form1.ciocompany.value=ccid;
  form1.act.value=act;
  form1.submit();
}
</script>
</head>
<body id="qiyelog">
<img src="/res/cavendishgroup/u/0810/081059230.jpg" border="0" align="left">
</body>
</html>
