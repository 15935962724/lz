function emptyFunc(){}
function sAJAX(func,method,url,data,efunc){AJAX(func,method,url,true,null,null,data,efunc);}
function AJAX(func,method,url,async,user,password,data,efunc){var req=new XMLHttpRequest();if(req){req.onreadystatechange=function(){if(req.readyState==4&&req.status==200){if(func)func(req);}else if(req.readyState==4&&req.status>200){if(efunc)efunc(req);}
if(req.readyState==4){}};method=method.toUpperCase();req.open(method,url,async,user,password);if(method=='POST'){req.setRequestHeader('Content-type','application/x-www-form-urlencoded');}
if(data){req.send(data);}else{req.send(null);}}
return req;}
if(window.ActiveXObject&&!window.XMLHttpRequest){window.XMLHttpRequest=function(){var msxmls=new Array('Msxml2.XMLHTTP','Microsoft.XMLHTTP');for(var i=0;i<msxmls.length;i++){try{return new ActiveXObject(msxmls[i]);}catch(e){}}
return null;};}
