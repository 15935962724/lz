<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.entity.locoso.*" %>
<%

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
par.append("?");
String class1=request.getParameter("class1");
String class2=request.getParameter("class2");
if(class2!=null&&class2.length()>0)
{
  sql.append(" AND category=").append(DbAdapter.cite(class2));
  par.append("&class1=").append(class1);
  par.append("&class2=").append(class2);
}else if(class1!=null&&class1.length()>0)
{
  sql.append(" AND category=").append(DbAdapter.cite(class1));
  par.append("&class1=").append(class1);
}
String q=request.getParameter("q");
if(q!=null&&q.length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+q+"%"));
  par.append("&q=").append(URLEncoder.encode(q,"UTF-8"));
}
par.append("&pos=");
int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int sum=Company.count(sql.toString());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link href="/tea/community.css" rel="stylesheet" type="text/css">
</head>
<body onload="f_load()">

<h2>查询</h2>
<form name="form1" action="?">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>
<select name="class1" onchange="f_change(value)">
<option value="">--------------------</option>
<%
StringBuffer sb=new StringBuffer();
for(int i=0;i<Locoso.CAT.length;i++)
{
  String id=Locoso.CAT[i][0][0];
  out.print("<option value="+id);
  if(id.equals(class1))
  {
    out.print(" selected=''");
  }
  out.print(">"+Locoso.CAT[i][0][1]);
  sb.append("case '").append(id).append("':");
  for(int j=1;j<Locoso.CAT[i].length;j++)
  {
    sb.append("o[o.length]=new Option('").append(Locoso.CAT[i][j][1]).append("','").append(Locoso.CAT[i][j][0]).append("');");
  }
  sb.append("break;\r\n");
}
%>
</select>
<select name="class2">
<option value="">--------------------</option>
</select>
  </td>
  <td>
    名称:<input type="text" name="q" value="<%if(q!=null)out.print(q);%>"/>
  </td>
  <td>
    <input type="submit" value="GO"/>
  </td>
</tr>
</table>
</form>
<script>
function f_change(v)
{
  var o=form1.class2.options;
  while(o.length>1)
  {
    o[1]=null;
  }
  switch(v)
  {
    <%=sb.toString()%>
  }
}
function f_load()
{
  f_change(form1.class1.value);
  <%
  if(class2!=null&&class2.length()>0)
  {
    out.print("form1.class2.value='"+class2+"';");
  }
  %>
}
</script>

<h2>列表 <%=sum%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id=tableonetr><td>名称</td><td>电话</td><td>地址</td><td>邮编</td></tr>
<%
Enumeration e=Company.find(sql.toString(),pos,25);
while(e.hasMoreElements())
{
  Company obj=(Company)e.nextElement();
  String id=obj.getId();
  String name=obj.getName();
  String tel=obj.getTel();
  if(q!=null&&q.length()>0)
  {
    name= name.replaceAll(q,"<font color='red'>"+q+"</font>");
  }
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td><a href="+id+" target='_blank'>"+name+"</a>");
  out.print("<td>&nbsp;");
  if(tel!=null)out.print(tel);
  out.print("<td>"+obj.getAddress());
  out.print("<td>"+obj.getZip());
}
%>
</table>
<%=new tea.htmlx.FPNL(1,par.toString(),pos,sum)%>
</body>
</html>
