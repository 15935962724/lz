<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.admin.*"%><%
response.setHeader("Pragma", "no-cache");
Http h=new Http(request);

String nexturl="/jsp/admin/popedom/AdminUnitTypes.jsp?community="+h.community;

int adminunittype=h.getInt("adminunittype");
AdminUnitType t=AdminUnitType.find(adminunittype);
if("POST".equals(request.getMethod()))
{
  if("del".equals(request.getQueryString()))
  {
    t.delete();
    //out.print("<script>alert('数据删除成功!');</script>");
  }else
  {
    t.community=h.community;
    t.name=h.get("name");
    t.sequence=h.getInt("sequence");
    t.set();
    //out.print("<script>alert('数据修改成功!');</script>");
  }
  response.sendRedirect(nexturl);
  //out.print("<script>location.href='/jsp/admin/popedom/AdminUnitTypes.jsp?community="+h.community+"';</script>");
  return;
}

%><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body onload="form1.name.focus();">
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="adminunittype" value="<%=adminunittype%>"/>

<table id="tablecenter">
  <tr>
    <td>名称</td>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="名称"/></td>
  </tr>
  <tr>
    <td>顺序</td>
    <td><input name="sequence" value="<%=MT.f(t.sequence)%>" mask="int"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="window.open('<%=nexturl%>',window.name);"/>
</form>

</body>
</html>
