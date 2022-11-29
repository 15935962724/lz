<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.weibo.*" %><%

Http h=new Http(request,response);


StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?node="+h.node);

String oday=h.get("oday","");
if(oday.length()==4)
{
  sql.append(" AND month="+Integer.parseInt(oday.substring(0,2)));
  sql.append(" AND day="+Integer.parseInt(oday.substring(2)));
  par.append("&oday="+oday);
}

sql.append(" AND microid>0");

Date otime0=h.getDate("otime0");
if(otime0!=null)
{
  sql.append(" AND otime>="+DbAdapter.cite(otime0));
  par.append("&otime0="+MT.f(otime0));
}

Date otime1=h.getDate("otime1");
if(otime1!=null)
{
  sql.append(" AND otime<="+DbAdapter.cite(otime1));
  par.append("&otime1="+MT.f(otime1));
}

String q=h.get("q","");
if(q.length()>0)
{
  String str=DbAdapter.cite("%"+q+"%");
  sql.append(" AND(source LIKE "+str+" OR sourcedesc LIKE "+str);
  sql.append(" OR node IN(SELECT node FROM NodeLayer WHERE subject LIKE "+str+" OR content LIKE "+str+"))");
  par.append("&q="+h.enc(q));
}


int sum=Historical.count(sql.toString());

sql.append(" ORDER BY stime DESC");
System.out.println(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");



%>
<%--
<script src="/tea/mt.js"></script>
<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>

<table id="tablecenter" cellspacing="0">
<tr>
  <td>时间：<input name='otime0' onclick='mt.date(this)'>--<input name='otime1' onclick='mt.date(this)'></td>
  <td><input name="q" value="<%=q%>" title="关键词"/>　　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>
--%>

<table id="tablecenter" cellspacing="0">

<%
if(sum<1)
{
  out.print("<tr><td align='center'>暂无记录!</td></tr>");
}else
{
  WConfig wc=WConfig.find(h.community);

  Iterator it=Historical.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Historical t=(Historical)it.next();
    Node n=Node.find(t.node);
    WMicro wm=WMicro.find(t.microid);
    String url = "http://weibo.com/" +wm.userid+ "/" + OAuth.mid(t.microid);
  %>
  <tr>
    <td class="td01"><span>[<%=MT.f(t.otime)%>]<span>　<a href="<%=url%>"><%=n.getSubject(h.language)%></a></td>
  </tr>
  <tr>
    <td class="td02"><%=MT.f(n.getText(h.language),260)%><br/><img src="<%=MT.f(n.getPicture(h.language),wc.picture)%>" width="210" /></td>
  </tr>
  <tr>
    <td class="td03"><a href="<%=url%>?type=repost">转发(<%=t.reposts%>)</a> | <a href="<%=url%>">评论(<%=t.comments%>)</a></td>
  </tr>
  <%
  }
}%>
</table>
<div class="page"><%=new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)%></div>
