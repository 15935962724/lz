<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.*"%><%@ page import="tea.entity.member.*"%><%@ page  import="java.util.*" %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.bbs.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int ctopic=0,chits=0;
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT COUNT(*) FROM Node n WHERE n.community=" + DbAdapter.cite(h.community) + " AND n.type=57 AND n.hidden=0");
  if(db.next())ctopic=db.getInt(1);

  db.executeQuery("SELECT SUM(click) FROM Node n WHERE n.community=" + DbAdapter.cite(h.community) + " AND n.type=57 AND n.hidden=0");
  if(db.next())chits=db.getInt(1);

  Iterator it=Category.find(h.community,57,0,200).iterator();
  while(it.hasNext())
  {
    int nid=((Integer)it.next()).intValue();
    int[] arr=BBS.count(nid);
    BBSForum bf=BBSForum.find(nid);
    bf.ctopic=arr[0];
    bf.creply=arr[1];
    db.executeQuery("SELECT SUM(click) FROM Node WHERE father="+nid);
    if(db.next())bf.chits=db.getInt(1);
    bf.set();
  }
}finally
{
  db.close();
}
int menu=h.getInt("id");

StringBuilder sql=new StringBuilder(),par=new StringBuilder();
sql.append(" AND node IN(SELECT n.node FROM Node n WHERE n.type=1 AND n.community="+DbAdapter.cite(h.community)+")");
par.append("?id="+menu+"&community="+h.community);

int sum=BBSForum.count(sql.toString());

String order=h.get("order","ctopic");
sql.append(" ORDER BY "+order+" DESC");
par.append("&order="+order);

int pos=h.getInt("pos");
par.append("&pos=");



%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
b{color:#FF0000}
</style>
</head>
<body>

<h1>论坛统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table id="tablecenter">
<tr><td>论坛当前注册总人数：<b><%=Profile.count(" AND community="+DbAdapter.cite(h.community))%></b>人<td>当前在线人数：<b><%=OnlineList.countByCommunity(h.community,"")%></b>人<td>当前贴子数：<b><%=ctopic%></b><td>贴子点击总数：<b><%=chits%></b>
</table>


<form name="form1" action="?" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="id" value="<%=menu%>"/>

<table id="tablecenter">
<tr id="tableonetr">
  <td>论坛版块</td>
  <td><a href="javascript:mt.act('ctopic')">贴子数</a></td>
  <td><a href="javascript:mt.act('creply')">回复数</a></td>
  <td><a href="javascript:mt.act('chits')">点击数</a></td>
</tr>
<%

if(sum<1)
out.print("<tr><td colspan=10>暂无记录");
else
{
  Iterator it=BBSForum.find(sql.toString(),pos,20).iterator();
  while(it.hasNext())
  {
    BBSForum t=(BBSForum)it.next();
    ctopic+=t.ctopic;
    chits+=t.chits;
    out.println("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
    out.println("<td>"+Node.find(t.node).getAnchor(teasession._nLanguage));
    out.println("<td>"+t.ctopic);
    out.println("<td>"+t.creply);
    out.println("<td>"+t.chits);
  }
  if(sum>20)out.print("<tr><td colspan=10>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(), pos, sum,20 ));
}
%>
</table>

</form>



<script>
mt.act=function(o)
{
  form1.order.value=o;
  form1.submit();
}
</script>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
