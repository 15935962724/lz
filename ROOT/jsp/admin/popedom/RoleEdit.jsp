<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?community="+h.community+"'</script>");
  return;
}
if(h.isIllegal())
{
  response.sendError(404,request.getRequestURI());
  return;
}

String key=h.get("role");
AdminRole t=AdminRole.find(key.length()<1?0:Integer.parseInt(MT.dec(key)));
if(t.id<1)t.type=1;

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑角色</h1>

<form name="form1" action="/Roles.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="role" value="<%=key%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="act" value="edit"/>

<table id="tablecenter">
  <tr>
    <td class="th">名称：</td>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="名称"/></td>
  </tr>
  <tr>
    <td class="th">类型：</td>
    <td><%=h.radios(AdminRole.ROLE_TYPE,"type",t.type)%></td>
  </tr>
  <tr>
    <td class="th">角色等级：</td>
    <td><input name="levels" value="<%=MT.f(t.levels)%>" mask="int" /></td>
  </tr>
  <tr>
    <td class="th">描述：</td>
    <td><input name="content" value="<%=MT.f(t.content)%>" size="50"/></td>
  </tr>
  <tr>
    <td class="th">选项：</td>
    <td><input name="distinguish" type="checkbox" id="distinguish" <%=t.distinguish?" checked":""%> /><label for="distinguish">区分内外网</label></td>
  </tr>
<%--
  <tr>
    <td>成员</td>
    <td><input type="button" value="添加" onclick="mt.show('/admin/member/MemberSel.jsp?type=1,2&member='+mt.value(form1.members,'|'),2,value,500,400)"/>
      <div id="t_member"><%
    String[] ar=t.member.split("[|]");
    for(int i=1;i<ar.length;i++)
    {
      out.print("<span><input type='hidden' name='members' value='"+ar[i]+"'/>"+Member.find(Integer.parseInt(ar[i])).username+"<img src='/tea/image/d7.gif' onclick='mt.del(this);' /></span>");
    }
    %></div>
    </td>
  </tr>
--%>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<script>
//var t=form1.type[0];
//if(!t.checked)
//{
//  t.style.display="none";
//  t.nextSibling.style.display="none";
//}
mt.receive=function(a,b,c){$('t_member').innerHTML+=c;}
mt.del=function(p){p=p.parentNode;p.parentNode.removeChild(p);}
mt.focus();
</script>

</body>
</html>
