<%@page contentType="text/html;charset=UTF-8" %>
<%
/////////////////////////////放入购物车提示/////////////////////////////////////
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.resource.Resource r=new tea.resource.Resource();

String community=request.getParameter("community");
if(community==null)
community=node.getCommunity();
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script type="">
window.outerHeight=20;
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<table border="0" cellpadding="0" cellspacing="0" id="joinshoppingout">
  <tr>
    <td id="pingouttop"> </td></tr><tr>
    <td>
<table border="0" cellpadding="0" cellspacing="0" id="joinshopping">
  <tr>
    <td id="joinshoptop">您选购的<span>[<%=node.getSubject(teasession._nLanguage)%>]</span> 数量<span>[<%=request.getParameter("Quantity")%>] </span><span></span>
      已放入购物车！</td>
  </tr>
  <tr>
    <td id="joinshopbot"><a  href="javascript:window.open('/jsp/offer/ShoppingCarts.jsp?community=<%=community%>');window.close();" class="bag">查看购物车</a>　　<a href="javascript:window.close();" class="trade">继续选购</a></td>
  </tr>
</table>
</td>
  </tr>
</table>
</body>
</html>

