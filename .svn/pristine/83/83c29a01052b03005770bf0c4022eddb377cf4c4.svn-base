<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);

sql.append(" AND father="+h.node);

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND member="+DbAdapter.cite(member));
  par.append("&member="+h.enc(member));
}

Date t0=h.getDate("t0");
if(t0!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(t0));
  par.append("&t0="+MT.f(t0));
}

Date t1=h.getDate("t1");
if(t1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(t1));
  par.append("&t1="+MT.f(t1));
}

String title=h.get("title","");
if(title.length()>0)
{
  sql.append(" AND EXISTS(SELECT node FROM NodeLayer nl WHERE n.node=nl.node AND nl.subject LIKE "+DbAdapter.cite("%"+title+"%")+")");
  par.append("&title="+h.enc(title));
}

int sum=Node.count(sql.toString());

sql.append(" ORDER BY node DESC");

int pos=h.getInt("pos");
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>观点碰撞</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>标题:<input name="title" value="<%=title%>"/></td>
  <td>时间:<input name="t0" value="<%=MT.f(t0)%>" size="12" onclick="new Calendar().show('form1.t0')"/> 至 <input name="t1" value="<%=MT.f(t1)%>" size="12" onclick="new Calendar().show('form1.t1')"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<h2>列表 <%=sum%></h2>
<form name="form2" action="/NFasts.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="father" value="<%=h.node%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td>标题</td>
  <td>红方</td>
  <td>蓝方</td>
  <td>创建会员</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Enumeration e=Node.find(sql.toString(),pos,10);
  for(int i=1+pos;e.hasMoreElements();i++)
  {
    int nid=((Integer)e.nextElement()).intValue();
    Node n=Node.find(nid);

    Enumeration es=Node.findAllSons(nid);
    if(!es.hasMoreElements())continue;
    int red=((Integer)es.nextElement()).intValue();
    if(!es.hasMoreElements())continue;
    int blue=((Integer)es.nextElement()).intValue();

    StringBuffer sb=new StringBuffer();
    out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
    out.print("<td>"+i);
    out.print("<td>"+n.getAnchor(h.language));
    out.print("<td>"+Node.find(red).getSubject(h.language));
    out.print("<td>"+Node.find(blue).getSubject(h.language));
    out.print("<td>"+n.getCreator()._strR);
    out.print("<td>"+MT.f(n.getTime(),1));
  %>
    <td><input type="button" value="红方新闻"  style="color:#FF0000" onclick="f_act('Lists',<%=red%>)"/>
    <input type="button" value="蓝方新闻" style="color:#0000FF" onclick="f_act('Lists',<%=blue%>)"/>
    <input type="button" value="编辑" onclick="f_act('Edit',<%=nid%>)"/>
<input type="button" value="删除" onclick="f_act('del',<%=nid%>)"/>
    </td>
  <%}
}%>
</table>
<%=new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10)%>
<br/>
<input type="button" value="创建" onclick="f_act('Edit',0)"/>
</form>

<script>
mt.disabled(form2.docs);
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id)
{
  form2.act.value='opinion'+a;
  form2.node.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    form2.action="/jsp/admin/nfast/Opinion"+a+".jsp";form2.method="get";form2.target="_self";form2.submit();
  }
}
</script>
</body>
</html>
