<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
/*
if(node.isCreator(teasession._rv))
{
  response.sendRedirect("/servlet/Node?node=" + teasession._nNode);
  return;
}
*/
r.add("/tea/ui/node/access/RequestAccess");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script></head>
<body>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>
<%
if(AccessRequest.isAccessRequest(teasession._nNode,teasession._rv))
{
  out.print(r.getString(teasession._nLanguage,"InfRequested"));
}else
{
  Enumeration e = AccessPrice.find(teasession._nNode);
  if(!e.hasMoreElements())
  {
	  out.print(r.getString(teasession._nLanguage,"请设置节点价格"));
  }
  while(e.hasMoreElements())
  {
    int i = ((Integer) e.nextElement()).intValue();
    BigDecimal bigdecimal = AccessPrice.find(teasession._nNode,i).getPrice();
    out.print(new Anchor("/servlet/PayAccess?node=" + teasession._nNode + "&Currency=" + i + "&Price=" + bigdecimal,new Text(RequestHelper.format(r.getString(teasession._nLanguage,"InfPay"),r.getString(teasession._nLanguage,Common.CURRENCY[i]) + bigdecimal))));
    out.print("<br/>");
  }
}
%>
<!--
<input type="button" name="" onclick="location='RequestAccess2.jsp?node=<%=teasession._nNode%>'" value="发送请求" >
  ::　您没有权限访问该页，<a href="mailto:yuguangtao@officebill.net">请与管理员联系</a>！　::-->

</td></tr></table>

<div id="language"><%=new Languages(teasession._nLanguage,request)%></div></DIV>
</body>
</html>
