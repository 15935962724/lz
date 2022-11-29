<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuilder sql=new StringBuilder(),par=new StringBuilder();

int menuid=h.getInt("id");
par.append("?id="+menuid);
sql.append(" AND lo.lmsorg>0 AND lc.lmscourse>0 AND lp.lmsplan>0");

String str=Lms.query(h,sql,par,false);

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,");
  return;
}

int lmsplan=h.getInt("lmsplan");
if(lmsplan>0)
{
  sql.append(" AND ls.lmsplan="+lmsplan);
  par.append("&lmsplan="+lmsplan);
}

String lmscourse=h.get("lmscourse","");
if(lmscourse.length()>0)
{
  sql.append(" AND lc.name LIKE "+DbAdapter.cite("%"+lmscourse+"%"));
  par.append("&lmscourse="+lmscourse);
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND ls.name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String ticket=h.get("ticket","");
if(ticket.length()>0)
{
  sql.append(" AND ls.ticket LIKE "+DbAdapter.cite("%"+ticket+"%"));
  par.append("&ticket="+h.enc(ticket));
}

int order=h.getInt("order",4);
par.append("&order="+order);

boolean desc="true".equals(h.get("desc"));
par.append("&desc="+desc);

int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsScore.count(sql.toString());
String acts=h.get("acts","");


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
.null<%=(acts.contains("oper,")?"":",.oper")%>{display:none}
</style>
</head>
<body>
<h1><%=menuid<1?"考试成绩":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <%=str%>
  <th>考试科目:</th><td><input name="lmscourse" value="<%=lmscourse%>"/></td>
</tr>
<tr>
  <th>姓名:</th><td><input name="name" value="<%=name%>"/></td>
  <th>准考证号:</th><td><input name="ticket" value="<%=ticket%>"/></td>
  <td><td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<input type="button" value="导入" onclick="mt.act(null,'imp')" class="oper"/>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsScores.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsscore"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td><a href="javascript:mt.order('O1')" id="O1">学习服务中心</a></td>
  <td><a href="javascript:mt.order('O3')" id="O3">姓名</a></td>
  <td><a href="javascript:mt.order('O4')" id="O4">准考证号</a></td>
  <td><a href="javascript:mt.order('O5')" id="O5">考试计划</a></td>
  <td><a href="javascript:mt.order('O6')" id="O6">考试科目</a></td>
  <td><a href="javascript:mt.order('O7')" id="O7">得分</a></td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"ls.lmsscore","lo.orgname","","ls.name","ls.ticket","lp.name","lc.name","ls.score"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",ls.lmsscore");
  Iterator it=LmsScore.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsScore t=(LmsScore)it.next();
  %>
  <tr id="<%=MT.enc(t.lmsscore)%>">
    <td><%=i%></td>
    <td><a href="/jsp/lms/LmsOrgView0.jsp?lmsorg=<%=MT.enc(t.lmsorg)%>"><%=LmsOrg.find(t.lmsorg).orgname%></a></td>
    <td><%=Lms.getAnchor(Profile.find(t.member))%></td>
    <td><%=MT.f(t.ticket)%></td>
    <td><a href="/jsp/lms/LmsPlanView.jsp?lmsplan=<%=MT.enc(t.lmsplan)%>"><%=LmsPlan.find(t.lmsplan).name%></a></td>
    <td><a href="/jsp/lms/LmsCourseView.jsp?lmscourse=<%=MT.enc(t.lmscourse)%>"><%=LmsCourse.find(t.lmscourse).name%></a></td>
    <td style="text-align:right"><%=MT.f(t.score)%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'view')>查看</a>");
    out.println("<a href=### onclick=mt.act(this,'edit') class='oper'>编辑</a>");
    out.println("<a href=### onclick=mt.act(this,'del') class='oper'>删除</a>");
    %></td>
  </tr>
  <%
  }
  out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<!--
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
-->
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.lmsscore.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsScoreView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsScoreEdit.jsp';
    else if(a=='imp')
      form2.action='/jsp/lms/LmsScoreImp.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
