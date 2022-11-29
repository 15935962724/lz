<%@page import="tea.entity.SeqTable"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="tea.entity.member.*" %>
<%@ page import="tea.entity.integral.*"%>
<jsp:directive.page import="java.math.BigDecimal"/>
<jsp:directive.page import="java.net.URLEncoder"/>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  out.println("您还没有登录，系统不能处理您的信息.<a href=\"###\" onclick=\"parent.ymPrompt.close();\" >关闭</a> ");
  return;
}


int gid= 0;
 
if(teasession.getParameter("gid")!=null && teasession.getParameter("gid").length()>0)
{
	gid = Integer.parseInt(teasession.getParameter("gid"));  
} 
IntegralPrize obj = IntegralPrize.find(gid);
String member = teasession.getParameter("member");
Profile pobj = Profile.find(member);


if("POST".equals(request.getMethod()))
{
	String phone = teasession.getParameter("phone");
	String address= teasession.getParameter("address");
	String consignee = teasession.getParameter("consignee");
	  
		String pro = teasession.getParameter("city1");
		String zip = teasession.getParameter("zip");
    
		java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yyyyMMdd");
		String orderid  = "WST"+ymd.format(new Date()) + SeqTable.getSeqNo("IntegralChange");
		
		
    IntegralChange.create(null,teasession._strCommunity,member,String.valueOf("/"+gid+"/"),new Date(),
    		null,obj.getShop_integral(),1,null,phone,address,consignee,orderid,0,member,pro,zip);
    
    IntegralPrize ipobj = IntegralPrize.find(gid);
    ipobj.setCstype(ipobj.getCstype()+1);  
    
    
    //发送短信
    String mtext = "恭喜您已手机在线兑换成功，您订单号："+orderid+"，我们将在两个工作日内发货，请注意查收";
    SMSMessage.create(teasession._strCommunity,member,Profile.find(member).getMobile(),teasession._nLanguage,mtext);
    
    
    out.println("恭喜您已手机在线兑换成功，您订单号："+orderid+"，我们将在两个工作日内发货，请注意查收");
    
   // out.println("<script>");
   // out.println("ymPrompt.win({message:'<br><br><br><center>您的积分兑换商品成功.<br>请等待工作人员审核...</center>',height:150,width:250,btn: ['OK'],closeBtn:false,handler:function (){parent.ymPrompt.close();}});");
  ////  out.println("</script>");
    return;     
}





float  myintegral=pobj.getMyintegral()+10000;
float  shop_integral= ((Integer)obj.getShop_integral()).floatValue();





float in = IntegralChange.getIntegral(member,teasession._strCommunity);

myintegral = myintegral-in;

float surintegral = myintegral-shop_integral;
  

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js"></script>
<script src="/tea/city.js"></script>

 
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head> 
<%
if(myintegral<shop_integral)
{
	//积分不够	


%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"> 
<tr><td>您的积分不足</td></tr>
<tr><td>您的总积分是：<%=myintegral %></td></tr>
<tr><td>需要兑换积分：<%=shop_integral %></td></tr>
<tr><td>兑换后剩余积分：<%=surintegral %></td></tr>
<tr><td align="center"><input type="button" value="关闭" onClick="parent.ymPrompt.close();" /></td></tr>
</table>

<%
	return;
}
%>

<script>
	function f_sub()
	{
		if(form1.consignee.value=='')
		{
	
			ymPrompt.win({message:'<br><br><br><center>联系人不能为空</center>',height:150,width:250,btn: ['OK'],closeBtn:false,handler:function (){form1.consignee.focus();}});
			return false;
		}
		if(form1.phone.value=='')
		{
		
			ymPrompt.win({message:'<br><br><br><center>联系电话不能为空</center>',height:150,width:250,btn: ['OK'],closeBtn:false,handler:function (){form1.phone.focus();}});
			return false;
		}
		if(form1.zip.value=='')
		{
		
			ymPrompt.win({message:'<br><br><br><center>邮编不能为空</center>',height:150,width:250,btn: ['OK'],closeBtn:false,handler:function (){form1.zip.focus();}});
			return false;
		}
		if(form1.city0.value=='')
		{
			
	   	 ymPrompt.win({message:'<br><br><br><center>现通讯地址省份不能为空</center>',height:150,width:250,btn: ['OK'],closeBtn:false,handler:function (){form1.city0.focus();}});
			
			return false;
		}
		
		if(form1.city1.value=='')
		{
			ymPrompt.win({message:'<br><br><br><center>现通讯地址市区不能为空</center>',height:150,width:250,btn: ['OK'],closeBtn:false,handler:function (){form1.city1.focus();}});
			
			return false;
		}
		
		
		if(form1.address.value=='')
		{
		
			ymPrompt.win({message:'<br><br><br><center>现通讯详细地址不能为空</center>',height:150,width:250,btn: ['OK'],closeBtn:false,handler:function (){form1.address.focus();}});
			
			return false;
		}
	

	}
</script>
<body bgcolor="#ffffff" class="pop_up">
<h1>商品积分兑换</h1>
<form action="?" method="POST"  name="form1" onSubmit="return f_sub();">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>

<input type="hidden" name="act" value="integralprize"/>
<input type="hidden" name="gid" value="<%=gid%>">
<input type="hidden" name="member" value="<%=member%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"> 

<tr><td colspan="10">请您确认兑换"<%=obj.getShopping() %>"并填写必要送货信息</td></tr>
<tr><td colspan="10"><%=member %>&nbsp;您的总积分是：<%=pobj.getMyintegral() %>&nbsp;&nbsp;需要兑换积分：<%=obj.getShop_integral() %>&nbsp;&nbsp;兑换后剩余积分：<%=pobj.getMyintegral()-((Integer)obj.getShop_integral()).floatValue() %></td></tr>
<tr><td align="right" nowrap><font color=red>*</font>联系人：</td><td><input type="text"   name="consignee" value="<%=pobj.getFirstName(teasession._nLanguage) %>"/></td></tr>
<tr><td align="right" nowrap><font color=red>*</font>联系电话：</td><td><input type="text"    name="phone" value="<%=pobj.getMobile()%>"/></td></tr>
<tr><td align="right" nowrap><font color=red>*</font>邮编：</td><td  nowrap>
<input type="text" name="zip" value="<%=pobj.getZip(teasession._nLanguage) %>">
</td> 

<tr><td align="right" nowrap><font color=red>*</font>现通讯地址：</td><td  nowrap>
	<script>mt.city("city0","city1",null,'<%=pobj.getProvince(teasession._nLanguage) %>');</script><input type="text"    name="address" value="<%=pobj.getAddress(teasession._nLanguage) %>"/></td></tr>


 

<tr><td colspan="2" align="center"><input type="submit" value="提交" /> <input type="button" value="返回" onClick="history.go(-1);" /></td></tr>

</table>
</form>
</body>
</html>

