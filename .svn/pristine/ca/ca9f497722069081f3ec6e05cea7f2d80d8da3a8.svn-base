<%@page import="tea.entity.admin.sales.PriceSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="util.Imptxt"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    Http h=new Http(request);
    int type=h.getInt("type");
    Date date=new Date();
    
    %>
    <script src="/tea/mt.js" type="text/javascript"></script>
<form action="/Orders.do" method="post" name="form1">
<input type="hidden" name="act" value="JKsubmit"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="price" value="<%=PriceSet.find(type).price %>"/>
<input type="hidden" name="tprice" value=""/>
<input type="hidden" name="nexturl" value="/html/Home/folder/140612982-1.htm"/>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="td01"><font color="#f00">*</font>姓　　名：</td>
    <td class="td02"><input type="text" name="name" /><span class="tishi">请填写您的真实姓名</span></td>
    <td rowspan="6" class="td_pic"><img src="/res/Home/structure/zzfm.png" /></td>
  </tr>
  <tr>
    <td class="td01"><font color="#f00">*</font>联系电话：</td>
    <td class="td02"><input type="text" name="mobile" /><span class="tishi">请填写您的联系电话</span></td>
  </tr>
  <tr>
    <td class="td01"><font color="#f00">*</font>邮寄地址：</td>
    <td  class="td03"><input type="text" name="address" /><span class="tishi">请填写您的邮寄地址，我们将会邮寄您订阅的杂志</span></td>
  </tr>
  <tr>
    <td class="td01"><font color="#f00">*</font>邮　　编：</td>
    <td class="td02"><input type="text" name="zipCode" /><span class="tishi">请填写您的邮编</span></td>
  </tr>
  <tr>
    <td class="td01"><font color="#f00">*</font>E-mail：</td>
    <td class="td02"><input type="text" name="email" /><span class="tishi">请填写您的E-mail</span></td>
  </tr>
  <tr>
    <td class="td01"><font color="#f00">*</font>配送方式：</td>
    <td>
    <input type="radio" name="goway" value="1" checked/>平邮
    </td>
  </tr>
  <tr>
    <td colspan="3"><font color="#f00" style="padding-left:55px;">*</font>请选择您要订阅的刊物：
     <input type="radio" name="node" value="14050306" <%=type==14050306?"checked":"" %> onclick="change(<%=PriceSet.find(14050306).price %>)"/>北京健康教育通讯
     <input type="radio" name="node" value="14050307" <%=type==14050307?"checked":"" %> onclick="change(<%=PriceSet.find(14050307).price %>)"/>健康少年画报
     <input type="radio" name="node" value="14050308" <%=type==14050308?"checked":"" %> onclick="change(<%=PriceSet.find(14050308).price %>)"/>健康
    </td>
  </tr>
  <tr>
    <td colspan="3" style="td01"><font color="#f00" style="padding-left:55px;">*</font>您要订阅的期刊月份：
    <select name="startyear" onchange="change(form1.price.value)">
     <%
      for(int i=2013;i<2114;i++){ 
     %>
       <option value="<%=i %>" <%=Integer.valueOf(new SimpleDateFormat("yyyy").format(date))==i?"selected":"" %>><%=i %></option>
     <%
      }
     %>
    </select>
    <select name="startmonth" onchange="change(form1.price.value)">
     <%
      for(int i=1;i<=12;i++){
     %>
       <option value="<%=i %>" <%=date.getMonth()==i?"selected":"" %>><%=i %></option>
     <%
      }
     %>
    </select>到
    <select name="stopyear" onchange="change(form1.price.value)">
     <%
      for(int i=2013;i<2114;i++){ 
     %>
       <option value="<%=i %>" <%=Integer.valueOf(new SimpleDateFormat("yyyy").format(date))==i?"selected":"" %>><%=i %></option>
     <%
      }
     %>
    </select>
    <select name="stopmonth" onchange="change(form1.price.value)">
     <%
      for(int i=1;i<=12;i++){
     %>
       <option value="<%=i %>" <%=date.getMonth()==i?"selected":"" %>><%=i %></option>
     <%
      }
     %>
    </select>
    </td>
  </tr>
  <tr>
    <td class="td01"><font color="#f00">*</font>份　　数：</td>
    <td colspan="2" class="td04"><input type="text" name="num" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onchange="change(form1.price.value)" value="1" size="2" class="text1"/>是否需要发票：<input type="radio" name="isInvoive" value="0" checked onclick="document.getElementById('inv').style.display='none'"/>否<input type="radio" name="isInvoive" value="1"  onclick="document.getElementById('inv').style.display=''"/>是</td>
  </tr>
  <tr id="inv" style="display:none">
    <td class="td01"><font color="#f00">*</font>发票抬头：</td>
    <td colspan="2" class="td05"><input type="text" name="unitName" /></td>
  </tr>
  <tr>
    <td class="td01">总价格：</td>
    <td colspan="2" class="td05" id="tprice"></td>
  </tr>
  <tr>
    <td colspan="3" align="center"  class="td06"><input type="button" onclick="subform()" value="确认订购"></td>
  </tr>
</table>
<script type="text/javascript">
window.onload=function(){
	change(form1.price.value);
}
function change(a,b,c,d,e){
	form1.price.value=a;
	var b=Number(form1.startyear.value);
	var c=Number(form1.startmonth.value);
	var d=Number(form1.stopyear.value);
	var e=Number(form1.stopmonth.value);
	var mnum=0;
	if(b==d){
		if(e>=c)
		 mnum=e-c+1;
	}else if(b<d){
		mnum=(d-b)*12+c-e+1;
	}else{
		mnum=0;
	}
	var num=form1.num.value;
	if(num=="")num=0;
	document.getElementById("tprice").innerHTML="￥"+a*num*mnum;
	form1.tprice.value=a*num*mnum;
}
function subform(){
	if(form1.name.value==""){
		mt.show('请填写您的真实姓名');
		return;
	}
	if(form1.mobile.value==""){
		mt.show('请填写您的联系电话');
		return;
	}
	if(form1.mobile.value!=""){
		var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
		if(!reg.test(form1.mobile.value)){
			mt.show('联系电话格式不正确');
			return;
		}
	}
	if(form1.address.value==""){
		mt.show('请填写您的邮寄地址');
		return;
	}
	if(form1.zipCode.value==""){
		mt.show('请填写您的邮编');
		return;
	}
	if(form1.email.value==""){
		mt.show('请填写您的email');
		return;
	}
	var a=Number(form1.startyear.value);
	var b=Number(form1.startmonth.value);
	var c=Number(form1.stopyear.value);
	var d=Number(form1.stopmonth.value);
	if(a>c){
		mt.show('期刊月份不正确，请重新输入');
		return;
	}else if(b>d){
		mt.show('期刊月份不正确，请重新输入');
		return;
	}else{
		form1.submit();
	}
}
</script>
</form>