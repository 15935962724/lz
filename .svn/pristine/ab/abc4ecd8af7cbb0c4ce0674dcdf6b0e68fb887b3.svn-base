<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.site.Community"%>
<%@page import="tea.entity.admin.Payinstall"%>
<%@page import="tea.entity.plane.PlaneBooking"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%
Http h=new Http(request);
int id=h.getInt("id", 0);
Community c=Community.find(h.community);
PlaneBooking p=PlaneBooking.find(id);
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

if(h.member<1)
{
  out.print("<script>location.href='/xhtml/"+h.community+"/folder/"+c.getLogin()+"-1.htm?nexturl=/xhtml/"+h.community+"/folder/"+h.node+"-1.htm';</script>");
  return;
}
%>
<script src="/tea/mt.js"></script>
<script src="/mobjsp/plane/sss.js"></script>
<script src="/tea/jquery.js"></script>
<!--<style>
body{clear:both;position:relative;background:#005DAA;padding:10px;}
a{text-decoration:none;}
p.p1{display:block;text-align:center;}
.time{font-size:18px;font-weight:bold;color:#fff;}
.inp{clear:both; position:relative;padding-top:10px;}
.time1{width:100%;display:block;font-size:18px;font-weight:bold;padding:3px 0px;border:none;}
.t_left{width:48%;height:100px;float:left;text-align:center;font-size:16px;font-weight:bold;}
.t_tit{clear:both;position:relative;height:40px;line-height:40px;}
.t_right{width:48%;height:100px;float:right;text-align:center;font-size:16px;font-weight:bold;}
.time2{background:#B2DFF2;display:block;}
.time_box{clear:both;position:relative;background:#E0F2FE;padding:20px 0px;}
.time_box select{padding:2px 0px;font-size:18px;font-weight:bold;}
.money{clear:both;padding:0px 10px;font-size:16px;font-weight:bold;color:#fff;}
input.moey{border:none;background:none;color:#fff;font-size:16px;font-weight:bold;}

.con{clear:both;position:relative;padding:10px 0px;}
.yuyue{clear:both;position:relative;padding-top:30px;}
.yuyue .yy{display:block;background:#E0F2FE;height:40px;line-height:40px;padding:0px 10px;font-size:16px;font-weight:bold;}
a.jian,a.jia{background:#FF5B1F;padding:2px 6px;color:#fff;font-size:16px;font-weight:bold;-moz-border-radius:3px;-khtml-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;
}
span.sp1{float:right;display:block;}
input.txt{border:none;font-size:18px;font-weight:bold;padding:0px 1px;text-align:center;background:none;}

input.submit{width:60%;margin:0px auto;clear:both;height:44px;font-size:20px;font-weight:bold;color:#fff;line-height:44px;text-align:center;border:none;position: relative;
filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#FE855A',EndColorStr='#FB4600');
background: -webkit-gradient(linear,0 0,0 100%,from(#FE855A),to(#FB4600));
background: -moz-linear-gradient(#FE855A,#FB4600);
background: -o-linear-gradient(#FE855A,#FB4600);
background: linear-gradient(#FE855A,#FB4600);}

</style>-->
<script type="text/javascript">
var time=[30,15,15,30,90];
var newtime=[];
function selchange(obj){
	if(obj.value==0){
		$(document.getElementsByName("endTime")[0]).html("<option value='0'>00:00</option>");
		return;
	}
	var mytime = obj.value;
	var date = new Date("1990/01/01 "+mytime);
	for(var i=0;i<time.length;i++){
		date.setMinutes(date.getMinutes()+time[i]);
		newtime[i]=date;
		var b=newtime[i].getHours()+":";
		var a=newtime[i].getMinutes()==0?"00":newtime[i].getMinutes();
		if(i==0)$(document.getElementsByName("endTime")[0]).html("");
		$(document.getElementsByName("endTime")[0]).append("<option value='"+b+a+"'>"+b+a+"</option>");
	}
	prichange();
}
function prichange(){
	var beginTime =document.getElementById("beginTime").value;
	var endTime =document.getElementById("endTime").value;
	var datebegin = new Date("1990/01/01 "+beginTime);
	var dateend = new Date("1990/01/01 "+endTime);
	var num=(dateend.getTime()-datebegin.getTime())/60000;
	if(num==30){
		$("#total").html("<%=p.price30%>");
		form1.totalmaney.value=<%=p.price30%>;
		$(".jia").unbind("click").click(function(){add(1);});
		$(".jian").unbind("click").click(function(){reduct();});
		form1.personNum.value="1";
	}else if(num==45){
		$("#total").html("<%=p.price45%>");
		form1.totalmaney.value=<%=p.price45%>;
		$(".jia").unbind("click").click(function(){add(1);});
		$(".jian").unbind("click").click(function(){reduct();});
		form1.personNum.value="1";
	}else if(num==60){
		$("#total").html("<%=p.price60%>");
		form1.totalmaney.value=<%=p.price60%>;
		$(".jia").unbind("click").click(function(){add(3,<%=p.price60%>+200);});
		$(".jian").unbind("click").click(function(){reduct(3,<%=p.price60%>);});
	}else if(num==90){
		$("#total").html("<%=p.price90%>");
		form1.totalmaney.value=<%=p.price90%>;
		$(".jia").unbind("click").click(function(){add(3,<%=p.price90%>+200);});
		$(".jian").unbind("click").click(function(){reduct(3,<%=p.price90%>);});
	}else if(num==180){
		$("#total").html("<%=p.price180%>");
		form1.totalmaney.value=<%=p.price180%>;
		$(".jia").unbind("click").click(function(){add(3,<%=p.price180%>+500);});
		$(".jian").unbind("click").click(function(){reduct(3,<%=p.price180%>);});
	}
	
}
</script>
<form method="post" action="/Orders.do" name="form1">
<input type="hidden" name="act" value="FTsubmit">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="community" value="<%=h.community%>">

<input type="hidden" name="nexturl" value="/html/flight737sim/folder/14040111-1.htm">
<span class="time">预约时间</span>
<div class="inp">
    <input type="text" name="reserveTime" value="<%=sf.format(new Date()) %>" alt="预约时间" readonly class="time1" id="time_c"  onclick="mt.date(this,false,new Date())" >
</div>
<div class="con">
<div class="t_left">
    <div class="t_tit">
        <span class="time2">开始时间</span>
    </div>
    <div class="time_box">
        <select name="beginTime" id="beginTime"  onchange="selchange(this)" alt="开始时间">
        <option value="0">00:00</option>
        <option value="10:00">10:00</option>
        <option value="10:15">10:15</option>
        <option value="10:30">10:30</option>
        <option value="10:45">10:45</option>
        <option value="11:00">11:00</option>
        <option value="11:15">11:15</option>
        <option value="11:30">11:30</option>
        <option value="11:45">11:45</option>
        <option value="12:00">12:00</option>
        <option value="12:15">12:15</option>
        <option value="12:30">12:30</option>
        <option value="12:45">12:45</option>
        <option value="13:00">13:00</option>
        <option value="13:15">13:15</option>
        <option value="13:30">13:30</option>
        <option value="13:45">13:45</option>
        <option value="14:00">14:00</option>
        <option value="14:15">14:15</option>
        <option value="14:30">14:30</option>
        <option value="14:45">14:45</option>
        <option value="15:00">15:00</option>
        <option value="15:15">15:15</option>
        <option value="15:30">15:30</option>
        <option value="15:45">15:45</option>
        <option value="16:00">16:00</option>
        <option value="16:15">16:15</option>
        <option value="16:30">16:30</option>
        <option value="16:45">16:45</option>
        <option value="17:00">17:00</option>
        <option value="17:15">17:15</option>
        <option value="17:30">17:30</option>
        <option value="17:45">17:45</option>
        <option value="18:00">18:00</option>
        <option value="18:15">18:15</option>
        <option value="18:30">18:30</option>
        <option value="18:45">18:45</option>
        <option value="19:00">19:00</option>
        <option value="19:15">19:15</option>
        <option value="19:30">19:30</option>
        <option value="19:45">19:45</option>
        <option value="20:00">20:00</option>
        </select>
    </div>
</div>

<div class="t_right">
    <div class="t_tit">
        <span class="time2" >结束时间</span>
    </div>
    <div class="time_box">
        <select name="endTime" id="endTime" alt="结束时间" onchange="prichange()">
        <option value="0">00:00</option>
        </select>
    </div>
</div>
</div>
<div class="yuyue">
    <p class="yy">预约人数：
    <span class="sp1"><a href="###" class="jian">－</a><input type="text" class="txt" value="1" onkeyup="this.value=this.value.replace(/\D/g,'')" name="personNum" size=3 class="manber"><a class="jia" href="###">＋</a></span>
    </p>
</div>
<div class="money">
    金额：&yen<span id="total">0</span>
    <input class="money" type="hidden" name="totalmaney" id="totalmaney"/>
</div>
<div class="pay">
<%
Payinstall payobj = Payinstall.findpay(2);
boolean f = true;
	if(f){
	%>
	<input type="radio" name="paytype" value="0" checked="checked" onclick="f_check1();">&nbsp;网银支付 &nbsp;&nbsp;
	<%} %>
	
	
	
	<%-- <input type="radio" name="paytype" value="2" onclick="f_check2();" <%if(!f){out.println(" checked  ");} %>>&nbsp;会员卡支付&nbsp;&nbsp;--%>
	
	<input type="radio" name="paytype" value="1" onclick="f_check3();">&nbsp;现场支付
	&nbsp;
	<span id= "paytypeshow"></span>
<div id="payid1">
<%

if(f){

if("/".equals(payobj.getUsename()) &&   payobj.getUsetype()!=1)
{
		f =false;
}
boolean thi=false;
if(payobj.getUsename()!=null && payobj.getUsename().indexOf("/3/")!=-1 && payobj.getUsetype()==1)
{
	//支付宝
	out.print("<input type=\"radio\" name=\"webpaytype\" value=\"1\"");
	out.print(">&nbsp;<img src='/res/Golf/structure/zfb.jpg'/>");
	out.print("&nbsp;&nbsp;");
	thi=true;
}
if(!thi){
	out.print("暂时没有支持的预定的在线支付 方式");
}
}
%>
<span id="webpaytypeshow"></span>
</div>
</div>
<p class="p1"><input type="button" class="submit" onclick="isch()" value="提交订单"></p>
</form>
<script>
function f_check1()
{
	<%if(f){%>
	document.getElementById("payid1").style.display='';
	<%}%>
	//document.getElementById("payid2").style.display='none';
	
}
function f_check3()
{
	<%if(f){%>
	document.getElementById("payid1").style.display='none';
	<%}%>
	//document.getElementById("payid2").style.display='none';
}
function isch()
{
	var ch = document.getElementsByName("paytype");

	var ff =true;
	for(var i = 0; i < ch.length; i++) 
	{
		if(ch[i].checked) 
		{
			ff = false;
		}
	}
	if(ff)
	{
		document.getElementById("paytypeshow").innerHTML='<font color=red>请选择在线支付方式</font>';
		return false;
	}
	
	if(ch.length>0 && ch[0].checked)
	{
		var ch2 = document.getElementsByName("webpaytype");
		var f =true;
		for(var i = 0; i < ch2.length; i++) 
		{
			if(ch2[i].checked) 
			{
				f = false;
			}
		}
		if(f)
		{
			document.getElementById("webpaytypeshow").innerHTML='<font color=red>请选择在线支付方式</font>';
			return;
		}  
	}
	if(form1.reserveTime.value==''){
		alert("预约时间不能为空");
	}else if(form1.beginTime.value==0){
		alert("请填写开始时间");
	}else if(form1.endTime.value==0){
		alert("请填写开始时间");
	}else{
		form1.submit();
	}
		
}
var reduct=function(a,b){
	var num=form1.personNum.value;
	if(Number(num)>1)form1.personNum.value=Number(num)-1;
	if(form1.personNum.value==1&&a==3){
		$("#total").html(b);
    	form1.totalmaney.value=b;
	}
}
var add=function(a,b){
	var num=form1.personNum.value;
	if(Number(num)<a)form1.personNum.value=Number(form1.personNum.value)+1;
    if(a==3){
    	$("#total").html(b);
    	form1.totalmaney.value=b;
	}
}
</script>
