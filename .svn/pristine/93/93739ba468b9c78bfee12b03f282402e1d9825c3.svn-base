<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.admin.*"%><%

Http h=new Http(request);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);
sql.append(" AND member="+DbAdapter.cite(teasession._rv._strR));

int state=h.getInt("state");
sql.append(" AND EXISTS(SELECT flowview FROM Flowview fv WHERE fv.flowview=fr.flowview AND state="+state+")");
par.append("&state="+state);

Date t0=h.getDate("t0");
if(t0!=null)
{
  sql.append(" AND time>="+DbAdapter.cite(t0));
  par.append("&t0="+MT.f(t0));
}
Date t1=h.getDate("t1");
if(t1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(t1));
  par.append("&t1="+MT.f(t1));
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+Http.enc(name));
}
String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+Http.enc(code));
}


int flow=h.getInt("flow");
String content=h.get("content","");//内容
if(flow>0||content.length()>0)
{
  sql.append(" AND EXISTS(SELECT fb.flowbusiness FROM Flowbusiness fb WHERE fb.flowbusiness=fr.flowbusiness");
  if(flow>0)
  {
    sql.append(" AND fb.flow="+flow);
    par.append("&flow="+flow);
  }
  if(content.length()>0)
  {
    sql.append(" AND fb.content LIKE "+DbAdapter.cite("%"+content+"%"));
    par.append("&content="+Http.enc(content));
  }
  sql.append(")");
}


int pos=h.getInt("pos");
int sum=Flowreading.count(sql.toString());
par.append("&pos=");

String title=state==0?"待阅文件":"阅毕文件";

System.out.println(sql.toString());

%><!--
state: 0:未办理 2:已办理

//旧路径
/jsp/admin/xny/Flowbusiness_dist.jsp
-->
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_open(flow,flowbusiness,flowview)
{
  window.open("/jsp/admin/xny/FlowbusinessEdit.jsp?community=<%=teasession._strCommunity%>&flow="+flow+"&flowbusiness="+flowbusiness+"&flowview="+flowview+"&nexturl="+encodeURI(location.href),'_self');
}
</script>
</head>
<body>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="state" value="<%=state%>"/>
<table id="tablecenter">
<tr>
<td>日期：<input name="t0" size="11" value="<%=MT.f(t0)%>"><img onClick="showCalendar('form1.t0')" align="absmiddle" src="/tea/image/public/Calendar2.gif"> <input name="t1" size="11" value="<%=MT.f(t1)%>"><img onClick="showCalendar('form1.t1')" align="absmiddle" src="/tea/image/public/Calendar2.gif"></td>
<td>流程：<select name='flow'><option value=''>------------------</option>
<%
Enumeration e2=Flow.find(teasession._strCommunity, " AND flow NOT IN(11,12,13,14)");
while(e2.hasMoreElements())
{
  int i=((Integer)e2.nextElement()).intValue();
  out.print("<option value="+i);
  if(flow==i)out.print(" selected='' ");
  out.println(" >"+Flow.find(i).getName(teasession._nLanguage));
}
%></select>
<td>文件字号：<input name="code" value="<%=MT.f(code)%>" /></td>
<tr><td>标题：<input name="name" value="<%=MT.f(name)%>" /></td>
<td>内容：<input name="content" value="<%=MT.f(content)%>" /></td>
<td>
<td><input type="submit" value="查询"/></td>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/EditFlowreading.jsp?del">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="flowreading"/>
<table id="tablecenter">
<tr id="tableonetr">
  <td>序号</td>
  <td>文件标题</td>
  <td>文件字号</td>
  <td><%=state==0?"分发时间":"阅毕时间"%></td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Flowreading.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Flowreading t=(Flowreading)it.next();
    Flowbusiness fb=Flowbusiness.find(t.flowbusiness);
    Flowview f=Flowview.find(t.flowview);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><a href="javascript:f_open(<%=fb.getFlow()%>,<%=t.flowbusiness%>,<%=t.flowview%>)"><%=MT.f(t.name)%></a></td>
    <td><%=MT.f(t.code)%></td>
    <td><%=MT.f(f.getTime(),3)%></td>
    <td>
<%
if(state==0)
out.print("<input type='button' value=办理 onClick=f_open("+fb.getFlow()+","+t.flowbusiness+","+t.flowview+")>");
else
out.print("<input type='button' value='下载' onclick=location.href='/jsp/include/DownFile.jsp?uri="+Http.enc(fb.getTape2())+"&name="+Http.enc(t.name)+".doc' />");
%>
</td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</form>

</body>
</html>
