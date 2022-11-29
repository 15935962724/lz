<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.pm.*"%><%@page import="tea.entity.util.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);


int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type LIKE "+DbAdapter.cite("%"+type+"%"));
  par.append("&type="+type);
}

String content=h.get("content","");
if(content.length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+content+"%"));
  par.append("&content="+h.enc(content));
}

String url=h.get("url","");
if(url.length()>0)
{
  sql.append(" AND url LIKE "+DbAdapter.cite("%"+url+"%"));
  par.append("&url="+h.enc(url));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=Newsline.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>实时新闻</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>分类:<select name="type"><%=h.options(Newsline.NEWSLINE_TYPE,type)%></select></td>
  <td>内容:<input name="content" value="<%=content%>"/></td>
  <td>网址:<input name="url" value="<%=url%>"/></td>
  <td>时间:<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Newslines.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="newsline"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>分类</td>
  <td>内容</td>
  <td>网址</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY time DESC");
  Iterator it=Newsline.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Newsline t=(Newsline)it.next();
  %>
  <tr>
    <td><%=i%></td>
    <td><%=Newsline.NEWSLINE_TYPE[t.type]%></td>
    <td><%=Lucene.t(t.content)%></td>
    <td><a href="<%=t.url%>" target="_blank"><%=MT.f(t.url,20)%></a></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><%
    out.println("<a href=javascript:mt.act('edit',"+t.newsline+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+t.newsline+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.newsline.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/NewslineView.jsp';
    else if(a=='edit')
      form2.action='/jsp/pm/NewslineEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
