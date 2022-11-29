<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.node.type.mpoll.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?nexturl=" + Http.enc(request.getRequestURI() + "?" + request.getQueryString()));
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menu=h.getInt("id");
par.append("?id="+menu);

int poll=h.getInt("poll");
Poll p=Poll.find(poll);
if(poll>0)
{
  sql.append(" AND v.poll="+poll);
  par.append("&poll="+poll);
}

int question=h.getInt("question");
if(question>0)
{
  par.append("&question="+question);
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND a.question="+question+" AND a.content LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

int stotal=h.getInt("stotal");
if(stotal>0)
{
  sql.append(" AND v.total>="+stotal);
  par.append("&stotal="+MT.f(stotal));
}

int etotal=h.getInt("etotal");
if(etotal>0)
{
  sql.append(" AND v.total<"+etotal);
  par.append("&etotal="+MT.f(etotal));
}

Date stime=h.getDate("stime");
if(stime!=null)
{
  sql.append(" AND v.time>"+DbAdapter.cite(stime));
  par.append("&stime="+MT.f(stime));
}

Date etime=h.getDate("etime");
if(etime!=null)
{
  sql.append(" AND v.time<"+DbAdapter.cite(etime));
  par.append("&etime="+MT.f(etime));
}


ArrayList qs=Question.find(" AND poll="+poll+" AND type!=10",0,5);

int sum=Vote.count(sql.toString());

int pos=h.getInt("pos");
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
<input type="hidden" name="poll" value="<%=poll%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th"><select name="question"><%=Question.options(poll,question)%></select>:</td><td><input name="name" value="<%=name%>"/></td>
  <%
  if(p.score>0)out.print("<td class='th'>得分：</td><td><input name='stotal' value='"+MT.f(stotal)+"' size='8' />至<input name='etotal' value='"+MT.f(etotal)+"' size='8' /></td>");
  %>
  <td class="th">时间：</td><td><input name="stime" value="<%=MT.f(stime)%>" class="date" readonly onclick="mt.date(this)"/>至<input name="etime" value="<%=MT.f(etime)%>" class="date" readonly onclick="mt.date(this)"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/MVotes.do" method="post" target="_ajax">
<input type="hidden" name="poll" value="<%=poll%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="vote"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>用户</td>
  <%
  for(int i=0;i<qs.size();i++)
  {
    Question q=(Question)qs.get(i);
    out.print("<td>"+q.name[1].replaceAll("[：:]$",""));
  }
  if(p.score>0)out.print("<td>得分</td>");
  %>
  <td>时间</td>
  <td>IP地址</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Vote.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Vote v=(Vote)it.next();
    out.print("<tr>");
    out.print("<td>"+i);
    out.print("<td>"+(v.member<1?"游客":Profile.find(v.member).getMember()));
    HashMap hm=Answer.findByVote(v.vote);
    for(int j=0;j<qs.size();j++)
    {
      Question q=(Question)qs.get(j);
      Answer a=(Answer)hm.get(new Integer(q.question));
      out.print("<td>"+(a==null?"--":a.getContent()));
    }
    if(p.score>0)out.print("<td>"+v.total);
    out.print("<td>"+MT.f(v.time,1));
    out.print("<td>"+MT.f(v.ip));
    %>
    <td>
      <a href="javascript:mt.act('VoteView',<%=v.vote%>)">查看</a>
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="清空" onclick="mt.act('clear')"/>
<input type="button" value="导出" onclick="mt.act('expxls')"/>
<input type="button" value="导出CSV" onclick="mt.act('csv')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.vote.value=id;
  if(a=='view')
    window.open("/jsp/type/mpoll/VoteView2.jsp?poll="+id,"","width=500,height=600");
  else if(a=='clear')
    mt.show("确认清空结果吗？",2,"form2.submit()");
  else if(a=='del')
    mt.show('你确定要删除吗？',2,'form2.submit()');
  else
  {
    if(a.indexOf('exp')==0)
    {
    }else if(a=='csv')
    {
      mt.show(null,0,'导出中...');
    }else
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
