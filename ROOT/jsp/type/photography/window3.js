


//企业版
function tips_pop2(){
  var MsgPop=document.getElementById("winpop2");
  var popH=parseInt(MsgPop.style.height);
   if (popH==0){
   MsgPop.style.display="block";
  show=setInterval("changeH2('up')",2);
   }
  else {
   hide=setInterval("changeH2('down')",2);
  }
}
function changeH2(str) {
 var MsgPop=document.getElementById("winpop2");
 var popH=parseInt(MsgPop.style.height);
 if(str=="up"){
	    MsgPop.style.top=document.body.scrollTop+document.body.clientHeight-MsgPop.clientHeight-4+"px"
	           MsgPop.style.left=document.body.scrollLeft+document.body.clientWidth-MsgPop.clientWidth-4+"px"
	  if (popH<=117){
	  MsgPop.style.height=(popH+4).toString()+"px";
	  }
	  else{
	  clearInterval(show);
	  }
 }
 if(str=="down"){
  if (popH>=4){
  MsgPop.style.height=(popH-4).toString()+"px";
  }
  else{
  clearInterval(hide);
  MsgPop.style.display="none";
  }
 }
}



