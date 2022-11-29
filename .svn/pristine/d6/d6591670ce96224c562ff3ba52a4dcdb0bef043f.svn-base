<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
//if(h.member==null)
//{
//  response.sendRedirect("/my/Login.jsp?nexturl=" + Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
//  return;
//}
//

String act=h.get("act");
if("ok".equals(act))
{
  String avatar=(String)session.getAttribute("avatar");

  out.print("<script>var $$=parent.$$;");
  out.print("var t=$$('avatar');t.value='"+avatar+"';t=$$('avatar_img');t.src='"+avatar+"?t='+new Date().getTime();");
  out.print("parent.mt.close();</script>");
  return;
}

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body style="margin:0;overflow:hidden">


<script>
mt.embed("/tea/mt/avatar.swf?inajax=1&appid=13&input=&agent=&ucapi="+location.host+"%2FMembers.do%3Fact%3Davatar%26repository%3Davatar<%%>%26&avatartype=virtual&uploadSize=5120",450,253);
function updateavatar()
{
  location=location.href+'&act=ok';
}
</script>


</body>
</html>
