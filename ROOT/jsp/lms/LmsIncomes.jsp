<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,");
  return;
}

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

int city=h.getInt("city");
if(city>0)
{
  sql.append(" AND city="+city);
  par.append("&city="+city);
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(time0));
  par.append("&time="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(time1));
  par.append("&time="+MT.f(time1));
}


float price0=h.getFloat("price0");
if(price0>0)
{
  sql.append(" AND price>"+price0);
  par.append("&price="+price0);
}

float price1=h.getFloat("price1");
if(price1>0)
{
  sql.append(" AND price<"+price1);
  par.append("&price="+price1);
}

int state=h.getInt("state");
if(state>0)
{
  sql.append(" AND state LIKE "+DbAdapter.cite("%"+state+"%"));
  par.append("&state="+state);
}


int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsIncome.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<style>
.<%=type==1||type==3||type==5?"C":""%>{display:none}
</style>
</head>
<body>
<h1><%=AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <th class="C">省:</th><td class="C"><script>mt.city("city",null,null,"<%=city%>");</script></td>
  <th>收费标准:</th><td><input name="price0" value="<%=MT.f(price0)%>" size="10" mask="float"/> - <input name="price1" value="<%=MT.f(price1)%>" size="10" mask="float"/></td>
  <th>审批状态:</th><td><select name="state"><%=h.options(LmsIncome.STATE_TYPE,state)%></select></td>
  <th>创建时间:</th><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/LmsIncomes.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsincome"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="state"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td class="C">省</td>
  <td>收费标准</td>
  <td>有效时间</td>
  <td>状态</td>
  <td>创建时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY starttime DESC");
  Iterator it=LmsIncome.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsIncome t=(LmsIncome)it.next();
  %>
  <tr>
    <td><%=i%></td>
    <td class="C"><script>mt.city(<%=t.city%>)</script></td>
    <td><%=MT.f(t.price)%></td>
    <td><%=MT.f(t.starttime)+" - "+MT.f(t.endtime)%></td>
    <td><%=LmsIncome.STATE_TYPE[t.state]%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><%
    if(t.state!=2)
    {
      out.println("<a href=javascript:mt.act('edit',"+t.lmsincome+")>编辑</a>");
      out.println("<a href=javascript:mt.act('del',"+t.lmsincome+")>删除</a>");
    }
    if(acts.contains("oper,"))
    {
      if(t.state==1)
      out.println("<a href=javascript:mt.act('state',"+t.lmsincome+")>审核</a>");
    }
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='7' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
<input type="button" value="导出" onclick="mt.show(null,0);form3.submit();"/>
</form>

<form name="form3" action="/LmsExports.do?name=收费.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="sql"/>
<input type="hidden" name="key" value="<%=MT.enc("SELECT c.address 省份,li.price 收费标准,li.starttime 开始时间,li.endtime 结束时间,"+Lms.when(LmsIncome.STATE_TYPE,"li.state")+" 状态,li.time 创建时间 FROM LmsIncome li LEFT JOIN Card c ON li.city=c.card WHERE 1=1"+sql.toString())%>"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.lmsincome.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='state')
  {
    mt.show("状态：<input type='radio' name='_state' value='2' id='_state_2' checked /><label for='_state_2'>通过</label>　<input type='radio' name='_state' value='3' id='_state_3' /><label for='_state_3'>不通过</label>",2,"form2.state.value=$$('_state_2').checked?2:3;form2.submit()");
  }else
  {
    if(a=='view')
      form2.action='/LmsIncomeView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsIncomeEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
