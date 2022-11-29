<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.io.*"%><%@page import="java.util.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%><%

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
//h.member=teasession._rv.toString();

int menuid=h.getInt("id");

Community c=Community.find(h.community);

if("POST".equals(request.getMethod()))
{
  c.set("verify",String.valueOf(c.verify=h.getInt("verify")));
  out.print("<script>parent.mt.show('数据提交成功！')</script>");
  return;
}




%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>验证码设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" />
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter">
  <tr>
    <td>验证码类型</td>
    <td><input type="radio" name="verify" value="0" checked="checked"/>无
<%
for(int i=1;i<4;i++)
{
  out.print("<input type='radio' name='verify' value='"+i+"' "+(i==c.verify?" checked":"")+" /><img src='/NFasts.do?act=verify&verify="+i+"' /> ");
}
%>
</td>
  </tr>
</table>

<br/>
<input type="submit" value="提交" onclick=""/> <input type="button" value="返回" onclick="history.back();"/>

</form>

</body>
</html>
