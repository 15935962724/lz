<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String _strId=request.getParameter("id");

Resource r=new Resource("/tea/resource/AdminList");

StringBuffer sql=new StringBuffer(" and (hiddenorg!=1 or hiddenorg is null)");
StringBuffer par=new StringBuffer("?");
sql.append(" AND father>0");

String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  par.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}
par.append("&pos=");

int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int count=AdminUnit.countByCommunity(teasession._strCommunity,sql.toString());

String o=request.getParameter("o");
if(o==null)
{
  o="sequence";
}
boolean a=Boolean.parseBoolean(request.getParameter("a"));
sql.append(" ORDER BY ").append(o).append(" ").append(a?"DESC":"ASC");

////
String alname="adminunit";
AdminList al=AdminList.find(teasession._rv._strV,alname);
String fields[]=al.getField().split("/");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_order(v)
{
  var asc=form1.a.value=="true";
  if(form1.o.value==v)
  {
    form1.a.value=!asc;
  }else
  {
    form1.o.value=v;
  }
  form1.action="?";
  form1.submit();
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "部门列表")%></h1>
<div id="head6"><img height="6" alt=""></div>

<h2><%=r.getString(teasession._nLanguage, "查询")%></h2>

<form name="form1" action="?" >
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="id" value="<%=_strId%>">
<input type=hidden name="o" value="<%=o%>">
<input type=hidden name="a" value="<%=a%>">

<table cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "部门名称")%><input name="name" value="<%if(name!=null)out.print(name);%>" size="25" ></td>
      <td><input type="submit" value="检索"></td>
    </tr>
</TABLE>
</FORM>

<h2><%=r.getString(teasession._nLanguage, "列表")+" ( "+count+" )"%><!--<a href="/jsp/admin/popedom/EditAdminList.jsp?name=<%=alname%>">定制列表格式</a>--></h2>
<table  cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
<%
out.print("<TR id=tableonetr><td nowrap>序号</td>");
for(int j=1;j<fields.length;j++)
{
  out.print("<td><a href=javascript:f_order('"+fields[j]+"')>"+r.getString(teasession._nLanguage,alname+"."+fields[j])+"</a>");
  if(o.equals(fields[j]))
  {
    if(a)
    out.print("↓");
    else
    out.print("↑");
  }
}
Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity,sql.toString(),pos,size);
for(int i=1+pos;e.hasMoreElements();i++)
{
  AdminUnit obj=(AdminUnit)e.nextElement();
  int id=obj.getId();
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td width=10>"+i);
  for(int j=1;j<fields.length;j++)
  {
    out.print("<td nowrap>&nbsp;");
    if(fields[j].equals("name"))
    {
      out.print("<a href=/jsp/admin/popedom/AdminUnitView.jsp?community="+teasession._strCommunity+"&adminunit="+id+" >");
      if(o.equals("sequence"))
      {
        out.print(obj.getPrefix());
      }
      out.print(obj.getName()+"</a>");
    }else if(fields[j].equals("ename"))
    {
      out.print(obj.getEName());
    }else if(fields[j].equals("linkmanname"))
    {
      out.print(obj.getLinkmanname());
    }else if(fields[j].equals("father"))
    {
      if(obj.getFather()>0)
      {
        out.print("<a href=/jsp/admin/popedom/AdminUnitView.jsp?community="+teasession._strCommunity+"&adminunit="+obj.getFather()+" >"+AdminUnit.find(obj.getFather()).getName()+"</a>");
        //out.print(AdminUnit.find(obj.getFather()).getName());
      }
    }else if(fields[j].equals("address"))
    {
      out.print(obj.getAddress());
    }
  }
}if(count>size){
%>
<tr><td colspan="50" align="right"><%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,size)%></td>
<%}%>
</TABLE>

<br>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>
