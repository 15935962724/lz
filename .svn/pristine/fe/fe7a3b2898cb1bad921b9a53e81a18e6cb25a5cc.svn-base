<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.pm.Transactions" %>
<%@page import="tea.entity.MT" %>
<%

Http h=new Http(request,response);


String key=h.get("tmember");
int member =0;

if(key!=null&&key.length() > 0){
	try{
		member=Integer.parseInt(MT.dec(key));
	}catch(Exception e){
		
	}
}
if(member==0){
	
}

Profile p =Profile.find(member);
String picture="";
if(p.getPhotopath(h.language)!=null&&p.getPhotopath(h.language).length()>0){
	picture=p.getPhotopath(h.language);
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?community="+h.community+"&tmember="+key);

sql.append(" AND hidden=0 AND community="+DbAdapter.cite(h.community));
sql.append(" AND member="+member);


//范围


int sum=Transactions.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<script>mt.fit();</script>
</head>
<body style="border:none;">
<div class="people">
<table>
	<tr>
		<td rowspan="2" class="pic"><img src="<%=picture %>" width="130" /></td>
		<td class="name"><%=MT.f(p.getName(h.language)) %></td>
		<td class="zc"><%=MT.f(p.getJob(h.language)) %>(<%=p.getTitle(h.language) %>)</td>
	</tr>
	<tr>
		<td colspan="2" class="jj">
			<%=MT.f(p.getIntroduce(h.language)) %>
		</td>
	</tr>
	
</table>
</div>

<div class="record_title"><img src="/res/Home/structure/list11.png" />交易记录</div>

<form name="form2" action="/DeptSeqs.do?dept=" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="tid"/>
<div class="record">
<table id="tablecenter" cellspacing="0">

<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center' >暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY tid desc");
  Enumeration e=Transactions.find(sql.toString(), pos, 5);
  while(e.hasMoreElements())
  {
	int tid=(Integer)e.nextElement();
	Transactions t=Transactions.find(tid);
  %>
  <tr><td colspan="6" style="height:8px;padding:0px;background:#f2f2f2;"></td></tr>
  <tr>
  		<td colspan="2" class="td01"><b>交易品种：</b><%=MT.f(t.getVarieties()) %></td>
  		<td colspan="2" class="td01"><b>交易方向：</b><%=MT.f(t.getDirection()) %></td>
  		<td colspan="2" class="td01"><b>交易时间：</b><%=t.getTtime()==null?"":Entity.sdf2.format(t.getTtime()) %></td>
  </tr>
  <tr id="<%=MT.enc(tid)%>">
  		<td colspan="2" class="td01"><b>成交数量：</b><%=t.getQuantity() %></td>
  		<td colspan="4" class="td02"><b>成交金额：</b><%=t.getTmoney() %></td>
  </tr>
  <tr><td colspan="6" style="height:8px;padding:0px;background:#f2f2f2;"></td></tr>
  <tr>
  		<td colspan="6" class="td03"><div><%=MT.f(t.getContent(),350) %></div></td>
  </tr>
  <%
  }
  if(sum>5)out.print("<tr class='page'><td colspan='10' align='center'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,5));
}%>
</table>
</div>

</form>


</body>
</html>
