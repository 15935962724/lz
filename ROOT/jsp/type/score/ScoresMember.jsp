<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Http h=new Http(request);


if("del".equals(h.get("act")))
{
  Score.delete(h.getInt("score"));
  out.print("<script>alert('数据修改成功!');history.back();</script>");
  return;
}

String member=teasession._rv.toString();
 
String sql=" and member = "+DbAdapter.cite(member);



boolean isRole=h.getBool("role");

int menuid=h.getInt("id");
StringBuffer par=new StringBuffer();
par.append("?id="+menuid);
par.append("&community="+h.community);



int g=h.getInt("g");

Date s=h.getDate("s"),e=h.getDate("e");
String ss=MT.f(s),se=MT.f(e);
if(g>0)
{
  sql+=" AND node="+g;
  par.append("&g="+g);
}
if(s!=null)
{
  sql+=" AND times>"+DbAdapter.cite(s);
  par.append("&s="+ss);
}
if(e!=null)
{
  sql+=" AND times<"+DbAdapter.cite(e);
  par.append("&e="+se);
}


par.append("&pos=");



String tmp=request.getParameter("pos");
int pos=tmp!=null?Integer.parseInt(tmp):0;

int sum=Score.count(sql);

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_new()
{
  window.open("/jsp/type/score/EditScoreMember1.jsp?community=<%=h.community%>&role=<%=isRole%>","_self");
} 
function f_edit(sid)
{
  window.open("/jsp/type/score/EditScoreMember2.jsp?community=<%=h.community%>&role=<%=isRole%>&score="+sid,"_self");
}
function f_del(sid)
{
  if(confirm("你确定要删除吗?"))window.open("?community=<%=h.community%>&act=del&id=<%=menuid%>&score="+sid,"_self");
}
</script>
</head>
<body>
<h1>差点管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="role" value="<%=isRole%>"/>
<table id="tablecenter">
<tr><td>球场名称:<select name="g"><option value="">------------------</option>
<%
java.util.Enumeration en=Node.find(" AND type=62 AND community="+DbAdapter.cite(h.community),0,200);
while(en.hasMoreElements())
{
  int nid=((Integer)en.nextElement()).intValue();
  Node obj=Node.find(nid);
  out.print("<option value="+nid);
  if(g==nid)out.print(" selected=''");
  out.print(">"+obj.getSubject(h.language));
}
%>
</select></td>

<td>日期:<input name="s" value="<%=ss%>" size="10"/><img src="/tea/image/public/Calendar2.gif" onclick="showCalendar('form1.s');" align="top" />
-<input name="e" value="<%=se%>" size="10"/><img src="/tea/image/public/Calendar2.gif" onclick="showCalendar('form1.e');" align="top" />
<td><input type="submit" value="查询"/>
</tr>
</table>
</form>
<h2>列表 <%=sum%></h2>
<table id="tablecenter">
  <tr id="tableonetr">
    <td>序号</td>
    <td>会员</td>
    <td>日期</td>
    <td>球场名称</td>
    <td>成绩</td>
    <td>发球台</td>
    <td>是否比赛</td>
    <!-- <td>来源</td> -->
    <td>详细</td>
  </tr>
<%
Iterator it=Score.find(sql,pos,20).iterator();
for(int index=1;it.hasNext();index++)
{
  Score objTop=(Score)it.next();
  int sid=objTop.score;
  int gid=objTop.getNode();
  String gname;

%>
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <td><%=index%></td>
  <td><%=objTop.member%></td>
  <td><%=objTop.getTimesToString()%></td>
  <td><a href='/servlet/Golf?node=<%=gid %>' target='_blank'><%=objTop.getName() %></a></td>
  <td><%=objTop.getSums()%></td>
  <td><img SRC="/tea/image/score/0<%=objTop.getTee()+1%>.jpg" alt="发球台"/></td>
  <td><%=objTop.isCompete()?"是":"否"%></td>
 <!-- <td><%=MT.f(objTop.posid).length()<1?"手动添加":"自动导入"%></td> --> 
  <td><input type="button" value="编辑" onclick="f_edit(<%=sid%>)"/> <input type="button" value="删除" onclick="f_del(<%=sid%>)"/></td>
</tr>
<%}%>
</table>

<%=new tea.htmlx.FPNL(teasession._nLanguage, par.toString(), pos, sum,20)%>
<br/>
<input type="button" value="添加" onclick="f_new()"/>

</body></html>
