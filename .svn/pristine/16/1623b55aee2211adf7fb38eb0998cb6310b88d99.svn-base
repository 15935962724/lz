<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.axis.encoding.Base64"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script> 
</head>
<%
Http h=new Http(request);
Resource r=new Resource("/tea/ui/member/community/dpxReg");
%>
<body>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<div class="denglu">

<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)&&mt.show(null,0);" name="form2" method="post">
<input type="hidden" value="get" name="act" />
<input type="hidden" value="/" name="nexturl" />
<ul>
<li><span class="sp1">用户名</span><input name="username" alt="用户名" class="texts lo1" /></li>
<li><span class="sp1"><%=r.getString(h.language, "verificationcode")%></span><input  style="text-transform: uppercase; width:122px;" class="texts" alt="<%=r.getString(h.language, "verificationcode")%>" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off"><a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: hidden;position:relative;top:7px;left:3px;"></a></li>
<li class="li_log" style="border:none;"><input value="提交" type="submit" class='log' /></li>
</ul></form>

</div>

	<script>
	mt.verifys=function()
	{
	  var imgs=document.getElementById('img_verifys');
          imgs.style.visibility = "visible";
	  imgs.src=imgs.src.replace(/=[.\d]+/,'='+Math.random());
	  foLogin.verify.value='';
	  foLogin.verify.focus();
	};
	</script>
<script>
mt.fit();
</script>

</body>
</html>