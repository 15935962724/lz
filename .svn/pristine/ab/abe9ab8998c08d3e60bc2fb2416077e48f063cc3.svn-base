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
<h1>章节信息——<%=lc.name%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/LmsChapters.do">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmschapter"/>
<input type="hidden" name="nexturl"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>标题</td>
  <td>在线观看</td>
  <td>网络下载</td>
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
    <td><a href="<%=MT.f(t.durl)%>" target="_blank">下载</a></td>
  </tr>
  <%
  }
  out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
</form>

<script>
mt.act=function(t,a,b)
{
  form2.lmschapter.value=t?mt.ftr(t).id:"";
  if(a=='v')
  {
    mt.show(form2.action+'?act=view&lmschapter='+form2.lmschapter.value,2,'在线观看　密码:gxyh',500,400);
  }
};
</script>
</body>
</html>
