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
<title>客户退货单管理</title>
</head>
<body id="bodynone">
  <h1>客户退货单管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form accept="?" name="form2">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>退货日期:&nbsp;从&nbsp;
      <input name="time_k" size="7"  value=""><A href="###"><img onclick="showCalendar('form2.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
      <input name="time_j" size="7"  value=""><A href="###"><img onclick="showCalendar('form2.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    </td>

    <td>退货人:&nbsp;<input type="text" name="" value=""/></td>
    <td>退货仓库:<select name="">
<option>----------</option>
<option>北京仓库</option>
</select> </td>

    <td><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>
<h2>列表(1)</h2>
  <form action="?" name="form1" method="POST">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>退货客户</td>
      <td nowrap>退货单号</td>
      <td nowrap>退货日期</td>
      <td nowrap>退货人</td>
      <td nowrap>退货仓库</td>
      <td nowrap>退货数量</td>
      <td nowrap>操作</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center">北京怡康科技有限公司</td>
      <td align="center"><a href="#">20090414002</a></td>
      <td align="center">2009-04-14</td>
      <td align="center">李先生</td>
      <td align="center"><a href="#">北京仓库</a></td>
      <td align="center">10</td>
      <td align="center"><a href="#">编辑</a>&nbsp;<a href="#">删除</a> </td>
    </tr>
  </table>
  <br />
<input type="button" value="添加客户退货单" onclick="window.open('/jsp/erp/EditClientReturned.jsp?nexturl=<%=nexturl%>','_self');"/>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
