<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%><%@page import="net.mietian.convert.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.tobacco.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%>
<%@page import="tea.entity.markplus.MarkPlus"%>

<%

Http h=new Http(request,response);
if(h.member < 1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

sql.append(" AND community="+DbAdapter.cite(h.community));
par.append(" &community="+h.community);

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

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

int order=h.getInt("order",0);
par.append("&order="+order);

int pos=h.getInt("pos");
par.append("&pos=");

String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.len{background:#000000;color:#FFFFFF;width:80px;margin-top:-3px;}
</style>
</head>
<body>
<h1>标记加一管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称:</td><td align="left"><input name="name" value="<%=name%>"/></td>
  <td class="th">时间:</td><td align="left"><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>-<input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/>　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>
列表&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="删除" name="multi" onclick="mt.act('del','0')"/>
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
</h2>
<form name="form2" action="/EditMarkPlus.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="markplus"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="15"><input type="checkbox" onclick="mt.select(form2.markpluses,checked)"/></td>
  <td>名称</td>
  <td>缩略图</td>
  <td>单位</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
int sum=MarkPlus.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY sequence ASC");
  Iterator it=MarkPlus.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  MarkPlus t=(MarkPlus)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="markpluses" value="<%=t.getId()%>"/></td>
    <td nowrap><%=MT.f(t.getName())%></td>
    <td><%
    if(t.getPath()>0)
    {
      Attch a=Attch.find(t.getPath());
      if(a.path!=null)
      {
        out.print("<img src='"+a.path+"' width='80' />");
      }
    }
    %></td>
    <td nowrap><%=MT.f(t.getUnit())%></td>
    <td><%=MT.f(t.getTime(),1)%></td>
    <td nowrap><%
    out.println("<a href=javascript:mt.act('edit',"+t.getId()+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+t.getId()+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="删除" name="multi" onclick="mt.act('del','0')"/>
<!-- <input type="button" value="导出" onclick="mt.act('exp','0')"/> -->
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
</form>

<script>
mt.disabled(form2.markpluses);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.markplus.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/jsp/markplus/markPlusView.jsp';
    else if(a=='edit')
      form2.action='/jsp/markplus/markPlusEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
