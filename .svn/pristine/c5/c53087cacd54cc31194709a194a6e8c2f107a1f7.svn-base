<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.util.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}


StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

sql.append(" AND father="+h.node);

//NodeLayer
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE 1=1");
  sql.append(" AND subject LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
  sql.append(")");
}

//
sql.append(" AND node IN(SELECT node FROM outside WHERE 1=1");

boolean isMe=h.getBool("me");
if(isMe)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%|"+h.member+"|%"));
}

int city=h.getInt("city2");
if(city<1)city=h.getInt("city1");
if(city<1)city=h.getInt("city0");
if(city>0)
{
  sql.append(" AND city LIKE "+DbAdapter.cite(city+"%"));
  par.append("&city="+city);
}

String website=h.get("website","");
if(website.length()>0)
{
  sql.append(" AND website LIKE "+DbAdapter.cite("%"+website+"%"));
  par.append("&website="+h.enc(website));
}

String tel=h.get("tel","");
if(tel.length()>0)
{
  sql.append(" AND tel LIKE "+DbAdapter.cite("%"+tel+"%"));
  par.append("&tel="+h.enc(tel));
}
sql.append(")");

int sum=Node.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

String acts=h.get("acts","");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1>校外机构管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td>城市:<script>mt.city('city0','city1','city2','<%=city%>');</script></td>
  <td>电话:<input name="tel" value="<%=tel%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Outsides.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>城市</td>
  <td>网址</td>
  <td>电话</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Enumeration e=Node.find(sql.toString(),pos,20);
  for(int i=1+pos;e.hasMoreElements();i++)
  {
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);
    Outside t=Outside.find(node,h.language);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=Card.find(t.city).toString()%></td>
    <td><%=MT.f(t.website)%></td>
    <td><%=MT.f(t.tel)%></td>
    <td>
    <%
    if(acts.contains("edit"))
    {
      Enumeration es=Node.find(" AND father="+t.node+" ORDER BY node",0,4);
      if(es.hasMoreElements())es.nextElement();
      out.print("<a href=javascript:mt.act('edit',"+t.node+")>编辑</a> ");
      if(es.hasMoreElements())out.print("<a href=javascript:mt.act('edit1',"+es.nextElement()+")>动态</a> ");
      if(es.hasMoreElements())out.print("<a href=javascript:mt.act('edit2',"+es.nextElement()+")>师资</a> ");
    }
    if(acts.contains("member"))out.print("<a href=javascript:mt.act('member',"+t.node+")>权限</a> ");
    if(acts.contains("del"))out.print("<a href=javascript:mt.act('del',"+t.node+")>删除</a> ");
    %>
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<%
if(acts.contains("add"))out.print("<input type='button' value='添加' onclick=mt.act('edit','"+h.node+"') />");
%>

</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.node.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='member')
      form2.action='/jsp/type/outside/OutsideMember.jsp';
    else if(a=='edit')
      form2.action='/jsp/type/outside/EditOutside.jsp';
    else if(a=='edit1')
      form2.action='/jsp/general/NodeReport.jsp';
    else if(a=='edit2')
      form2.action='/jsp/type/people/Peoples.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
