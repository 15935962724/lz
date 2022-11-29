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
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE 1=1");
  sql.append(" AND subject LIKE "+DbAdapter.cite("%"+subject+"%"));
  par.append("&subject="+h.enc(subject));
  sql.append(")");
}

sql.append(" AND node IN(SELECT node FROM reserve WHERE 1=1");
String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND code="+code);
  par.append("&code="+h.enc(code));
}

int level=h.getInt("level");
if(level>0)
{
  sql.append(" AND level="+level);
  par.append("&level="+level);
}

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

int dept=h.getInt("dept");
if(dept>0)
{
  sql.append(" AND dept="+dept);
  par.append("&dept="+dept);
}

int city=h.getInt("city");
if(city>0)
{
  sql.append(" AND city="+city);
  par.append("&city="+city);
}
sql.append(")");

int pos=h.getInt("pos");
par.append("&pos=");

int sum=Node.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1>自然保护区管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td><td><input name="subject" value="<%=subject%>"/></td>
  <td class="th">编号：</td><td><input name="code" value="<%=code%>"/></td>
  <td class="th">级别：</td><td><select name="level"><%=h.options(Reserve.LEVEL_TYPE,level)%></select></td>
</tr>
<tr>
  <td class="th">类型：</td><td><select name="type"><%=h.options(Reserve.RESERVE_TYPE,type)%></select></td>
  <td class="th">所属部门：</td><td><select name="dept"><%=h.options(Reserve.DEPT_TYPE,dept)%></select></td>
  <td class="th">地区：</td><td><script>mt.city('city',null,null,"<%=city%>")</script>　　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Reserves.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>编号</td>
  <td>级别</td>
  <td>类型</td>
  <td>所属部门</td>
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
    Reserve t=Reserve.find(node,h.language);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=MT.f(t.code)%></td>
    <td><%=Reserve.LEVEL_TYPE[t.level]%></td>
    <td><%=Reserve.RESERVE_TYPE[t.type]%></td>
    <td><%=Reserve.DEPT_TYPE[t.dept]%></td>
    <td>
    <%
    out.println("<a href=javascript:mt.act('hidden',"+node+")>"+(n.isHidden()?"发布":"取消发布")+"</a>");
    out.println("<a href=javascript:mt.act('edit',"+node+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+node+")>删除</a>");
    %>
  </tr>
  <%}
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
      form2.action='/jsp/type/reserve/EditReserve.jsp';
      form2.target=form2.method='';
    }
    form2.submit();
  }
};
</script>
</body>
</html>
