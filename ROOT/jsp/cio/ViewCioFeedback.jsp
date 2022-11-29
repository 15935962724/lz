<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
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

int ciofeedback=Integer.parseInt(request.getParameter("ciofeedback"));
int ciocompany=Integer.parseInt(request.getParameter("ciocompany"));
String ccname="--";
if(ciocompany>0)
{
  ccname=CioCompany.find(ciocompany).getName();
}
CioFeedback cf=CioFeedback.find(ciofeedback);

String content=cf.getContent();
content=content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;");

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<form name="form1" action="?" method="post" onSubmit="return submitText(this.content,'无效-意见建议')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<h1>查看意见建议</h1>
<div id="canh_ry">
<table border='0' cellpadding='0' cellspacing='0' id='canh_ry_table'>
  <tr>
    <td nowrap>企业：</td><td><%=ccname%></td>
  </tr>
  <tr>
    <td nowrap>提交人：</td><td><%=cf.getMember()%></td>
  </tr>
  <tr>
    <td nowrap>提交时间：</td><td><%=cf.getTimeToString()%></td>
  </tr>
  <tr>
    <td colspan="2"><%=content%></td>
  </tr>
 </table>
<div class="fanhui_bn"><input type="button" value="返回" onClick="history.back()"/></div>
</div>
</form>
</body>
</html>
