<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.ui.*"%><%@page import="java.util.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="tea.htmlx.*"%><%@page import="tea.html.HtmlElement"%><%

Http h=new Http(request,response);

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}
Resource r = new Resource();

Node n=Node.find(h.node);

String tmp=h.get("lang");
if(tmp!=null)h.language=Integer.parseInt(tmp);

int menuid=h.getInt("id");

StringBuilder sql=new StringBuilder(),par=new StringBuilder();
sql.append(" AND node="+h.node+" AND language="+h.language);
par.append("?node="+h.node);

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+member+"%"));
  par.append("&member="+Http.enc(member));
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

par.append("&pos=");

int sum=PollVote.count(sql.toString());
int pos=h.getInt("pos");



%><html>
<head><link href="/res/<%=h.community%>/cssjs/community.css" type="text/css" rel="stylesheet">
<script src="/tea/mt.js" type="text/javascript" ></script>
</head>
<body>

<h1>投票结果 ( <%=n.getSubject(h.language)%> )
<%
Vector v=n.getLanguages();
if(v.size()==1)
  h.language=((Integer)v.get(0)).intValue();
else for(int i=0;i<v.size();i++)
{
  int j=((Integer)v.get(i)).intValue();
  out.print("<a href=### onclick=form1.lang.value="+j+";form1.submit();>"+r.getString(h.language,Common.LANGUAGE[j])+"</a>　");
}
%>
</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="lang" value="<%=h.language%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>用户:<input name="member" value="<%=MT.f(member)%>"/></td>
    <td>时间:<input name="t0" value="<%=MT.f(t0)%>" size="12" onclick="mt.date(this)"/>-<input name="t1" value="<%=MT.f(t1)%>" size="12" onclick="mt.date(this)"/></td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>




<h2>列表(<%=sum%>)</h2>
<form name="form2" action="/PollVotes.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="lang" value="<%=h.language%>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
<input type="hidden" name="nexturl"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
  <td></td>
  <td>参与者ID</td>
<%
Enumeration ep=Poll.find(" AND node="+h.node+" AND language="+h.language);
while(ep.hasMoreElements())
{
  int pid=((Integer)ep.nextElement()).intValue();
  Poll p=Poll.find(pid);
  out.print("<td>"+p.getQuestion());
}
%>
  <td>参与调查日期</td>
</tr>
<%
if(sum<1)
out.print("<tr><td colspan='50' align='center'>暂无记录！");
else
{
  Iterator it=PollVote.find(sql.toString(),pos,20).iterator();
  for(int i=1;it.hasNext();i++)
  {
    PollVote pv=(PollVote)it.next();
    out.print("<tr><td>"+i);
    out.print("<td>"+MT.f(pv.member,"游客"));
    ep=Poll.find(" AND node="+h.node+" AND language="+h.language);
    while(ep.hasMoreElements())
    {
      int pid=((Integer)ep.nextElement()).intValue();
      Poll p=Poll.find(pid);
      PollVoteList pvl=PollVoteList.find(pv.pollvote,pid);

      out.print("<td>");
      if(pvl.answer!=null)
      {
        if(p.getType()<2)
        {
          String[] arr=pvl.answer.split("[|]");
          for(int j=1;j<arr.length;j++)
          {
            out.print(PollChoice.find(Integer.parseInt(arr[j])).getTitle()+"　");
          }
        }else
        out.print(pvl.answer);
      }
    }
    out.print("<td>"+MT.f(pv.time,1));
  }
}
%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,20)%>
<input type="button" value="导出" onclick="mt.act('exp')"/>
<input type="button" value="返回" onclick="history.back()"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a)
{
  form2.act.value=a;
  form2.submit();
};
</script>

</body>
</html>
