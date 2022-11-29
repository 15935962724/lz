<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.shop.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if("ok".equals(h.get("act")))
{
	String avatar=(String)session.getAttribute("avatar");
	out.print("<script>parent.mt.re('"+avatar+"');parent.mt.close();</script>");
	return;
}

ProfileBBS pb=ProfileBBS.find(h.community,String.valueOf(h.member));

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body style="margin:0;overflow:hidden">


<script>
mt.embed("/tea/mt/avatar.swf?inajax=1&appid=13&input=&agent=&ucapi="+location.host+"%2FMembers.do%3Fact%3Davatar%26repository%3Davatar%26&avatartype=virtual&uploadSize=2048",450,253);
//function updateavatar(){parent.location.reload();}
function updateavatar(){location=location+'&act=ok';}
</script>

<form name="form1" action="/Members.do" method="post" enctype="multipart/form-data" target="_ajax">
<input type="hidden" name="act" value="avatar"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<input type="hidden" name="repository" value="photo"/>

<table>
<tr><td><img src="<%=MT.f(pb.getPortrait(h.language),"/tea/image/avatar.jpg")%>" /><br/>当前头像</td>
</table>


<input type="file" name="photo" style="position:absolute;width:0;filter:alpha(opacity=0);opacity:0" onfocus="hideFocus=true;" onChange="form1.submit();" size="1" /><input type="button" value="选择您要上传的头像" onMouseMove="form1.photo.style.left=event.x-30;"/>
<br/>我们只接受jpg，jpeg，gif，png，bmp格式图像;图像最大不要超过4Mb或4096Kb
<br/>
<input type="button" value="关闭" onClick="parent.mt.close();"/>
</form>

</body>
</html>
