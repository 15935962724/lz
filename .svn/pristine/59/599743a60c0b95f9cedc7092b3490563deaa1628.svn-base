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

int sid = 0;
if(teasession.getParameter("sid")!=null && teasession.getParameter("sid").length()>0)
{
	sid = Integer.parseInt(teasession.getParameter("sid"));
}

Subscribe sobj = Subscribe.find(sid);


%>
<html>
<head>
<title>电子报套餐订单确认</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script>
window.name='tar';
function f_check_1()
{
	var fp_id =document.getElementById("fp_id");
	if(form1.check_1.checked)
	{
		fp_id.style.display="";
	}else
	{
		fp_id.style.display="none";
	}
}
function f_submit()
{

	if(form1.check_1.checked)
	{
		if(form1.shoujiaren.value=='')
		{
			alert('收件人不能为空');
			form1.shoujiaren.focus();
			return false;
		}
		if(form1.dizhi.value=='')
		{
			alert('地址不能为空');
			form1.dizhi.focus();
			return false;
		}

		if(form1.youbian.value=='')
		{
			alert('邮编不能为空');
			form1.youbian.focus();
			return false;
		}else
		{
			 var iLength=form1.youbian.value.length;
		    if(6>iLength||6< iLength)
		    {
			    alert('邮政编码格式不正确');
				form1.youbian.focus();
				return false;
		    }
		}
		if(form1.dianhua.value=='')
		{
			alert('电话不能为空');
			form1.dianhua.focus();
			return false;
		}else
		{
			var string_value =form1.dianhua.value;
		    var type="^\s*[+-]?[0-9]+\s*$";
		    var re = new RegExp(type);

		    if(string_value.match(re)==null)
		    {
		       alert('电话格式不正确');
				form1.dianhua.focus();
				return false;
		    }
		}
		if(form1.fapiaotaitou.value=='')
		{
			alert('发票抬头不能为空');
			form1.fapiaotaitou.focus();
			return false;
		}

		
		
	}

	form1.action="/servlet/EditPackageOrder";
	form1.submit();
}
//放弃下单
function f_close()
{
	window.returnValue=1;
	window.close();
}
</script>

<h1>套电子报套餐订单确认</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form action="?" name="form1" method="POST"    target="tar" onsubmit="return f_submit();"  >

<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="nexturl" value="/jsp/general/subscribe/PackageOrder2.jsp"/>
<input type="hidden" name="sid" value="<%=sid %>"/>
<input type="hidden" name="act" value="PackageOrder1"/> 

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap align="right">套餐名称:</td>
       <td><%=sobj.getSubject() %></td>
	</tr>
	<tr>
       <td nowrap align="right">套餐价格:</td>
       <td >￥<%=sobj.getMarketprice() %>&nbsp;/&nbsp;＄<%=sobj.getPromotionsprice() %></td>
	</tr>
	<tr>
       <td nowrap align="right">套餐备注说明:</td>
       <td><%=sobj.getRemarks() %></td>
    </tr>
    <tr>
    	<td nowrap align="right">此订单是否需要邮寄发票</td>
    	<td><input type="checkbox" name="check_1" value="1" onclick="f_check_1();"></td>
    </tr>
    <tr id="fp_id" style="display: none">
    	<td colspan="2">
	
    		<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    			<tr>
    				<td nowrap align="right"><font color="red">*</font>&nbsp;收件人:</td>
    				<td><input type="text" name="shoujiaren" value="" size="50"></td>
    			</tr>
    			<tr>
    				<td nowrap align="right"><font color="red">*</font>&nbsp;地址:</td>
    				<td><input type="text" name="dizhi" value="" size="50"></td>
    			</tr>
    			<tr>
    				<td nowrap align="right"><font color="red">*</font>&nbsp;邮编:</td>
    				<td><input type="text" name="youbian" value="" size="50"  maxlength="6" onkeypress="return event.keyCode>47&&event.keyCode<58"></td>
    			</tr>
    			<tr>
    				<td nowrap align="right"><font color="red">*</font>&nbsp;电话:</td>
    				<td><input type="text" name="dianhua" value="" size="50"  maxlength="11" ></td>
    			</tr>
    			<tr>
    				<td nowrap align="right"><font color="red">*</font>&nbsp;发票抬头:</td>
    				<td><input type="text" name="fapiaotaitou" value="" size="50"></td>
    			</tr>
    			<tr>
    				<td nowrap align="right"><font color="red">*</font>&nbsp;发票内容:</td>
    				<td><input type="text" name="fapiaoneirong" value="订阅电子版信息服务费用" readonly="readonly" size="50"/></td>
    			</tr>
    			<tr>
    				<td nowrap align="right">备注内容:</td>
    				<td><input type="text" name="beizhushuoming" value=""  size="50"></td>
    			</tr>
    			
    			
    		</table>
    	</td>
    </tr>
  </table>
  <br/>
  <input type="submit" value="确认下单"/>&nbsp;<input type="button" value="放弃下单" onclick="f_close();">&nbsp;
</form>
</body>
</html>
