<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);
sql.append(" AND father="+h.node);

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer nl WHERE nl.subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  par.append("&subject="+h.enc(subject));
}

sql.append(" AND node IN(SELECT node FROM animal WHERE 1=1");
String reserve=h.get("reserve","");
if(reserve.length()>0)
{
  sql.append(" AND reserve IN(SELECT n.node FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.type=102 AND nl.subject LIKE "+DbAdapter.cite("%"+reserve+"%")+")");
  par.append("&reserve="+h.enc(reserve));
}

String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}

String genus=h.get("genus","");
if(genus.length()>0)
{
  sql.append(" AND genus LIKE "+DbAdapter.cite("%"+genus+"%"));
  par.append("&genus="+h.enc(genus));
}

String family=h.get("family","");
if(family.length()>0)
{
  sql.append(" AND family1 LIKE "+DbAdapter.cite("%"+family+"%"));
  par.append("&family="+h.enc(family));
}
String order=h.get("order","");
if(order.length()>0)
{
  sql.append(" AND order1 LIKE "+DbAdapter.cite("%"+order+"%"));
  par.append("&order="+h.enc(order));
}
sql.append(")");

int pos=h.getInt("pos");
par.append("&pos=");

int sum=Node.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>动物管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">保护区：</td><td><input name="reserve" value="<%=reserve%>"/></td>
  <td class="th">种名：</td><td><input name="subject" value="<%=subject%>"/></td>
  <td class="th">物种代码：</td><td><input name="code" value="<%=code%>"/></td>
</tr>
<tr>
  <td class="th">属名：</td><td><input name="genus" value="<%=genus%>"/></td>
  <td class="th">科名：</td><td><input name="family" value="<%=family%>"/></td>
  <td class="th">目名：</td><td><input name="order" value="<%=order%>"/>　　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Animals.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>保护区</td>
  <td>物种名称</td>
  <td>物种代码</td>
  <td>属名</td>
  <td>科名</td>
  <td>目名</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY node");
  Enumeration e=Node.find(sql.toString(),pos,20);
  for(int i=1+pos;e.hasMoreElements();i++)
  {
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);
    Animal t=Animal.find(node);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=Node.find(t.reserve).getAnchor(h.language)%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=MT.f(t.code)%></td>
    <td><%=MT.f(t.genus)%></td>
    <td><%=MT.f(t.family[1])%></td>
    <td><%=MT.f(t.order[1])%></td>
    <td>
    <%
    out.println("<a href=javascript:mt.act('hidden',"+node+")>"+(n.isHidden()?"发布":"取消发布")+"</a>");
    out.println("<a href=javascript:mt.act('edit',"+node+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+node+")>删除</a>");
    %>
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','<%=h.node%>')"/>
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
    if(a=='hidden')
    {
    }else if(a=='edit')
    {
      form2.action='/jsp/type/animal/EditAnimal.jsp';
      form2.target=form2.method='';
    }
    form2.submit();
  }
};
</script>
</body>
</html>
