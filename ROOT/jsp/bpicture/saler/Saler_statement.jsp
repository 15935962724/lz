<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.db.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.math.BigDecimal" %>
<%
TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

int cwid=0;
if(teasession.getParameter("cwid")!=null && teasession.getParameter("cwid").length()>0)
{
  cwid = Integer.parseInt(teasession.getParameter("cwid"));
  Bimage.enterPrice(cwid,teasession._rv.toString());
}
Bprice priceobj=Bprice.find(teasession._rv.toString());

BigDecimal salesun= new BigDecimal(0);
salesun=Bimage.countSumMoney(" and  member='"+teasession._rv.toString()+"'  ");//销售总额:

BigDecimal salejzye= new BigDecimal(0);
BigDecimal saleyongjin= salesun.multiply((new BigDecimal(0.6))).setScale(2,BigDecimal.ROUND_HALF_UP);//佣金
BigDecimal saleshouyi= salesun.multiply((new BigDecimal(0.4))).setScale(2,BigDecimal.ROUND_HALF_UP);//共计付款给您:

BigDecimal saleyezj= new BigDecimal(0); //结转余额
//BigDecimal saleyezj=  priceobj.getPrice().add(saleshouyi);//结转余额
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title>帐户余额</title>
  <style>
  #table002 td{background:#eee;border-bottom:1px solid #ccc;height:30px;padding-top:6px;padding-bottom:6px;}
  #table002{width:95%;padding:6px;margin-top:20px;}
  #table006 td{background:#F6F6F6;border-bottom:5px solid #eee;height:30px;}
  #table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:5px 10px;}
  </style>
</HEAD>
<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;帐户余额</div>
<h1>
帐户余额
</h1>
<form action="">


<table border="0" cellpadding="0" cellspacing="0" id="table002">
<tr>
<td align="left">账户名称:<%=teasession._rv.toString()%></td><td>&nbsp;</td>
</tr>
</table>
<table width="95%" border="0" cellpadding="0" cellspacing="0" id="table006">
<tr>
<td width="15%">&nbsp;</td>
<td width="70%" align="center">总结发言期间 2008年11月01日 至 2008年11月05日</td>
<td width="15%" align="right">&nbsp;</td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="2" id="table005">
<tr>
<td width="20%" >结转余额:</td>
<td  align="right" ><%=saleyezj%></td>

</tr>
<tr>
<td>销售总额:</td>
<td align="right" ><%=salesun%>元</td>
</tr>
<tr>
<td>佣金/收费:</td>
<td align="right" ><%=saleyongjin%>元</td>
</tr>
<tr>
<td>共计付款给您:</td>
<td align="right" ><%=saleshouyi%>元</td>
</tr>
<tr>
<td >余额结转:</td>
<td align="right"><%=salesun.multiply((new BigDecimal(0.4))).setScale(2,BigDecimal.ROUND_HALF_UP)%></td>
</tr>
<tr>
<td>清除差额:</td>
<td align="right" >0.00</td>
</tr>
<tr>
<td>下一步付款日期:</td>
<td align="right">
				不是预定的
	  </td>
</tr>
</table>
<!--table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr valign="top">
<th>日期</th>
<th>说明</th>
<th>B-picture裁判</th>
<th>详情</th>
<th>借记卡 ($)</th>
<th>信用 ($)</th>
<th>差额 ($)</th>
<th>支付 <span class="red">*</span></th>
</tr>
<tr align="right" valign="top">
<td align="center"></td>
<td align="left">Balance brought forward</td>
<td align="center"></td>
<td align="left"></td>
<td ></td>
<td ></td>
<td >0.00</td>
<td align="center" ></td>
</tr>
</table-->
</form>
</div>
</body>
</html>
