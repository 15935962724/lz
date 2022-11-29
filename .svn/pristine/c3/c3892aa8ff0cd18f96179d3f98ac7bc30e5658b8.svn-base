<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

StringBuffer sql=new StringBuffer();


int unit=0;
String tmp=request.getParameter("unit");
if(tmp!=null&&tmp.length()>0)
{
  unit=Integer.parseInt(tmp);
  sql.append(" AND unit=").append(unit);
}

String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member LIKE ").append(DbAdapter.cite("%"+member+"%"));
}

String input=request.getParameter("input");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_click(m)
{
  var obj=opener.<%=input%>;
  if(obj.value.indexOf(m+"; ")==-1)
  {
    obj.value=obj.value+m+"; ";
  }
}
</script>
</head>
<body>

<h1>查询</h1>
<div id=head6><img height=6 src=about:blank></div>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>会员:<input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
  <td>部门:<select name="unit">
  <option value="">--------------------</option>
  <%
  Enumeration eau=AdminUnit.findByCommunity(teasession._strCommunity,"");
  while(eau.hasMoreElements())
  {
    AdminUnit obj=(AdminUnit)eau.nextElement();
    int id=obj.getId();
    out.print("<option value="+id);
    if(id==unit)out.print(" selected ");
    out.print(">"+obj.getName());
  }
  %>
  </select></td>
  <td><input type="submit" value="GO"/></td>
</tr>
</table>
</form>

<h1>列表</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr"><td>会员</td><td>部门</td></tr>
<%
Enumeration e=AdminUsrRole.findByCommunity(teasession._strCommunity,sql.toString());
for(int i=1;e.hasMoreElements();i++)
{
  member=(String)e.nextElement();
  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,member);
  AdminUnit au=AdminUnit.find(aur.getUnit());
  out.print("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' style=\"cursor:hand;\" onclick=\"f_click('"+member+"')\"><td>");
  out.print(member);
  out.print("<td>&nbsp;");
  if(au.isExists())
  {
    out.print(au.getName());
  }
}
%>
</table>

</body>
</html>
