<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>聊天室</title>
<link href="/jsp/type/chartRoom/CSS/style.css" rel="stylesheet">
<script language="javascript" src="/jsp/type/chartRoom/JS/AjaxRequest.js"></script>
<script language="javascript" src="/tea/tea.js"></script>
<script language="javascript">
window.setInterval("showContent();",1000); 
window.setInterval("showOnline();",10000); 
//此处需要加&nocache="+new Date().getTime()，否则将出现在线人员列表不更新的情况
function showOnline(){
	var loader=new net.AjaxRequest("online.jsp?nocache="+new Date().getTime(),deal_online,onerror,"GET");
}
function showContent(){
	var loader1=new net.AjaxRequest("content.jsp?nocache="+new Date().getTime(),deal_content,onerror,"GET");
	
}
function onerror(){
	alert("很抱歉，服务器超时，当前窗口将关闭！");
	//window.opener=null;
	window.top.close();
}
function deal_online(){
	online.innerHTML=this.req.responseText;
}  
function deal_content(){
	content.innerHTML=this.req.responseText;
}
</script>
<script language="javascript">
<!--
	function check(){	//验证聊天信息
		if(form1.tempuser.value==""){
			alert("请选择聊天对象！");return false;
		}
		if(form1.message.value==""){
			alert("发送信息不可以为空！");form1.message.focus();return false;
		}
		
		
		
		
		
		sendx("/jsp/type/chartRoom/content.jsp?tempuser="+encodeURIComponent(form1.tempuser.value)+"&selectwx="+encodeURIComponent(form1.selectwx.value)+"&color="+encodeURIComponent(form1.color.value)+"&message="+encodeURIComponent(form1.message.value),
				 function(data)
				 {
						//var loader=new net.AjaxRequest("online.jsp?nocache="+new Date().getTime(),deal_online,onerror,"GET");
						//var loader1=new net.AjaxRequest("content.jsp?nocache="+new Date().getTime(),deal_content,onerror,"GET"); 
						form1.message.value='';
						window.location.hash='topname'; 
						form1.message.focus();
				 }
				  
		);
		
		 
		
		
		
	}
	function Exit(){
		window.location.href="leave.jsp";
		
		alert("您已经成功退出了聊天室");
		window.top.close();
	}
 

</script>

<script language="jscript">   
//window.onbeforeunload=function(){  
  
//	window.location.href="leave.jsp";    
      ////  alert('您已经退出。');  
//}

//关闭浏览器销毁Seesion
    var xmlHttp;
    function createXMLHttpRequest()
   {
      //IE
      if (window.ActiveXObject)
      {
       xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      //Other
      else if (window.XMLHttpRequest)
      {
       xmlHttp = new XMLHttpRequest();
      }
   }
   function destorySession()
   {
                       try{
                        createXMLHttpRequest();
                        var url = "leave.jsp";
                        xmlHttp.open("POST", url, false);
                        xmlHttp.send(null);
                        var result = xmlHttp.responseText;
                     }
                     catch(e)
                    { 
                      alert("销毁异常！");
                     }
    }
   
   window.onbeforeunload = function()  
   {  
     var n = window.event.screenX - window.screenLeft;  
     var b = n > document.documentElement.scrollWidth-20;  
     if(b && window.event.clientY < 0 || window.event.altKey)  
     {  
    	 alert('您已经成功退出了聊天室');
         destorySession();
     }else  
     {  
       //alert('您已经成功退出了聊天室');
     //  destorySession();
     }  
   }
</script>  
</head>
<body onLoad="showContent();showOnline();"   style="padding-top:750px;"><div style="width:748px;height:750px;overflow:auto;position:absolute;left:0px;top:0px;">
<table width="748" height="550" border="0"align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="145" valign="top" bgcolor="#FDF7E9" id="online" style="padding:5px">在线人员列表</td>
    <td width="600" valign="top" bgcolor="#FFFFFF" id="content" style="padding:5px">聊天内容</td>
  </tr>
</table></div>
<form action="?" name="form1" method="post">
<table width="748" height="100"  border="0" align="center" id="liao"  cellpadding="0" cellspacing="0" bordercolor="#D6D3CE" bgcolor="#D39800">
  <tr>
    <td height="30" align="left">&nbsp;</td>
    <td height="37" align="left">[<%=session.getAttribute("username")%> ]对
      <input name="tempuser" type="text" value="" size="35" readonly="readonly" >
表情
<select name="selectwx" class="wenbenkuang">
  <option  value="无表情的">无表情的</option>
  <option value="微笑着" selected>微笑着</option>
  <option value="笑呵呵地">笑呵呵地</option>
  <option value="热情的">热情的</option>
  <option value="温柔的">温柔的</option>
  <option value="红着脸">红着脸</option>
  <option value="幸福的">幸福的</option>
  <option value="嘟着嘴">嘟着嘴</option>
  <option value="热泪盈眶的">热泪盈眶的</option>
  <option value="依依不舍的">依依不舍的</option>
  <option value="得意的">得意的</option>
  <option value="神秘兮兮的">神秘兮兮的</option>
  <option value="恶狠狠的">恶狠狠的</option>
  <option value="大声的">大声的</option>
  <option value="生气的">生气的</option>
  <option value="幸灾乐祸的">幸灾乐祸的</option>
  <option value="同情的">同情的</option>
  <option value="遗憾的">遗憾的</option>
  <option value="正义凛然的">正义凛然的</option>
  <option value="严肃的">严肃的</option>
  <option value="慢条斯理的">慢条斯理的</option>
  <option value="无精打采的">无精打采的</option>
</select>
说： </td>
    <td width="170" align="left"> &nbsp;&nbsp;字体颜色：
      <select name="color" size="1" class="wenbenkuang" id="select">
        <option selected>默认颜色</option>
        <option style="color:#FF0000" value="FF0000">红色热情</option>
        <option style="color:#0000FF" value="0000ff">蓝色开朗</option>
        <option style="color:#ff00ff" value="ff00ff">桃色浪漫</option>
        <option style="color:#009900" value="009900">绿色青春</option>
        <option style="color:#009999" value="009999">青色清爽</option>
        <option style="color:#990099" value="990099">紫色拘谨</option>
        <option style="color:#990000" value="990000">暗夜兴奋</option>
        <option style="color:#000099" value="000099">深蓝忧郁</option>
        <option style="color:#999900" value="999900">卡其制服</option>
        <option style="color:#ff9900" value="ff9900">镏金岁月</option>
        <option style="color:#0099ff" value="0099ff">湖波荡漾</option>
        <option style="color:#9900ff" value="9900ff">发亮蓝紫</option>
        <option style="color:#ff0099" value="ff0099">爱的暗示</option>
        <option style="color:#006600" value="006600">墨绿深沉</option>
        <option style="color:#999999" value="999999">烟雨蒙蒙</option>
      </select></td>
    <td width="19" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td width="21" height="30" align="left">&nbsp;</td>
    <td width="575" align="left" height="50"><input name="message" type="text" size="70"  onkeydown="enterIn(event);">
      <input name="Submit2" type="button" class="btn_blank" value="发送" onClick="check();"></td>
    <td align="right"><input name="button_exit" type="button" class="btn_orange" value="退出聊天室" onClick="Exit()"></td>
    <td align="center">&nbsp;</td>
  </tr>
</table>

</form>

<script language="javascript">
function set(selectPerson){	//自动添加聊天对象
	if(selectPerson!="<%=session.getAttribute("username")%>"){
		form1.tempuser.value=selectPerson;
		//window.location.hash='topname';
	}else{ 
		alert("请重新选择聊天对象！"); 
	} 
	
}
</script>
<script>
function enterIn(evt){
	  var evt=evt?evt:(window.event?window.event:null);//兼容IE和FF
	  if (evt.keyCode==13){
	  var obj ;
	  check();
	} 
	}



</script>
</body>
</html>
