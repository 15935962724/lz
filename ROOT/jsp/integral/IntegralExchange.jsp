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
Profile pobj = Profile.find(teasession._rv.toString());
if(pobj.getMembertype()!=1)
{
	//不是俱乐部会员，不能兑换
	 out.println("您不是俱乐部会员或您的申请没有审核，请耐心等待...<a href=\"###\" onclick=\"parent.ymPrompt.close();\" >关闭</a> ");
	  return;
}

int igid= 0;
 
if(teasession.getParameter("igid")!=null && teasession.getParameter("igid").length()>0)
{
  igid = Integer.parseInt(teasession.getParameter("igid"));  
} 
IntegralPrize obj = IntegralPrize.find(igid);


if("POST".equals(request.getMethod()))
{
	String phone = teasession.getParameter("phone");
	String address= teasession.getParameter("address");
	String consignee = teasession.getParameter("consignee");
	  
		String pro = teasession.getParameter("city1");
		String zip = teasession.getParameter("zip");
    
    IntegralChange.create(null,teasession._strCommunity,teasession._rv.toString(),String.valueOf("/"+igid+"/"),new Date(),
    		null,obj.getShop_integral(),1,null,phone,address,consignee,null,0,teasession._rv.toString(),pro,zip);
    
    IntegralPrize ipobj = IntegralPrize.find(igid);
    ipobj.setCstype(ipobj.getCstype()+1);  
    
    
    
    out.print("<SCRIPT LANGUAGE=JAVASCRIPT SRC=\"/tea/ym/ymPrompt.js\" type=\"\"></SCRIPT>");
    out.print("<link href=\"/tea/ym/skin/dmm-green/ymPrompt.css\" rel=\"stylesheet\" type=\"text/css\">");
    
    out.println("<script>");
    out.println("ymPrompt.win({message:'<br><br><br><center>您的积分兑换商品成功.<br>请等待工作人员审核...</center>',height:150,width:250,btn: ['OK'],closeBtn:false,handler:function (){parent.ymPrompt.close();}});");
    out.println("</script>");
    return;     
}




float  myintegral=pobj.getMyintegral();
float  shop_integral= ((Integer)obj.getShop_integral()).floatValue();





float in = IntegralChange.getIntegral(teasession._rv.toString(),teasession._strCommunity);

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
<input type="hidden" name="igid" value="<%=igid%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"> 

<tr><td colspan="10">请您确认兑换"<%=obj.getShopping() %>"并填写必要送货信息</td></tr>
<tr><td colspan="10"><%=teasession._rv.toString() %>&nbsp;您的总积分是：<%=pobj.getMyintegral() %>&nbsp;&nbsp;需要兑换积分：<%=obj.getShop_integral() %>&nbsp;&nbsp;兑换后剩余积分：<%=pobj.getMyintegral()-((Integer)obj.getShop_integral()).floatValue() %></td></tr>
<tr><td align="right" nowrap><font color=red>*</font>联系人：</td><td><input type="text"   name="consignee" value="<%=pobj.getFirstName(teasession._nLanguage) %>"/></td></tr>
<tr><td align="right" nowrap><font color=red>*</font>联系电话：</td><td><input type="text"    name="phone" value="<%=pobj.getMobile()%>"/></td></tr>
<tr><td align="right" nowrap><font color=red>*</font>邮编：</td><td  nowrap>
<input type="text" name="zip" value="<%=pobj.getZip(teasession._nLanguage) %>">
</td> 

<tr><td align="right" nowrap><font color=red>*</font>现通讯地址：</td><td  nowrap>
	<script>mt.city("city0","city1",null,'<%=pobj.getProvince(teasession._nLanguage) %>');</script><input type="text"    name="address" value="<%=pobj.getAddress(teasession._nLanguage) %>"/></td></tr>


 

<tr><td colspan="2" align="center"><input type="submit" value="提交" /> <input type="button" value="返回" onClick="parent.ymPrompt.close();" /></td></tr>

</table>
</form>
</body>
</html>

