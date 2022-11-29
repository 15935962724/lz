<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int down=h.getInt("down");
FDown t=FDown.find(down);
Node n=Node.find(t.node);
Profile m=Profile.find(t.member);
Files f=Files.find(t.node,h.language);

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看——文件下载</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="down" value="<%=down%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">文件：</td>
    <td><%=n.getAnchor(h.language)%></td>
  </tr>
  <tr>
    <td class="th">文件大小：</td>
    <td><%=MT.f(f.filesize/1024F)%>K</td>
  </tr>
  <tr>
    <td class="th">用户名：</td>
    <td><%=m.getMember()%></td>
  </tr>
  <tr>
    <td class="th">E-Mail：</td>
    <td><%=m.getEmail()%></td>
  </tr>
  <tr>
    <td class="th">手机号：</td>
    <td><%=m.getMobile()%></td>
  </tr>
  <tr>
    <td class="th">电话：</td>
    <td><%=m.getTelephone(h.language)%></td>
  </tr>
  <tr>
    <td class="th">单位：</td>
    <td><%=m.getOrganization(h.language)%></td>
  </tr>
  <tr>
    <td class="th">职务：</td>
    <td><%=m.getJob(h.language)%></td>
  </tr>
  <tr>
    <td class="th">IP地址：</td>
    <td><%=MT.f(t.ip)%></td>
  </tr>
  <tr>
    <td class="th">时间：</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
