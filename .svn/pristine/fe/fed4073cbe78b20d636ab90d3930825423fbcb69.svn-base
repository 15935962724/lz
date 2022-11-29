<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
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




String nexturl = request.getRequestURL() + "?"+ request.getContextPath();

int potype =0;//判断是付款管理 还是生效管理 0 付款管理 ，1 生效管理
if(teasession.getParameter("potype")!=null && teasession.getParameter("potype").length()>0)
{
	potype = Integer.parseInt(teasession.getParameter("potype"));
}


StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
param.append("&potype=").append(potype);

String postr ="订单付款";
if(potype==1)//生效订单 不能显示未付款的订单
{
	sql.append(" and type=1 ");
	postr="订单生效";
}

//订单编号
String porderid = teasession.getParameter("porderid");
if(porderid!=null && porderid.length()>0)
{
	porderid = porderid.trim();
	sql.append(" and pkorder = ").append(DbAdapter.cite(porderid));
	param.append("&porderid=").append(porderid);
}
//下单用户
String member = teasession.getParameter("member");
if(member!=null &&member.length()>0 )
{
	member = member.trim();
	sql.append(" and member like ").append(DbAdapter.cite("%"+member+"%"));
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}  
//下单时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{

  sql.append(" AND orderstime >=").append(DbAdapter.cite(PackageOrder.sdf2.parse(time_c+" 00:00")));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND orderstime <=").append(DbAdapter.cite(PackageOrder.sdf2.parse(time_d+" 23:59")));
  param.append("&time_d=").append(time_d);
}

//付款方式
int paymanner = 0;
if(teasession.getParameter("paymanner")!=null && teasession.getParameter("paymanner").length()>0)
{
	paymanner = Integer.parseInt(teasession.getParameter("paymanner"));
}
if(paymanner>0)
{
	sql.append(" and paymanner = ").append(paymanner);
	param.append("&paymanner=").append(paymanner);
}
//是否需要发票

int whethermail =-1;
if(teasession.getParameter("whethermail")!=null && teasession.getParameter("whethermail").length()>0)
{
	whethermail = Integer.parseInt(teasession.getParameter("whethermail"));
}
if(whethermail>=0)
{
	sql.append(" and whethermail = ").append(whethermail);
	param.append("&whethermail=").append(whethermail);
}
//发票开具状态
int issued =-1;
if(teasession.getParameter("issued")!=null && teasession.getParameter("issued").length()>0)
{
	issued = Integer.parseInt(teasession.getParameter("issued"));
}
if(issued>=0)
{
	sql.append(" and issued = ").append(issued);
	param.append("&issued=").append(issued);
}

//手动付款操作人 paymentmember 
String paymentmember = teasession.getParameter("paymentmember");
if(paymentmember!=null &&paymentmember.length()>0 )
{
	paymentmember = paymentmember.trim();
	sql.append(" and paymentmember like ").append(DbAdapter.cite("%"+paymentmember+"%"));
	param.append("&paymentmember=").append(URLEncoder.encode(paymentmember,"UTF-8"));
}

//手动付款操作时间：paymenttime
String time_c2 = teasession.getParameter("time_c2");
if(time_c2!=null && time_c2.length()>0)
{
  sql.append(" AND paymenttime >=").append(DbAdapter.cite(PackageOrder.sdf2.parse(time_c2+" 00:00")));
  param.append("&time_c2=").append(time_c2);
}
String time_d2 = teasession.getParameter("time_d2");
if(time_d2!=null && time_d2.length()>0)
{
  sql.append(" AND paymenttime <=").append(DbAdapter.cite(PackageOrder.sdf2.parse(time_d2+" 23:59")));
  param.append("&time_d2=").append(time_d2);
}
 

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = PackageOrder.count(teasession._strCommunity,sql.toString());

sql.append(" order by orderstime desc ");



  
   

%>
<html>
<head>
<title><%=postr %>管理</title>
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
//点击手动付款
	var str = "";
	document.writeln("<div id=\"_contents\" style=\"padding:6px; background-color:#E3E3E3; font-size: 12px; border: 1px solid #777777;  position:absolute; left:?px; top:?px; width:?px; height:?px; z-index:1; visibility:hidden\">");
	    str += '<select id="paymanner" name="paymanner">';

	    str += '<option value="1">管理员激活</option>';
	    str += '<option value="2">在线支付</option>';
	    str += '<option value="3">邮局汇款</option>';
	    str += '<option value="4">银行转账</option>';

		str += '</select>&nbsp;';
		str += '<input  type="button" onclick="_Determine()" value="确定" style="font-size:12px" >&nbsp;';
		str += '<input  type="button" onclick="_Cancel()" value="取消" style="font-size:12px" >'; 
		str += '</div>';
	document.writeln(str);
	var _fieldname;

function _Setshoudong(tt) {
	
    _fieldname = tt;
    var ttop = tt.offsetTop;    //TT控件的定位点高
    var thei = tt.clientHeight;    //TT控件本身的高
    var tleft = tt.offsetLeft;    //TT控件的定位点宽
    while (tt = tt.offsetParent) {
        ttop += tt.offsetTop;
        tleft += tt.offsetLeft;
    }
    document.all._contents.style.top = ttop + thei + 4;
    document.all._contents.style.left = tleft;
    document.all._contents.style.visibility = "visible";
}

//手动生效管理

function _Setshoudong2()
{
	//判断是否选中手动付款的记录
	  var ch = form1.checkbox_id;
	  var porders ="/";
	if((ch.length+"")=="undefined")    
	{
	 		if(!ch.checked)
	 		{
	 			alert("您还没有选中订单信息!");
				return false;
	 	 	}else 
	 	 	{
	 	 	  form1.porders.value=porders+form1.checkbox_id.value+"/";
		 	}

	 		
	 }else
	 {
		  
		    var f = false;
		  
		    for (var i=0; i< ch.length; i++)
		    {
		      if (form1.checkbox_id[i].checked)
		      {
		    	  porders = porders+form1.checkbox_id[i].value+"/";
			      f = true;
			     
			  }
		    }
		  
		    form1.porders.value=porders;

		    if(!f)
		    {
				alert("您还没有选中订单信息!");
				return false;
		    }
	 }

	if(confirm('您确定执行【手动生效】的操作?'))
    {
		var str_url = "?act=_Setshoudong2&porders="+form1.porders.value
	    sendx("/jsp/general/subscribe/subscribe_ajax.jsp"+str_url,
	      		 function(data)
	      		 { 
	 		 		alert(data);
	 		 		window.location.reload();
	      		 }
	      	);
    }


	 
}


function _Determine()
{
	//判断是否选中手动付款的记录
	  var ch = form1.checkbox_id;
	    var porders ="/";
	if((ch.length+"")=="undefined")    
	{
 	 		if(!ch.checked)
 	 		{
 	 			alert("您还没有选中订单信息!");
				return false;
 	 	 	}else 
	 	 	{
 		 	 	  form1.porders.value=porders+form1.checkbox_id.value+"/";
 			 	}
 	 		
 	 }else
 	 {
		    var f = false;
		
		    for (var i=0; i< ch.length; i++)
		    {
		      if (form1.checkbox_id[i].checked)
		      {
		    	  porders = porders+form1.checkbox_id[i].value+"/";
			      f = true;
			     
			  }
		    }
		    form1.porders.value=porders;

		    if(!f)
		    {
				alert("您还没有选中订单信息!");
				return false;
		    }
 	 }
	var paym  = document.getElementById("paymanner");
	

	var str_url = "?act=_Determine&porders="+form1.porders.value+"&paymanner="+paym.value
    sendx("/jsp/general/subscribe/subscribe_ajax.jsp"+str_url,
      		 function(data)
      		 {
 		 		alert(data);
 		 		window.location.reload();
      		 }
      	);

    //document.all._contents.style.visibility = "hidden";
}
function _Cancel()
{
	 document.all._contents.style.visibility = "hidden";
}
//发票开具状态

var fp_str = "";
	document.writeln("<div id=\"_contents_fp\" style=\"padding:6px; background-color:#E3E3E3; font-size: 12px; border: 1px solid #777777;  position:absolute; left:?px; top:?px; width:?px; height:?px; z-index:1; visibility:hidden\">");
	fp_str += '<select name="issued" id="issued">';

	fp_str += '<option value="1">已开具</option>';
	fp_str += '<option value="0">未开具</option>';


	fp_str += '</select>&nbsp;';
	fp_str += '<input  type="button" onclick="_Determine_fp()" value="\u786e\u5b9a" style="font-size:12px" >&nbsp;';
	fp_str += '<input  type="button" onclick="_Cancel_fp()" value="取消" style="font-size:12px" >'; 
	fp_str += '</div>';
	document.writeln(fp_str);
	var _fieldname_fp;
function _Setfpkjzt(tt)
{
	_fieldname_fp = tt;
	    var ttop = tt.offsetTop;    //TT控件的定位点高
	    var thei = tt.clientHeight;    //TT控件本身的高
	    var tleft = tt.offsetLeft;    //TT控件的定位点宽
	    while (tt = tt.offsetParent) {
	        ttop += tt.offsetTop;
	        tleft += tt.offsetLeft;
	    }
	    document.all._contents_fp.style.top = ttop + thei + 4;
	    document.all._contents_fp.style.left = tleft;
	    document.all._contents_fp.style.visibility = "visible";
}
function _Determine_fp()
{

	
	//判断是否选中手动付款的记录
	  var ch = form1.checkbox_id;
	   var porders ="/";
	if((ch.length+"")=="undefined")    
	{
	 		if(!ch.checked)
	 		{
	 			alert("您还没有选中订单信息!");
				return false;
	 	 	}else 
	 	 	{
		 	 	  form1.porders.value=porders+form1.checkbox_id.value+"/";
			}
	 		
	 }else
	 {
		    var f = false;
		 
		    for (var i=0; i< ch.length; i++)
		    {
		      if (form1.checkbox_id[i].checked)
		      {
		    	  porders = porders+form1.checkbox_id[i].value+"/";
			      f = true;
			     
			  }
		    }
		    form1.porders.value=porders;

		    if(!f)
		    {
				alert("您还没有选中订单信息!");
				return false;
		    }
	 }
	var issued  = document.getElementById("issued");
	

	var str_url = "?act=_Determine_fp&porders="+form1.porders.value+"&issued="+issued.value
  sendx("/jsp/general/subscribe/subscribe_ajax.jsp"+str_url,
    		 function(data)
    		 {
		 		alert(data);
		 		window.location.reload();
    		 }
    	);
}
function _Cancel_fp()
{
	 document.all._contents_fp.style.visibility = "hidden";
}
//撤销手动付款

function  f_cx()
{
	  	var ch = form1.checkbox_id;
	 	  var porders ="/";
		if((ch.length+"")=="undefined")    
		{
	 	 		if(!ch.checked)
	 	 		{
	 	 			alert("您还没有选中订单信息!");
					return false;
	 	 	 	}else 
		 	 	{
			 	 	  form1.porders.value=porders+form1.checkbox_id.value+"/";
				}
	 	 		
	 	 }else
	 	 { 
			    var f = false;
			    var porders ="/";
			    for (var i=0; i< ch.length; i++)
			    {
			      if (form1.checkbox_id[i].checked)
			      {
			    	  porders = porders+form1.checkbox_id[i].value+"/";
				      f = true;
				     
				  }
			    }
			    form1.porders.value=porders;

			    if(!f)
			    {
					alert("您还没有选中订单信息!");
					return false;
			    }
	 	 }
	
	if(confirm('您确定执行【撤销手动付款】的操作?'))
    {
		var str_url = "?act=revocation&porders="+form1.porders.value
	    sendx("/jsp/general/subscribe/subscribe_ajax.jsp"+str_url,
	      		 function(data)
	      		 {
	 		 		alert(data);
	 		 		window.location.reload();
	      		 }
	      	);
    }
}
//撤销手动生效

function  f_cx2()
{
	  	var ch = form1.checkbox_id;
	 	  var porders ="/";
		if((ch.length+"")=="undefined")    
		{
	 	 		if(!ch.checked)
	 	 		{
	 	 			alert("您还没有选中订单信息!");
					return false;
	 	 	 	}else 
		 	 	{
			 	 	  form1.porders.value=porders+form1.checkbox_id.value+"/";
				}
	 	 		
	 	 }else
	 	 { 
			    var f = false;
			    var porders ="/";
			    for (var i=0; i< ch.length; i++)
			    {
			      if (form1.checkbox_id[i].checked)
			      {
			    	  porders = porders+form1.checkbox_id[i].value+"/";
				      f = true;
				     
				  }
			    }
			    form1.porders.value=porders;

			    if(!f)
			    {
					alert("您还没有选中订单信息!");
					return false;
			    }
	 	 }
	
	if(confirm('您确定执行【撤销手动生效】的操作?'))
    {
		var str_url = "?act=f_cx2effect&porders="+form1.porders.value
	    sendx("/jsp/general/subscribe/subscribe_ajax.jsp"+str_url,
	      		 function(data)
	      		 {
	 		 		alert(data);
	 		 		window.location.reload();
	      		 }
	      	);
    }
}

function f_excel()
{
	form1.action ="/servlet/EditPackageOrderExcel";
	form1.submit();
}
</script>

<h1><%=postr %>管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2><%=postr %>查询</h2>
<form action="?" name="form1" method="GET" >
 
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="porders"> 
<input type="hidden" name="sql" value="<%=sql.toString() %>"/>
<input type="hidden" name="files" value="订单付款列表信息"/>
<input type="hidden" name="act" value="PaymentOrders"/>
<input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>  
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr>
       <td nowrap>订单编号：</td>
       <td nowrap><input type="text" name="porderid" value="<%if(porderid!=null)out.print(porderid); %>"/></td>
       <td nowrap>下单用户：</td>
       <td nowrap><input type="text" name="member" value="<%if(member!=null)out.print(member); %>"/></td>
       <td nowrap>下单时间：</td>
       <td nowrap> 
	       	从&nbsp; 
	        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
	    </td>
	 </tr>
	 <tr>
	    <td nowrap>付款方式：</td>
	    <td>
	    	<select name="paymanner">
	    	<option value="0">--全部--</option>
	    	<%
	    		for(int i =1;i<PackageOrder.PAYNAME_TYPE.length;i++)
	    		{
	    			out.print("<option value= "+i);
	    			if(paymanner == i)
	    			{
	    				out.print(" selected ");
	    			}
	    			out.print(">"+PackageOrder.PAYNAME_TYPE[i]);
	    			out.print("</option>");
	    		}
	    	%>
	    	
	    	</select>
	    </td>
 <%if(potype==0){ %>
	        <td nowrap>是否需要发票：</td>
		    <td>
		    	<select name="whethermail">
		    		<option value="-1">--全部--</option>
		    		<%
		    		for(int i =0;i<PackageOrder.WHETHERMAIL_TYPE.length;i++)
		    		{
		    			out.print("<option value= "+i);
		    			if(whethermail == i)
		    			{
		    				out.print(" selected ");
		    			}
		    			out.print(">"+PackageOrder.WHETHERMAIL_TYPE[i]);
		    			out.print("</option>");
		    		}
	    	%>
		    	</select>
		    </td>
		     <td nowrap>发票开具状态：</td>
		    <td>
		    	<select name="issued">
		    		<option value="-1">--全部--</option>
		    		<%
		    		for(int i =0;i<PackageOrder.ISSUED_TYPE.length;i++)
		    		{
		    			out.print("<option value= "+i);
		    			if(issued == i)
		    			{
		    				out.print(" selected ");
		    			}
		    			out.print(">"+PackageOrder.ISSUED_TYPE[i]);
		    			out.print("</option>");
		    		}
	    	%>
		    	</select>
		    </td>
	    </tr>
	    
	    <tr>
		   <td nowrap>手动付款操作人：</td>
	       <td nowrap><input type="text" name="paymentmember" value="<%if(paymentmember!=null)out.print(paymentmember); %>"/></td>
		     <td nowrap>手动付款操作时间：</td>
	       <td nowrap> 
		       	从&nbsp;
		        <input id="time_c2" name="time_c2" size="7"  value="<%if(time_c2!=null)out.print(time_c2); %>" readonly="readonly">
		        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c2');" />
		        &nbsp;到&nbsp;
		        <input id="time_d2" name="time_d2" size="7"  value="<%if(time_d2!=null)out.print(time_d2); %>" readonly="readonly">
		        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d2');" />
		    </td>
	  <%} %>
	    	<td><input type="button" value="查询" onclick="form1.action='?';form1.submit();"></td>
    </tr>
   
  </table> 

  

  <h2><%=postr %>列表</h2>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
	   	<td colspan="20">
	   	<%if(potype==0){ %>
	   		<input type="button" value="手动付款"   onclick="_Setshoudong(this)">&nbsp;
	   		<input type="button" value="撤销手动付款" onclick="f_cx();">&nbsp;
	   		<input type="button" value="修改发票开具状态" onclick="_Setfpkjzt(this)">&nbsp;
	   		<%}else if(potype==1){ %>
		   		<input type="button" value="手动生效"   onclick="_Setshoudong2()">&nbsp;
		   		<input type="button" value="撤销手动生效" onclick="f_cx2();">&nbsp;
	   		<%} %>
	   		<input type="button" value="导出Excel" onclick="f_excel();">&nbsp;
	   	</td>
   </tr>
   <tr id=tableonetr>
      <td width=1><input type="checkbox" name="checkall" onclick="CheckAll()" /></td>
      <td nowrap>订单编号</td>
       <td nowrap>下单时间</td>
       <td nowrap>下单用户</td>
       <td nowrap>套餐名称</td>
       <td nowrap>套餐价格</td>
       <td nowrap>付款状态</td>
       <td nowrap>付款方式</td>
       
       <%if(potype==0){ %>
           <td nowrap>付款时间</td>
	       <td nowrap>需要开票</td>
	       <td nowrap>发票开具状态</td>
	       <td nowrap>手动付款操作人</td>
	       <td nowrap>手动付款操作时间</td>
       <%}else if(potype==1){ %>
	         <td nowrap>生效状态</td>
		     <td nowrap>手动生效操作人</td>
		     <td nowrap>手动生效操作时间</td>
       <%} %>
       <td nowrap>操作</td>
    </tr>
    <%

	java.util.Enumeration e = PackageOrder.find(teasession._strCommunity,sql.toString(),pos,pageSize);

    if(!e.hasMoreElements())
    {
        out.print("<tr><td colspan=20 align=center>暂无订单</td></tr>");
    }
	  for(int i =1;e.hasMoreElements();i++)
	  {
		  String porder = ((String)e.nextElement());
		  PackageOrder pobj = PackageOrder.find(porder);
    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
        <td width=1><input type="checkbox" name="checkbox_id" value="<%=porder %>"/></td>
    	<td><%=porder %></td>
    	<td><%=pobj.getOrderstimeToString() %></td>
    	<td><%=pobj.getMember() %></td>
    	<td><%=pobj.getSname() %></td>
    	<td>￥<%=pobj.getMarketprice() %>&nbsp;/&nbsp;＄<%=pobj.getPromotionsprice() %></td>
    	<td><%if(pobj.getType()==0){out.print("<font color=red>未付款</font>");}else if(pobj.getType()==1){out.print("已付款");} %></td>
    	<td><%if(pobj.getType()==1){out.print(pobj.getPayname());} %></td>
    	<%
    		if(potype==0)
    		{
    	%>
	    	<td><%if(pobj.getType()==1){out.print(pobj.getPaytimeToString());} %></td>
	    	<td><%=pobj.WHETHERMAIL_TYPE[pobj.getWhethermail()] %></td>
	    	<td><%=pobj.ISSUED_TYPE[pobj.getIssued()] %></td>
	    	<td><%if(pobj.getPaymentmember()!=null){out.print(pobj.getPaymentmember());} %></td>
	    	<td><%if(pobj.getPaymenttime()!=null){out.print(pobj.getPaymenttimeToString());} %></td>
    	<%} else if(potype==1){%>
    		<td><%if(pobj.getEffect()==0){out.print("<font color=red>"+pobj.EFFECT_TYPE[pobj.getEffect()]+"</font>");}else{out.print(pobj.EFFECT_TYPE[pobj.getEffect()]);} %></td>
    		<td><%if(pobj.getEffectmember()!=null)out.print(pobj.getEffectmember());%></td>
    		<td><%if(pobj.getEffecttime()!=null)out.print(pobj.getEffecttimeToString());%></td>
    	<%} %>
    	<td><a href="/jsp/general/subscribe/PaymentOrdersShow.jsp?porder=<%=porder %>" target="_self">查看</a></td>
    </tr>
    
    <%
    	}
	%>
	 <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
    </table>
 
</form>
</body>
</html>
