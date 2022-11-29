<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.pm.Transactions" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

if(h.isIllegal())
{
  response.sendError(404,request.getRequestURI());
  return;
}


StringBuffer sql=new StringBuffer(),par=new StringBuffer();


sql.append(" AND hidden in (0,2) AND community="+DbAdapter.cite(h.community));

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

//范围



String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND member in (select p.profile from Profile p inner join ProfileLayer pl on pl.member=p.member where  pl.firstname LIKE "+DbAdapter.cite("%"+username+"%")+") ");
  par.append("&username="+Http.enc(username));
}


String varieties=h.get("varieties","");
if(varieties.length()>0)
{
  sql.append(" AND varieties  LIKE "+DbAdapter.cite("%"+varieties+"%"));
  par.append("&varieties="+Http.enc(varieties));
}




int sum=Transactions.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>

</head>
<body>


<h1>交易明细管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">专家名称：</td><td><input name="username" value="<%=username%>"/></td>
  <td class="th">交易品种：</td><td><input name="varieties" value="<%=varieties%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>
<h2>列表   共<%=sum %>条记录</h2>



<form name="form2" action="/EditTransactionRecord.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="tid"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
		<td><input type="checkbox" onclick="mt.select(form2.tids,checked)"></td>
  		<td>序号</td>
  		<td>交易品种</td>
  		<td>专家</td>
  		<td>交易方向</td>
  		<td>交易时间</td>
  		<td>成交数量</td>
  		<td>成交金额</td>
  		<td>状态</td>
  		<td>操作</td>

<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY ctime desc");
  Enumeration e=Transactions.find(sql.toString(), pos, 10);
  int i=1;
  while(e.hasMoreElements())
  {
	int tid=(Integer)e.nextElement();
	Transactions t=Transactions.find(tid);
	Profile p= Profile.find(t.getMember());
  %>
  <tr id="<%=MT.enc(tid)%>">
  		<td><input type="checkbox" name="tids" value="<%=MT.enc(tid)%>"/></td>
  		<td><%=i++ %></td>
  		<td><%=MT.f(t.getVarieties()) %></td>
  		<td><%=MT.f(p.getName(h.language)) %></td>
  		<td><%=MT.f(t.getDirection()) %></td>
  		<td><%=t.getTtime()==null?"":Entity.sdf2.format(t.getTtime()) %></td>
  		<td><%=t.getQuantity() %></td>
  		<td><%=t.getTmoney() %></td>
  		<td><%if(t.getHidden()==2){out.print("隐藏");}else if(t.getHidden()==0){out.print("显示");} %></td>
  		<td colspan="2"><input type="button" onclick=mt.act(this,'view') value="查看"><input type="button" onclick=mt.act(this,'hidden') value="隐藏"><input type="button" onclick=mt.act(this,'nhidden') value="显示"></td>
  </tr>
  
  <%
  }
  if(sum>10){
	  out.print("<tr><td align='left'><input type='button' onclick=mt.act(this,'hiddens') value='批量隐藏'><input type='button' onclick=mt.act(this,'nhiddens') value='批量显示'></td><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10));
  }else{
	  out.print("<tr><td colspan='10' align='left'><input type='button' onclick=mt.act(this,'hiddens') value='批量隐藏'><input type='button' onclick=mt.act(this,'nhiddens') value='批量显示'></td></tr>");
  }
}%>
</table>


</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.tid.value=t?mt.ftr(t).id:"";
  if(a=='hidden'||a=='hiddens')
  {
	  mt.show('你确定要隐藏吗？',2,"form2.action='/EditTransactionRecord.do';form2.submit()");
	  
  }if(a=='nhidden'||a=='nhiddens')
  {
	  mt.show('你确定要隐藏吗？',2,"form2.action='/EditTransactionRecord.do';form2.submit()");
	  
  }else if(a=='view'){
      form2.action='/jsp/type/Consultant/ViewTransactionRecord.jsp';
      form2.target=form2.method='';
      form2.submit();
  }
  
  
};
</script>
</body>
</html>
