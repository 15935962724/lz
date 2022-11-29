<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.service.SendEmaily" %>
<%request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
if(h.username==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

tea.resource.Resource r=new tea.resource.Resource();

%>
<!DOCTYPE html><html><head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js"></script>
<script src="/tea/mt.js"></script>
<style>.tree{padding-left:20px;}</style>
<script type="text/javascript">

function f_submit()
{
  
  if(form1.email.value != ""){
	     var v = /(\S)+[@]{1}(\S)+[.]{1}(\w)+/;
	    var mails=form1.email.value.split(",");
	       for(var j = 0;j <= (mails.length - 1);j++){
	    	   if(j==(mails.length - 1)&&mails[j].trim()==""){
	    		   return true;
	    	   }
	       if(!v.test(mails[j]))
	       {
	         alert("您的邮箱地址有误"+mails[j]);
	 	return false;
	       }
	    }

	      return true;
	  }else{
		  if(form1.check_email.checked){
			   alert("邮箱地址不能为空");
			    return false;
			}
  }
}

</script>
</head>
<body>
<h1>发送</h1>

<form name="form1" action="/servlet/Subscibes" target="_ajax" method="POST" onsubmit="return f_submit()&&mt.show(null,0);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="sendEmail"/>
<input type="hidden" name="nexturl"/>

<div class='radiusBox'>
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='2'>列表 </td></tr>
</thead>
<tr>
  <td align="right">主题:</td><td><input type="text" name="theme" size="40"/></td>
</tr>
<tr>
  <td align="right">内容:</td>
  <td><textarea name="contents" id="text" rows="5" cols="50"></textarea></td>
</tr>
<tr>
  <td align="right">附加E-Mail:</td>
  <td>
    您共输入了<span id="emailNums">0</span>个邮箱地址(以“,”分隔多个邮箱地址)<br><br>
    <textarea id="email" name="email" rows="5" cols="50" onkeydown="countEmailAddr();" onkeyup="countEmailAddr();"></textarea>
    <input type="button" value="添加" onclick="mt.show('/jsp/yl/user/DeptSeqs2.jsp',2,'选择用户',500,500)">
  </td>
</tr>
</table>
</div>
<div class='mt15'><input type="submit" class="btn btn-primary" value="<%=r.getString(h.language,"CBSend")%>"/></div>
</form>
<script>
form1.nexturl.value=location.pathname+location.search;
function countEmailAddr()
{
  var mails = form1.email.value.split("@");
  document.getElementById("emailNums").style.display = "";
  var i = mails.length - 1;
  document.getElementById("emailNums").innerHTML = i;
}
mt.value=function(v){
	var va=form1.email.value;
	for(var i=0;i<v.length;i++){
		//alert(va.indexOf(v[i])!=-1);
		if(va.indexOf(v[i])==-1){
			form1.email.value=va+(va.length>0?",":"")+v[i];
			va=form1.email.value;
		}
	}
	countEmailAddr();
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</html>
