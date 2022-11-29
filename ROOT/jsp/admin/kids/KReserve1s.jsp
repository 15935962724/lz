<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.kids.*"%><%

Http h=new Http(request,response);

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);

sql.append(" AND type=1");

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String tel=h.get("tel","");
if(tel.length()>0)
{
  sql.append(" AND tel LIKE "+DbAdapter.cite("%"+tel+"%"));
  par.append("&tel="+h.enc(tel));
}

String course=h.get("course","");
if(course.length()>0)
{
  sql.append(" AND course="+DbAdapter.cite(course));
  par.append("&course="+h.enc(course));
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


int pos=h.getInt("pos");
int sum=KReserve.count(sql.toString());
par.append("&pos=");
sql.append(" ORDER BY reserve DESC");

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>预约参观管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="type" value="1"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>姓名:<input name="name" value="<%=name%>" size="12"/></td>
  <td>电话:<input name="tel" value="<%=tel%>" size="12"/></td>
  <td>园所: <select name="course">
            <option value="">---不限---</option>
        	<option value="雕塑园">雕塑园</option>
            <option value="望湖园">望湖园</option>
            <option value="广宁园">广宁园</option>
        </select></td>
  <td>预约时间:<input name="t0" value="<%=MT.f(t0)%>" size="10" onclick="new Calendar().show('form1.t0')"/>至<input name="t1" value="<%=MT.f(t1)%>" size="10" onclick="new Calendar().show('form1.t1')"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Kids.do" method="post" enctype="multipart/form-data" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="reserve"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>姓名</td>
  <td>电话</td>
  <td>园所</td>
  <td>参观时间</td>
  <td>预约时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=KReserve.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    KReserve t=(KReserve)it.next();
    int id=t.reserve;
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.tel)%></td>
    <td><%=MT.f(t.course)%></td>
    <td><%=MT.f(t.vtime)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><input type="button" value="删除" onclick="f_act('rdel',<%=id%>)"/></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="导出" onclick="f_act('r1exp','0')"/>
</form>

<script>
form1.course.value="<%=course%>";
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.reserve.value=id;
  if(a=='rdel')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='r1exp')
  {
    form2.submit();
  }
}
</script>
</body>
</html>
