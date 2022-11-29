<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int menuid=h.getInt("id");
par.append("?id="+menuid);

int node=h.getInt("node");
if(node>0)
{
  sql.append(" AND node="+node);
  par.append("&node="+node);
}

String iperson=h.get("iperson","");
if(iperson.length()>0)
{
  sql.append(" AND iperson LIKE "+DbAdapter.cite("%"+iperson+"%"));
  par.append("&iperson="+h.enc(iperson));
}

Date times=h.getDate("times");
if(times!=null)
{
  sql.append(" AND iyear>"+DbAdapter.cite(times));
  par.append("&times="+MT.f(times));
}

Date timee=h.getDate("timee");
if(timee!=null)
{
  sql.append(" AND iyear<"+DbAdapter.cite(timee));
  par.append("&timee="+MT.f(timee));
}


int pos=h.getInt("pos");
par.append("&pos=");

int sum=SIdentify.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>鉴定管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
<!--  <td>标本ID:<input name="node" value="<%=node%>"/></td>-->
  <td class="th">鉴定人：</td><td><input name="iperson" value="<%=iperson%>"/></td>
  <td class="th">鉴定时间：</td><td><input name="times" value="<%=MT.f(times)%>" onClick="mt.date(this)" class="date"/> 至 <input name="timee" value="<%=MT.f(timee)%>" onClick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Specimens.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="identify"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>标本</td>
  <td>鉴定人</td>
  <td>鉴定时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=SIdentify.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    SIdentify t=(SIdentify)it.next();
    int id=t.identify;
    Node n=Node.find(t.node);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=MT.f(t.iperson)%></td>
    <td><%=MT.f(t.iyear)%></td>
    <td><a href=javascript:mt.act('edit',<%=id%>)>编辑</a> <a href=javascript:mt.act('del',<%=id%>)>删除</a></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit',0)"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value='i'+a;
  form2.identify.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/type/specimen/SIdentifyEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
