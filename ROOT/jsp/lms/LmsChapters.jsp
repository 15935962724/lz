<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

String ckey=h.get("lmscourse","");
int lmscourse=Integer.parseInt(MT.dec(ckey));
sql.append(" AND lmscourse="+lmscourse);
par.append("&lmscourse="+ckey);


String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String  content=h.get("content","");
if(content.length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+content+"%"));
  par.append("&content="+h.enc(content));
}


int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsChapter.count(sql.toString());
String acts=h.get("acts","");

LmsCourse lc=LmsCourse.find(lmscourse);


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>章节管理——<%=lc.name%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="lmscourse" value="<%=ckey%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <th>标题:</th><td><input name="name" value="<%=name%>"/></td>
  <th>描述:</th><td><input name="content" value="<%=content%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/LmsChapters.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmschapter"/>
<input type="hidden" name="lmscourse" value="<%=ckey%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>标题</td>
  <td>在线观看</td>
  <td>网络下载</td>
  <td>观看次数</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=LmsChapter.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsChapter t=(LmsChapter)it.next();
  %>
  <tr id="<%=MT.enc(t.lmschapter)%>">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><a href="###" onclick="mt.act(this,'v')">观看</a></td>
    <td><%=MT.f(t.durl)%></td>
    <td><%=MT.f(t.hits)%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'edit')>编辑</a>");
    out.println("<a href=### onclick=mt.act(this,'del')>删除</a>");
    %></td>
  </tr>
  <%
  }
  out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act(null,'edit')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.lmschapter.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='v')
  {
    mt.show(form2.action+'?act=view&lmschapter='+form2.lmschapter.value,2,'在线观看　密码:gxyh',500,400);
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsChapterView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsChapterEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
