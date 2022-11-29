<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.type.mpoll.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?nexturl=" + Http.enc(request.getRequestURI() + "?" + request.getQueryString()));
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menu=h.getInt("id");
par.append("?id="+menu);
sql.append(" AND community="+Database.cite(h.community));

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND(name0 LIKE "+Database.cite("%"+name+"%")+" OR name1 LIKE "+Database.cite("%"+name+"%")+")");
  par.append("&name="+h.enc(name));
}

Date stime=h.getDate("stime");
if(stime!=null)
{
  sql.append(" AND time>"+Database.cite(stime));
  par.append("&stime="+MT.f(stime));
}

Date etime=h.getDate("etime");
if(etime!=null)
{
  sql.append(" AND time<"+Database.cite(etime));
  par.append("&etime="+MT.f(etime));
}



int pos=h.getInt("pos");
int sum=Poll.count(sql.toString());

par.append("&pos=");

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>投票管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>

<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">标题:</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">时间：</td><td><input name="stime" value="<%=MT.f(stime)%>" class="date" readonly onclick="mt.date(this)"/>至<input name="etime" value="<%=MT.f(etime)%>" class="date" readonly onclick="mt.date(this)"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/MPolls.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="poll"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>标题</td>
  <td>过滤机制</td>
  <td>被投次数</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Poll.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Poll t=(Poll)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><a href="/jsp/type/mpoll/PollView.jsp?poll=<%=t.poll%>"><%=MT.f(t.name[1])%></a></td>
    <td><%=t.filter==8?Question.find(t.question).getName():MT.f(Poll.FILTER_TYPE,t.filter)%></td>
    <td><%=t.hits%></td>
    <td>
      <a href="javascript:mt.act('PollEdit',<%=t.poll%>)">编辑</a>
      <a href="javascript:mt.act('Questions',<%=t.poll%>)">问卷</a>
      <a href="javascript:mt.act('clone',<%=t.poll%>)">复制</a>
      <a href="javascript:mt.act('del',<%=t.poll%>)">删除</a>
      <a href="javascript:mt.act('Votes',<%=t.poll%>)">查看结果</a>
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('PollEdit','0')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.poll.value=id;
  if(a=='view')
    window.open("/jsp/type/mpoll/VoteView2.jsp?poll="+id,"","width=500,height=600");
  else if(a=='del')
    mt.show('你确定要删除吗？',2,'form2.submit()');
  else
  {
    if(a!='clone')
    {
      form2.action='/jsp/type/mpoll/'+a+'.jsp';
      form2.target=form2.method='';
    }
    form2.submit();
  }
};
</script>
</body>
</html>
