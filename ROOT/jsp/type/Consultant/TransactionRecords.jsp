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

boolean isM="webmaster".equals(h.username);
Profile p=Profile.find(h.member);
if(!isM&&p.getPMMJ()!=1)
{
  response.sendError(404,request.getRequestURI());
  return;
}


StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?community="+h.community);

sql.append(" AND hidden=0 AND community="+DbAdapter.cite(h.community));


if(!isM)
{
  sql.append(" AND member="+h.member);
}


//范围


int sum=Transactions.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");



%>

<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>


<div class="jyjl"><span style="font-size:16px;color:#408DD6;padding:0px 10px;float:left;">交易记录</span>  <span style="padding:0px 10px;float:right;color:#999;">共<em style="font-weight:bold;padding:0px;font-style:normal;color:#d80000;"><%=sum %></em>条记录</span></div>


<form name="form2" action="/DeptSeqs.do?dept=" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="tid"/>
<div style="border:1px #ddd solid;border-bottom:none;float:left;">
<table id="tablecenter" cellspacing="0">

<%
if(sum<1)
{
  out.print("<tr><td colspan='10' style='text-align:center;'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY tid desc");
  Enumeration e=Transactions.find(sql.toString(), pos, 5);
  while(e.hasMoreElements())
  {
	int tid=(Integer)e.nextElement();
	Transactions t=Transactions.find(tid);
  %>
  <tr style="height:28px">
  		<td class="td01">交易品种：</td>
  		<td><%=MT.f(t.getVarieties()) %></td>
  		<td class="td01">交易方向：</td>
  		<td><%=MT.f(t.getDirection()) %></td>
  		<td class="td01">交易时间：</td>
  		<td><%=t.getTtime()==null?"":Entity.sdf2.format(t.getTtime()) %></td>
  </tr>
  <tr style="height:28px" id="<%=MT.enc(tid)%>">
  		<td class="td01">成交数量：</td>
  		<td><%=t.getQuantity() %></td>
  		<td class="td01">成交金额：</td>
  		<td><%=t.getTmoney() %></td>
  		<td colspan="2" style="text-align:right;"><a href=### onclick=mt.act(this,'edit')>编辑</a>　　</td>
  </tr>
  <tr style="height:93px">
  		<td class="td01" valign="top" style="line-height:24px;">阐述原因：</td>
  		<td class="td01" style="text-align:left;line-height:24px;" colspan="5" valign="top"><div style="width:710px;height:72px;overflow:hidden;"><%=t.getContent() %></div></td>
  </tr>
  <%
  }
  if(sum>5)out.print("<tr><td colspan='10' style='text-align:right;'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,5));
}%>
</table>
</div>

</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.tid.value=t?mt.ftr(t).id:"";
  if(a=='edit')
      form2.action='/html/folder/14091199-1.htm';
  form2.target=form2.method='';
  form2.submit();
  
};
</script>

