<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmscert");
int lmscert=key.length()<1?0:Integer.parseInt(MT.dec(key));
LmsCert t=LmsCert.find(lmscert);

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看证书信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1">


<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th>证书编号：</th>
    <td><%=MT.f(t.code)%></td>
  </tr>
  <tr>
    <th>证书名称：</th>
    <td><%=MT.f(t.name)%></td>
  </tr>
  <tr>
    <th>证书类型：</th>
    <td><%=LmsCert.LMSCERT_TYPE[t.type]%></td>
  </tr>
  <tr>
    <th>证书等级：</th>
    <td><%=LmsCert.RANK_TYPE[t.rank]%></td>
  </tr>
  <tr>
    <th>申请费用：</th>
    <td><%=MT.f(t.price)%></td>
  </tr>
  <tr>
    <th>证书描述：</th>
    <td><%=MT.f(t.content).replaceAll("\r\n","<br/>")%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
</script>
</body>
</html>
