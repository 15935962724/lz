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
<title>客户还款管理</title>
</head>
<body id="bodynone">
<script type="">
function f_m()
{
   var rs = window.showModalDialog('/jsp/erp/RepaymentShow.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:657px;dialogHeight:405px;');
}
function f_d()
{
   var rs = window.showModalDialog('/jsp/erp/RepaymentShow2.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:657px;dialogHeight:405px;');
}
function f_h()
{
   var rs = window.showModalDialog('/jsp/erp/EditRepayment.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:657px;dialogHeight:405px;');
}
</script>
  <h1>客户还款管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form accept="?" name="form2">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>客户名称:&nbsp;<input type="text" name="" value=""/></td>


<td><input type="submit" value="查询"/></td>
  </tr>

</table>
</form>
<h2>列表(1)</h2>
  <form action="?" name="form1" method="POST">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>客户名称</td>
      <td nowrap>欠款金额</td>
      <td nowrap>操作</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center">北京怡康科技有限公司</td>
      <td align="center">1600.00元</td>
      <td align="center"><input type="button" value="欠款货物明细" onclick="f_m();">&nbsp;
        <input type="button" value="打款明细" onclick="f_d();">&nbsp;
        <input type="button" value="还款" onclick="f_h();"></td>
    </tr>
  </table>

  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
