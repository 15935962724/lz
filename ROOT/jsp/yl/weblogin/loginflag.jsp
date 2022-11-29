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

<script type="text/javascript">
	onload = function(){
		var bang = document.getElementById("bang");
		var create = document.getElementById("create");
		<%
		Http h=new Http(request,response);
			String act = h.get("act");
			String openid = h.get("openid");
			String access_token = h.get("access_token");
			//out.print("alert('/mobjsp/admin/createUser.jsp?act=qq&access_token="+access_token+"&openid="+openid+"');");
			if(act.equals("qq")){
				out.print("bang.href='/jsp/pcadmin/moblogin.jsp?act=qq&access_token="+access_token+"&openid="+openid+"';create.href='/jsp/yl/user/YlReg.jsp?act=qq&access_token="+access_token+"&openid="+openid+"';");
			}else if(act.equals("wx")){
				out.print("bang.href='/jsp/pcadmin/moblogin.jsp?act=wx&access_token="+access_token+"&openid="+openid+"';create.href='/jsp/yl/user/YlReg.jsp?act=wx&access_token="+access_token+"&openid="+openid+"';");
			}else if(act.equals("wb")){
				out.print("bang.href='/jsp/pcadmin/moblogin.jsp?act=wb&access_token="+access_token+"&openid="+openid+"';create.href='/jsp/yl/user/YlReg.jsp?act=wb&access_token="+access_token+"&openid="+openid+"';");
			}
		%>
	}
</script>
<body>
<div class="yonghu">
            	<p class="p1">亲爱的新浪微博用户</p>
                <span class="sp1">如果您已经注册过粒子治疗账号，请</span>
                <a href="" id="bang">绑定用户</a>
                <span class="sp1">如果您之前未注册过粒子治疗账号，请</span>
                <a href="" id="create">新建用户</a>
            </div>

<script>
mt.fit();
</script>
</body>
</html>