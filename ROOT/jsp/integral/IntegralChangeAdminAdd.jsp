<%@page import="tea.entity.westrac.WestracIntegralLog"%>
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
  out.println("您还没有登录，系统不能处理您的信息.<a href=\"###\" onclick=\"history.go(-1)\" >返回</a> ");
  return;
}

String member = teasession.getParameter("member");
Profile pobj = Profile.find(member);
String nexturl = teasession.getParameter("nexturl");

float in = IntegralChange.getIntegral(member,teasession._strCommunity);




if((pobj.getMyintegral()-in)<=0 || pobj.getMyintegral()<=0)
{
	out.println("<script>alert('会员"+member+"的积分不足，不能兑换这个商品');window.location.href='"+nexturl+"';</script>");
	return;
}




if("POST".equals(request.getMethod()))
{
	
	String shop_integral = teasession.getParameter("shop_integral");
	
	if(pobj.getMyintegral()<Integer.parseInt(shop_integral))
	{
		out.println("<script>alert('会员"+member+"的积分不足，不能兑换这个商品');window.location.href='"+nexturl+"';</script>");
		return;
	}
	
	String iprizenameid = "/"+teasession.getParameter("iprizenameid");
	
	String phone = teasession.getParameter("phone");
	String address= teasession.getParameter("address");
	String consignee = teasession.getParameter("consignee");
String pro = teasession.getParameter("city1");
String zip = teasession.getParameter("zip");
		
IntegralChange.create(null,teasession._strCommunity,member,iprizenameid,new Date(),
		null,Integer.parseInt(shop_integral),1,null,phone,address,consignee,null,1,teasession._rv.toString(),pro,zip);
    
    for(int i=1;i<iprizenameid.split("/").length;i++)
    {
    	int igid = Integer.parseInt(iprizenameid.split("/")[i]);
    	 IntegralPrize ipobj = IntegralPrize.find(igid);
    	 ipobj.setCstype(ipobj.getCstype()+1);  
    } 
    
   
    //
   
    out.println("<script>alert('商品兑换成功,请等待管理员审核...');window.location.href='"+nexturl+"';</script>");
	return;


} 

 







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
		if(form1.iprizename.value=='')
		{
			ymPrompt.win({message:'<br><br><br><center>请选择兑换的商品</center>',height:150,width:250,btn: ['OK'],closeBtn:false,handler:function (){form1.iprizename.focus();}});
			return false;
		}
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
	
	//查询商品
	function f_c()
	{
		 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
		 var url = '/jsp/integral/IntegralAdminPrize.jsp?t='+new Date().getTime()+'&iprizenameid='+form1.iprizenameid.value;
		 var rs = window.showModalDialog(url,self,y);
		 if(rs!='')
		 {
			 //alert(rs.split("#")[2]+"--");
			if(('/'+form1.iprizenameid.value).indexOf('/'+rs.split("#")[1]+'/')==-1)
			{
			 form1.iprizenameid.value=form1.iprizenameid.value+rs.split("#")[1]+'/';
			 form1.iprizename.value=(form1.iprizename.value+rs.split("#")[2]+';');
			 
			    var s = 0;
				 if( form1.shop_integral.value!='')
				{
					s=  parseFloat(form1.shop_integral.value)
				}
			 var s3 =parseFloat(rs.split('#')[3]);
			// alert(s+"--"+s3+"--=-"+(s+s3));
			 form1.shop_integral.value=(s+s3);
			 
			 
			 
			}else
			{
				 form1.iprizenameid.value =('/'+form1.iprizenameid.value).replace('/'+rs.split("#")[1]+'/','');
				 form1.iprizename.value= (';'+form1.iprizename.value).replace(';'+rs.split("#")[2]+';','');
				 
				 var s = 0;
				 if( form1.shop_integral.value!='')
				{
					s=  parseFloat(form1.shop_integral.value)
				}
				 var s3 =parseFloat(rs.split('#')[3]);
		
				 form1.shop_integral.value=(s-s3);
			}
		 } 
	} 
	
	
	
</script>
<body bgcolor="#ffffff">
<h1>商品积分兑换</h1>
<form action="?" method="POST"  name="form1" onsubmit="return f_sub();">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="member" value="<%=member %>">
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>

<input type="hidden" name="iprizenameid">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"> 
<tr>
	<td align="right">会员编号：</td>
	<td><%=pobj.getCode() %></td>
</tr>
<tr>
	<td align="right">用户名：</td>
	<td><%=member%></td>
</tr>
<tr>
	<td align="right">姓名：</td>
	<td><%=pobj.getFirstName(teasession._nLanguage)%></td>
</tr>
<tr>
	<td align="right">总积分：</td>
	<td><%=pobj.getMyintegral()%></td>
</tr> 
<tr>
	<td align="right"><font color=red>*</font>兑换的商品：</td>
	<td><input type="text" size=70 name="iprizename" readonly="readonly" value="">&nbsp;<input type="button" value="查找商品" onclick="f_c();"></td>
</tr>

<tr>
	<td align="right">兑换积分：</td>
	<td><input type="text" size=4 name="shop_integral" readonly="readonly" value="">&nbsp;分</td>
</tr> 
<tr><td align="right"><font color=red>*</font>联系人：</td><td><input type="text"   name="consignee" value="<%=pobj.getFirstName(teasession._nLanguage) %>"/></td></tr>

<tr><td align="right"><font color=red>*</font>联系电话：</td><td><input type="text"    name="phone" value="<%=pobj.getMobile()%>"/></td></tr>
<tr><td align="right" nowrap><font color=red>*</font>邮编：</td><td  nowrap>
<input type="text" name="zip" value="<%=pobj.getZip(teasession._nLanguage) %>">
</td> 
<tr><td align="right"><font color=red>*</font>现通讯地址：</td><td>
<script>mt.city("city0","city1",null,'<%=pobj.getProvince(teasession._nLanguage) %>');</script><input type="text"    name="address" value="<%=tea.entity.util.Card.find(pobj.getProvince(teasession._nLanguage)).toString2() %><%=pobj.getAddress(teasession._nLanguage) %>"/></td></tr>


 

<tr><td colspan="2" align="center"><input type="submit" value="确定" /> <input type="button" name="reset" value="返回" onClick="javascript:history.go(-1)"></td></tr>

</table>
</form>
</body>
</html>

