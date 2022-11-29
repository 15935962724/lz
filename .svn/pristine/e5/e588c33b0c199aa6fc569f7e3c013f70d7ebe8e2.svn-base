

  
	
function submitForm(type){
   var falg=true;
	var consigneeform=document.forms["consigneeform"];	
	
	
	document.getElementById("consigneeError").innerHTML="";
	document.getElementById("nowareaError").innerHTML="";    
    document.getElementById("streetaddressError").innerHTML=""; 
    document.getElementById("postcodeError").innerHTML="";
    document.getElementById("homephoneError").innerHTML="";
    document.getElementById("phoneError").innerHTML="";
	   
	
	if(consigneeform.consignee.value.length<1){
	  document.getElementById("consigneeError").innerHTML="* 收货人不能为空！";
	  falg=false;	  
	}
	        
	
	
   var nowarea=consigneeform.nowarea;
   nowarea.value="";  
   
   var provinceid=consigneeform.provinceid;
   var cityid=consigneeform.cityid;
   var districtid=consigneeform.districtid;
   
   var provinces=consigneeform.provinceid.options;
   var citys=consigneeform.cityid.options;
   var districts=consigneeform.districtid.options;
   
   var province=provinces[provinceid.selectedIndex].value;
   var city=citys[cityid.selectedIndex].value;
   var district=districts[districtid.selectedIndex].value;   
      
   var p=provinces[provinceid.selectedIndex].innerHTML+" ";
   var c=citys[cityid.selectedIndex].innerHTML+" ";
   var d=districts[districtid.selectedIndex].innerHTML+" ";       
   
   if(province.length>0 && city.length>0 && district.length>0){
      
     nowarea.value=district+"&"+p+c+d;         
   }else{            
     document.getElementById("nowareaError").innerHTML="* 请选择省、市、区！";
     falg=false;
   }   
   
   if(consigneeform.streetaddress.value.length<1){
	  document.getElementById("streetaddressError").innerHTML="* 街道地址不能为空！";
	  falg=false;	  
	}	
	
	var postcode=consigneeform.postcode.value;
	if(postcode.length<1){
	  document.getElementById("postcodeError").innerHTML="* 邮政编码不能为空！";
	  falg=false;	  
	}else if(postcode.length!=6 || isNaN(postcode)){   
	  document.getElementById("postcodeError").innerHTML="* 邮政编码格式不对，6位数字！";
	  falg=false;	  
	}	
	var homephone=consigneeform.homephone.value;	
	if(homephone.length>0){  	  
	  if(isNaN(homephone.substr(0,3)) || homephone.substr(3,1)!="-" || isNaN(homephone.substr(4))){    	  
	  document.getElementById("homephoneError").innerHTML="* 电话号码格式不对，010-11111111！";
	  falg=false;
	  }
	}
		
	var phone=consigneeform.phone.value;
	if(phone.length>0){  	  
	  if(isNaN(phone)){
	  document.getElementById("phoneError").innerHTML="* 手机号码格式不对！";
	  falg=false;	  	
	  }
	}  
	if(falg){
	   if(type==0){	
	         consigneeform.action="jsp/consigneeaddress/consigneeaddress.jsp?type=0";
	          consigneeform.submit();
	   }
	   if(type==1){
	         consigneeform.action="jsp/consigneeaddress/consigneeaddress.jsp?type=4";
	          consigneeform.submit();
	   }
	          
	}	 
   }