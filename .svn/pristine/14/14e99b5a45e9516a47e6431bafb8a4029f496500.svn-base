<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuilder sql=new StringBuilder(),par=new StringBuilder();

int menuid=h.getInt("id");
par.append("?id="+menuid);
sql.append(" AND p.profile>0");

String str=Lms.query(h,sql,par,false);

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,");
  return;
}

String acts=h.get("acts","");
int remind=acts.contains("oper,")?LmsPay.count(sql.toString()+" AND lp.status=1"):0;
if("remind".equals(act))
{
  out.print(remind);
  return;
}

String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND lp.code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}

int payment=h.getInt("payment");
if(payment>0)
{
  sql.append(" AND lp.payment="+payment);
  par.append("&payment="+payment);
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND lp.etime>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND lp.etime<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int order=h.getInt("order",1);
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);

int pos=h.getInt("pos");
par.append("&pos=");

int tab=h.getInt("tab",1);

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
<h1>缴费管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <%=str%>
  <th>缴费单号:</th><td><input name="code" value="<%=code%>"/></td>
</tr>
<tr>
  <th>支付方式:</th><td><select name="payment"><%=h.options(LmsPay.PAYMENT_TYPE,payment)%></select></td>
  <th>缴费日期:</th><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <th></th><td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<!--
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
-->
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsPays.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmspay"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="status"/>
<input type="hidden" name="act"/>
<%
out.print("<div class='switch'>");
for(int i=1;i<LmsPay.STATUS_TYPE.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(tab==i?"current":"")+"'>"+LmsPay.STATUS_TYPE[i]+"("+LmsPay.count(sql.toString()+" AND lp.status="+i)+")</a>");
}
out.print("</div>");
%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td><a href="javascript:mt.order('O1')" id="O1">缴费单号</a></td>
  <td><a href="javascript:mt.order('O2')" id="O2">缴费人数</a></td>
  <td><a href="javascript:mt.order('O3')" id="O3">缴费金额</a></td>
  <td><a href="javascript:mt.order('O4')" id="O4">缴费日期</a></td>
  <td>操作</td>
</tr>
<%
sql.append(" AND lp.status="+tab);
int sum=LmsPay.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"lp.lmspay","lp.code","lp.quantity","lp.price","lp.etime","p.ltime0","p.type"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",lp.lmspay");
  Iterator it=LmsPay.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsPay t=(LmsPay)it.next();
  %>
  <tr id="<%=MT.enc(t.lmspay)%>">
    <td><%=i%></td>
    <td><%=MT.f(t.code)%></td>
    <td><%=MT.f(t.quantity)%></td>
    <td><%=MT.f(t.price)%></td>
    <td><%=MT.f(t.etime,1)%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'view')>查看</a>");
    if(t.status!=2)
    {
      if(t.payment==2)out.println("<a href=### onclick=mt.act(this,'edit')>上传汇款凭证</a>");
      out.println("<a href=### onclick=mt.act(this,'del')>删除</a>");
    }
    out.println("<a href=### onclick=mt.act(this,'status')>审核</a>");
    %></td>
  </tr>
  <%
  }
  out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,c)
{
  form2.act.value=a;
  form2.lmspay.value=mt.ftr(t).id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='status')
  {
    mt.show("状态：<input type='radio' name='_status' value='2' id='_status_2' checked /><label for='_status_2'>通过</label>　<input type='radio' name='_status' value='3' id='_status_3' /><label for='_status_3'>不通过</label>",2,"form2.status.value=$$('_status_2').checked?2:3;form2.submit()");
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsPayView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsPayEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
edn.remind(<%=remind%>);
</script>
</body>
</html>
