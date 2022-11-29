
//注册
mt.verify=function()
{
  $('t_verify').src+='&t='+new Date().getTime();
}
var v_mobile=function(a)
{
	var t=$(a.name+'_info'),v=a.value;
    var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
  
	
	
	  if(v.length==0)
	  {
	    t.innerHTML="手机不能为空。";
	    t.className='tip';
	  }else if(!reg.test(v))
	  {
		  t.innerHTML="手机格式不正确。";
		  t.className='err';
		  
	  }else
	  {
		  
		  sendx("/jsp/admin/edn_ajax.jsp?act=WRegmobile&mobile="+v,
					 function(data)
					 {

					//alert(data);
						   if(data!=''&&data.trim()=='true')
						   { 
							   t.innerHTML="这个手机号已经注册，请重新填写。";
								  t.className='err';
							   
						   }else if(data!=''&&data.trim()=='false')
						   {
								t.innerHTML='&nbsp;';
							    t.className='ok';
							   
						  }
					 }
					 );
		  
		  
		  
		  
	
	  }
} 
mt.isEmail=function(a)
{
	
	var t=$(a.name+'_info'),v=a.value.trim();

	var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	 
  
  if(v.length==0)
  {
    t.innerHTML="邮箱地址不能为空";
    t.className='tip';
  }else if(!filter.test(v)){
	    t.innerHTML="邮箱地址的格式不正确。";
	    t.className='tip';
	  }else
  {
		t.innerHTML='&nbsp;';
	    t.className='ok';
	  }
};
mt.f_email=function(a)
{
  var t=$(a.name+'_info'),v=a.value.trim();
  alert(v);
  //在JavaScript中，正 则 表达式只能使用"/"开头和结束，不能使用双引号 
  var re = /^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/; 
  var objExp=new RegExp(re); 
  if(v.size()==0)
  {
    t.innerHTML="邮箱不能为空。";
    t.className='tip';
  }else if(objExp.test(v)==true){ 
	  sendx("/SupSuppliers.do?act=check_email&q="+encodeURIComponent(v),function(d){
	      if(d=='true')
	      {
	        t.innerHTML='该邮箱已被使用。';
	        t.className='err';
	      }else
	      {
	        t.innerHTML='&nbsp;';
	        t.className='ok';
	      }
	    }); 
  }else{ 
	  t.innerHTML='邮箱格式不正确';
      t.className='err'; 
  } 

    
  
}
mt.f_m=function(a)
{
  var t=$(a.name+'_info'),v=a.value.trim();
  if(v.length==0)
  {
    t.innerHTML="4-20个字符，一个汉字为两个字符，不能使用纯数字，推荐使用中文会员名。一旦注册成功会员名不能修改。";
    t.className='tip';
  }else if(v.size()<4)
  {
    t.innerHTML="会员名在4-20个字符内。";
    t.className='err';
  }else if(/^\d+$/.test(v))
  {
    t.innerHTML="会员名不能全为数字。";
    t.className='err'; n 
  }else if(/[ |,.:;'"　，。：；\\\/]/.test(v))
  {
    t.innerHTML="非法的会员名。";
    t.className='err';
  }else
  {
    //t.innerHTML='检测中...';
    sendx("/servlet/Ajax?act=checkmember&member="+encodeURIComponent(v),function(d){
      if(d=='true')
      {
        t.innerHTML='该会员名已被使用。';
        t.className='err';
      }else
      {
        t.innerHTML='&nbsp;';
        t.className='ok';
      }
    });
  }
}

//推荐人
mt.f_tm=function(a)
{
  var t=$(a.name+'_info'),v=a.value.trim();
  
  
  if(/[ ,.:;'"　，。：；\\\/]/.test(v))
  {
    t.innerHTML="非法的会员编号或用户名。";
    t.className='err';
  }else  if(v.length>0)
  {
    //t.innerHTML='检测中...';
	  
	  sendx("/jsp/admin/edn_ajax.jsp?act=Tlogin&member="+ encodeURIComponent(v),
				 function(data)
				 {
					data = data.trim();
					if(data==3)
					{
						
						 t.innerHTML='你有输入错误的会员编号,系统不能给这个会员编号加分';
					        t.className='err';
					       // a.value='';
					}else if(data==2)
					{
						
						t.innerHTML='你有输入错误的用户名,系统不能给这个会员编号加分';
				        t.className='err';
				       // a.value='';
					}else
					{
						 t.innerHTML='&nbsp;';
					     t.className='ok';
					}
				
				 }
			 );
	  
	  
   
  }
}

mt.f_p=function(a)
{
  var t=$(a.name+'_info'),v=a.value.trim();
  if(v.length==0)
  {
    t.innerHTML="请输入6-20个字符密码"; 
    t.className='tip';
  }else if(v.length<6)
  {
    t.innerHTML="密码在6-20个字符内。";
    t.className='err';
  }else
  {
    t.innerHTML='&nbsp;';
    t.className='ok';
  }
}
mt.f_2=function(a)
{
  var t=$(a.name+'_info'),v=a.value.trim();
  if(v.length==0)
  {
    t.innerHTML="请再次输入密码。";
    t.className='tip';
  }else if(a.form.password.value!=v)
  {
    t.innerHTML="登录密码与再次输入密码不一致。";
    t.className='err';
  }else
  {
    t.innerHTML='&nbsp;';
    t.className='ok';
  }
}

mt.f_3=function(a)
{
  var t=$(a.name+'_info'),v=a.value.trim();
  if(v.length==0)
  {
    t.innerHTML="请再次输入密码。";
    t.className='tip';
  }else if(a.form.EnterPassword.value!=v)
  {
    t.innerHTML="登录密码与再次输入密码不一致。";
    t.className='err';
  }else
  {
    t.innerHTML='&nbsp;';
    t.className='ok';
  }
}

mt.f_v=function(a,b)
{
  var t=$(a.name+'_info'),v=a.value;
  if(v.length==0)
  {
    t.innerHTML="请正确输入验证码。";
    t.className='tip';
  }
  if(!b)
  {
    t.innerHTML='';
    t.className='ok';
  }
}

mt.f_membername=function(a)
{
	 var t=$(a.name+'_info'),v=a.value;
	  if(v.length==0)
	  {
	    t.innerHTML="姓名不能为空。";
	    t.className='tip';
	  }else
	  {
		t.innerHTML='&nbsp;';
	    t.className='ok';
	  }
}
mt.f_card=function(a)
{

	 var t=$(a.name+'_info'),v=a.value;

	  if(v.length==0)
	  {
	    t.innerHTML="身份证号不能为空。";
	    t.className='tip';
	  }else if(!isIdCardNo(form1.card.value))
	  {
		  t.innerHTML="身份证号的格式不正确。";
		  t.className='err';

			  document.getElementById("submit1").disabled=true;
			  document.getElementById("submit1").value='信息格式不正确，不能注册...';
		  
	  }else
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
		  
	
	  }
}
 

mt.f_mobile=function(a)
{
	var t=$(a.name+'_info'),v=a.value;

	var str = form1.mobile.value;
    var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
  
	
	
	  if(v.length==0)
	  {
	    t.innerHTML="手机不能为空。";
	    t.className='tip';
	  }else if(!reg.test(str))
	  {
		  t.innerHTML="手机格式不正确。";
		  t.className='err';
		
		  document.getElementById("submit1").disabled=true;
		  document.getElementById("submit1").value='信息格式不正确，不能注册...';
		  
	  }else
	  {
		  
		  sendx("/jsp/admin/edn_ajax.jsp?act=WRegmobile&mobile="+str,
					 function(data)
					 {

					//alert(data);
						   if(data!=''&&data.trim()=='true')
						   { 
							   t.innerHTML="这个手机号已经注册，请重新填写。";
								  t.className='err';
			 
									  document.getElementById("submit1").disabled=true;
									  document.getElementById("submit1").value='信息格式不正确，不能注册...';
							   
						   }else if(data!=''&&data.trim()=='false')
						   {
								t.innerHTML='&nbsp;';
							    t.className='ok';
							    
							    if( $('card_info').className=='ok' && $('mobile_info').className=='ok'  && $('address_info').className=='ok' )
							    {
								    document.getElementById("submit1").disabled=false;
									document.getElementById("submit1").value='注册';
							    }
							    
						  }
					 }
					 );
		  
		  
		  
		  
	
	  }
} 
mt.f_birth=function(a)
{ 
	  var t=$(a.name+'_info'),v=a.value;
	  if(v.length==0)
	  {
	    t.innerHTML="请选择生日。";
	    t.className='tip';
	  }else
	  {
	    t.innerHTML='&nbsp;';
	    t.className='ok';
	  }
}

mt.f_address=function(a)
{
	
	var t=$(a.name+'_info'),v=form1.city0.value;
	  if(v.length==0)
	  {
	    t.innerHTML="现工作地省份。";
	    t.className='tip';
	     document.getElementById("submit1").disabled=true;
		  document.getElementById("submit1").value='请选择现工作地省份，不能注册';
	  }else if(form1.city1.value.length==0)
	  {
		  t.innerHTML="现工作地市。";
		    t.className='tip';
		    document.getElementById("submit1").disabled=true;
			  document.getElementById("submit1").value='请选择现工作地市，不能注册';
	  }else if(form1.address.value.length==0)
	 {
		  t.innerHTML="现工作地详细地址。";
		    t.className='tip';
		    
		    document.getElementById("submit1").disabled=true;
			document.getElementById("submit1").value='现工作地详细地址不能为空，不能注册';
	 } else
	  {
	    t.innerHTML='&nbsp;';
	    t.className='ok';

	    if( $('card_info').className=='ok' && $('mobile_info').className=='ok' && $('address_info').className=='ok' )
	    	{
	      document.getElementById("submit1").disabled=false;
		  document.getElementById("submit1").value='注册';
	    	}else
	    	{
	    		  document.getElementById("submit1").disabled=true;
				  document.getElementById("submit1").value='信息格式不正确，不能注册...';
	    	}
	   
	  }
	
	 
	
	/*
	 var t=$(a.name+'_info'),v=a.value;
	  if(v.length==0)
	  {
	    t.innerHTML="现工作地详细地址。";
	    t.className='tip';
	  }else
	  {
	    t.innerHTML='&nbsp;';
	    t.className='ok';
	  }
	  */
}

mt.f_city0=function(a)
{
	 var t=$(a.name+'_info'),v=a.value;
	  if(v.length==0)
	  {
		    return false;
		    
	  }
}
mt.f_city1=function(a)
{
	 var t=$(a.name+'_info'),v=a.value;
	  if(v.length==0)
	  {
	    t.innerHTML="现工作地详细地址。";
	    t.className='tip';
	  }else
	  {
	    t.innerHTML='&nbsp;';
	    t.className='ok';
	  }
}


mt.f_trainname=function(a)
{
	 var t=$(a.name+'_info'),v=a.value;
	  if(v.length==0)
	  {
	    t.innerHTML="那次培训不能为空。";
	    t.className='tip';
	  }else
	  {
		t.innerHTML='&nbsp;';
	    t.className='ok';
	  }
}
mt.f_trainaddress=function(a)
{
	 var t=$(a.name+'_info'),v=a.value;
	  if(v.length==0)
	  {
	    t.innerHTML="培训地点不能为空。";
	    t.className='tip';
	  }else
	  {
		t.innerHTML='&nbsp;';
	    t.className='ok';
	  }
}
mt.f_traintime=function(a)
{
	 var t=$(a.name+'_info'),v=a.value;
	  if(v.length==0)
	  {
	    t.innerHTML="培训时间不能为空。";
	    t.className='tip';
	  }else
	  {
		t.innerHTML='&nbsp;';
	    t.className='ok';
	  }
}
mt.f_belsell=function(a)
{
	 var t=$(a.name+'_info'),v=a.value;
	  if(v.length==0)
	  {
	    t.innerHTML="销售员姓名不能为空。";
	    t.className='tip';
		 document.getElementById("submit1").disabled=true;
		  document.getElementById("submit1").value='信息格式不正确，不能注册...';
	  }else
	  {
		t.innerHTML='&nbsp;';
	    t.className='ok';
	    document.getElementById("submit1").disabled=false;
		  document.getElementById("submit1").value='注册';
	  }
}
mt.f_belsellphone=function(a){
	var phone=a.value;
	var s=$(a.name+'_info');
	var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
//	var reg=/(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/;
	 if((phone.length!=0)){
		 if(!reg.test(phone)){
		 s.innerHTML="手机号格式不正确。";
		 s.className='tip';
		 document.getElementById("submit1").disabled=true;
		  document.getElementById("submit1").value='信息格式不正确，不能注册...';
		 }else{
		s.innerHTML='&nbsp;';
	    s.className='ok';
	    document.getElementById("submit1").disabled=false;
		  document.getElementById("submit1").value='注册';
	   }
		 
	 }else if(phone.length==0)
	  {
		 s.innerHTML="手机号不能为空。";
		    s.className='tip';
			 document.getElementById("submit1").disabled=true;
			  document.getElementById("submit1").value='信息格式不正确，不能注册...';
		  }
	
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




