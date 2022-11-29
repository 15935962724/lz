<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
<%

TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("user_id");//最终用户在ASSP上的唯一用户身份ID

String appInstanceId = request.getParameter("app_instance_id");//最终用户订购ISV软件生成的唯一编码

String initType = request.getParameter("initType");//初始化信息类型

%>
<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/tea/community.css" rel="stylesheet" type="text/css">
<script LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function check(form)
{
  var initType = <%=initType%>;
  if(initType==1){
    return submitText(form.companyname,'无效-公司名称')
    &&submitText(form.comemail,'无效-公司Email')
    &&submitEmail(form.comemail,'无效-公司Email');
  }else{
    return submitText(form.proname,'无效-用户姓名')
    &&submitText(form.proemail,'无效-个人Email')
    &&submitEmail(form.proemail,'无效-个人Email');
  }
}
</script>
<title>
公司信息初始化
</title>
</head>
<body bgcolor="#ffffff">
<h1>系统初始化信息</h1>
<form name="form1" action="/SubscCtrl" onsubmit="return check(this);">
<input type="hidden" name="user_id" value="<%=userId%>"/>
<input type="hidden" name="role" value="<%=request.getParameter("role")%>"/>
<input type="hidden" name="app_instance_id" value="<%=appInstanceId%>"/>

<%if("1".equals(initType)){%>
<input type="hidden" name="act" value="company"/>
<hr />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td colspan="2">为了初始化系统，请填写公司信息！</td>
  </tr>
  <tr>
    <td width="100">公司名称：</td><td><input type="text" name="companyname"/></td>
  </tr>
  <tr>
    <td width="100">公司Email：</td><td><input type="text" name="comemail"/></td>
  </tr>
  <tr>
    <td colspan="2"><input type="submit" value="初始化公司信息"/></td>
  </tr>
</table>
<%}else{%>
<input type="hidden" name="act" value="profile"/>
<hr />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td colspan="2">为了初始化系统，请填写个人信息！</td>
  </tr>
  <tr>
    <td width="100">用户姓名：</td><td><input type="text" name="proname"/></td>
  </tr>
  <tr>
    <td width="100">个人Email：</td><td><input type="text" name="proemail"/></td>
  </tr>
  <tr>
    <td colspan="2"><input type="submit" value="初始化用户信息"/></td>
  </tr>
</table>
<%}%>
</form>
</body>
</html>
