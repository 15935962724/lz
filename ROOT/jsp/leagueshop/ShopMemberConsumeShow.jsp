<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>分店会员消费商品信息</title>
</head>
<body id="bodynone">
<h1>分店会员消费商品信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <form accept="?" name="form2">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td align="center" nowrap>商品编号</td>
      <td align="center" nowrap>商品名称</td>
      <td align="center" nowrap>规格型号</td>
      <td align="center" nowrap>商品品牌</td>
      <td align="center" nowrap>商品单价</td>
      <td align="center" nowrap>商品备注</td>
      <td align="center" nowrap>商品数量</td>
      <td align="center" nowrap>消费金额</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center" nowrap>SP01-01</td>
      <td align="center">迷迭香</td>
       <td align="center">ML</td>
      <td align="center">奥瑞拉</td>
      <td align="center">148.00&nbsp;元</td>
      <td align="center">&nbsp;</td>
      <td align="center">10</td>
      <td align="center">1480.00&nbsp;元</td>
    </tr>
    <tr>
      <td colspan="5">&nbsp;</td>
      <td align="center"><b>合计:</b></td>
      <td align="center">10</td>
      <td align="center">1000</td>
    </tr>

            </table>

  </form>
  <br />
<input type="button" value="关闭"  onClick="javascript:window.close();">
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
