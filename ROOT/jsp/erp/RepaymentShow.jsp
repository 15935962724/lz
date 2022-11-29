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
<title>客户欠款货物明细单</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >


<div id="lzi_rkd">
  <h1>客户欠款货物明细单</h1>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td >客户名称：</td>
      <td >
      北京怡康科技有限公司
      </td>

    </tr>

  </table>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td align="center" nowrap>商品名称</td>
      <td align="center" nowrap>品牌</td>
      <td align="center" nowrap>提货人</td>
      <td align="center" nowrap>经办人</td>
      <td align="center" nowrap>提货日期</td>
      <td align="center" nowrap>进价</td>
      <td align="center" nowrap>数量</td>
      <td align="center" nowrap>金额</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>左旋C美白霜</td>
      <td>奥瑞拉</td>
      <td>张先生</td>
      <td>管理员</td>
      <td>2009-04-14</td>
      <td>600.00</td>
      <td>100</td>
      <td>60000&nbsp;元</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>顶级左旋C美白纯精素</td>
      <td>奥瑞拉</td>
      <td>张先生</td>
      <td>管理员</td>
      <td>2009-04-13</td>
      <td>200.00</td>
      <td>100</td>
      <td>20000&nbsp;元</td>
    </tr>

    <tr>
      <td colspan="4">&nbsp;</td>
      <td align="center">合计:</td>
      <td>200</td>
      <td>80000&nbsp;元</td>
    </tr>

  </table>


</div>

<br>
<input type="button" value="关闭"  onClick="javascript:window.close();">
</body>
</html>
