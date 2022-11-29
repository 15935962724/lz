<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);

TeaSession ts=new TeaSession(request);
if(ts._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}


StringBuilder sql=new StringBuilder(),par=new StringBuilder();

int menu=h.getInt("id");
par.append("?id="+menu);

sql.append(" AND folder IN(2,3)");

String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND mobile LIKE "+Database.cite("%"+mobile+"%"));
  par.append("&mobile="+h.enc(mobile));
}

String content=h.get("content","");
if(content.length()>0)
{
  sql.append(" AND content LIKE "+Database.cite("%"+content+"%"));
  par.append("&content="+h.enc(content));
}

Date t0=h.getDate("t0");
if(t0!=null)
{
  sql.append(" AND time>"+Database.cite(t0));
  par.append("&t0="+MT.f(t0));
}
Date t1=h.getDate("t1");
if(t1!=null)
{
  sql.append(" AND time<"+Database.cite(t1));
  par.append("&t1="+MT.f(t1));
}

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND member IN(SELECT profile FROM Profile WHERE member LIKE "+Database.cite("%"+member+"%")+")");
  par.append("&member="+Http.enc(member));
}


int sum=SMessage.count(sql.toString());
sql.append(" ORDER BY smessage DESC");

int pos=h.getInt("pos");
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>短信列表</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">发送人：</td><td><input name="member" value="<%=member%>"/></td>
  <td class="th">手机号：</td><td><input name="mobile" value="<%=mobile%>"/></td>
  <td class="th">内容：</td><td><input name="content" value="<%=content%>"/></td>
  <td class="th">时间：</td><td><input name="t0" value="<%=MT.f(t0)%>" class="date" readonly="readonly" onClick="mt.date(this)"/>至<input name="t1" value="<%=MT.f(t1)%>" class="date" readonly="readonly" onClick="mt.date(this)"/></td>
  <td><input class="but" type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/SMessages.do" method="post" target="_ajax">
<input type="hidden" name="smessage"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td><input type="checkbox" onclick="mt.select(form2.smessages,checked)"/></td>
  <td>发送人</td>
  <td>接收人</td>
  <td>内容</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=SMessage.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    SMessage t=(SMessage)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="smessages" value="<%=t.smessage%>"/></td>
    <td><%=Profile.find(t.member).getMember()%></td>
    <td><%=t.getToName(true)%></td>
    <td><%=MT.f(t.content)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td nowrap><a href="javascript:mt.act('View',<%=t.smessage%>)">查看</a> <a href="javascript:mt.act('del',<%=t.smessage%>)">删除</a></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(), pos, sum,20));
}%>
</table>

<input class="but" type="button" name="multi" value="删除" onclick="mt.act('del',0)" />
<input class="but" type="button" value="发送" onclick="mt.act('Add','0')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.disabled(form2.smessages);
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.smessage.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    form2.action='/jsp/sms/SMessage'+a+'.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
