<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
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
Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
String act = h.get("act");
String access_token = h.get("access_token");
String openid = h.get("openid");
%>
<body>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	function checkform(){
		var name = form2.name.value;
		var pwd = form2.pwd.value;
		var namediv = $("#namediv");
		var pwddiv = $("#pwddiv");
		if(name==""){
			namediv.html("用户名不能为空");
			return;
		}
		namediv.html("");
		if(pwd==""){
			pwddiv.html("密码不能为空");
			return;
		}
		pwddiv.html("");
		sendx("/jsp/admin/edn_ajax.jsp?act=ispass&mob="+ encodeURIComponent(form2.name.value)+"&myact=<%= act%>&mobile="+ encodeURIComponent(form2.name.value)+"&paw="+form2.pwd.value,
				function(data)
				 {
					data = data.trim();
					if(data==2)
					{
						namediv.html("用户名或密码错误");
						return;
					}else if(data==4)
	                {
						namediv.html("用户被锁定");
						return;
	                }else if(data==6){
	                	namediv.html("用户已经被绑定");
						return;
	                }else{
	                	form2.submit();
	                }
				 }	 
		);
		/* sendx("/jsp/admin/edn_ajax.jsp?act=WestracEvent_login&mobile="+ encodeURIComponent(form2.name.value)+"&paw="+form2.pwd.value,
				 function(data)
				 {
					data = data.trim();
					if(data==2)
					{
						alert("用户名或密码错误");
						return;
					}else if(data==4)
	                {
						alert("用户被锁定");
						return;
	                }else{
	                	form2.submit();
	                }
				 }); */
	}
</script>

<div class="log">
                <form name="form2" action="/jsp/pcadmin/saveUser.jsp">
		<input type="hidden" name="act" value="<%= act %>" />
		<input type="hidden" name="access_token" value="<%= access_token %>" />
		<input type="hidden" name="openid" value="<%= openid %>" />
	
	<p class="p1">绑定已有粒子治疗账号</p>
	<table class="tab" cellpadding="0" cellspacing="0">
		<tr>
			<td class="td1">用户名：</td><td><input class="name text" name="name" /></td><td><div id="namediv"></div></td>
		</tr>
		<tr>
			<td class="td1">密码：</td><td><input class="pwd text" name="pwd" /></td><td><div id="pwddiv"></div></td>
		</tr>
		<tr>
        <td class="td1">&nbsp;</td>
			<td>
				<input type="button" class="button" value="提交" onclick="checkform();" />
			</td>
		</tr>
	</table>
	
</form>
            </div>
		<script>
mt.fit();
</script>
</body>
</html>