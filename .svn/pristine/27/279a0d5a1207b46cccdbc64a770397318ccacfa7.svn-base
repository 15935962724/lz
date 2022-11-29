<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?community="+h.community+"'</script>");
  return;
}


int role=h.getInt("role");
AdminRole t=AdminRole.find(role);


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看角色</h1>

<form name="form1" action="/Roles.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="role" value="<%=role%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="act" value="edit"/>

<table id="tablecenter">
  <tr>
    <td class="th">名称：</td>
    <td><%=MT.f(t.name)%></td>
  </tr>
  <tr>
    <td class="th">类型：</td>
    <td><%=AdminRole.ROLE_TYPE[t.type]%></td>
  </tr>
  <tr>
    <td class="th" nowrap>角色等级：</td>
    <td><%=MT.f(t.levels)%></td>
  </tr>
  <tr>
    <td class="th">描述：</td>
    <td><%=MT.f(t.content)%></td>
  </tr>
  <tr>
    <td class="th">时间：</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
  <tr>
    <td class="th">成员：</td>
    <td>
    <%
    Iterator e=Profile.find1(" AND p.member!='webmaster' AND p.deleted=0 AND aur.role LIKE "+DbAdapter.cite("%/"+t.id+"/%"),0,Integer.MAX_VALUE).iterator();
    while(e.hasNext())
    {
      Profile m=(Profile)e.next();
      out.print("<a href='/jsp/sub/MemberView.jsp?member="+m.getProfile()+"'>"+m.getMember()+"</a>；");
    }
    %>
    </td>
  </tr>
<%--
  <tr>
    <td class="th">选项：</td>
    <td><input name="distinguish" type="checkbox" id="distinguish" <%=t.distinguish?" checked":""%> /><label for="distinguish">区分内外网</label></td>
  </tr>
--%>
</table>

<br/>
<input type="button" value="返回" onClick="history.back();"/>
</form>

<script>
</script>

</body>
</html>
