<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND node IN(SELECT n.node FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.type=41 AND nl.subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  par.append("&subject="+h.enc(subject));
}

String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND member IN(SELECT profile FROM Profile WHERE member LIKE "+DbAdapter.cite("%"+username+"%")+")");
  par.append("&username="+h.enc(username));
}

Date times=h.getDate("times");
if(times!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(times));
  par.append("&times="+MT.f(times));
}

Date timee=h.getDate("timee");
if(timee!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(timee));
  par.append("&timee="+MT.f(timee));
}

int pos=h.getInt("pos");
par.append("&pos=");
int sum=FDown.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>下载统计表</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">文件：</td><td><input name="subject" value="<%=subject%>"/></td>
  <td class="th">用户名：</td><td><input name="username" value="<%=username%>"/></td>
  <td class="th">下载时间：</td><td><input name="times" value="<%=MT.f(times)%>" onClick="mt.date(this)" class="date"/> 至 <input name="timee" value="<%=MT.f(timee)%>" onClick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/FDowns.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="down"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>文件</td>
  <td>用户名</td>
  <td>E-Mail</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=FDown.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    FDown t=(FDown)it.next();
    Profile m=Profile.find(t.member);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=Node.find(t.node).getAnchor(h.language)%></td>
    <td><%=m.getMember()%></td>
    <td><%=m.getEmail()%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><a href=javascript:mt.act('view',<%=t.down%>)>查看</a></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
</form>

<form name="form3" action="/Exports.do/下载统计表.xls" method="post" target="_ajax">
<input type="hidden" name="key" value="<%=MT.f(sql.toString())%>"/>
<input type="hidden" name="act" value="fdown"/>
<input type="button" value="导出" onclick="form3.submit()"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.down.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='view')
  {
    form2.action='/jsp/type/files/FDownView.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
