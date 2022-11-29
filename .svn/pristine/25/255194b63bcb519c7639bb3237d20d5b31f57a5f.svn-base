<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
Profile profile=Profile.find(teasession._rv.toString());
%>
<style type="text/css">
<!--
#BodyRight{width:0px}
#BodyLeft{width:0px}
#Bodycenter{width:auto}
td{font-size:12px;}
select{font-size:12px;}
.10h{font-size:14px;color:#000000;line-height:15pt;}
-->
</style>

<SCRIPT LANGUAGE=JAVASCRIPT>
function ShowCalendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
//去掉字串两端的空格
function trim(str) {
	var SubStr;
	SubStr=str;
	while (SubStr.lengTD>0) {
   		if (SubStr.charAt(0)==" "){
			SubStr=SubStr.slice(1);
		}else{
			break;
		}
  	}
	while (SubStr.lengTD>0) {
   		if (SubStr.charAt(SubStr.length-1)==" "){
			SubStr=SubStr.substr(0,SubStr.length-1);
		}else{
			break;
		}
  	}
  	return SubStr;
}
//检测用户的姓名是否合法
function CheckName(GuestName) {
	var ErrStr;
	var ErrChar;
	var ArryErrStr;

////////	ErrChar="!@#$%^&*()_+|-=\\~`;'[]{}\"':;,./<>?～！@#￥％^&×（）……＋|－＝、〔〕｛｝：“；‘《》？，。、0123456789";
	ErrStr="虚拟,傻冒,先生,小姐,代订";

	ArryErrStr = ErrStr.split(",");

	//是否含有非法字符
	for(var k=0;k<GuestName.length;k++){
		if(ErrChar.indexOf(GuestName.charAt(k))>-1){
			return false;
		}
	}
	//是否含有非法字符串
	for (k=0; k<ArryErrStr.length; k++){
		if (GuestName.indexOf(ArryErrStr[k])>-1){
			return false;
		}
	}
	return true;
}

function check() {
	var i;
	var Guests;
	var Rooms;
	var NumDisplay;
	var GuestName;


	Guests=0;
	NumDisplay=0;
	Rooms=document.theform.num_room.value;
	for (i=0;i<(document.theform.num_guest.value);i++) {
		if (document.theform.TxtName[i].style.display!="none"){
			NumDisplay=NumDisplay+1;
		}

		GuestName=trim(document.theform.TxtName[i].value);
		if (GuestName!=""){
			if (CheckName(GuestName)==false){
				document.theform.TxtName[i].focus();
				alert("请输入正确的客人姓名！");
				return false;
			}
			Guests=Guests+1;
		}
	}
	if (Guests<Rooms){
		alert("请至少添加"+Rooms+"个入住人！");
		if (NumDisplay<Rooms) {
			document.theform.num_guest.focus();
		}else{
			document.theform.TxtName[Guests].focus();
		}
		return false;
	}
	for (i=0;i<(document.theform.num_guest.value);i++) {
		if(document.theform.TxtName[i].value.length<=1){
				alert("请输入客人姓名全称！");
				document.theform.TxtName[i].focus();
				return false;
		}
	}

	for (i=0;i<(document.theform.num_guest.value);i++) {
		if (document.theform.TxtName[i].value!=""){
			guestName=document.theform.TxtName[i].value;
			for (var k=i+1;k<(document.theform.num_guest.value);k++) {
				if (guestName==document.theform.TxtName[k].value){
					alert("入住人姓名不能重复！");
					document.theform.TxtName[k].focus();
					return false;
				}
			}
		}
	}


	if (document.theform.contacter_mobile.value==""&&document.theform.contacter_mobile_1.value==""&&document.theform.contacter_mobile_2.value=="")
	{
		alert("请输入联系电话！");
		document.theform.contacter_mobile.focus();
		return false;
	}

	if ((!(((CompStr(document.theform.contacter_mobile.value.substring(0,4),'0135')||CompStr(document.theform.contacter_mobile.value.substring(0,4),'0136')||CompStr(document.theform.contacter_mobile.value.substring(0,4),'0137')||CompStr(document.theform.contacter_mobile.value.substring(0,4),'0138')||CompStr(document.theform.contacter_mobile.value.substring(0,4),'0139')||CompStr(document.theform.contacter_mobile.value.substring(0,4),'0130')||CompStr(document.theform.contacter_mobile.value.substring(0,4),'0131')||CompStr(document.theform.contacter_mobile.value.substring(0,4),'0132')||CompStr(document.theform.contacter_mobile.value.substring(0,4),'0133'))&&document.theform.contacter_mobile.value.length==12)||((CompStr(document.theform.contacter_mobile.value.substring(0,3),'135')||CompStr(document.theform.contacter_mobile.value.substring(0,3),'136')||CompStr(document.theform.contacter_mobile.value.substring(0,3),'137')||CompStr(document.theform.contacter_mobile.value.substring(0,3),'138')||CompStr(document.theform.contacter_mobile.value.substring(0,3),'139')||CompStr(document.theform.contacter_mobile.value.substring(0,3),'130')||CompStr(document.theform.contacter_mobile.value.substring(0,3),'131')||CompStr(document.theform.contacter_mobile.value.substring(0,3),'132')||CompStr(document.theform.contacter_mobile.value.substring(0,3),'133'))&&document.theform.contacter_mobile.value.length==11)))&&(document.theform.confirm_method.options[document.theform.confirm_method.selectedIndex].value=="mobile"))
	{
		alert("请输入正确的联系电话！");
		document.theform.contacter_mobile.focus();
		return false;
	}

	if (document.theform.num_room.options[document.theform.num_room.selectedIndex].value=="6")
	{
		alert("如果您需要在酒店预订5间以上的房间，请和e龙酒店预订中心联系：8008101010或01064329999，我们会竭诚为您服务。");
		return false;
	}

	if(parseInt(document.theform.time_early.options[document.theform.time_early.selectedIndex].value)>parseInt(document.theform.time_late.options[document.theform.time_late.selectedIndex].value))
	{
		alert("对不起，最早到达时间不能晚于最晚到达时间！");
		document.theform.time_early.focus();
		return false;
	}
	if(parseInt(document.theform.time_late.options[document.theform.time_late.selectedIndex].value)-parseInt(document.theform.time_early.options[document.theform.time_early.selectedIndex].value)>4)
	{
		alert("对不起，最早到达时间与最晚到达时间不能超过四个小时！");
		document.theform.time_early.focus();
		return false;
	}


	if (trim(document.theform.contacter.value)=="")
	{
		alert("请输入联系人姓名！");
		document.theform.contacter.focus;
		return false;
	}
	if (CheckName(document.theform.contacter.value)==false){
		alert("请输入正确的联系人姓名！");
		document.theform.contacter.focus;
		return false;
	}
	if (trim(document.theform.contacter.value.length)<=1)
	{
		alert("请输入联系人姓名全称！");
		document.theform.contacter.focus();
		return false;
	}

	var contacter_sex=false;
	for (i=0;i<document.theform.contacter_sex.length;i++)
	{
		if (document.theform.contacter_sex[i].checked)
		{
			contacter_sex=true;
			break;
		}
	}
	if (!contacter_sex)
	{
		alert("请选择联系人性别！");
		document.theform.contacter.focus();
		return false;
	}
	if (document.theform.phone.value==""&&document.theform.phone_1.value==""&&document.theform.phone_2.value=="")
	{
		alert("请输入联系电话！");
		document.theform.phone.focus();
		return false;
	}
	if ((!(((CompStr(document.theform.phone.value.substring(0,4),'0135')||CompStr(document.theform.phone.value.substring(0,4),'0136')||CompStr(document.theform.phone.value.substring(0,4),'0137')||CompStr(document.theform.phone.value.substring(0,4),'0138')||CompStr(document.theform.phone.value.substring(0,4),'0139')||CompStr(document.theform.phone.value.substring(0,4),'0130')||CompStr(document.theform.phone.value.substring(0,4),'0131')||CompStr(document.theform.phone.value.substring(0,4),'0132')||CompStr(document.theform.phone.value.substring(0,4),'0133'))&&document.theform.phone.value.length==12)||((CompStr(document.theform.phone.value.substring(0,3),'135')||CompStr(document.theform.phone.value.substring(0,3),'136')||CompStr(document.theform.phone.value.substring(0,3),'137')||CompStr(document.theform.phone.value.substring(0,3),'138')||CompStr(document.theform.phone.value.substring(0,3),'139')||CompStr(document.theform.phone.value.substring(0,3),'130')||CompStr(document.theform.phone.value.substring(0,3),'131')||CompStr(document.theform.phone.value.substring(0,3),'132')||CompStr(document.theform.phone.value.substring(0,3),'133'))&&document.theform.phone.value.length==11))) && (document.theform.confirm_method.options[document.theform.confirm_method.selectedIndex].value=="mobile"))
	{
		alert("请输入正确的联系电话！");
		document.theform.phone.focus();
		return false;
	}

	//if ((CompStr(document.theform.phone.value.substring(0,3),'130')||CompStr(document.theform.phone.value.substring(0,3),'131')||CompStr(document.theform.phone.value.substring(0,3),'133')) && (document.theform.confirm_method.options[document.theform.confirm_method.selectedIndex].value=="mobile"))

       // {
               // alert("联通用户暂不能短信确认，请修改确认方式！");
               // document.theform.confirm_method.selectedIndex=2;
               // return false;
       // }


	//只有选择email确认时，必须填写email
	//if(document.theform.confirm_method.value!="mobile")
	if(document.theform.confirm_method.value=="email")
	{

	if (document.theform.email.value=="" || document.theform.email.value.length<6 || document.theform.email.value.indexOf("@")==-1 ||document.theform.email.value.indexOf(".")==-1)
	        {
		         alert("请输入正确的email！");
		         document.theform.email.focus();
		         return false;
	        }
	}
	if(document.theform.confirm_method.value=="fax")
	{

	    if (document.theform.fax.value=="" )
	        {
		         alert("请输入正确的传真电话！");
		         document.theform.fax.focus();
		         return false;
	        }
	}

		 		if (document.theform.getcard.checked==true)
				{
					if (document.theform.postcode.value=="" )
					{
						alert("请输入正确的邮编！");
						//reserve.style.display='';
						document.theform.postcode.focus();
						return false;
					}
				}
				if (document.theform.getcard.checked==true)
				{
					if (document.theform.address.value=="")
					{
						alert("请输入通讯地址！");
						//reserve.style.display='';
						document.theform.address.focus();
						return false;
					}
				}







 }

function change()
{
	if (document.theform.same_p.checked)
	{
		document.theform.contacter.value=document.theform.TxtName[0].value;
		document.theform.phone.value=document.theform.contacter_mobile.value;
		document.theform.phone_1.value=document.theform.contacter_mobile_1.value;
		document.theform.phone_2.value=document.theform.contacter_mobile_2.value;
		var sex;
		sex=document.theform.guest_sex.value;
		if(sex!=""){
			if(sex=="男"){
				document.theform.contacter_sex(0).checked=true;
			}else if(sex=="女"){
				document.theform.contacter_sex(1).checked=true;
			}
		}
	}
	else
	{
		document.theform.contacter.value="";
		document.theform.phone.value="";
		document.theform.phone_1.value="";
		document.theform.phone_2.value="";
	}

}

function change_payment()
{
	if(document.theform.payment.selectedIndex==1)
	{
		now_money.style.display="";
	}
	else
	{
		now_money.style.display="none";
		document.theform.Money_flag.checked=false;
	}
}

///////////////最晚最早到达时间检测函数//////////////////////
function SetLateTime(){
	var ArryTime;
	var Hour;
	var Minu;
	var Str_time_late;

	ArryTime= document.theform.time_early.value.split(":");
	Hour=parseInt(ArryTime[0]);
	Minu=ArryTime[1];

	if ( Hour < 20) {
		Hour=Hour + 4;
		Str_time_late= Hour + ":" + Minu;
	}else{
		Str_time_late="23:59";
	}

	for(i=0;i< document.theform.time_late.options.length;i++){
		if ( document.theform.time_late.options[i].value == Str_time_late) {
			document.theform.time_late.options[i].selected=true;
			return;
		}
	}
}

function ChkLateTime(){
	var ArryEarly;
	var ArryLate;
	var HourEarly;
	var MinuEarly;
	var HourLate;
	var MinuLate;

	ArryEarly= document.theform.time_early.value.split(":");
	ArryLate= document.theform.time_late.value.split(":");
	HourEarly=ArryEarly[0];
	MinuEarly=ArryEarly[1];
	HourLate=ArryLate[0];
	MinuLate=ArryLate[1];

	if ( parseInt(""+HourLate+MinuLate) <= parseInt(""+HourEarly+MinuEarly)) {
		alert("最晚到达时间不能早于最早到达时间！");
		SetLateTime();
		return;
	}


}

function PutInGuest(){
	//var IsFull;
	//IsFull=true;
	for (var i=0;i<document.theform.num_guest.value;i++) {
		if(document.theform.TxtName[i].value==document.theform.guest_name_index.value){
			alert("入住人已经添加");
			return;
		}
	}
	for (var i=0;i<document.theform.num_guest.value;i++) {
		if(document.theform.TxtName[i].value==""){
			document.theform.TxtName[i].value=document.theform.guest_name_index.value;
			return;
		}
	}
	document.theform.TxtName[document.theform.IndexOfGuest.value].value=document.theform.guest_name_index.value;
}

function ChangeGuest(IntArg){
	document.theform.SelNumGuest.value=IntArg;
	for(var i=0;i<document.theform.TxtName.length;i++){
		//document.theform.Text[i-1].style.display="none";
		if (i<IntArg) {
			document.theform.TxtName[i].style.display="";
		}else{
			document.theform.TxtName[i].value="";
			document.theform.TxtName[i].style.display="none";
		}
	}
}

function ResetGuest(){
	var NumGuest;
	if(document.theform.SelNumGuest.value!=""){
		NumGuest=document.theform.SelNumGuest.value;

		//改写可选入住人数量
		var MinGuests;
		var MaxGuests;
		var obj;
		obj=document.theform.num_guest;
		MinGuests=document.theform.num_room.value;
		MaxGuests=MinGuests*3;
		for(var i=obj.length-1;i>=0;i--){
			//obj.options[i] = null;
			obj.remove(i);
		}
		var MaxLength=MaxGuests-MinGuests+1;
		for(var i=0;i<MaxLength;i++){
			obj.options[i]= new Option(MinGuests, MinGuests);
			if (MinGuests==NumGuest) {
				obj.options[i].selected=true;
			}
			MinGuests++;
		}
		for(var i=0;i<document.theform.TxtName.length;i++){
		//document.theform.Text[i-1].style.display="none";
		if (i<NumGuest) {
			document.theform.TxtName[i].style.display="";
		}else{
			document.theform.TxtName[i].value="";
			document.theform.TxtName[i].style.display="none";
		}
	}
	}
}
window.onload=ResetGuest;
</SCRIPT>
<body>
<center>
  <table width="750" height="36" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="402" height="42" valign="bottom">　　<img src="/tea/image/section/10907.gif" width="116" height="18" vspace="6" align="absmiddle"></td>
    </tr>
</table>
  <table width="750" height="6" border="0" cellpadding="0" cellspacing="0" bgcolor="#1EA817">
    <tr>
      <td><img SRC="/img/z.gif" width="1" height="1"></td>
    </tr>
</table>
  <br><table width="735" height="92" border="0" cellpadding="0" cellspacing="0" ID="Table2">
     <tr>
      <td align="center">

	<form name="theform" action="/servlet/EditDestine" method="post" onSubmit="return check();" target="_self">
            <input type=hidden name="SelNumGuest"  id="SelNumGuest" value="">


  <input type="hidden" name="hotel_name" value="北京天伦王朝饭店">

  <input type="hidden" name="card_no" value="7010900000">

  <input type="hidden" name="hotel_id" value="40101039">
   <input type="hidden" name="id" value="348">
  <input type="hidden" name="room_type_id" value="0010">
  <input type="hidden" name="room_type" value="豪华标间">
  <input type="hidden" name="rq_stay" value="2004-11-20">
  <input type="hidden" name="rq_leave" value="2004-11-25">
  <input type="hidden" name="currency_id" value="">
  <input type="hidden" name="guest_type_id" value="1001">
  <input type="hidden" name="sum_price" value="0">
  <input type="hidden" name="add_bed_price" value="1000">
  <input type="hidden" name="num_night" value="5">
  <input type="hidden" name="weekend_days" value="2">
  <input type="hidden" name="tempuser" value="0">
  <input type="hidden" name="tempusers" value="0">
  <input type="hidden" name="zc" value="">
  <input type="hidden" name="double_credit" value="1">
<input type=hidden name=no_card value="yes">
<input type="hidden" name="add_bed_price_all" value="">



<script language="javascript">
<!--
	//动态显示总金额

	var js_price;
	var js_MsPrice;
	var js_double_credit;
	var str_percent;

	//金额格式化后的字符串数组
	var ArryPrice=new Array(4);
ArryPrice[0]="4,995.00";ArryPrice[1]="9,990.00";ArryPrice[2]="14,985.00";ArryPrice[3]="19,980.00";str_percent="(省39%)";


	js_price = 4995;
	js_MsPrice= 8300;
	js_double_credit = 1;


	//TxtMoney.value=ArryPrice[0];
	TxtMsPrice.value="门市价RMB" + js_MsPrice;
	TxtMemPrice.value=js_price + str_percent;
	TxtAmount.value=(js_price*js_double_credit+500) + "分";

	function ChangeTotal(val){
		if ((document.theform.num_room.value)==5){
			alert('如果您需要在酒店预订5间或5间以上的房间，请和e龙酒店预订中心联系：8008101010或01064329999，我们会竭诚为您服务。');
			document.theform.num_room.selectedIndex=0;
			//TxtMoney.value=ArryPrice[0];
			TxtMsPrice.value="门市价RMB" + js_MsPrice;
			TxtMemPrice.value=js_price + str_percent;
			TxtAmount.value=(js_price*js_double_credit+500) + "分";

		}else{

			//TxtMoney.value=ArryPrice[val-1];
			TxtMsPrice.value="门市价RMB" + js_MsPrice*val;
			TxtMemPrice.value=js_price*val + str_percent;
			TxtAmount.value=(js_price*val*js_double_credit+500) + "分";
		}

		//改写可选入住人数量
		var MinGuests;
		var MaxGuests;
		var obj;
		obj=document.theform.num_guest;
		MinGuests=document.theform.num_room.value;
		MaxGuests=MinGuests*3;

		ChangeGuest(MinGuests);

		for(var i=obj.length-1;i>=0;i--){
			//obj.options[i] = null;
			obj.remove(i);
		}
		var MaxLength=MaxGuests-MinGuests+1;
		for(var i=0;i<MaxLength;i++){
			obj.options[i]= new Option(MinGuests, MinGuests);
			MinGuests++;
		}


	}

	//-->
</SCRIPT>


      	<table width="750" height="30" border="0" cellpadding="0" cellspacing="0" bgcolor="#1EA817">
          <tr>
              <td style="color:white;">　<img src="/tea/image/section/10908.gif" width="13" height="13" align="absmiddle">
                <strong>入住信息</strong></td>
          </tr>
        </table>
          <table width="750" border="0" cellspacing="1" cellpadding="0">
             <tr>
              <td height="30" bgcolor="#E5F6E4">　　房间数量：　　
                <select name="roomCount" id="roomCount" onchange="javascript:ChangeTotal(this.value);">
                  <option selected value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5或5间以上</option>
                </select> <font color="#1EA817">※</font></td>
            </tr>
             <tr>
              <td height="30" bgcolor="#E5F6E4">　　入住人数：　　
                <select name="humanCount" id="num_guest" onchange="javascript:ChangeGuest(this.value);">
                  <option selected value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                </select> <font color="#1EA817">※</font></td>
            </tr>
			<!--anboo-->
			<tr>
				<td height="30" bgcolor="#E5F6E4">
				<table width="100%" border="0" ID="Table2">
                 <tr>
                   <td width="106" valign="middle" rowspan="2">　　入 住 人：　　</td>
				 	<td>
					</td>
				 </tr>
				 <tr>
                   <td width="572">
<input name="humanName" type="text" class="inputmodify" style="width:80px;display:" onfocus="javascript:document.theform.IndexOfGuest.value='0';" value="<%=teasession._rv%>" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='1';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='2';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='3';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='4';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='5';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='6';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='7';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='8';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='9';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='10';" onmouseover="javascript:this.select();this.focus();">
<input name="TxtName" type="text" class="inputmodify" style="width:80px;display:none" onfocus="javascript:document.theform.IndexOfGuest.value='11';" onmouseover="javascript:this.select();this.focus();">
<font color="#1EA817">※</font>
<input type="hidden" name="guest_sex" value="">
<input type="hidden" name="IndexOfGuest" value="0">
 </td>
                 </tr>
               </table>
				</td>
			</tr>

            <tr>
              <td height="30" bgcolor="#E5F6E4">　　手机号码：　　
                <input name="handset" type="text" class="inputmodify" style="width:148px;" value="<%=profile.getMobile()%>" size="15"> <font color="#1EA817">※</font>　　如果没有手机，请留下座机号码：
                <input name="contacter_mobile_1" type="text" class="inputmodify" style="width:50px;" size=4 maxlength=5>-<input type=text value="<%=profile.getTelephone(teasession._nLanguage)%>" name=phone size=14 maxlength=20 class="inputmodify" style="width:70px;"></td>
            </tr>
            <tr>
              <td height="30" bgcolor="#E5F6E4">　　房间类型：　　
			  高级园景房&nbsp;<font color="#1EA817">※</font></td>
            </tr>
<input type="hidden" value="" name="roomType"/>
            <tr>
              <td height="30" bgcolor="#E5F6E4">　　住店日期：　　
			  <input class="text" type="text" maxLength="12" size="9" value="" name="kipDate" ID="Text3">&nbsp;<a href="javascript:ShowCalendar('condition.BEGIN_DATE')" target="_self"><img id="dimg3" style="POSITION: relative" src="/tea/image/section/10912.gif"  border="0" align="absmiddle"></a>　　离开日期：
			  <input class="text" type="text" maxLength="12" size="9" value="" name="leaveDate" ID="Text4">&nbsp;<a href="javascript:ShowCalendar('condition.END_DATE')" target="_self"><img id="dimg4" style="POSITION: relative" src="/tea/image/section/10912.gif"  border="0" align="absmiddle"></a>&nbsp;&nbsp; <font color="#1EA817">※</font></td>
            </tr>
            <tr>
              <td height="30" bgcolor="#E5F6E4">　　最早到达时间：
                <select name="earlyArrive" id="time_early" onChange="javascript:SetLateTime()">
                  <option value="10:00">10:00</option>
                  <option value="10:30">10:30</option>
                  <option value="11:00">11:00</option>
                  <option value="11:30">11:30</option>
                  <option value="12:00" selected>12:00</option>
                  <option value="12:30">12:30</option>
                  <option value="13:00">13:00</option>
                  <option value="13:30">13:30</option>
                  <option value="14:00">14:00</option>
                  <option value="14:30">14:30</option>
                  <option value="15:00">15:00</option>
                  <option value="15:30">15:30</option>
                  <option value="16:00">16:00</option>
                  <option value="16:30">16:30</option>
                  <option value="17:00">17:00</option>
                  <option value="17:30">17:30</option>
                  <option value="18:00">18:00</option>
                  <option value="18:30">18:30</option>
                  <option value="19:00">19:00</option>
                  <option value="19:30">19:30</option>
                  <option value="20:00">20:00</option>
                  <option value="20:30">20:30</option>
                  <option value="21:00">21:00</option>
                  <option value="21:30">21:30</option>
                  <option value="22:00">22:00</option>
                  <option value="22:00">22:30</option>
                  <option value="23:00">23:00</option>
                  <option value="23:30">23:30</option>
                  <option value="23:59">23:59</option>
                </select>
                <font color="#1EA817">※</font></td>
            </tr>
            <tr>
              <td height="30" bgcolor="#E5F6E4"><font color="#1EA817">　　</font>最晚到达时间：
                <select name="eveningArrive" id="time_late" onChange="javascript:ChkLateTime()">
                  <option value="10:00">10:00</option>
                  <option value="10:30">10:30</option>
                  <option value="11:00">11:00</option>
                  <option value="11:30">11:30</option>
                  <option value="12:00">12:00</option>
                  <option value="12:30">12:30</option>
                  <option value="13:00">13:00</option>
                  <option value="13:30">13:30</option>
                  <option value="14:00">14:00</option>
                  <option value="14:30">14:30</option>
                  <option value="15:00">15:00</option>
                  <option value="15:30">15:30</option>
                  <option value="16:00" selected>16:00</option>
                  <option value="16:30">16:30</option>
                  <option value="17:00">17:00</option>
                  <option value="17:30">17:30</option>
                  <option value="18:00">18:00</option>
                  <option value="18:30">18:30</option>
                  <option value="19:00">19:00</option>
                  <option value="19:30">19:30</option>
                  <option value="20:00">20:00</option>
                  <option value="20:30">20:30</option>
                  <option value="21:00">21:00</option>
                  <option value="21:30">21:30</option>
                  <option value="22:00">22:00</option>
                  <option value="22:00">22:30</option>
                  <option value="23:00">23:00</option>
                  <option value="23:30">23:30</option>
                  <option value="23:59">23:59</option>
                </select> <font color="#1EA817"> <font color="#1EA817">※</font></font></td>
            </tr>
            <tr>
              <td height="30" bgcolor="#E5F6E4">　　客人类型：　　
			  内宾&nbsp;<font color="#1EA817">※</font></td>
            </tr>
<tr>
              <td height="30" bgcolor="#E5F6E4">　　付款类型：　　
<select name="paymentType">
<%for(int i=0;i<RoomPrice.PAYMENT.length;i++) {%>
  <option value="<%=i%>"><%=r.getString(teasession._nLanguage,RoomPrice.PAYMENT[i])%></option>
<%}%>
</select>
                <input type=hidden name=payment value="P">

                <font color="#1EA817">※</font></td>
            </tr>

          </table>
    <table width="750" height="30" border="0" cellpadding="0" cellspacing="0" bgcolor="#1EA817">
          <tr>
              <td style="color:white;">　<img src="/tea/image/section/10908.gif" width="13" height="13" align="absmiddle">
                <strong>联系人信息</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <input  id=CHECKBOX type="CHECKBOX" name=same_p onclick="javascript:change();" checked>&nbsp;与入住人相同

            </td>
          </tr>
        </table>


          <table width="750" border="0" cellspacing="1" cellpadding="0">
            <tr>
              <td height="30" bgcolor="#E5F6E4">　　联系人姓名：

                &nbsp;&nbsp;<input name="linkmanName" type="text" class="inputmodify" style="width:148px;" value="" size="15"> <font color="#1EA817">※</font></td>
            </tr>
            <tr>
              <td height="30" bgcolor="#E5F6E4"> 　　性 　　别：　
			  <input  id="radio" type="radio" value="男" name="linkmanSex" <%=getCheck(profile.getAge()==1)%>>
                男
                <input  id="radio" type="radio" name="linkmanSex" value="女" <%=getCheck(profile.getAge()==0)%>>
                女 <font color="#1EA817">※</font></td>
            </tr>
            <tr>
              <td height="30" bgcolor="#E5F6E4">　　手机号码：　　
			  <input name="linkmanHandset" type="text" class="inputmodify" style="width:148px;" value="" size="15"> <font color="#1EA817">※</font>　　如果没有手机，请留下座机号码：
                <input name="phone_1" type="text" class="inputmodify" style="width:50px;" size=4 maxlength=5>-<input type=text name=linkmanPhone size=14 maxlength=20 class="inputmodify" style="width:70px;"></td>
            </tr>
            <tr>
              <td height="30" bgcolor="#E5F6E4">　　电子邮件：　　
			  <input name="linkmanMail" type="text" class="inputmodify" style="width:180px;" value="<%=profile.getEmail()%>" size="25">
              </td>
            </tr>
            <tr>
              <td height="30" bgcolor="#E5F6E4">　　传　　真：　　
			  <input name="linkmanFax" type="text" class="inputmodify" style="width:180px;" value="<%=profile.getFax(teasession._nLanguage)%>" size="15">
                <font color="#1EA817">※</font></td>
            </tr>
            <tr>
              <td height="30" bgcolor="#E5F6E4">　　确认方式：　　
			  <select name="linkmanAffirm">
                  <option value="noneed">不需确认<option value="mobile" selected>使用短信来确认<option value="phone">使用电话来确认<option value="fax">使用传真来确认<option value="email">使用e-mail来确认
                </select>
                <font color="#1EA817">※</font>　　　　　　　　　　　　</td>
            </tr>
            <tr>
              <td height="45" align="center" bgcolor="#E5F6E4"><font color="#DC441C"><strong>为了与您及时确认并联系，请您确认留下的联系方式</strong></font></td>
            </tr>
          </table>

          <table width="750" height="30" border="0" cellpadding="0" cellspacing="0" bgcolor="#1EA817">
            <tr>
              <td style="color:white;">　<img src="/tea/image/section/10908.gif" width="13" height="13" align="absmiddle">
                <strong>其他信息</strong></td>
            </tr>
          </table>

	<script language="javascript">
	function CompStr(Str1,Str2)
	{if (Str1==Str2) return true;
	else return false;}
	</script>
          <table width="750" border="0" cellpadding="6" cellspacing="0" bgcolor="#E5F6E4">

            <input type=hidden name="upproxy"  id="upproxy2" value="">


			<tr id=mobilesend style="DISPLAY: yes">
			<td colspan="2" class="10h">当您成功入住酒店后，我们会按照您填写的邮编地址，在15天内给您邮寄一张”“及最新商旅手册。</td>
            </tr>
			<tr id=mobilesend style="DISPLAY: yes">
			<td colspan=2 class="10h">
			<input name="otherSend"  id="CHECKBOX" type="CHECKBOX"  value="no" >
			我需要（注：如果您需要寄卡，请确保您填写的会员注册信息是真实的,我们会按此邮寄。）
			</td>
			</tr>
			<tr id=mobilesend style="DISPLAY: yes">
				  <td>&nbsp;&nbsp;邮政编码：</td>
			  	  <td><input type=text name="otherPostalcode" class="inputmodify" size=6 value="<%=profile.getZip(teasession._nLanguage)%>" maxlength=6></td>
			</tr>
			<tr id=mobilesend style="DISPLAY: yes">
				  <td>&nbsp;&nbsp;通讯地址：</td>
				  <td><input type=text name="otherAddress" class="inputmodify" size=30 maxlength=64 value="<%=profile.getAddress(teasession._nLanguage)%>"></td>
			</tr>


            <tr>
              <td valign="top">　特殊要求： </td>
              <td><textarea name="otherRequest" rows="5" class="inputmodify" style="width:500px;"></textarea></td>
            </tr>
            <tr valign="top">
              <td width="90" height="45">

                　加床数量： </td>
              <td width="573"><input name="otherAddBed" type="text" class="inputmodify" style="width:70px;" size="3" maxlength="3" value="">

                如您在最晚到店时间以后到店，请及时与我们联系<strong><font color="#DC441C">(86-10-64329999)</font></strong></td>

            </tr>
          </table>



          <table width="750" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="719" height="50" align="center">
		<input name="Input" type="image" src="/tea/image/section/10909.gif" width="75" height="21">
                <input name="Input" type="image" onClick="reset();return false;" src="/tea/image/section/10910.gif" width="75" height="21"></td>
            </tr>
        </table>
          <input type="hidden" name="campaign_id" value="">
        </form>


      </td>
    </tr>
</table></body>

