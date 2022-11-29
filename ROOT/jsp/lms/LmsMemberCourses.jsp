<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuilder sql=new StringBuilder(),par=new StringBuilder();

int menuid=h.getInt("id");
par.append("?id="+menuid);

sql.append(" AND p.type!=1 AND p.deleted=0 AND pl.language="+h.language);

String str=Lms.query(h,sql,par,false);

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,");
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

int leveltype=h.getInt("leveltype");
if(leveltype>0)
{
  sql.append(" AND p.leveltype="+leveltype);
  par.append("&leveltype="+leveltype);
}

int lmsplan=h.getInt("lmsplan");
if(lmsplan<1)lmsplan=LmsPlan.getInstance().lmsplan;

if(lmsplan>0)
{
  sql.append(" AND lmc.lmsplan="+lmsplan);
  par.append("&lmsplan="+lmsplan);
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

int province=h.getInt("province1",h.getInt("province0"));
if(province>0)
{
  sql.append(" AND pl.province LIKE "+DbAdapter.cite(province+"%"));
  par.append("&province="+province);
}

int order=h.getInt("order",1);
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);


int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsMemberCourse.count(sql.toString());
String acts=h.get("acts","");


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script src="/jsp/lms/lms.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
.null<%=(acts.contains("oper,")?"":",.oper")%>{display:none}
</style>
</head>
<body>
<h1><%=menuid<1?"学员报考":AdminFunction.find(menuid).getName(h.language)%></h1>
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
  <th>专业方向:</th><td><select name="leveltype"><option value="0">--<%=LmsCert.options(" AND rank=2",leveltype)%></select></td>
  <th>证件号码:</th><td><input name="card" value="<%=card%>"/></td>
  <th>姓名:</th><td><input name="name" value="<%=name%>"/></td>
</tr>
<tr>
  <th>考试计划:</th><td><select name="lmsplan"><%=LmsPlan.options(" AND father=0 AND status IN(2,4) ORDER BY time DESC",lmsplan)%></select></td>
  <th>报名地区：</th><td><script>mt.city("province0","province1",null,"<%=province%>")</script><td><td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<input type="button" value="缴费" onclick="mt.act(null,'pay',0)" class="oper" title="1、直接点击，就是对“<%=sum%>”个学员进行缴费。&#13;2、选中后再点击，仅对选中的学员进行缴费。"/>
<input type="button" value="导出" onclick="mt.show(null,0);form3.act.value='membercourse';form3.submit();"/>
<input type="button" value="导出(上报)" onclick="mt.show(null,0);form3.act.value='membercity';form3.submit();" title="上报给考试中心的数据格式"/>
<input type="button" value="导入" onclick="mt.act(null,'imp')" class="oper"/>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsMemberCourses.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsmembercourse"/>
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="key"/>
<table id="tablecenter" cellspacing="0" class="alignLeft">
<tr id="tableonetr">
  <td width="8"><input type="checkbox" onclick="mt.select(form2.lmsmembercourses,checked)"/></td>
  <td><a href="javascript:mt.order('O1')" id="O1">学号</a></td>
  <td><a href="javascript:mt.order('O2')" id="O2">姓名</a></td>
  <td><a href="javascript:mt.order('O3')" id="O3">学习服务中心</a></td>
  <td><a href="javascript:mt.order('O5')" id="O5">证书方向</a></td>
  <td><a href="javascript:mt.order('O6')" id="O6">实践科次(已报考)</a></td>
  <td><a href="javascript:mt.order('O7')" id="O7">机考科次(已报考)</a></td>
  <td><a href="javascript:mt.order('O8')" id="O8">报考费用</a></td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  float total=LmsMemberCourse.sum(sql.toString());
  String[] ORDER_TYPE={"p.profile","p.member","pl.firstname","lo.orgname","lc.name","p.leveltype","LENGTH(lmc.lmscourse0)-LENGTH(REPLACE(lmc.lmscourse0,'|',''))","LENGTH(lmc.lmscourse1)-LENGTH(REPLACE(lmc.lmscourse1,'|',''))","lmc.price"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",p.profile");
  Iterator it=LmsMemberCourse.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsMemberCourse t=(LmsMemberCourse)it.next();
    Profile p=Profile.find(t.member);
    LmsOrg lo=LmsOrg.find(p.getAgent());
    String mkey=MT.enc(t.member);
  %>
  <tr id="<%=MT.enc(t.lmsmembercourse)%>">
    <td><input type="checkbox" name="lmsmembercourses" <%=t.lmspay<1?"":" disabled"%> value="<%=t.lmsmembercourse%>"/></td>
    <td><%=p.getMember()%></td>
    <td><%=Lms.getAnchor(p)%></td>
    <td><%=MT.f(lo.orgname)%></td>
    <td><%=p.getLeveltype()<1?"--":LmsCert.f(p.getLeveltype())%></td>
    <%
    out.print("<td>");
    if(t.lmspay<1&&acts.contains("oper,"))out.print("<a href=### onclick=mt.act(this,'edit','"+mkey+"',0)>");
    out.print(Math.max(0,t.lmscourse0.split("[|]").length-1)+"</a>");

    out.print("<td>");
    if(t.lmspay<1&&acts.contains("oper,"))out.print("<a href=### onclick=mt.act(this,'edit','"+mkey+"',1)>");
    out.print(Math.max(0,t.lmscourse1.split("[|]").length-1)+"</a>");
    %>
    <td onmouseover="mt.tip(this,'<table><%=t.getPrice()%></table>');"><%=MT.f(t.price)%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'view','"+mkey+"')>查看</a>");
    if(t.lmspay<1)out.println("<a href=### onclick=mt.act(this,'del') class='oper'>删除</a>");
    %></td>
  </tr>
  <%
  }
  out.print("<tr><td colspan='7' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20)+"<td>"+MT.f(total)+"<td>");
}%>
</table>
</form>

<form name="form3" action="/LmsExports.do?lmsplan=<%=lmsplan%>&name=学员报考.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="membercourse"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%><%//=MT.enc("SELECT p.member 学号,pl.firstname 姓名,lo.orgname 学习服务中心,lc.name 证书方向,LENGTH(lmc.lmscourse0)-LENGTH(REPLACE(lmc.lmscourse0,'|',''))-1 实践科次,LENGTH(lmc.lmscourse1)-LENGTH(REPLACE(lmc.lmscourse1,'|',''))-1 机考科次,lmc.price 报考费用 FROM lmsmembercourse lmc INNER JOIN Profile p ON p.profile=lmc.member INNER JOIN ProfileLayer pl ON pl.profile=p.profile AND pl.language="+h.language+" LEFT JOIN lmscert lc ON lc.lmscert=p.leveltype INNER JOIN lmsorg lo ON lo.lmsorg=p.agent WHERE 1=1"+sql.toString())%>"/>
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b,c)
{
  form2.act.value=a;
  form2.lmsmembercourse.value=t?mt.ftr(t).id:'';
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    mt.show('/jsp/lms/LmsMemberCourseEdit.jsp?member='+b+'&lmsplan='+form1.lmsplan.value+'&type='+c,2,'报考课程表',700);
  }else
  {
    if(a=='view')
    {
      form2.member.value=b;
      form2.action='/jsp/lms/LmsMemberCourseView.jsp';
    }else if(a=='edit')
      form2.action='/jsp/lms/LmsMemberEdit.jsp';
    else if(a=='imp')
      form2.action='/jsp/lms/LmsMemberCourseImp.jsp';
    else if(a=='pay')
    {
      form2.nexturl.value="/jsp/lms/LmsPays.jsp";
      form2.key.value="<%=MT.enc(sql.toString())%>";
      form2.action='/jsp/lms/LmsPayAdd.jsp';
    }
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
