<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");

String nexturl=request.getParameter("nexturl");

String q=request.getParameter("q");

StringBuilder sql=new StringBuilder();
if(q!=null)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+q+"%"));
}

Resource r=new Resource();

int j=CioCompany.count(teasession._strCommunity,sql.toString());

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
<body id="tes_body">
<h1>本企业参会信息管理5</h1>
<div id="tes_body02">
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<div id="content_all02">
<div id="content_01">
中国核工业集团公司，参会负责人您好：</div>
<div id="content_02">您的企业还没有提交参会报名表<br/>
请马上提交参会报名表！</div>
<div id="content_04"><img src="/res/cavendishgroup/u/0810/081059187.gif"></div>
<div  id="tablebottom_002">
如遇问题请马上联系<br/>010-61392325！
</div>
</div>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</div>
</body>
</html>
