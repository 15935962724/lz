
//
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
mt.f_card=function(a)
{
	 var t=$(a.name+'_info'),v=a.value;
	 t.style.display="";
	  if(v.length==0)
	  {
	    t.innerHTML="身份证号不能为空。";
	    t.className='tip';
		  document.getElementById("submit1").disabled=true;
		  document.getElementById("submit1").value='信息格式不正确，不能注册...';
	  }else if(!isIdCardNo(v))
	  {
		  t.innerHTML="身份证号的格式不正确。";
		  t.className='err';
		  document.getElementById("submit1").disabled=true;
		  document.getElementById("submit1").value='信息格式不正确，不能注册...';
		  
	  }else{
		  t.style.display="none";
		  document.getElementById("submit1").disabled=false;
		  document.getElementById("submit1").value='保存';
	  }
	  /*else
	  {
		  
   
	       sendx("/jsp/admin/edn_ajax.jsp?act=WRegcadr&card="+form1.card.value,
			 function(data)
			 {

			//alert(data);
				   if(data!=''&&data.trim()=='true')
				   { 
					   t.innerHTML="这个身份证号已经注册，请重新填写。";
						  t.className='err';
	 
							  document.getElementById("submit1").disabled=true;
							  document.getElementById("submit1").value='信息格式不正确，不能注册...';
					   
				   }else if(data!=''&&data.trim()=='false')
				   {
						t.innerHTML='&nbsp;';
					    t.className='ok';
					    if( $('card_info').className=='ok' && $('mobile_info').className=='ok' && $('address_info').className=='ok' )
					    {
					       document.getElementById("submit1").disabled=false;
						   document.getElementById("submit1").value='注册';
					    }
					   
				  }
			 }
			 );
		  
	
	  }*/
}
function checkDate(date)
{
  return true;
}

mt.tabchange=function(i){
	form1.tabtype.value=i;
	form1.submit();
}

mt.act=function(type,vid,node){
	form2.node.value=node;
	if("Edit"==type){
		form2.vid.value=vid;
		form2.nextUrl.value=window.location;
		form2.action="/jsp/custom/jjh/"+type+"Volunteer.jsp";
		form2.target="";
		form2.submit();
	}else if("del"==type){
		if(confirm("确定要删除该条信息吗？")){
			form2.vid.value=vid;
			form2.act.value="del";
			form2.nextUrl.value=window.location;
			form2.action="/EditVolunteers.do";
			form2.submit();
		}
	}else if("Excel"==type){
		  form2.vid.value=vid;
		  form2.act.value="Excel";
		  form2.nextUrl.value=window.location;
		  form2.action="/EditVolunteers.do";
		  form2.submit();
	}else if("Import"==type){
		// form2.vid.value=vid;
		  //form2.act.value="Import";
		  //form2.nextUrl.value=window.loction;
		  //form2.action="/EditVolunteers.do";
		  //form2.submit();
		  
		  var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:650px;';
			 var url = '/jsp/custom/jjh/VolunteerImport.jsp?t='+new Date().getTime()+"&community="+form2.community.value+"&node="+node;
			 var rs = window.showModalDialog(url,self,y);

		  // form1.submit();
			 window.location.reload();
	}else if ("deleteAll"==type){

			var nodess="/";
			var vids=document.getElementsByName("vids");
			for(var i=0;i<vids.length;i++){
				if(vids[i].checked==true){
					nodess=nodess+vids[i].value+"/";
				}
			}

			  form2.nodess.value=nodess;
		  form2.act.value="delAll";
		  form2.nextUrl.value=window.location;
		  form2.action="/EditVolunteers.do";
		  form2.submit();
		
	}
}


//表单
mt.checkform=function(a)
{
  if(a.vname!=null&&a.vname.value.trim()==""){
	  mt.show("志愿者姓名不能为空！");
	  a.vname.focus();
	  return false;
  }
  if(a.vnation.selectedIndex==0){
	  mt.show("志愿者民族不能为空！");
	  a.vnation.focus();
	  return false;
  }
  if(a.vprovince!=null&&a.vprovince.value.trim()==""){
	  mt.show("志愿者省份不能为空！");
	  a.vprovince.focus();
	  return false;
  }
  if(a.vnum!=null&&a.vnum.value.trim()==""){
	  mt.show("身份证号不能为空！");
	  a.vnum.focus();
	  return false;
  }
  return true;
};
