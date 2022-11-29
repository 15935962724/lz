<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

InfraredGroup.ref();

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int menuid=h.getInt("id");
par.append("&community="+h.community+"&id="+menuid);


String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+Http.enc(name));
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

int sum=InfraredGroup.count(sql.toString());
String acts=h.get("acts","");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
<%
if(sql.length()>0)out.println(".SEQ{display:none}");
%>
</style>
</head>
<body>
<h1>红外相机首选图</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">时间：</td><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Infrareds.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="infraredgroup"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>姓名</td>
  <td>数量</td>
  <td>图片</td>
  <td>时间</td>
  <td class="SEQ">顺序</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY sequence");
  Iterator it=InfraredGroup.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    InfraredGroup t=(InfraredGroup)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="hidden" name="infraredgroups" value="<%=t.infraredgroup%>"/><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.count)%></td>
    <td><img src="<%=t.picture<1?"/res/papc/404.jpg":Attch.find(t.picture).path%>"/></td>
    <td><%=MT.f(t.time,1)%></td>
    <td class="SEQ"><img name="sequence" src="/tea/image/public/move2.gif" id="<%=t.infraredgroup%>" value="<%=t.sequence%>" /></td>
    <td><a href="javascript:mt.act('edit',<%=t.infraredgroup%>)">编辑</a>
    <%
    //out.println("<a href=javascript:mt.act('del',"+t.name+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
<!--
<br/>
<input type="button" value="添加" onclick="mt.act('edit','')"/>
-->
</form>

<script>
mt.sequence(form2.infraredgroups,<%=pos%>);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.infraredgroup.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/InfraredGroupView.jsp';
    else if(a=='edit')
      form2.action='/jsp/type/infrared/InfraredGroupEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
