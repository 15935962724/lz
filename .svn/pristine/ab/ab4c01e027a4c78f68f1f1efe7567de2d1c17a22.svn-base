<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.lvyou.LvyouJobCatagory"%>
<%@page import="tea.entity.lvyou.LvyouModels "%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

if(teasession._rv==null)
{
	out.println("您没有登录，请登录后操作");
	return;
}

tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = teasession.getParameter("nexturl");
String member = teasession.getParameter("member");
Profile p = Profile.find(member);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
<script src="/jsp/custom/westrac/script.js"></script>

<script type="text/javascript">

function f_sub()
{


	if(form1.member.value=='')
	{
		document.getElementById("member_id").innerHTML='用户名不能为空';
		form1.member.focus();
		return false;
	}else if(form1.member.value.indexOf("<")!=-1||form1.member.value.indexOf(">")!=-1)
	{
		document.getElementById("member_id").innerHTML='用户名中含有非法字符';
		form1.member.focus();
		return false;
	}

	if(form1.membername.value=='')
	{
		document.getElementById("membername_id").innerHTML='姓名不能为空';
		form1.membername.focus();
		return false;

	}
	document.getElementById("membername_id").innerHTML='';


	if(form1.EnterPassword.value.length<6 || form1.EnterPassword.value.length>18)
    {

        document.getElementById("EnterPassword_id").innerHTML='密码必须为6到18位之间';
        form1.EnterPassword.focus();
        return false;
    }
	document.getElementById("EnterPassword_id").innerHTML='';

    if(form1.ConfirmPassword.value!=form1.EnterPassword.value)
    {
       document.getElementById("ConfirmPassword_id").innerHTML='两次密码输入不一致';
       form1.ConfirmPassword.focus();
       return false;
   }
    document.getElementById("ConfirmPassword_id").innerHTML='';

    if(form1.card.value=='')
    {
    	document.getElementById("card_id").innerHTML='身份证号不能为空';
    	form1.card.focus();
        return false;

    }else if (!isIdCardNo(form1.card.value)){

    	   document.getElementById("card_id").innerHTML='身份证号的格式不正确';
    	   form1.card.focus();
    	   return false;

    }
    document.getElementById("card_id").innerHTML='';

    if(form1.mobile.value=='')
    {
    	  document.getElementById("mobile_id").innerHTML='手机不能为空';
   	    form1.mobile.focus();
   	    return false;
    }else
    {
    	var str = form1.mobile.value;
      //  var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
      var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
      if(!reg.test(str)){
        	document.getElementById("mobile_id").innerHTML='手机格式不正确';
       	    form1.mobile.focus();
       	    return false;
        }
    }

    document.getElementById("mobile_id").innerHTML='';

    if(form1.birth.value=='')
    {
    	  document.getElementById("birth_id").innerHTML='生日不能为空';
   	    form1.birth.focus();
   	    return false;
    }

    document.getElementById("birth_id").innerHTML='';


	if(form1.city0.value=='')
	{
		document.getElementById("city_id").innerHTML='现工作地省份不能为空';
   	    form1.city0.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';
	if(form1.city1.value=='')
	{
		document.getElementById("city_id").innerHTML='现工作地市不能为空';
   	    form1.city1.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';
	if(form1.address.value==''){

		document.getElementById("city_id").innerHTML='现工作地详细地址不能为空';
   	    form1.address.focus();
   	    return false;
	}

	document.getElementById("city_id").innerHTML='';

if(form1.source.value==0){

		document.getElementById("source_id").innerHTML='请选择从何得知履友联盟';
   	    form1.source.focus();
   	    return false;
	}

	document.getElementById("source_id").innerHTML='';
	if(form1.source.value==1)
	{

			if(form1.trainname.value==''){

					document.getElementById("trainname_id").innerHTML='哪次培训不能为空';
			   	    form1.trainname.focus();
			   	    return false;
				}
				document.getElementById("trainname_id").innerHTML='';
			if(form1.trainaddress.value==''){

					document.getElementById("trainaddress_id").innerHTML='培训地点不能为空';
			   	    form1.trainaddress.focus();
			   	    return false;
				}
				document.getElementById("trainaddress_id").innerHTML='';

			if(form1.traintime.value==''){

					document.getElementById("traintime_id").innerHTML='培训时间不能为空';
			   	    form1.traintime.focus();
			   	    return false;
				}
				document.getElementById("traintime_id").innerHTML='';
	}else if(form1.source.value==2)

	{
		 if(form1.tjmember.value=='')
		  {

				document.getElementById("tjmember_info").innerHTML='荐人会员编号或用户名不能为空';
		   	    form1.tjmember.focus();
		   	    return false;
			}
			//document.getElementById("tjmember_id").innerHTML='';
	}else if(form1.source.value==3)
	{
		if(form1.belsell.value==''){

				document.getElementById("belsell_id").innerHTML='销售员姓名不能为空';
		   	    form1.belsell.focus();
		   	    return false;
			}
			document.getElementById("belsell_id").innerHTML='';
			 if(form1.tjmobile.value!=''){
		    	var str = form1.tjmobile.value;
		      //  var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
		      var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
		    //var reg=/(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/;
		      if(str.length>0&&(!reg.test(str))){
		        	document.getElementById("tjmobile_id").innerHTML='手机号格式不正确';
		       	    form1.tjmobile.focus();
		       	    return false;
		        }
   			 }else{
   			 	document.getElementById("tjmobile_id").innerHTML='手机号不能为空';
		   	    form1.belsell.focus();
		   	    return false;
   			 }

    document.getElementById("tjmobile_id").innerHTML='';
			
	}
	
	document.getElementById("submitshow").innerHTML='正在提交，请稍候...';
	 

	form1.action='/servlet/EditMember';

	form1.submit();



}
function isIdCardNo(num)
{
	var factorArr = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1);
	var error;
	var varArray = new Array();
	var intValue;
	var lngProduct = 0;
	var intCheckDigit;
	var intStrLen = num.length;
	var idNumber = num;
	// initialize
	if ((intStrLen != 15) && (intStrLen != 18)) {
	//error = "输入身份证号码长度不对！";
	//alert(error);
	//frmAddUser.txtIDCard.focus();
	return false;
	}
	// check and set value
	for(i=0;i<intStrLen;i++) {
	varArray[i] = idNumber.charAt(i);
	if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
	//error = "错误的身份证号码！.";
	//alert(error);
	//frmAddUser.txtIDCard.focus();
	return false;
	} else if (i < 17) {
	varArray[i] = varArray[i]*factorArr[i];
	}
	}
	if (intStrLen == 18) {
	//check date
	var date8 = idNumber.substring(6,14);
	if (checkDate(date8) == false) {
	//error = "身份证中日期信息不正确！.";
	//alert(error);
	return false;
	}
	// calculate the sum of the products
	for(i=0;i<17;i++) {
	lngProduct = lngProduct + varArray[i];
	}
	// calculate the check digit
	intCheckDigit = 12 - lngProduct % 11;
	switch (intCheckDigit) {
	case 10:
	intCheckDigit = 'X';
	break;
	case 11:
	intCheckDigit = 0;
	break;
	case 12:
	intCheckDigit = 1;
	break;
	}
	// check last digit
	if (varArray[17].toUpperCase() != intCheckDigit) {
	//error = "身份证效验位错误!...正确为： " + intCheckDigit + ".";
	//alert(error);
	return false;
	}
	}
	else{ //length is 15
	//check date
	var date6 = idNumber.substring(6,12);
	if (checkDate(date6) == false) {
	//alert("身份证日期信息有误！.");
	return false;
	}
	}
	//alert ("Correct.");
	return true;
}


function checkDate(date)
{
  return true;
}
function f_xybcheck()
{

	if(document.getElementById("xybcheck").checked)
	{
		document.getElementById("welid").style.display=''
	}else
	{
		document.getElementById("welid").style.display='none'
	}
}

function f_xp(igd,igdstrid,igdname,igdpingpai)
{

	 sendx("/jsp/admin/edn_ajax.jsp?act=ewmxp&wm="+igd+"&igdname="+igdname+"&igdpingpai="+igdpingpai,
			 function(data)
			 {
		 		if(data!=''&&data.length>1)
		 			{
		 			data = data.trim();
				 	document.getElementById(igdstrid).innerHTML=data;
		 			}
			 }
			 );
}

function f_x()
{
	f_xp('<%=p.getXpinpai()%>','xxinghaoid','xxinghao','<%=p.getXxinghao()%>');
	f_xp('<%=p.getCpinpai()%>','cxinghaoid','cxinghao','<%=p.getCxinghao()%>');
}


function f_source()
{
	if(form1.source.value==1)
	{
		//培训
		document.getElementById("trainid").style.display='';
		document.getElementById("tjmemberid").style.display='none';
		document.getElementById("belsellid").style.display='none';
	}else if(form1.source.value==2)
	{
		//履友推荐
		document.getElementById("trainid").style.display='none';
		document.getElementById("belsellid").style.display='none';
		document.getElementById("tjmemberid").style.display='';

	}else if(form1.source.value==3)
	{
		//销售员推荐
		document.getElementById("belsellid").style.display='';
		document.getElementById("trainid").style.display='none';
		document.getElementById("tjmemberid").style.display='none';
	}else
	{
		document.getElementById("belsellid").style.display='none';
		document.getElementById("trainid").style.display='none';
		document.getElementById("tjmemberid").style.display='none';
	}

}
</script>
</head>

<body onload="f_x();">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<h1>履友(<%=member %>)编辑</h1>

<form name="form1" method="POST" action="/servlet/EditMember" >

<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="EditWestracMmeber">
<input type="hidden"   name="member" value="<%=member %>">
<input type="hidden"   name="code" value="<%=p.getCode() %>">

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

 <tr>
      <td align="right"><span id="btid">*</span>&nbsp;会员编号：</td>
      <td>
        <%=Entity.getNULL(p.getCode()) %>
      </td>
    </tr>
     <tr>
      <td align="right">E-mail：</td>
      <td>
       	<input type="text"    class="edit_input" name="email" value="<%=Entity.getNULL(p.getEmail()) %>">&nbsp;
       	<!-- 邮箱是联系我们、订阅信息、找回密码的必要手段，请正确填写。如您还没有邮箱，请马上去<a herf="http://reg.email.163.com/mailregAll/reg0.jsp?from=163mail_right">注册</a>一个。 -->
      </td>
    </tr>

    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;用户名：</td>
      <td>
        <%=Entity.getNULL(member) %>
      </td>
    </tr>

	<tr>
      <td align="right"><span id="btid">*</span>&nbsp;姓名：</td>
      <td>
        <input type="text"    class="edit_input" name="membername" value="<%=Entity.getNULL(p.getFirstName(teasession._nLanguage)) %>">&nbsp;<span id="membername_id"></span>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;性别：</td>
      <td>
       	<select name="sex">
       		<option value="1" <%if(!p.isSex()){out.println(" selected ");} %>>男</option>
       		<option value="0" <%if(p.isSex()){out.println(" selected ");} %>>女</option>
       	</select>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;密码：</td>
      <td>
       	<input type="password"   class="edit_input" name="EnterPassword" value="<%=p.getPassword() %>">&nbsp;<span id="EnterPassword_id"></span>
      </td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;确认密码：</td>
      <td>
       	<input type="password"    class="edit_input" name="ConfirmPassword" value="<%=p.getPassword() %>">&nbsp;<span id="ConfirmPassword_id"></span>
      </td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;身份证号：</td>
      <td>
       	<input type="text"    class="edit_input" name="card" value="<%=p.getCard() %>">&nbsp;<span id="card_id"></span>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;手机：</td>
      <td>
       	<input type="text"    class="edit_input" name="mobile" value="<%=p.getMobile() %>">&nbsp;<span id="mobile_id"></span>
      </td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;身份类型：</td>
      <td>
      <select name="wsttype">
      <%
      ArrayList<LvyouJobCatagory> catatList =LvyouJobCatagory.find();
      for(int i=0;i<catatList.size();i++)
      {
    	  LvyouJobCatagory cata=(LvyouJobCatagory)catatList.get(i);
        out.print("<option value="+i);
        if(p.getWstType()==i)out.print(" selected");
        out.print(">"+cata.getName());
      }
      /*
      for(int i=0;i<Profile.WST_TYPE.length;i++)
      {
        out.print("<option value="+i);
        if(p.getWstType()==i)out.print(" selected");
        out.print(">"+Profile.WST_TYPE[i]);
      }*/
      %>
      </select>
      </td>
    </tr>
 <tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;生日：</td>
      <td>
        <input id="birth" name="birth" size="7"  value="<%if(p.getBirth()!=null)out.print(Entity.sdf.format(p.getBirth())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.birth');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.birth');" />
       &nbsp;<span id="birth_id"></span>
      </td>
    </tr>
       <tr>
      <td align="right"><span id="btid">*</span>&nbsp;现工作地：</td>
      <td>
       	<script>mt.city("city0","city1",null,'<%=p.getProvince(teasession._nLanguage) %>');</script>

    详细地址:<input type="text" name="address" value="<%=p.getAddress(teasession._nLanguage) %>" title="详细地址">&nbsp;<span id="city_id"></span>
      </td>
    </tr>

     <tr>
   	<td align="right"><span id="btid">*</span>&nbsp;从何得知履友联盟？</td>
   	<td>
   		<select name="source" onchange="f_source();">
   			<option value="0">-选择-</option>
   			<%
   				for(int i=1;i<Profile.SOURCE_TYPE.length;i++)
   				{
   					out.print("<option value="+i);
   					if(p.getSource()==i)
   					{
   						out.println(" selected ");
   					}
   					out.print(">"+Profile.SOURCE_TYPE[i]);
   					out.print("</option>");
   				}
   			%>
   		</select>
   		&nbsp;
   		<span id="trainid" <%if(p.getSource()==1){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   			哪次培训：<input type="text" name="trainname" value="<%=Entity.getNULL(p.getTraintime()) %>">&nbsp;<span id="trainname_id"></span><br>
   			培训地点：<input type="text" name="trainaddress" value="<%=Entity.getNULL(p.getTrainaddress()) %>">&nbsp;<span id="trainaddress_id"></span><br>
   			培训时间：<input type="text" name="traintime" value="<%=Entity.getNULL(p.getTraintime()) %>"><span id="traintime_id"></span>
   		</span>
   		<span id="tjmemberid" <%if(p.getSource()==2){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   		推荐人会员编号或用户名：
 			<input type="text"    class="edit_input" name="tjmember" value="<%=Entity.getNULL(p.getTjmember()) %>"  onfocus="mt.f_tm(this)" onblur="mt.f_tm(this)" min='4' maxlength="20" alt="推荐人会员编号或用户名">
 		
 			
 			<span id="tjmember_info"></span>


   		</span>
   		<span id="belsellid" <%if(p.getSource()==3){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   			销售员姓名：<input type="text" name="belsell" value="<%=Entity.getNULL(p.getBelsell()) %>"><span id="belsell_id"></span><br>
   			销售员手机号：<input type="text"    name="tjmobile" value="<%=Entity.getNULL(p.getTjmobile()) %>"><span id="tjmobile_id"></span>
   		</span>
   		<span id ="source_id"></span>
   	</td>
   </tr>

      <tr>
      <td></td>
      <td>
      	<input type="checkbox" name="xybcheck" id="xybcheck" value="1" <%if(p.getType()==1)out.println(" checked"); %> onclick="f_xybcheck();" >&nbsp;
      	用户的详细信息

      </td>

    </tr>

      <%if(teasession._rv!=null  && p.getMembertype()==2 && AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString()).isExists() ) {%>
     <tr>
      <td></td>
      <td>
      <input type="radio" name="membertype" value="1">通过审核&nbsp;&nbsp;
      <input type="radio" name="membertype" value="3">未通过审核&nbsp;&nbsp;
      </td>

    </tr>
    <%} %>

  </table>


 <span id="welid"  <%if(p.getType()==0)out.println(" style=\"display:none\""); %>>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >



     <tr>
      <td align="right">民族：</td>
      <td>
        <input type="text"  maxlength=16  class="edit_input" name="zzracky" value="<%=Entity.getNULL(p.getZzracky()) %>">
      </td>
    </tr>



    <tr>
      <td align="right">学历：</td>
      <td>
       	  <select name="degree">
       	  	<%
       	  		for(int i=0;i<Profile.DEGREE_TYPE.length;i++)
       	  		{
       	  			out.print("<option value="+i);
       	  			if(String.valueOf(i).equals(p.getDegree(teasession._nLanguage)))
       	  			{
       	  				out.print(" selected ");
       	  			}
       	  			out.print(">"+Profile.DEGREE_TYPE[i]);
       	  			out.print("</option>");

       	  		}
       	  	%>
       	  </select>
      </td>
    </tr>

	<tr>
      <td align="right">固定电话：</td>
      <td>
        <input type="text"    class="edit_input" name="telephone" value="<%=Entity.getNULL(p.getTelephone(teasession._nLanguage)) %>
        ">
      </td>
    </tr>
     <tr>
      <td align="right">家庭所在地：</td>
      <td>
       	 	<script>mt.city("zzhkszd0","zzhkszd1",null,"<%=p.getZzhkszd(teasession._nLanguage) %>");</script>

    详细地址:<input type="text" name="paddress" value="<%=Entity.getNULL(p.getPAddress(teasession._nLanguage)) %>" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">现通讯地址：</td>
      <td>
       	<script>mt.city("state0","state1",null,"<%=p.getState(teasession._nLanguage) %>");</script>

    详细地址:<input type="text" name="organization" value="<%=Entity.getNULL(p.getOrganization(teasession._nLanguage)) %>" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">邮编：</td>
      <td>
       	<input type="text"    class="edit_input" name="zip" value="<%=Entity.getNULL(p.getZip(teasession._nLanguage)) %>">
      </td>
    </tr>

    <tr>
      <td align="right">QQ：</td>
      <td>
       	<input type="text"    class="edit_input" name="msn" value="<%=Entity.getNULL(p.getMsnID()) %>">
      </td>
    </tr>


      <tr>
      <td  align="right">是否有上岗证：</td>
      <td>
	      <input type="radio" name="sfshanggang" value="0" <%if(p.getSfshanggang()==0){out.println(" checked ");} %>>&nbsp;是
	      <input type="radio" name="sfshanggang" value="1"  <%if(p.getSfshanggang()==1){out.println(" checked ");} %>>&nbsp;否
      </td>

    </tr>

      <tr>
      <td align="right">发证机关：</td>
      <td>
 			<input type="text"    class="edit_input" name="fazhengjiguan" value="<%=Entity.getNULL(p.getFazhengjiguan()) %>">
      </td>
    </tr>
     <tr>
      <td align="right">操作年限：</td>
      <td>
 			<input type="text"    class="edit_input" name="caozuonianxian" value="<%=Entity.getNULL(p.getCaozuonianxian()) %>">
      </td>
    </tr>


    
      <td align="right">机种：</td>
      <td>
      <%
      String wstmode=p.getWstModel();
      ArrayList<LvyouModels> modelist=LvyouModels.find();
      for(int i=0;i<modelist.size();i++)
      {LvyouModels model=(LvyouModels)modelist.get(i);
        out.print("<input type='checkbox' name='wstmodel' value='"+model.getName()+"' id='_wstmodel"+i+"'");
        if(wstmode!=null&&wstmode.indexOf(model.getName())!=-1)out.print(" checked");
        out.print("><label for='_wstmodel"+i+"'>"+model.getName()+"</label>　");
      }
      /*
      for(int i=1;i<Profile.WST_MODEL.length;i++)
      {
        out.print("<input type='checkbox' name='wstmodel' value='"+Profile.WST_MODEL[i]+"' id='_wstmodel"+i+"'");
        if(wstmode!=null&&wstmode.indexOf(Profile.WST_MODEL[i])!=-1)out.print(" checked");
        out.print("><label for='_wstmodel"+i+"'>"+Profile.WST_MODEL[i]+"</label>　");
      }
      */
      %>
      </td>
    </tr>



     <tr>
      <td align="right">现操作机型：</td>
      <td>
 			<select name="xpinpai" onchange="f_xp(this.value,'xxinghaoid','xxinghao','0');">
 				<option value="0">品牌</option>
 				<%
 				java.util.Enumeration e = WomenOptions.find(teasession._strCommunity, " and type= 0",0,Integer.MAX_VALUE);
 		        while(e.hasMoreElements())
 		       {
 		            int wid = ((Integer)e.nextElement()).intValue();
 		            WomenOptions obj = WomenOptions.find(wid);
 		            out.println("<option value="+wid);
 		            if(p.getXpinpai()==wid)
 		            {
 		            	out.println(" selected ");
 		            }
 		            out.println(">"+obj.getWoname());
 		            out.print("</option>");
 		       }
 				%>
 			</select>
 			<span id="xxinghaoid">
	 			<select name="xxinghao">
	 				<option value="0">型号</option>

	 			</select>
 			</span>其他:
 			<input type="text"     name="xqita" value="<%=Entity.getNULL(p.getXqita()) %>">
      </td>
    </tr>
     <tr>
      <td align="right">曾操作机型：</td>
      <td>
 			<select name="cpinpai" onchange="f_xp(this.value,'cxinghaoid','cxinghao','0');">
 				<option value="0">品牌</option>
 				<%
	 				java.util.Enumeration e2 = WomenOptions.find(teasession._strCommunity, " and type= 0",0,Integer.MAX_VALUE);
	 		        while(e2.hasMoreElements())
	 		       {
	 		            int wid = ((Integer)e2.nextElement()).intValue();
	 		            WomenOptions obj = WomenOptions.find(wid);
	 		            out.println("<option value="+wid);
	 		           if(p.getCpinpai()==wid)
	 		            {
	 		            	out.println(" selected ");
	 		            }
	 		            out.println(">"+obj.getWoname());
	 		            out.print("</option>");
	 		       }
 				%>
 			</select>
 				<span id="cxinghaoid">
	 			<select name="cxinghao">
	 				<option value="0">型号</option>
	 			</select>
 			</span>其他:
 			<input type="text"     name="cqita"  value="<%=Entity.getNULL(p.getCqita()) %>">
      </td>
    </tr>

     <tr>
      <td align="right">机主相关：</td>
      <td>
 			姓名:<input type="text"    class="edit_input" name="jzname" value="<%=Entity.getNULL(p.getJzname()) %>">
 			型号:<input type="text"    class="edit_input" name="jzxinghao" value="<%=Entity.getNULL(p.getJzxinghao()) %>">
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
 			序列号:<input type="text"    class="edit_input" name="jzxuliehao" value="<%=Entity.getNULL(p.getJzxuliehao()) %>">
      </td>
    </tr>
     <tr>
      <td>&nbsp;</td>
      <td>
 			联系方式:<input type="text"    class="edit_input" name="jzlianxi" value="<%=Entity.getNULL(p.getJzlianxi()) %>">
      </td>
    </tr>
     <tr>
     <td align="right">爱好：</td>
      <td>
 			<textarea rows="3" cols="60" name="aihao"><%=Entity.getNULL(p.getAihao()) %></textarea>
      </td>
    </tr>
  </table>
</span>
<br>
  <center>
  
  <span id="submitshow">
  
  <%if(p.getMembertype()==2) {%>
  <INPUT TYPE=button ID="submit1" class="edit_button" VALUE="审核用户信息" onclick="f_sub();">&nbsp;
  <%}else{ %>
  <INPUT TYPE=button ID="submit1" class="edit_button" VALUE="提交用户信息" onclick="f_sub();">&nbsp;
  <%} %>
  <input type="button" name="reset" value="返回" onClick="window.open('<%=nexturl%>','_self');">

</span>
</center></form>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</body>
</html>

