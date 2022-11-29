<%@page import="tea.entity.Entity"%>
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

int icid=0;

if(teasession.getParameter("icid")!=null && teasession.getParameter("icid").length()>0)
{
	icid = Integer.parseInt(teasession.getParameter("icid"));  
}
IntegralChange icobj = IntegralChange.find(icid);

String nexturl = teasession.getParameter("nexturl");
String goodsname = "";
float shop_integral=0;

for(int i=1;i<icobj.getPresent().split("/").length;i++)
{
	int igid = Integer.parseInt(icobj.getPresent().split("/")[i]);
	IntegralPrize obj = IntegralPrize.find(igid);
	goodsname =goodsname+obj.getShopping();
	shop_integral =shop_integral+obj.getShop_integral();
}

String member = teasession.getParameter("member");


Profile pobj = Profile.find(member);



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js"></script>
<script src="/tea/city.js"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head> 


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
<body bgcolor="#ffffff">
<h1>商品积分兑换</h1>
<form action="/servlet/EditIntegralManage" method="POST"  name="form1" onsubmit="return f_sub();">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="integralchangeadd">
<input type="hidden" name="icid" value="<%=icid %>">
<input type="hidden" name="member" value="<%=member %>">
<input type="hidden" name="nexturl" value="<%=nexturl %>">
<input type="hidden" name="present" value="<%=icobj.getPresent() %>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"> 

<tr>
	<td align="right">用户兑换订单号：</td>
	<td><%=icobj.getOrderid() %></td>
</tr>

<tr>
	<td align="right">用户兑换的商品：</td>
	<td><%=goodsname %></td>
</tr>

<tr>
	<td align="right">兑换需要积分：</td>
	<td><%=shop_integral %></td>
</tr>

<tr>
	<td align="right"><font color=red>*</font>联系人：</td>
	<td><input type="text"   name="consignee" value="<%=Entity.getNULL(icobj.getConsignee()) %>"/></td>
</tr>
<tr>
	<td align="right">
	<font color=red>*</font>联系电话：</td>
		<td>
			<input type="text"    name="phone" value="<%=Entity.getNULL(icobj.getPhone())%>"/>
		</td>
</tr>

<tr><td align="right" nowrap><font color=red>*</font>邮编：</td><td  nowrap>
<input type="text" name="zip" value="<%=Entity.getNULL(icobj.getZip()) %>">
</td> 




 
 <tr>
	<td align="right">
	<font color=red>*</font>现通讯地址：</td>
	<td>
		<script>mt.city("city0","city1",null,'<%=icobj.getProvince() %>');</script><input type="text"    name="address" value="<%=icobj.getAddress() %>"/>
	</td>
</tr>
<%
	if(icobj.getStatics()==1){
%>
 <tr>
	<td align="right">
	<font color=red>*</font>审核状态：</td>
	<td>
	
      <input type="radio" name="statics" value="1">通过审核&nbsp;&nbsp;
      <input type="radio" name="statics" value="5">未通过审核&nbsp;&nbsp;
      </td>

</tr>
<%}else 
{
	out.println("<input type=hidden name=statics value="+icobj.getScore()+">");	
}
	
	
%>
<tr><td colspan="2" align="center"><input type="submit" value="确定" />
<input type="button" name="reset" value="返回" onClick="javascript:history.go(-1)">
 
 </td></tr>

</table>
</form>
</body>
</html>

