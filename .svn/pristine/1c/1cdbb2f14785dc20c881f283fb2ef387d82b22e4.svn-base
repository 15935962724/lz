<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.admin.*"%><%

Http h=new Http(request);

String nexturl="/jsp/admin/popedom/AdminUnitOrgs.jsp?community="+h.community;

int adminunitorg=h.getInt("adminunitorg");
AdminUnitOrg t=AdminUnitOrg.find(adminunitorg);
if("POST".equals(request.getMethod()))
{
  if("del".equals(request.getQueryString()))
  {
    t.delete();
    //out.print("<script>alert('数据删除成功!');history.go(-1);</script>");
  }else
  {
    t.community=h.community;
    t.name=h.get("name");
    t.org=h.get("org");
    t.sequence=h.getInt("sequence");
    t.set();
    //out.print("<script>alert('数据修改成功!');history.go(-2);</script>");
  }
  response.sendRedirect(nexturl);
  return;
}

%><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" onsubmit="return submitText(this.name,'不能为空!')">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="adminunitorg" value="<%=adminunitorg%>"/>

<table id="tablecenter">
  <tr>
    <td>类型名称</td>
    <td><input name="name" value="<%=MT.f(t.name)%>"/></td>
  </tr>
  <tr>
    <td>公司名称</td>
    <td><input name="org" value="<%=MT.f(t.org)%>"/></td>
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
