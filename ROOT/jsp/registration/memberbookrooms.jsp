<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.db.*" %>
<%
TeaSession teasession = new TeaSession(request);
Community community =Community.find(teasession._strCommunity);
StringBuffer sql=new StringBuffer();
String member = request.getParameter("member");
String kipDateFlag, leaveDateFlag;

%>

<html>
<head>
<link  href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<title>audits</title>
<SCRIPT LANGUAGE=JAVASCRIPT>
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
	/*
	TxtMsPrice.value="门市价RMB" + js_MsPrice;
	TxtMemPrice.value=js_price + str_percent;
	TxtAmount.value=(js_price*js_double_credit+500) + "分";

	function ChangeTotal(val){
		if ((document.form1.num_room.value)==5){
			alert('如果您需要在酒店预订5间或5间以上的房间，请和e龙酒店预订中心联系：8008101010或01064329999，我们会竭诚为您服务。');
			document.form1.num_room.selectedIndex=0;
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
		obj=document.form1.num_guest;
		MinGuests=document.form1.num_room.value;
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

*/

function ShowCalendar(fieldname)
{
 // myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
 // mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
// window.open('/jsp/type/hostel/Calendar.jsp');
 window.showModalDialog("Calendar2.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+200+"px;dialogLeft:"+300+"px");
 // window.showModalDialog("Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
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

	ErrChar="!@#$%^&*()_+|-=\\~`;'[]{}\"':;,./<>?～！@#￥％^&×（）……＋|－＝、〔〕｛｝：“；‘《》？，。、0123456789";
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

function check()
{
  var i;
  var Guests;
  var Rooms;
  var NumDisplay;
  var GuestName;


  Guests=0;
  NumDisplay=0;
  Rooms=document.form1.num_room.value;
  for (i=0;i<(document.form1.num_guest.value);i++)
  {
    if (document.form1.TxtName[i].style.display!="none")
    {
      NumDisplay=NumDisplay+1;
    }

    GuestName=trim(document.form1.TxtName[i].value);
    if (GuestName!="")
    {
      if (CheckName(GuestName)==false)
      {
        document.form1.TxtName[i].focus();
        alert("请输入正确的客人姓名！");
        return false;
      }
      Guests=Guests+1;
    }
  }

  if (Guests<Rooms)
  {
    alert("请至少添加"+Rooms+"个入住人！");
    if (NumDisplay<Rooms) {
      document.form1.num_guest.focus();
    }else{
      document.form1.TxtName[Guests].focus();
    }
    return false;
  }
  for (i=0;i<(document.form1.num_guest.value);i++)
  {
    if(document.form1.TxtName[i].value.length<=1)
    {
      alert("请输入客人姓名全称！");
      document.form1.TxtName[i].focus();
      return false;
    }
  }

  for (i=0;i<(document.form1.num_guest.value);i++)
  {
    if (document.form1.TxtName[i].value!="")
    {
      guestName=document.form1.TxtName[i].value;
      for (var k=i+1;k<(document.form1.num_guest.value);k++)
      {
        if (guestName==document.form1.TxtName[k].value)
        {
          alert("入住人姓名不能重复！");
          document.form1.TxtName[k].focus();
          return false;
        }
      }
    }
  }


  if (document.form1.handset.value==""&&document.form1.phone.value=="")
  {
    alert("请输入联系电话！");
    document.form1.handset.focus();
    return false;
  }

  if ((!(((CompStr(document.form1.handset.value.substring(0,4),'0135')||CompStr(document.form1.handset.value.substring(0,4),'0136')||CompStr(document.form1.handset.value.substring(0,4),'0137')||CompStr(document.form1.handset.value.substring(0,4),'0138')||CompStr(document.form1.handset.value.substring(0,4),'0139')||CompStr(document.form1.handset.value.substring(0,4),'0130')||CompStr(document.form1.handset.value.substring(0,4),'0131')||CompStr(document.form1.handset.value.substring(0,4),'0132')||CompStr(document.form1.handset.value.substring(0,4),'0133'))&&document.form1.handset.value.length==12)||((CompStr(document.form1.handset.value.substring(0,3),'135')||CompStr(document.form1.handset.value.substring(0,3),'136')||CompStr(document.form1.handset.value.substring(0,3),'137')||CompStr(document.form1.handset.value.substring(0,3),'138')||CompStr(document.form1.handset.value.substring(0,3),'139')||CompStr(document.form1.handset.value.substring(0,3),'130')||
  CompStr(document.form1.handset.value.substring(0,3),'131')||CompStr(document.form1.handset.value.substring(0,3),'132')||CompStr(document.form1.handset.value.substring(0,3),'133'))&&document.form1.handset.value.length==11)))&&(document.form1.linkmanAffirm.options[document.form1.linkmanAffirm.selectedIndex].value=="mobile"))
  {
    alert("请输入正确的联系电话！");
    document.form1.handset.focus();
    return false;
  }

  if (document.form1.kipDateFlag.value=="")
  {
    alert("请输入住店日期！");
    document.form1.kipDateFlag.focus();
    return false;
  }
  if (document.form1.leaveDateFlag.value=="")
  {
    alert("请输入离开日期！");
    document.form1.leaveDateFlag.focus();
    return false;
  }
  if (document.form1.num_room.options[document.form1.num_room.selectedIndex].value=="6")
  {
    alert("如果您需要在酒店预订5间以上的房间，请和e龙酒店预订中心联系：8008101010或01064329999，我们会竭诚为您服务。");
    return false;
  }

  if(parseInt(document.form1.time_early.options[document.form1.time_early.selectedIndex].value)>parseInt(document.form1.time_late.options[document.form1.time_late.selectedIndex].value))
  {
    alert("对不起，最早到达时间不能晚于最晚到达时间！");
    document.form1.time_early.focus();
    return false;
  }
  if(parseInt(document.form1.time_late.options[document.form1.time_late.selectedIndex].value)-parseInt(document.form1.time_early.options[document.form1.time_early.selectedIndex].value)>4)
  {
    alert("对不起，最早到达时间与最晚到达时间不能超过四个小时！");
    document.form1.time_early.focus();
    return false;
  }


  if (trim(document.form1.linkmanName.value)=="")
  {
    alert("请输入联系人姓名！");
    document.form1.linkmanName.focus();
    return false;
  }
  if (CheckName(document.form1.linkmanName.value)==false){
    alert("请输入正确的联系人姓名！");
    document.form1.linkmanName.focus();
    return false;
  }
  if (trim(document.form1.linkmanName.value.length)<=1)
  {
    alert("请输入联系人姓名全称！");
    document.form1.linkmanName.focus();
    return false;
  }
/*
	var contacter_sex=false;
	for (i=0;i<document.form1.contacter_sex.length;i++)
	{
		if (document.form1.contacter_sex[i].checked)
		{
			contacter_sex=true;
			break;
		}
	}
	if (!contacter_sex)
	{
		alert("请选择联系人性别！");
		document.form1.contacter.focus();
		return false;
	}*/
	/*if (document.form1.linkmanHandset.value==""&&document.form1.linkmanPhoneStart.value==""&&document.form1.linkmanPhoneEnd.value=="")
	{
		alert("请输入联系电话！");
		document.form1.linkmanHandset.focus();
		return false;
	}*/
        if (document.form1.linkmanHandset.value==""&&document.form1.linkmanphone.value=="")
        {
          alert("请输入联系电话！");
          document.form1.linkmanHandset.focus();
          return false;
        }
        if ((!(((CompStr(document.form1.linkmanHandset.value.substring(0,4),'0135')||CompStr(document.form1.linkmanHandset.value.substring(0,4),'0136')||CompStr(document.form1.linkmanHandset.value.substring(0,4),'0137')||CompStr(document.form1.linkmanHandset.value.substring(0,4),'0138')||CompStr(document.form1.linkmanHandset.value.substring(0,4),'0139')||CompStr(document.form1.linkmanHandset.value.substring(0,4),'0130')||CompStr(document.form1.linkmanHandset.value.substring(0,4),'0131')||CompStr(document.form1.linkmanHandset.value.substring(0,4),'0132')||CompStr(document.form1.linkmanHandset.value.substring(0,4),'0133'))&&document.form1.linkmanHandset.value.length==12)||((CompStr(document.form1.linkmanHandset.value.substring(0,3),'135')||CompStr(document.form1.linkmanHandset.value.substring(0,3),'136')||CompStr(document.form1.linkmanHandset.value.substring(0,3),'137')||CompStr(document.form1.linkmanHandset.value.substring(0,3),'138')||
        CompStr(document.form1.linkmanHandset.value.substring(0,3),'139')||CompStr(document.form1.linkmanHandset.value.substring(0,3),'130')||CompStr(document.form1.linkmanHandset.value.substring(0,3),'131')||CompStr(document.form1.linkmanHandset.value.substring(0,3),'132')||CompStr(document.form1.linkmanHandset.value.substring(0,3),'133'))&&document.form1.linkmanHandset.value.length==11))) && (document.form1.linkmanAffirm.options[document.form1.linkmanAffirm.selectedIndex].value=="mobile"))
        {
          alert("请输入正确的联系电话！");
          document.form1.linkmanHandset.focus();
          return false;
        }

	//if ((CompStr(document.form1.phone.value.substring(0,3),'130')||CompStr(document.form1.phone.value.substring(0,3),'131')||CompStr(document.form1.phone.value.substring(0,3),'133')) && (document.form1.linkmanAffirm.options[document.form1.linkmanAffirm.selectedIndex].value=="mobile"))

       // {
               // alert("联通用户暂不能短信确认，请修改确认方式！");
               // document.form1.linkmanAffirm.selectedIndex=2;
               // return false;
       // }


	//只有选择email确认时，必须填写email
	//if(document.form1.linkmanAffirm.value!="mobile")
	if(document.form1.linkmanAffirm.value=="email")
	{

	if (document.form1.linkmanMail.value=="" || document.form1.linkmanMail.value.length<6 || document.form1.linkmanMail.value.indexOf("@")==-1 ||document.form1.linkmanMail.value.indexOf(".")==-1)
	        {
		         alert("请输入正确的email！");
		         document.form1.linkmanMail.focus();
		         return false;
	        }
	}
	if(document.form1.linkmanAffirm.value=="fax")
	{

	    if (document.form1.linkmanFax.value=="" )
	        {
		         alert("请输入正确的传真电话！");
		         document.form1.linkmanFax.focus();
		         return false;
	        }
	}

        if (document.form1.otherSend.checked==true)
        {
          if (document.form1.otherPostalcode.value=="" )
          {
            alert("请输入正确的邮编！");
            //reserve.style.display='';
            document.form1.otherPostalcode.focus();
            return false;
          }
        }
        if (document.form1.otherSend.checked==true)
        {
          if (document.form1.otherAddress.value=="")
          {
            alert("请输入通讯地址！");
            //reserve.style.display='';
            document.form1.otherAddress.focus();
            return false;
          }
        }

        if(document.form1.otherRequest.value.lengTD>255)
        {
          alert("特殊要求不能长余255个字符！");
          document.form1.otherRequest.focus();
          return false;
        }
        return submitInteger(document.form1.otherAddBed,"无效数量");
      }

</SCRIPT>

</head>
<body>
<h1>会员预定房间</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<h2>预定信息</h2>
<form name="form1" action="editmbookrooms.jsp">
<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>房间数量：</td>
<td><select name="roomnumber">
  <option value="1">1</option>
  <option value="2">2</option>
  <option value="3">3</option>
  <option value="4">4</option>
  <option value="5">5</option>
  <option value="6">6</option>
  <option value="7">7</option>
  <option value="8">8</option>
  <option value="9">9</option>
  <option value="10">10</option>
  <option value="11">11</option>
  <option value="...">...</option>
</select></td>
</tr>
   <tr>
      <TD>住店日期：　　</TD>
      <td><input class="text" readonly="readonly" type="text" maxLength="12" size="9" value="<%//=kipDateFlag%>" name="kipDateFlag" ID="Text3">&nbsp;
        <a href="javascript:ShowCalendar('form1.kipDateFlag')" target="_self"> <img id="dimg3" style="POSITION: relative" src="/tea/image/public/Calendar.gif" border="0" align="middle" alt=""></a> 　　
      离开日期：
        <input class="text"  readonly="readonly" type="text" maxLength="12" size="9" value="<%//=leaveDateFlag%>" name="leaveDateFlag" ID="Text4">&nbsp;
        <a href="javascript:ShowCalendar('form1.leaveDateFlag')" target="_self"> <img id="dimg4" style="POSITION: relative" src="/tea/image/public/Calendar.gif" border="0" align="middle" alt=""></a>
      &nbsp;&nbsp; <font color="#1EA817">※</font> </td>
    </tr>

<tr>
<td>最晚到达时间：</td>
<td><select name="latetime">
<option value="16:00">16:00</option>
<option value="17:00">17:00</option>
<option value="18:00">18:00</option>
<option value="19:00">19:00</option>
<option value="20:00">20:00</option>
<option value="21:00">21:00</option>
<option value="22:00">22:00</option>
<option value="23:00">23:00</option>
<option value="24:00">24:00</option>
</select></td>
</tr>
<tr>
<td>房间类型：</td>
<td>一室一厅</td>
</tr>
</table>
<h2>入住信息</h2>
<!--此处师傅写的是提交给自己-->
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
</tr>
<tr>
<td><label>入住人：</label></td>
<td><input type="text" name="liveperson" /></td><!--入住人-->
</tr>
<tr>
<td>性别：</td>
<td>
<input type="radio" name="lsex" value="1" id="gender_0" checked="checked"/>
<label for="gender_0">男</label>
<input type="radio" name="lsex" value="0" id="gender_1" />
<label for="gender_1">女</label>
</td>
</tr>
 <tr>
 <td><label>手机号码：</label></td>
 <td><input type="text" name="lmobile"/>※&nbsp;&nbsp;&nbsp;如果没有手机，请留下座机号码：<input type="text" name="ltelephone"/></td>
  </tr>
<tr>
<td><label>付款类型：</label></td>
<td><select name="type">
<option value="0">门市价 </option>
<option value="1">前台现付价 </option>
<option value="2">网上支付价 </option>
<option value="3">周末价 </option>
</select></td>
</tr>
</table>
<h2>联系人信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
 <td><input type="checkbox" name="contactinfo"/>与入住人相同</td>
 <td>&nbsp;</td>
</tr>
<tr>
<td>联系人姓名：</td>
<td><input type="text" name="contactname" />※</td>
</tr>
 <tr>
<td>性别：</td>
<td><!--需要修改的地方之一-->
<input type="radio" name="csex" value="1" id="gender_0" checked="checked"/>
<label for="gender_0"> 男</label>
<input type="radio" name="csex" value="0" id="gender_1" />
<label for="gender_1">女</label>
</td>
</tr>
 <tr>
<td>手机号码：</td>
<td><input type="text" name="cmobile" />※&nbsp;&nbsp;&nbsp;如果没有手机，请留下座机号码：<input type="text" name="ctelephone" /></td>
</tr>
<tr>
<td>电子邮件：</td>
<td> <input type="text" name="cemail" />※</td>
</tr>
<tr>
<td>传真：</td>
<td> <input type="text" name="cfax" />※</td>
</tr>
<tr>
<td>确认方式：</td>
<td><select name="qrtype">
<option value="SMS">使用短信来确认</option>
</select>※</td>
</tr>
</table>
<h2 style="color:red;text-align:center;">为了与您及时确认并联系，请您确认留下的联系方式</h2>
<h2>特殊要求</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  <td>旅客留言：</td>
  <td>
    <textarea cols="110" rows="5" name="liveword"></textarea>
  </td>
  </tr>
  <tr>
  <td>&nbsp;</td>
  <td>最多255个字符</td>
</tr>
  <tr>
 <td>加床数量：</td>
<td><input name="addbed" type="text"/>&nbsp;&nbsp;<label>如您在最晚到店时间以后到店，请及时与我们联系.</label></td>
</tr>
</table>
<h2>酒店说明</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
<tr>
<td colspan="2">当您成功入住酒店后，我们会按照您填写的邮编地址，在15天内给您邮寄一张""及最新商旅手册. </td>
</tr>
 <tr>
<td colspan="2"><input type="checkbox" name="need"/><label>我需要（注：如果您需要寄卡，请确保您填写的会员注册信息是真实的，我们会按此邮寄。）</label></td>
</tr>
 <tr>
 <td>邮政编码：</td>
 <td><input name="postcode" type="text"/></td>
</tr>
  <tr>
 <td>通讯地址：</td>
 <td><input name="postaddress" type="text"/></td>
</tr>
</table>
<tr>
<td colspan="2" align="center"><input type="submit" value=" 提 交 " /></td>
</tr>
</form>
</body>
</html>
