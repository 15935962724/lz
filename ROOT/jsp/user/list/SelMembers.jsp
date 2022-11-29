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

boolean _bType=Boolean.parseBoolean(request.getParameter("type"));

int unit=0;
String tmp=request.getParameter("unit");
if(tmp!=null&&tmp.length()>0)
{
  unit=Integer.parseInt(tmp);
}

int cgroup=0;
tmp=request.getParameter("cgroup");
if(tmp!=null&&tmp.length()>0)
{
  cgroup=Integer.parseInt(tmp);
}
if(_bType)//个性化分类
{
  sql.append(" AND member IN ( SELECT p.profile FROM Contact c inner join Profile p on c.member=p.member ");
  if(cgroup>0)
  {
    sql.append(" WHERE c.cgroup=").append(cgroup);
  }
  sql.append(")");
}else if(unit>0)
{
  sql.append(" AND unit=").append(unit);
}

String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member in (select profile from profile where member LIKE ").append(DbAdapter.cite("%"+member+"%")+") ");
}
sql.append(" AND options NOT LIKE '%/1/%'");

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
var obj=opener.<%=input%>;
function f_unload()
{
  var ms=form1.members;
  if(ms)
  {
    //obj.value="";
    var v=obj.value;
    if(!ms.length)ms=new Array(ms);
    for(var i=0;i<ms.length;i++)
    {
      if(ms[i].checked&&v.indexOf(ms[i].value)==-1)
      {
        v=v+ms[i].value+"; ";
      }
    }
    obj.value=v;
  }
  window.close();
}

function f_type()
{
  if(form1.type[0].checked)
  {
    td0.style.display="";
    td1.style.display="none";
  }else
  {
    td0.style.display="none";
    td1.style.display="";
  }
}
function f_load()
{
  var s="; "+obj.value;
  var ms=form1.members;
  if(ms)
  {
    if(!ms.length)ms=new Array(ms);
    for(var i=0;i<ms.length;i++)
    {
      ms[i].checked=s.indexOf("; "+ms[i].value+"; ")!=-1;
    }
  }
  f_type();
}
</script>
</head>
<body onload="f_load();">

<h1>查询</h1>
<div id=head6><img height=6 src=about:blank></div>

<form name="form1" action="?" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="input" value="<%=input%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td colspan="2">
    <input name="type" type="radio" value="false" onclick="f_type()" checked>默认分类
    <input name="type" type="radio" value="true" onclick="f_type()" <%if(_bType)out.print(" checked ");%> >个性化分类
    <a href="/jsp/message/CGroups.jsp?community=<%=teasession._strCommunity%>" target="_blank" >管理</a>
  </td>
</tr>
<tr>
  <td>会员:<input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
  <td id="td0">部门:<select name="unit">
  <option value="">--------------------</option>
  <%
  Enumeration eau=AdminUnit.findByCommunity(teasession._strCommunity,"");
  while(eau.hasMoreElements())
  {
    AdminUnit obj=(AdminUnit)eau.nextElement();
    int id=obj.getId();
    out.print("<option value="+id);
    if(id==unit)out.print(" selected ");
    out.print(">"+obj.getPrefix()+obj.getName());
  }
  %>
  </select></td>
  <td id="td1" style="display:none">组:<select name="cgroup">
  <option value="">--------------------</option>
  <%
  eau=CGroup.find(teasession._rv._strV,"",0,Integer.MAX_VALUE);
  while(eau.hasMoreElements())
  {
    int id=((Integer)eau.nextElement()).intValue();
    CGroup obj=CGroup.find(id);
    out.print("<option value="+id);
    if(id==cgroup)out.print(" selected ");
    out.print(">"+obj.getName(teasession._nLanguage));
  }
  %>
  </select></td>
  <td><input type="submit" value="检索"/></td>
</tr>
</table>


<h1>列表</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr"><td><input type="checkbox" onclick="selectAll(form1.members,checked);"></td><td>会员</td><td>部门</td></tr>
<%
Enumeration e=AdminUsrRole.findByCommunity(teasession._strCommunity,sql.toString());
for(int i=1;e.hasMoreElements();i++)
{
  member=(String)e.nextElement();
  int mid=Integer.parseInt(member);
  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,mid);
  AdminUnit au=AdminUnit.find(aur.getUnit());
  out.print("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''>");
  out.print("<td><input type=checkbox name=members value="+Profile.find(mid).getMember()+">");
  out.print("<td>"+Profile.find(mid).getMember());
  out.print("<td>&nbsp;");
  if(au.isExists())
  {
    out.print(au.getName());
  }
}
%>
</table>
<input type="button" value="确定" onclick="f_unload();">
<input type="button" value="关闭" onclick="window.close();">
</form>


</body>
</html>
