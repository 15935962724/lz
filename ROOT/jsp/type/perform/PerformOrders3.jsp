<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.math.BigDecimal"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
//if (teasession._rv == null) {
 // response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
 // return;
//}

String ordersid = teasession.getParameter("ordersid");
PerformOrders pfobj = PerformOrders.find(ordersid);
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>在线支付</title>
</head>

<script>
  function f_ft() 
  {
  /*
    var ftype = document.getElementsByName("frontreartype");
      alert(document.getElementById("ft2"));
      alert(ftype.checked);
  
  */	
       var frontreartype = form1.frontreartype.value;

		 for(var i=0;i<form1.frontreartype.length;i++)
		{
		    if(form1.frontreartype[i].checked==true)
		   {
		     frontreartype = form1.frontreartype[i].value;
		     break;
		    }
		 }
		 

	if(frontreartype==0)  
  	{
  		document.getElementById("ft2").style.display='none';
  		document.getElementById("ft0").style.display='';
  	}else if(frontreartype==2)
  	{
    	document.getElementById("ft0").style.display='none';
  		document.getElementById("ft2").style.display='';
  	}
  	 sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=f_frontreartype&ordersid="+form1.ordersid.value+"&frontreartype="+frontreartype,
		  function(data)
		  {
		  }
		  );
  	   
  	
  	
  	
  }  
</script>  
<body id="bodynone2">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<div class="bodyFramework">
   <form action="/servlet/EditPerformOrders" method="POST" name="form1">
<input type="hidden" name="ordersid" value="<%=ordersid %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">

<div class="header">
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099950.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" class="title">
  <tr>
    <td><img src="/res/REDCOME/0909/09099972.gif"></td>
    <td><img src="/res/REDCOME/0909/09099952.gif"></td>
    <td><img src="/res/REDCOME/0909/09099953.gif"></td>
    <td><img src="/res/REDCOME/0909/09099975.gif"></td>
    <td><img src="/res/REDCOME/0909/09099955.gif"></td>
  </tr>
</table>
</div>

<div class="content">
<div class="MyBooking">
    	<div class="left">订单提交成功</div>
        <div class="right"></div>
    </div>
    <div class="OrderInfCon">
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		
		<td class="td01">订单号：</td>		
        <td class="td02"><font color="red"><%=ordersid %></font></td>
        <td class="td03">请记住您的订单号，用于领取票</td>
   </tr>
	<tr>  
		      
		<td class="td01">总金额：</td>		
        <td class="td02"><font color="red">￥&nbsp;<%=pfobj.getTotalprice() %></font></td>
        <td class="td03">&nbsp;</td>
   </tr>
	</table>
    </div> 
<div class="MyBooking">
    	<div class="left2">支付方式</div>
        <div class="right2">
        <input type="radio" value="0" name="frontreartype" id="frontreartype" <%if(pfobj.getFrontreartype()==0)out.print("checked=\"checked\""); %> onClick="f_ft();">&nbsp;在线支付
        　　<input type="radio" value="2" name="frontreartype"  id="frontreartype" <%if(pfobj.getFrontreartype()==2)out.print("checked=\"checked\""); %> onClick="f_ft();">&nbsp;票送到时付款</div>
</div> 
		
		<span id="ft0" >
        <div class="top">请点击“首信易支付”进入支付通道,完成支付</div>
        <div class="top2">点击“首信易支付通道”，您将进入网上安全支付平台。按系统提示选择您持有卡的所属银行进行操作，一分钟即可完成支付。</div>
        <input type="button" value="" class="payEase"  onClick="window.open('/jsp/pay/ntcc/Send.jsp?community=<%=teasession._strCommunity %>&ordersid=<%=ordersid %>','_blank');">
        <table border="0" cellpadding="0" cellspacing="0" class="tablecenter">
        <tr><td colspan="4" class=td01>支持下列银行：</td></tr>
         <tr><td>中国工商银行</td><td>中国银行</td><td>中国建设银行</td><td>中国农业银行</td></tr>
         <tr><td>招商银行</td><td>中国邮政储蓄</td><td>中国民生银行</td><td>广东发展银行</td></tr>
         <tr><td>中信银行</td><td>兴业银行</td><td>北京银行</td><td>深圳发展银行</td></tr>
         <tr><td>深圳平安银行</td><td>交通银行</td><td>华夏银行</td><td>中国光大银行</td></tr>
         <tr><td>上海浦东发展银行</td><td>广州市商业银行</td><td>顺德信用社</td><td>广州市农村信用合作社</td></tr>
         <tr><td>上海农村商业银行</td><td>北京农村商业</td><td>银行渤海银行</td><td>国际信用卡</td></tr> 
        </table>
        
        <div class="Tips">特别提示</div>
        <div class="Tips2">
        <p><span>安全保证：</span>您在网上支付过程中，银行卡信息的填写是在各大银行的支付网关上进行的，本站不收集任何银行卡资料，所以不会出现您所担心的安全问题。</p>

		<p>目前国内各大银行的支付网关都采用国际流行的SSL或SET方式加密的。在支付过程中您可以注意到浏览器右下角会出现“<span>小锁</span>”的标记，这个标志代表您目前的所有操作都是在加密保护模式下完成的，您的任何私人信息在传送过程中都是安全的，不会被第三方窃取。</p>

<p><span>支付提示：</span>为了保障用户款项的安全，您在支付货款时请通过本站提供的支付渠道，否则后果由用户自己承担。</p></div>
        </span>
        <span id="ft2" style="display:none">您的信息我们已经记录，我们会尽快把票送到！</span>
</div>
</form>
</div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
