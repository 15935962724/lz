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

String porder =teasession.getParameter("porder");
PackageOrder pobj = PackageOrder.find(porder);


%>
<html>
<head>
<title>订单详细信息查看</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<h1>订单详细信息查看</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"> 
   <tr>
       <td nowrap align="right">订单编号：</td>
       <td nowrap><%=porder %></td>
   </tr>
   <tr>
   		<td  nowrap align="right">下单时间：</td>
   		<td nowrap><%=pobj.getOrderstimeToString() %></td>
   </tr>
   <tr>
   		<td  nowrap align="right">下单用户：</td>
   		<td nowrap><%=pobj.getMember() %></td>
   </tr>
   <tr>
        <td  nowrap align="right">套餐名称：</td>
        <td nowrap><%=pobj.getSname() %></td>
   </tr>
      
   <tr>
        <td  nowrap align="right">套餐价格：</td>
        <td nowrap>￥<%=pobj.getMarketprice() %> / ＄<%=pobj.getPromotionsprice() %></td>
   </tr>
   <tr>
          <td  nowrap align="right">付款状态：</td>
          <td nowrap><%if(pobj.getType()==0){out.print("<font color=red>未付款</font>");}else if(pobj.getType()==1){out.print("已付款");} %></td>
   </tr>
   <tr>
        <td  nowrap align="right">付款方式：</td>
        <td nowrap><%if(pobj.getType()==1){out.print(pobj.getPayname());} %></td>
   </tr>
   <tr>
         <td  nowrap align="right">付款时间：</td>
         <td nowrap><%if(pobj.getType()==1){out.print(pobj.getPaytimeToString());} %></td>
   </tr>
   <tr>
        <td  nowrap align="right">需要开票：</td>
        <td nowrap><%=pobj.WHETHERMAIL_TYPE[pobj.getWhethermail()] %></td>
   </tr>
   <tr>
        <td  nowrap align="right">发票开具状态：</td>
        <td nowrap><%=pobj.ISSUED_TYPE[pobj.getIssued()] %></td>
   </tr>
    <tr>
        <td  nowrap align="right">生效状态：</td>
        <td nowrap><%=pobj.EFFECT_TYPE[pobj.getEffect()]%></td>
   </tr>
     <tr>
        <td  nowrap align="right">手动付款操作人：</td>
        <td nowrap><%if(pobj.getPaymentmember()!=null)out.print(pobj.getPaymentmember());%></td>
   </tr>
   
     <tr>
        <td  nowrap align="right">手动付款操作时间：</td>
        <td nowrap><%if(pobj.getPaymenttime()!=null)out.print(pobj.getPaymenttimeToString());%></td>
   </tr>
      <tr>
        <td  nowrap align="right">手动生效操作人：</td>
        <td nowrap><%if(pobj.getEffectmember()!=null)out.print(pobj.getEffectmember());%></td>
   </tr>
   
     <tr>
        <td  nowrap align="right">手动生效操作时间：</td>
        <td nowrap><%if(pobj.getEffecttimeToString()!=null)out.print(pobj.getEffecttimeToString());%></td>
   </tr>
   

 
</table>
 <br/>
 <input type="button" value="　返回 　" onclick="history.back();">

</body>
</html>
