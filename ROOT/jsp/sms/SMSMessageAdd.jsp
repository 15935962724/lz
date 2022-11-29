<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.member.*" %><%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String menuid=teasession.getParameter("id");

if("POST".equals(request.getMethod()))
{
  String rs=SMSMessage.create(teasession._strCommunity,teasession._rv._strR,teasession.getParameter("mobile"),teasession._nLanguage,teasession.getParameter("content"));
  //String rs = SMSMessage.create(teasession._strCommunity,"webmaster","15010780215",teasession._nLanguage,"1111");
  System.out.println(rs);
  out.print("<script>parent.mt.show('"+rs+"');</script>");
  return;
}


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body onload="form1.mobile.focus();">
<h1>发送短信</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="?" method="POST" target="_ajax" onsubmit="return mt.check(this)&&mt.show('正在发送中。。。',0)">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>手机号</TD>
    <td><textarea name="mobile" cols="50" rows="2"></textarea>接受手机,多个用“;”分号分割,最大不超过50个手机号码。</td>
  </tr>
  <tr>
    <td nowrap>内容</TD>
    <td><textarea name="content" cols="50" rows="5" alt="内容"></textarea><br/>
	<a href="#" onclick="alert(form1.content.value.length);form1.content.focus();" >查看长度</a>
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" value="发送"></td>
  </tr>
</table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

