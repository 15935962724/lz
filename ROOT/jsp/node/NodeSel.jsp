<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/admin/Login.jsp'</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menu=h.getInt("menu");
par.append("?menu="+menu);

int atype=h.getInt("atype");
//sql.append(" AND atype LIKE "+DbAdater.cite("%|"+atype+"|%"));
//par.append("&atype="+atype);
//AType at=AType.find(atype);

sql.append(" AND n.community="+DbAdapter.cite(h.community));
sql.append(" AND nl.language="+h.language+" AND n.hidden=0 AND n.finished=1");

String nodes=h.get("nodes","|");

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND nl.subject LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

Date t0=h.getDate("t0");
if(t0!=null)
{
  sql.append(" AND n.time>"+DbAdapter.cite(t0));
  par.append("&t0="+MT.f(t0));
}
Date t1=h.getDate("t1");
if(t1!=null)
{
  sql.append(" AND n.time<"+DbAdapter.cite(t1));
  par.append("&t1="+MT.f(t1));
}

int sum=Node.count(sql.toString());



int pos=h.getInt("pos");
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<form name="form1" action="?">
<input type="hidden" name="menu" value="<%=menu%>"/>
<input type="hidden" name="atype" value="<%=atype%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>标题:<input name="name" value="<%=MT.f(name)%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<form name="form2" action="/Articles.do" method="post" target="_ajax">
<input type="hidden" name="atype" value="<%=atype%>"/>
<input type="hidden" name="article"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td><input type="checkbox" onclick="mt.select(form2.nodes,checked)"/></td>
  <td>标题</td>
  <td>时间</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY time DESC");
  Iterator it=Node.find1(sql.toString(),h.language,pos,8).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Node t=(Node)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="nodes"  value="<%=nodes.contains("|"+t._nNode+"|")?"\" disabled checked ":""+t._nNode%>" /></td>
    <td><%=t.getAnchor(h.language)%></td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
  <%
  }
  if(sum>8)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,8));
}%>
</table>
<br/>
<input type="button" value="确定" onclick="f_act()"/> <input type="button" value="关闭" onclick="pmt.close();"/>
</form>

<script>
var pmt=parent.mt;
function f_act()
{
  pmt.receive(mt.value(form2.nodes,'|'));
  pmt.close();
}
mt.fit();
</script>
</body>
</html>
