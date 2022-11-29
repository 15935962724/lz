<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String member=teasession._rv.toString();

Http h=new Http(request);
if(h.key==null)h.key=member;

String sql=" AND member="+DbAdapter.cite(h.key);


StringBuffer par=new StringBuffer();
par.append("?id="+request.getParameter("id"));
par.append("&community="+teasession._strCommunity);
par.append("&mt="+Http.enc(MT.enc(h.key)));
par.append("&pos=");



String tmp=request.getParameter("pos");
int pos=tmp!=null?Integer.parseInt(tmp):0;

int sum=Score.count(sql);

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_edit(sid)
{
  window.open("/jsp/type/score/RO_ScoreView.jsp?community=<%=teasession._strCommunity%>&score="+sid,"_self");
}
</script>
</head>
<body>
<h1>差点记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2><%=h.key%>会员的记录</h2>
<table id="tablecenter">
  <tr id="tableonetr">
    <td>序号</td>
    <td>日期</td>
    <td>球场名称</td>
    <td>成绩</td>
    <td>发球台</td>
    <td>是否比赛</td>
    <td>详细</td>
  </tr>
<%
java.util.Iterator e=Score.find(sql,pos,20).iterator();
for(int index=1;e.hasNext();index++)
{
  Score objTop=(Score)e.next();
  int sid=objTop.score;
  int gid=objTop.getNode();
  String gname;

%>
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <td><%=index%></td>
  <td><%=objTop.getTimesToString()%></td>
  <td><%=(gid>0&&(gname=Node.find(gid).getSubject(teasession._nLanguage))!=null)?("<a href='/servlet/Golf?node="+gid+"' target='_blank'>"+gname+"</a>"):objTop.getName()%></td>
  <td><%=objTop.getSums()%></td>
  <td><img SRC="/tea/image/score/0<%=objTop.getTee()+1%>.jpg" alt="发球台"/></td>
  <td><%=objTop.isCompete()?"是":"否"%></td>
  <td><input type="button" value="查看" onclick="f_edit(<%=sid%>)"/></td>
</tr>
<%}%>
</table>

<%=new tea.htmlx.FPNL(teasession._nLanguage, par.toString(), pos, sum,20)%>
<br/>
<input type="button" value="返回" onclick="history.back();"/>

</body></html>
