<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuilder sql=new StringBuilder(),par=new StringBuilder();

int menuid=h.getInt("id");
par.append("?id="+menuid);

sql.append(" AND p.type!=1 AND p.deleted=0 AND ll.state=1");

String str=Lms.query(h,sql,par,false);

String act=h.get("act");
int remind=LmsLeave.count(sql.toString());
if("remind".equals(act))
{
  out.print(remind);
  return;
}

int type=h.getInt("type",-1);
if(type!=-1)
{
  sql.append(" AND p.type="+type);
  par.append("&type="+type);
}

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND p.member LIKE "+DbAdapter.cite("%"+member+"%"));
  par.append("&member="+h.enc(member));
}

String card=h.get("card","");
if(card.length()>0)
{
  sql.append(" AND p.card LIKE "+DbAdapter.cite("%"+card+"%"));
  par.append("&card="+h.enc(card));
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND pl.firstname LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND ll.time>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND ll.time<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int order=h.getInt("order",5);
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);

int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsLeave.count(sql.toString());
String acts=h.get("acts","");

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/lms/lms.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
</style>
</head>
<body>
<h1><%=menuid<1?"退学审核":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0" class="alignLeft">
<tr>
  <%=str%>
  <th>学号:</th><td><input name="member" value="<%=member%>"/></td>
</tr>
<tr>
  <th>退学申请日期:</th><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <th>证件号码:</th><td><input name="card" value="<%=card%>"/></td>
  <th>姓名:</th><td><input name="name" value="<%=name%>"/>　<input type="submit" value="查询"/></td>
  <!--<th>状态:</th><td><select name="type"><option value="-1">--<%=h.options(Lms.MEMBER_TYPE,type)%></select></td>-->
</tr>
</table>
</form>

<h3>
<input type="button" value="导出" onclick="mt.show(null,0);form3.submit();"/>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsLeaves.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsleave"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td><a href="javascript:mt.order('O1')" id="O1">学号</a></td>
  <td><a href="javascript:mt.order('O2')" id="O2">姓名</a></td>
  <td><a11 href="javascript:mt.order('O3')" id="O3">省助学发展机构</a></td>
  <td><a href="javascript:mt.order('O4')" id="O4">学习服务中心</a></td>
  <td><a href="javascript:mt.order('O5')" id="O5">退学申请日期</a></td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='7' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"ll.lmsleave","p.member","pl.firstname","==","lo.orgname","ll.time"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",ll.lmsleave");
  Iterator it=LmsLeave.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsLeave t=(LmsLeave)it.next();
    Profile p=Profile.find(t.member);
    LmsOrg lo=LmsOrg.find(p.getAgent());
  %>
  <tr>
    <td><%=i%></td>
    <td><%=p.getMember()%></td>
    <td><%=p.getName(h.language)%></td>
    <td><%=MT.f(LmsOrg.find(lo.father).orgname)%></td>
    <td><%=MT.f(lo.orgname)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><%
    out.println("<a href=javascript:mt.act('view',"+t.lmsleave+")>申请表</a>");
    out.println("<a href=javascript:mt.act('state',"+t.lmsleave+")>审核</a>");
    //if(acts.contains("edit"))out.println("<a href=javascript:mt.act('edit',"+id+")>编辑</a>");
    //if(acts.contains("del"))out.println("<a href=javascript:mt.act('del',"+id+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<!--
<br/>
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
-->
</form>

<form name="form3" action="/LmsExports.do?name=退学审核.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="sql"/>
<input type="hidden" name="key" value="<%=MT.enc("SELECT p.member 学号,pl.firstname 姓名,lo.orgname 学习服务中心,ll.time 退学申请日期 FROM lmsleave ll INNER JOIN Profile p ON p.profile=ll.member INNER JOIN ProfileLayer pl ON pl.profile=ll.member LEFT JOIN lmsorg lo ON lo.lmsorg=p.agent WHERE 1=1"+sql.toString())%>"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.lmsleave.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='state')
  {
    mt.show("状态：<input type='radio' name='_state' value='2' id='_state_2' checked /><label for='_state_2'>通过</label>　<input type='radio' name='_state' value='3' id='_state_3' /><label for='_state_3'>不通过</label>",2,"form2.state.value=$$('_state_2').checked?2:3;form2.submit()");
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsLeaveView.jsp';
    else if(a=='edit')
      form2.action='/LmsLeaveEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
edn.remind(<%=remind%>);
</script>
</body>
</html>
