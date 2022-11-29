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




%>
<html>
<head>
<title>订单生效管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script>
function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("checkbox_id");
	var lname=""; 
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=true; 
	}   
	}else{
	   for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=false; 
	   } 
	}
}
//手动生效
function f_sx()
{
	 if(confirm('您确定执行[手动生效]的操作?'))
	    {
	    }	
}
//撤销
function  f_cx()
{
	 if(confirm('您确定执行[撤销手动生效]的操作?'))
	    {
	    }
}
</script>

<h1>订单生效管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>订单生效查询</h2>
<form action="?" name="form1" method="POST" >

<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr>
       <td nowrap>订单编号：</td>
       <td nowrap><input type="text" name="" value=""/></td>
       <td nowrap>下单用户：</td>
       <td nowrap><input type="text" name="" value=""/></td>
       <td nowrap>下单时间：</td>
       <td nowrap> 
	       	从&nbsp;
	        <input id="time_c" name="time_c" size="7"  value="" readonly="readonly">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7"  value="" readonly="readonly">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
	    </td>
	 </tr>
	 <tr>
	    <td nowrap>付款方式：</td>
	    <td>
	    	<select name="">
	    		<option value="">--全部--</option>
	    		<option value="">--支付宝--</option>
	    		<option value="">--易支付--</option>
	    	</select>
	    </td>
 
	      
	  
	    	<td><input type="button" value="查询"/></td>
    </tr>
   
  </table> 
</form>
  
  <form action="?" name="form2" method="POST" >
  <h2>订单生效列表</h2>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
	   	<td colspan="20">
	   		<input type="button" value="手动生效"   onclick="_Setshoudong(this)">&nbsp;
	   		<input type="button" value="撤销手动生效" onclick="f_cx();">&nbsp;
	   		<input type="button" value="导出Excel"/>&nbsp;
	   	</td>
   </tr>
   <tr id=tableonetr>
      <td width=1><input type="checkbox" name="checkall" onclick="CheckAll()" /></td>
      <td nowrap>订单编号</td>
       <td nowrap>下单时间</td>
       <td nowrap>下单用户</td>
       <td nowrap>套餐名称</td>

       <td nowrap>付款状态</td>
        <td nowrap>付款方式</td>
       <td nowrap>生效状态</td>

       <td nowrap>手动生效操作人</td>
       <td nowrap>手动付款操作时间</td>
       <td nowrap>操作</td>
    </tr>
    
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
        <td width=1><input type="checkbox" name="checkbox_id" value="1"/></td>
    	<td>20100503000011</td>
    	<td>2010-5-3 19:48:50</td>
    	<td>admin</td>
    	<td>2010年年度套餐</td>

    	<td>已付款</td>
    	<td>支付宝</td>
    	<td>已生效</td>

    	<td></td>
    	<td></td>
    	<td><a href="/jsp/general/subscribe/PaymentOrdersShow.jsp?act=EO" target="_self">查看</a></td>
    </tr>
     <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
    	  <td width=1><input type="checkbox" name="checkbox_id" value="2"/></td>
    	<td>20100503000012</td>
    	<td>2010-5-3 19:48:50</td>
    	<td>admin</td>
    	<td>2010年年度套餐</td>

    	<td>已付款</td>
    	<td>支付宝</td>
    	<td>已生效</td>

    	<td></td>
    	<td></td>
    	<td><a href="/jsp/general/subscribe/PaymentOrdersShow.jsp?act=EO" target="_self">查看</a></td>
    </tr>
         <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
    	  <td width=1><input type="checkbox" name="checkbox_id" value="3"/></td>
    	<td>20100503000013</td>
    <td>2010-5-3 19:48:50</td>
    	<td>admin</td>
    	<td>2010年年度套餐</td>
    	<td>已付款</td>
    	<td>支付宝</td>
    	<td>已生效</td>

    	<td></td>
    	<td></td>
    	<td><a href="/jsp/general/subscribe/PaymentOrdersShow.jsp?act=EO" target="_self">查看</a></td>
    </tr>
    </table>
 
</form>
</body>
</html>
