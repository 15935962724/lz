<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.order.Order"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request);
if(h.member<1)
{
 response.sendRedirect("/servlet/StartLogin?node="+h.node);
 return;
}
Profile p=Profile.find(h.username);
String act =h.get("act","edit");
if("view".equals(act)){
if("POST".equals(request.getMethod())){
	if(h.getInt("isInv")>0){
		int isinv=h.getInt("isInv");
		int invType=h.getInt("invType");
		int invContent=h.getInt("invContent");
		String invUnit=h.get("invUnit");
		p.set(isinv, invType, invContent, invUnit);
		p.set("invouveState", 1);
	}else{
		p.set("isInvoive", h.getInt("isInv"));
		p.set("invouveState", 1);
	}
}}else{
	p.set("invouveState", 0);
}
%>
<script src="/tea/mt.js" type="text/javascript"></script>
<form action="?" method="POST" name="form2">
<input type="hidden" name="act" value="view">
<%
if("edit".equals(act)){%>
<span style="width:900px;padding-left:50px;margin-right:5px;display:block;font-size:12px;color:#666666;">是否开发票？<input type="radio" value="1" name="isInv" onclick=$('_reason').style.display=''>是<input type="radio" name="isInv" value="0" checked onclick=$('_reason').style.display='none'>否</span>
<style>
#_reason{width:100%;font-size:12px;color:666666;line-height:22px;margin-top:5px;}
#Unit{padding:0px 5px;float:left;}

</style>
<div style="display:none" id="_reason">
<div style="float:left;padding-left:50px !important;">发票类型：
<select name="invType" onchange=mt.c()>
<%
for(int i=0;i<Profile.INVOIVE_TYPE.length;i++){%>
<option value="<%=i+1%>" <%=p.invoiveType==(i+1)?"selected='selected'":"" %>><%=Order.INVOIVE_TYPE[i] %></option>
<%	
}
%>
</select>
</div>
<div id="Unit" style="display:none;"><input name="invUnit" type="text" value="<%=MT.f(p.unitName) %>"></div>
发票内容：
<select name="invContent" >
<%
for(int i=0;i<Profile.INVOIVE_CONTENT.length;i++){%>
<option value="<%=i+1%>" <%=p.invoiveContent==(i+1)?"selected='selected'":"" %>><%=Profile.INVOIVE_CONTENT[i] %></option>
<%	
}
%>
</select>
</div>
<div style="width:100%;float:left; text-align:left"><input type="submit" class="Order1" value="保存发票信息"></div>
<div style="font-size:12px !important;">
<%
}else{
if(Profile.find(h.username).getIsInvoive()==1){
%>
<span class="span1">发票类型：<%=Profile.INVOIVE_TYPE[p.invoiveType-1] %>&nbsp;&nbsp;&nbsp;<%=p.invoiveType==2?MT.f(p.unitName):"" %></span>
<br>
<span class="span1" style="margin-left:5px;">发票内容：<%=Profile.INVOIVE_CONTENT[p.invoiveContent-1] %></span>
<a href="#" onclick=mt.act() class="a1">编辑发票信息</a>
<%	
}else{%>
<font style="font-size:12px;margin-left:10px;">不开发票</font>
	<a href="#" onclick=mt.act() class="a1">编辑发票信息</a>
<%	
}

}
%>
</div>
</form>
<script type="text/javascript">
mt.c=function(){
	form2.invType.value==2?$('Unit').style.display='':$('Unit').style.display='none';	
}
form2.invType.value==2?$('Unit').style.display='':$('Unit').style.display='none';
</script>
<script>
mt.act=function(){
	form2.act.value='edit';
	form2.submit();
}
</script>

<style>

a.a1{width:150px;line-height:30px;clear:both;font-size:14px;display:block;color:fff;font-weight:bold;text-align:center;text-decoration:none;background:#E43F42;-moz-border-radius:3px;-khtml-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;margin-top:10px;margin-left:10px;}
span.span1{width:900px;padding-left:50px;font-size:12px;line-height:25px;display:block;float:left;}
input.Order1{padding:0px 20px;font-size:14px;float:left;color:#fff;font-weight:bold;height:30px;margin-top:20px;margin-left:10px;line-height:30px;border:none;background:#E43F42;-moz-border-radius:3px;-khtml-border-radius:3px;-webkit-border-radius:3px;border-radius:3px; cursor:pointer;}
#1030380600{font-size:12px;color:#ff00;}
</style>