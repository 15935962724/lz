<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String pkorder = teasession.getParameter("pkorder");
PackageOrder pobj = PackageOrder.find(pkorder);


%>
<html>
<head>
<title>订单付费方式选择</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script>
window.name='tar';
function f_zx()
{
	form1.act.value='zx';
	form1.submit();
}
function f_xx()
{
	form1.act.value='xx';
	form1.submit();
}

</script>

<h1>订单付费方式选择</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form action="/jsp/general/subscribe/PackageOrder3.jsp" name="form1" method="POST"  target="tar"  >

<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="pkorder" value="<%=pkorder %>"/>  
<input type="hidden" name="act" >  
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap align="right">订单号:</td>
       <td><%=pkorder %></td>
	</tr>
	<tr> 
       <td nowrap align="right">下单时间:</td>
       <td><%=pobj.getOrderstimeToString() %></td>
    </tr> 
	<tr>
       <td nowrap align="right">套餐价格:</td>
       <td >￥<%=pobj.getMarketprice() %>&nbsp;/&nbsp;＄<%=pobj.getPromotionsprice() %></td>
	</tr>
	<tr>
       <td nowrap align="right">套餐备注说明:</td>
       <td><%=pobj.getRemarks() %></td>
    </tr>
    <tr>
    	<td align="center" colspan="2"><input type="button" value="在线付费" onclick="f_zx();"></td>
    </tr>

    			<tr>
    				<td nowrap align="right">银行转账:</td>
    				<td>
    				  户　名：人民网发展有限公司<br/>开户行：中国农业银行北京水碓西里支行<br/>账　号：02136598545697458<br/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td nowrap align="right">邮局汇款:</td>
    				<td>收款人：北京科技有限公司<br/>地　址：北京市海淀区上地<br/>邮　编：100100</td>
    			</tr>
    			<tr>
    				<td nowrap align="right">汇款提示:</td>
    				<td>务必在汇款的附言或备注上填写：<br/>1、括号内的订单号（20100503000010）<br/>2、括号内的用户名（admin）</td>
    			</tr>
    			<tr>
    				<td></td>
    				<td>若未注明订单号和用户名，我们将无法及时为您开通权限.</td>
    			</tr>
    		    <tr>
    				<td align="center" colspan="2"><input type="button" value="线下支付"  onclick="f_xx();"></td>
   				 </tr>

  </table>

</form>
</body>
</html>
