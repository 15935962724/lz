<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.admin.City"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<%
Http h=new Http(request);
if(h.member<1)
{
 response.sendRedirect("/servlet/StartLogin?node="+h.node);
 return;
}
Profile p=Profile.find(h.username);
String consignee="",address="",tel="",phone="",email="";
String act=h.get("act","edit");
int city;
if("view".equals(act)){
	if("POST".equals(request.getMethod())){
		consignee=h.get("consignee");
		city = h.getInt("city2");
		if(city < 1)
		    city = h.getInt("city1");
		if(city < 1)
		    city = h.getInt("city0");
		address=h.get("address");
		tel=h.get("tel");
		phone=h.get("phone");
		email=h.get("email");
		p.set("jemail", email);
		p.set("personState", 1);
		p.set("jaddress", address);
		p.set("jcity", city);
		p.set("jmobbile", tel);
		p.setConsignee(consignee, h.language);		
	}
}else{
	p.set("personState", 0);
}


%>
<form action="?" method="POST" name="form1" onSubmit="return mt.check(this)">
<input name="act" value="view" type="hidden">
<%
if("view".equals(act)){%>

<table class="Rece1">
<tr>
<td><span class="span1">收货人：</span>
<%=p.getConsignee(1)%></td>
</tr>
<tr>
<td><span class="span1">详细地址：</span>
<script>mt.city(<%=p.getJcity()%>)</script>&nbsp;&nbsp;<%=Profile.find(h.username).getJaddress() %></td>
</tr>
<tr>
<td><span class="span1">手机号码：</span>
<%=Profile.find(h.username).getJmobbile()%></td><%-- 或&nbsp;&nbsp;固定电话<%=p.getPTelephone(h.language)%> --%>
</tr>
<tr>
<td><span class="span1">邮箱：</span>
<%=Profile.find(h.username).getJemail()%></td>
</tr>
<tr>
<td colspan="2"><a href="#" onclick=mt.act()>编辑收货人信息</a></td>
</tr>
</table>
<style>
table.Rece1{width:700px;float:left;font-size: 12px;color:#000;}
table.Rece1 td span.span1{text-align:right;width:70px;float:left;display:block;}
table.Rece1 td{line-height:25px;}
table.Rece1 td a{width:150px;color:#000; text-decoration:none; display:block; margin-left:10px;text-align:center;font-size:14px;color:#fff;height:30px;font-weight:bold;cursor:pointer;margin-top:10px;line-height:30px;border:none;background:#E43F42;-moz-border-radius:3px;-khtml-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;}

input.Order1{padding:0px 20px;font-size:14px;color:#fff;font-weight:bold;cursor:pointer;margin-top:10px;line-height:30px;border:none;background:#E43F42;-moz-border-radius:3px;-khtml-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;}
</style>
<%
	
}else{%>

<table class="Rece">
<tr>
<td class="td1"><span id="bitian">*</span>收货人：</td>
<td><input name="consignee" value="<%=p.getConsignee(1)%>" alt="收货人"></td>
</tr>
<tr>
<td class="td1"><span id="bitian">*</span>所在地区：</td>
<td><script>mt.city('city0','city1','city2','<%=p.getJcity()%>')</script></td>
</tr>
<tr>
<td class="td1"><span id="bitian">*</span>详细地址：</td>
<td style="padding:0px;border:0px;">&nbsp;<input alt="所在地区" name="address" value="<%=MT.f(p.getJaddress()) %>" size="41"/></td>
</tr>
<tr>
<td class="td1"><span id="bitian">*</span>手机号码：</td>
<td><input name="tel" alt="手机号码" value="<%=MT.f(p.getJmobbile())%>">或&nbsp;&nbsp;固定电话<input name="phone" value="<%=p.getPTelephone(h.language)%>"></td>
</tr>
<tr>
<td class="td1">邮箱：</td>
<td><input name="email" value="<%=MT.f(p.getJemail())%>"></td>
</tr>
<tr>
<td colspan="2"><input type="submit" class="Order1" value="保存收货人信息"></td>
</tr>
</table>
<style>
table.Rece {width:700px;float:left;font-size: 12px;color: #666666;}
table.Rece tr{height:30px;}
table.Rece td.td1{text-align: right;}
span#bitian{color:#f00;font-size:8px;margin-right:3px;}
input.Order1{padding:0px 20px;font-size:14px;color:#fff;font-weight:bold;cursor:pointer;margin-top:10px;margin-left:10px;line-height:30px;border:none;background:#E43F42;-moz-border-radius:3px;-khtml-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;}
</style>
	<%
}
%>

</form>
<script>
mt.act=function(){
	form1.act.value='edit';
	form1.submit();
}
</script>
