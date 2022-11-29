<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String nextUrl="";
	if(request.getAttribute("nextUrl")!=null){
		nextUrl=(String)request.getAttribute("nextUrl");
	}
	StringBuffer url=request.getRequestURL();
	String uri=request.getRequestURI();
	String main=url.substring(0, url.length()-uri.length());
%>

<script type="text/javascript">
	var i=10;
	function change(){
		i--;
		if(i==0){
			window.location="<%=main%>";
		}else{
			document.getElementById("time").innerHTML=i;
		}

		setTimeout("change()",1000);
	}
	window.onload=change;
</script>

<h2>恭喜您，注册成功！</h2>
<span class="Con">
	恭喜您成为校外教育信息资源网会员，会员注册通过审核后即可浏览网站所有栏目信息。欢迎您在网站的“校外机构”栏目上传贵单位的信息，并针对网站栏目内容进行投稿。真诚欢迎您的加入！
</span>
<span id="timespan"><span id="time">10</span>秒后 自动返回首页</span>
<div class="bottomFun"><a href="<%=nextUrl%>">返回浏览页面</a>　 　 　 <a href="<%=main%>">返回首页</a></div>
