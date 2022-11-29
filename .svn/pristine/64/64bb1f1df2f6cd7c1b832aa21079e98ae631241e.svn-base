<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int lmsincome=h.getInt("lmsincome");
LmsIncome t=LmsIncome.find(lmsincome);
if(t.lmsincome<1)
t.type=h.getInt("type");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<style>
.<%=t.type==1||t.type==3||t.type==5?"C":""%>{display:none}
</style>
</head>
<body>
<h1><%=(t.lmsincome<1?"添加":"编辑")+LmsIncome.INCOME_TYPE[t.type]%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsIncomes.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsincome" value="<%=lmsincome%>"/>
<input type="hidden" name="type" value="<%=t.type%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr class="C">
    <th>省</th>
    <td><script>mt.city("city",null,null,"<%=t.city%>");</script></td>
  </tr>
  <tr>
    <th>收费标准</th>
    <td><input name="price" value="<%=MT.f(t.price)%>" alt="收费标准" mask="float"/>元/科次</td>
  </tr>
  <tr>
    <th>有效期:</th>
    <td><input name="starttime" value="<%=MT.f(t.starttime)%>" alt="有效期" onclick="mt.date(this)" class="date"/> - <input name="endtime" value="<%=MT.f(t.endtime)%>" onclick="mt.date(this)" class="date"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
