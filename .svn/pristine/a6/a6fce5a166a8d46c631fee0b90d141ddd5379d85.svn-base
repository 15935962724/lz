<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.women.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
    
if("POST".equals(request.getMethod()))
{
	BigDecimal paymoney = new BigDecimal("0.00");
	if(teasession.getParameter("paymoney")!=null && teasession.getParameter("paymoney").length()>0){
		paymoney = new BigDecimal(teasession.getParameter("paymoney"));
	}
	//是否要发票
	int isinvoice =Integer.parseInt(teasession.getParameter("isinvoice"));
	
	String name = teasession.getParameter("name");
	String mobile=teasession.getParameter("mobile");
	String invoice = teasession.getParameter("invoice");
	String address = teasession.getParameter("address");
	String zip = teasession.getParameter("zip");
	//收件人地址 
	String recipientname = teasession.getParameter("recipientname"); 
	
	java.text.SimpleDateFormat sdf = new  java.text.SimpleDateFormat("yyyyMMdd");
	java.util.Date timestring = new java.util.Date(); 
	String cid = sdf.format(timestring)+session.getId().substring(0,4) + tea.entity.SeqTable.getSeqNo("contributionsid");
	Contributions.create(cid,name,mobile,invoice,address,zip,teasession._strCommunity,paymoney,0,0,isinvoice,recipientname); 
	 
	out.println("<script type=\"text/javascript\" src=\"/tea/ym/ymPrompt.js\"></script>");
	out.println("<link rel=\"stylesheet\" id='skin' type=\"text/css\" href=\"/tea/ym/skin/bluebar/ymPrompt.css\" />");
	out.println("<script>");
	//out.println("alert('aaa');");
	out.println("ymPrompt.win({message:'<br><center>信息已经提交成功,正转向支付...</center>',title:'',width:'300',height:'50',titleBar:false});");
	out.println("setTimeout(\"window.location.href='/jsp/pay/alipay/index.jsp?cid="+cid+"'\", 2000);");
	out.println("</script>");   
	
}

%>


<script>
function f_sub()
{
	if(form1.paymoney.value=='')
    	{
    		 alert('请填写您要捐款数额');
    		 form1.paymoney.focus();
    		 return false;
    	}else
    	{
    		//showTooltips(null,'只能输入数字');
    		if(isNaN(form1.paymoney.value))
    		{
    			 alert('您输入的捐款数额不正确，请重新输入');
	    		 form1.paymoney.focus();
	    		 return false;
    		}
    	
    	}
	
	if(form1.isinvoice.value==2){
	
			if(form1.name.value=='')
		    	{
		    		 alert('支付宝姓名');
		    		 form1.name.focus();
		    		 return false;
		    	}
			if(form1.mobile.value=='')
		    	{
		    		alert('请填写手机号');
		    		form1.mobile.focus();
		    		return false;
		    	}else
		    	{ 
		    		 var reg=/(^[0-9]{3,4}\-[0-9]{7,8}$)|(^[0-9]{7,8}\-[0-9]{3,4}$)|(^[0-9]{7,15}$)/;
					   if(!reg.test(form1.mobile.value))
					   {
						   alert('手机号格式填写错误');
						   form1.mobile.focus()
		    				return false;
					    	
					   }
		    	}
			
			if(form1.invoice.value==''){
				alert('请填写发票抬头');
				form1.invoice.focus();
				return false;
			}
			if(form1.recipientname.value==''){
				alert('请填写收件人姓名');
				form1.recipientname.focus();
				return false;
			}
			
			
			if(form1.address.value==''){
				alert('请填写邮寄地址');
				form1.address.focus();
				return false;
			}
			
			
			if(form1.zip.value=='')
		    	{
		    		alert('请填写邮编');
		    		form1.zip.focus();
		    		return false;
		    	}else
		    	{
		    		 var reg=/^\d{6}$/;
					   if(!reg.test(form1.zip.value))
					   {
						  alert('邮编格式填写错误');
						  form1.zip.focus();
		    				return false; 
					    
					   }
		    	}
			
			f_submit();
	}else{
		form1.submit();
	}
}

function f_isinvoice()
{
	if(form1.isinvoice.value==2){
		document.getElementById("xid").style.display='';
		document.getElementById("buttonid").style.display='none';
	}else
	{
		document.getElementById("xid").style.display='none';
		document.getElementById("buttonid").style.display='';
	}
}

//确认信息
function f_submit()
{
	var is = '是';
	if(form1.isinvoice.value==1){
		is='否';
	} 
    	var html = '<form  action="?" method="POST" >';
    	html +='<input type="hidden" name="paymoney" value="'+form1.paymoney.value+'">';
    	html +='<input type="hidden" name="isinvoice" value="'+form1.isinvoice.value+'">';
    	html +='<input type="hidden" name="name" value="'+form1.name.value+'">';
    	html +='<input type="hidden" name="mobile" value="'+form1.mobile.value+'">';
    	html +='<input type="hidden" name="invoice" value="'+form1.invoice.value+'">';
    	html +='<input type="hidden" name="recipientname" value="'+form1.recipientname.value+'">';
    	html +='<input type="hidden" name="address" value="'+form1.address.value+'">';
    	html +='<input type="hidden" name="zip" value="'+form1.zip.value+'">';
  
    	
    	html +='<table border="1" cellpadding="0" cellspacing="0" id="tablecenter2">';

    	html +='<tr><td>请输入您要捐款数额：</td><td>'+form1.paymoney.value+'</td></tr>';
    	html +='<tr><td>是否要发票：</td><td>'+is+'</td></tr>';
    	html +='<tr><td>支付宝姓名：</td><td>'+form1.name.value+'</td></tr>';
    	html +='<tr><td>手机号：</td><td>'+form1.mobile.value+'</td></tr>';
    	html +='<tr><td>发票抬头：</td><td>'+form1.invoice.value+'</td></tr>';
    	html +='<tr><td>收件人姓名：</td><td>'+form1.recipientname.value+'</td></tr>';
    	html +='<tr><td>邮寄地址：</td><td>'+form1.address.value+'</td></tr>';
    	html +='<tr><td>邮编：</td><td>'+form1.zip.value+'</td></tr>';
    	
    	html +='</table>';

    	html +='<input type="submit"  value="提交" >';

		

    	html +='</form>';
    	ymPrompt.win({message:html,title:'确认信息捐款信息',msgCls:'customCls',closeBtn:true,width:500,height:300});
}



</script>
<script type="text/javascript" src="/tea/ym/ymPrompt.js"></script>
<link href="/tea/ym/skin/bluebar/ymPrompt.css" rel="stylesheet" type="text/css"/>

  <form action="?" name="form1" method="POST">
  <style>
  #tablecenter2{width:400px;margin:0 auto;}
  #tablecenter2 td{font-size:12px;padding:5px;}
  .juankuan{text-align:center;}
  </style>
  <div class="juankuan">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter2">
     <tr>
      <td class="td01" style="text-align:right;" nowrap="nowrap">请输入您要捐款数额：</td>
      <td class="td02"><input type="text" name="paymoney" value=""/>&nbsp;元&nbsp; <input id="buttonid" type="button" value="捐赠" onclick="f_sub();"></td>
    </tr>
    
     <tr>
      <td align="right">是否要发票：</td>
      <td class="td02">
      	<select name="isinvoice" onchange="f_isinvoice();"> 
      		<option value="1">否</option>
      		<option value="2">是</option>
      	</select>
      </td>
    </tr>
    <tbody  id ="xid" style="display: none;">
    
    <tr>
      <td align="right">支付宝姓名：</td>
      <td class="td02"><input type="text" name="name" value=""/></td>
    </tr> 
    <tr>
        <td align="right">&nbsp;</td>
      <td class="td02">如未开通支付宝请填写一个邮箱名或手机号</td>
    </tr>
    <tr>
      <td align="right">手机号：</td>
      <td class="td02"><input type="text" name="mobile" value=""/></td>
    </tr>
    <tr>
      <td align="right">发票抬头：</td>
      <td class="td02"><input type="text" name="invoice" value=""/></td>
    </tr>
    
     <tr>
      <td align="right">收件人姓名：</td>
      <td class="td03"><input type="text" name="recipientname" value=""/></td>
    </tr>
    <tr>
      <td align="right">邮寄地址：</td>
      <td class="td03"><textarea rows="2" cols="40" name="address"></textarea></td>
    </tr>
    <tr>
      <td align="right">邮编：</td>
      <td class="td02"><input type="text" name="zip" value=""/></td>
    </tr>
     <tr>
        <td align="right">&nbsp;</td>
      <td class="td02">个人捐款如需发票请填写以上信息，未填者将视为自动放弃。我方将按月统一开具集体捐款发票。</td>
    </tr>
    <tr>
      <td align="center" colspan=2>
      <input type="button" value="提交" onclick="f_sub();">&nbsp;<input type="reset" value="取消" ></td>
      
    </tr>
    </tbody>
</table>

</div>
  </form>

