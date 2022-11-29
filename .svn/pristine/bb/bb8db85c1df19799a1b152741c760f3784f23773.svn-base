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

Resource r=new Resource();

int cccount=CioCompany.count(teasession._strCommunity," AND time IS NOT NULL");
int cpcount=CioPart.count(teasession._strCommunity,"");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_action(act,ccid)
{
  form1.ciocompany.value=ccid;
  form1.act.value=act;
  form1.submit();
}
</script>
</head>
<body id="tes_body">
<h1>本企业参会信息管理</h1>
<div id="tes_body02">
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<div id="content_all04">
<div id="content_01">
本次会议已收到报名企业<%=cccount%>家 参会人员<%=cpcount%>人：</div>
<table border="0" cellspacing="0" cellpadding="0" id="content_03">
  <tr id="tablecon_tr02">
    <td>查看已报名的企业及及报名表详细信息</td>
    <td>安排参会人员的接送服务</td>
  </tr>
   <tr id="tablecon_tr01">
    <td><a href="/jsp/cio/OkCioCompany.jsp"><img src="/res/cavendishgroup/u/0810/081059194.gif"></a></td>
    <td><a href="/jsp/cio/EditShuttleCioPart.jsp"><img src="/res/cavendishgroup/u/0810/081059195.gif"></a></td>
  </tr>
   <tr id="tablecon_tr02">
    <td>安排参会人员的住宿</td>
    <td>安排参会人员的座席</td>
  </tr>
  <tr id="tablecon_tr01">
    <td><a href="/jsp/cio/CioMeetingyapfan.jsp"><img src="/res/cavendishgroup/u/0810/081059196.gif"></a></td>
    <td><a href="/jsp/cio/OkCioCompany2.jsp?type=seat"><img src="/res/cavendishgroup/u/0810/081059197.gif"></a></td>
  </tr>
     <tr id="tablecon_tr02">
    <td>参会人员报到登记，已报到未报到查询。</td>
    <td>参会人员查询，导出及个别信息变更。</td>
  </tr>
   <tr id="tablecon_tr01">
    <td><a href="/jsp/cio/OkCioCompany2.jsp?type=bd"><img src="/res/cavendishgroup/u/0810/081059200.gif"></a></td>
    <td><a href="/jsp/cio/OkCioCompany3.jsp"><img src="/res/cavendishgroup/u/0810/081059198.gif"></a></td>
  </tr>
    </tr>
     <tr id="tablecon_tr02">
    <td>VIP会员设置及查询管理</td>
    <td>统计参会企业的问卷调查信息</td>
  </tr>
   <tr id="tablecon_tr01">
    <td><a href="/jsp/cio/OkCioCompany2.jsp?type=vip"><img src="/res/cavendishgroup/u/0810/081059201.gif"></a></td>
    <td><a href="/jsp/cio/CioPolls.jsp"><img src="/res/cavendishgroup/u/0810/081059199.gif"></a></td>
  </tr>
</table>
<div  id="tablebottom_0002">如操作中需到问题<br/>
请查看系统帮助或联系 010-61392325
</div>
</div>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</div>
</body>
</html>
