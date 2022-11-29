<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}





%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户还款明细单</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >


<div id="lzi_rkd">
  <h1>客户还款明细单</h1>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td >客户名称：</td>
      <td > 北京怡康科技有限公司 </td>
    </tr>
  </table>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td align="center" nowrap>经办人</td>
      <td align="center" nowrap>还款时间</td>
      <td align="center" nowrap>还款金额</td>
      <td align="center" nowrap>还款类型</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>管理员</td>
      <td>2009-04-14</td>
      <td>600.00</td>
      <td>欠款提货</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>管理员</td>
      <td>2009-04-14</td>
      <td>800.00</td>
      <td>还款</td>
    </tr>


  </table>


</div>

<br>
<input type="button" value="关闭"  onClick="javascript:window.close();">
</body>
</html>
