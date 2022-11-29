<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.women.*"%>
<%@page import="java.io.File"%>
<%@page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
    
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String cid = teasession.getParameter("cid");
Contributions cobj = Contributions.find(cid);
String nexturl = teasession.getParameter("nexturl");

int donationmethods = -1;
int isinvoice=1;
Date paytimes = new Date();
Date financetime = new Date();
Date receipttime = new Date();
if(cobj.isExist()){
	donationmethods = cobj.getDonationmethods();
	isinvoice = cobj.getIsinvoice();
	paytimes = cobj.getPaytimes();
	financetime=cobj.getFinancetime();
	receipttime=cobj.getReceipttime();
}


%>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<link href="/tea/ym/skin/bluebar/ymPrompt.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script type="text/javascript" language="javascript" src="/tea/ym/ymPrompt.js"></script> 
<script src="/tea/Calendar.js" type="text/javascript"></script>

<title>管理员添加捐款人详细信息</title>
</head>

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
    		 alert('请填写支付宝姓名/名称');
    		 form1.name.focus();
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
	}
	ymPrompt.win({message:'<br><center>信息提交中...</center>',title:'',width:'300',height:'50',titleBar:false});
    
		
      document.getElementById("fhid").disabled=true;
      document.getElementById("tjid").disabled=true;
	form1.submit();
}
//
function f_dm(){
	if(form1.donationmethods.value==4){
		document.getElementById('dmnameid').style.display='';
	}else{
		document.getElementById('dmnameid').style.display='none';
		form1.dmname.value='';
	}
}
function f_cur()
{
	if(form1.currency.value==1){
		document.getElementById("currencynameid").style.display='';
	}else{
		document.getElementById("currencynameid").style.display='none';
		form1.currencyname.value='';
	}
}

function f_isinvoice()
{
	if(form1.isinvoice.value==2){
		document.getElementById("xid").style.display='';
		
	}else
	{
		document.getElementById("xid").style.display='none';
		
	}
}
</script>
<body id="bodynone">
  <h1>管理员添加捐款人详细信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>捐赠者基本信息</h2>
  <form action="/servlet/EditContributions" name="form1" method="POST" enctype="multipart/form-data" >
  <input type="hidden" name="act" value="EditContributionsDetails"/>
  <input type="hidden" name="nexturl" value="<%=nexturl %>"/>
  <input type="hidden" name="cid" value="<%=cid %>"/>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td align="right">类型</td>
      <td><select name="cidtype">
      		<%
      			for(int i=1;i<Contributions.CID_TYPE.length;i++){
      				out.print("<option value="+i);
      				if(cobj.getCidtype() == i){
      					out.print(" selected ");
      				}
      				out.print(">"+Contributions.CID_TYPE[i]);
      				out.print("</ption>");
      			}
      		%>
      </select></td>
    </tr>
    
    <tr>
       <td align="right">是否要发票：</td>
      <td class="td02">
      	<select name="isinvoice"  onchange="f_isinvoice();" > 
      		<option value="1" <%if(isinvoice==1)out.print(" selected "); %>>否</option>
      		<option value="2" <%if(isinvoice==2)out.print(" selected "); %>>是</option>
      	</select>
      </td>
    </tr>
       <tbody  id ="xid" <%if(isinvoice==1)out.print(" style=display:none"); %>>
    <tr>
      <td align="right">支付宝姓名/名称：</td>
      <td><input type="text" name="name" value="<%=cobj.getNULL(cobj.getName()) %>"/></td>
    </tr>
    <tr>
      <td align="right">手机号：</td>
      <td><input type="text" name="mobile" value="<%=cobj.getNULL(cobj.getMobile()) %>"/></td>
    </tr>
     <tr>
      <td align="right">发票抬头：</td>
      <td><input type="text" name="invoice" value="<%=cobj.getNULL(cobj.getInvoice()) %>"/></td>
    </tr>
      <tr>
      <td align="right">收件人姓名：</td>
      <td class="td03"><input type="text" name="recipientname" value="<%=cobj.getNULL(cobj.getRecipientname()) %>"/></td>
    </tr>

    
      <td align="right">邮寄地址：</td>
      <td><textarea rows="2" cols="40" name="address"><%=cobj.getNULL(cobj.getAddress()) %></textarea></td>
    </tr>
    <tr>
      <td align="right">邮编：</td>
      <td><input type="text" name="zip" value="<%=cobj.getNULL(cobj.getZip()) %>"/></td>
    </tr>
    </tbody>
</table>

<h2>捐赠者详细信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td align="right">汇款单登记日期：</td>
      <td>
      
       <%=new tea.htmlx.TimeSelection("paytimes", paytimes,true,true) %>
       
       </td>
    </tr>
    
    <tr>
      <td align="right">财务登记日期：</td>
      <td>
      <%=new tea.htmlx.TimeSelection("financetime", financetime,true,true) %>
       </td>
    </tr>
    <tr>
      <td align="right">捐赠方式：</td>
      <td>
      		<select name="donationmethods" onChange="f_dm();">
      			<option value="">-支付方式-</option>
				<%
					for(int i=0;i<Contributions.DONATION_METHODS.length;i++){
						out.print("<option value="+i);
						if(donationmethods==i){
							out.print(" selected "); 
						}
						out.print(">"+Contributions.DONATION_METHODS[i]);
						out.print("</option>"); 
					}
				%>      		
      		</select>&nbsp;<span id="dmnameid" <%if(cobj.getDonationmethods()!=4){out.print(" style=display:none");} %>>
      		<input type="text" name="dmname" value="<%=cobj.getNULL(cobj.getDmname()) %>"/></span>
      </td>
    </tr>
     <tr>
      <td align="right"><font color="red"><b>捐赠金额：</b></font></td>
      <td><input type="text" name="paymoney" value="<%if(cobj.getPaymoney()!=null)out.print(cobj.getPaymoney()); %>"/>&nbsp;
      	币种：<select name="currency" onChange="f_cur();"><%
      	for(int i=0;i<Contributions.CURRENCY_TYPE.length;i++){
      		out.print("<option value="+i);
      		if(cobj.getCurrency()==i){
      			out.print(" selected ");
      		}
      		out.print(">"+Contributions.CURRENCY_TYPE[i]);
      		out.print("</option>");
      	}
      %></select>&nbsp;<span id="currencynameid" <%if(cobj.getCurrency()!=1){out.print("style=display:none");} %>>
      <input type="text" name="currencyname" value="<%=cobj.getNULL(cobj.getCurrencyname()) %>"/></span></td>
    </tr>
    <tr>
      <td align="right">捐赠要求：</td>
      <td><textarea rows="4" cols="60" name="donation_requested"><%=cobj.getNULL(cobj.getDonation_requested()) %></textarea></td>
    </tr>
    <tr>
      <td align="right">指定地点：</td>
      <td><input type="text" name="designated_place" value="<%=cobj.getNULL(cobj.getDesignated_place()) %>"></td>
    </tr>
    <tr>
      <td align="right">冠名要求：</td>
      <td><input type="text" name="naming_requirements" value="<%=cobj.getNULL(cobj.getNaming_requirements()) %>"></td>
    </tr>
    <tr>
      <td align="right">捐赠收据编号：</td>
      <td><input type="text" name="receiptno" value="<%=cobj.getNULL(cobj.getReceiptno()) %>"></td>
    </tr>
    <tr>
      <td align="right">收据开具日期：</td>
      <td>
       <%=new tea.htmlx.TimeSelection("receipttime", receipttime,true,true) %>
       
       </td>
    </tr>
    <tr>
      <td align="right">是否邮寄：</td>
      <td>
      <%
      	for(int i=0;i<Contributions.WHETHERTHEMAIL_TYPE.length;i++){
      		out.print("<input type=radio name=whetherthe_mail value="+i);
      		if(cobj.getWhetherthe_mail()==i){
      			out.print(" checked ");
      		}
      		out.print(">&nbsp;"+Contributions.WHETHERTHEMAIL_TYPE[i]);
      	}
      %>
      </td>
    </tr>
    <tr>
      <td align="right">是否退信：</td>
      <td>
      <%
      	for(int i=0;i<Contributions.WHETHERTHEMAIL_TYPE.length;i++){
      		out.print("<input type=radio name=bounce value="+i);
      		if(cobj.getBounce()==i){
      			out.print(" checked ");
      		}
      		out.print(">&nbsp;"+Contributions.WHETHERTHEMAIL_TYPE[i]);
      	}
      %>
      </td>
    </tr>

</table>
<h2>落实情况</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td align="right">落实时间：</td>
      <td>
      	<input id="implementationtimes" name="implementationtimes" size="7"  value="<%if(cobj.getImplementationtimes()!=null)out.print(cobj.sdf.format(cobj.getImplementationtimes())); %>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.implementationtimes');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.implementationtimes');" />
       </td>
    </tr>
   
    <tr>
      <td align="right">落实地点：</td>
      <td>
     	 省-县：<input type="text" name="imp_ddress_city" value="<%=cobj.getNULL(cobj.getImp_ddress_city()) %>"/>
     	 村：<input type="text" name="imp_ddress_village" value="<%=cobj.getNULL(cobj.getImp_ddress_village()) %>"/>
      	</td>
    </tr>
     <tr>
      <td align="right">回馈情况：</td>
      <td>
     	<textarea rows="4" cols="60" name="feedback"><%=cobj.getNULL(cobj.getFeedback()) %></textarea>
      	</td>
    </tr>
    <!-- 
    <tr>
      <td align="right">上传图片：</td>
      <td>
     	图片名称：<input type="text" name="imgname" value="<%=cobj.getNULL(cobj.getImgname()) %>"/><br/><br/>
     	图片路径：<input type="file" name="imgpath" value=""/>
     	<%
     	long len_img = 0;
     	if(cobj.getImgpath()!=null){
     		len_img = new File(application.getRealPath(cobj.getImgpath())).length();
     	}
      if(len_img> 0)
      {
        out.print("<a href='"+cobj.getImgpath()+"' target='_blank'>查看原图&nbsp;("+len_img +"Bytes)</a>");
        out.print("<input id='checkbox' type='checkbox' name='clear_imgpath' onclick='form1.imgpath.disabled=this.checked'>清空");
      }
      %>
      	</td>
    </tr>
     -->
</table>
<h2>备 注</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td align="right">备注信息：</td>
      <td>
      <textarea rows="5" cols="60" name="remarks"><%=cobj.getNULL(cobj.getRemarks()) %></textarea>
      	</td>
    </tr>
    </table>
<br/>
<input type="button" value="提交" id="tjid" onClick="f_sub();">&nbsp;
<input type="button" value="返回" id="fhid" onClick="history.go(-1);">
  </form>

  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>