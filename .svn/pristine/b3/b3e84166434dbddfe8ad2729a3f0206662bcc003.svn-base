<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmsleave");
LmsLeave t=LmsLeave.find(key.length()<1?0:Integer.parseInt(MT.dec(key)));

Profile p=Profile.find(t.member);
LmsOrg lo=LmsOrg.find(p.getAgent());


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>退学申请</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/LmsLeaves.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="if(mt.check(this)){mt.show(null,0);up.complete();}return false;">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member" value="<%=p.getProfile()%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th>省助学发展机构：</th>
    <td><%=MT.f(LmsOrg.find(lo.father).orgname)%></td>
    <th>学习服务中心：</th>
    <td><%=MT.f(lo.orgname)%></td>
  </tr>
  <tr>
    <th>申请人：</th>
    <td><%=p.getName(h.language)%></td>
    <th>学号：</th>
    <td><%=p.getMember()%></td>
  </tr>
  <tr>
    <th>证件号：</th>
    <td><%=p.getCard()%></td>
    <th>准考证号：</th>
    <td><%=MT.f(p.getCardnumber())%></td>
  </tr>
  <tr>
    <th>退学申请表：</th>
    <td colspan="3"><%=Attch.f(t.attch)%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>

</script>
</body>
</html>
