<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
    <script src="/jsp/plane/sss.js"></script>
<form method="post" action="/Orders.do" name="form1">
<input type="hidden" name="act" value="Fsubmit">
<p class="time">预约时间</p>
<div>
<input type="text" name="reserveTime"  onclick="WdatePicker({doubleCalendar:false,isShowClear:false, minDate:'%y-%M-%d'})" >
</div>
<div>
<div>
<p class="time" >开始时间</p>
</div>
<div>
<select name="beginTime">
<option>00.00</option>
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

<div>
<div>
<p class="time">结束时间</p>
</div>
<div>
<select name="endTime">
<option>00.00</option>
<option value="06:15">06:15</option>
<option value="06:30">06:30</option>
<option value="06:45">06:45</option>
<option value="07:00">07:00</option>
</select>
</div>
</div>
<div>
预约人数：
<a href="###" class="jian" onclick="reduct()">－</a><input type="text" value="1" onkeyup="this.value=this.value.replace(/\D/g,'')" name="personNum" size=3 class="manber"><a class="jia" onclick="add()">＋</a>
</div>
<div>
金额:
<input name="totalmaney"/>
</div>


<input type="submit" value="提交订单">
</form>
<script>
var reduct=function(){
	var num=form1.personNum.value;
	if(Number(num)>1)form1.personNum.value=Number(num)-1;
}
var add=function(){
	var num=form1.personNum.value;
	if(Number(num)<10)form1.personNum.value=Number(form1.personNum.value)+1;
}
</script>
