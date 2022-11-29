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



StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?community="+h.community);

sql.append(" AND hidden=0 AND community="+DbAdapter.cite(h.community));


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




<form name="form2" action="/DeptSeqs.do?dept=" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="tid"/>
<style>

</style>
<table id="tablecenter" cellspacing="0">

<%
if(sum<1)
{
  out.print("<tr><td colspan='10' style='text-align:center;'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY ctime desc");
  Enumeration e=Transactions.find(sql.toString(), pos, 10);
  while(e.hasMoreElements())
  {
	int tid=(Integer)e.nextElement();
	Transactions t=Transactions.find(tid);
	Profile p=Profile.find(t.getMember());
	String picture="";
	if(p.getPhotopath(h.language)!=null&&p.getPhotopath(h.language).length()>0){
		picture=p.getPhotopath(h.language);
	}
  %>
   <tr style="height:14px;"><td colspan="7"></td></tr>
  <tr>
		<td rowspan="3" class="pic"><img src="<%=picture %>" width="130" /></td>
		<td class="name"><%=MT.f(p.getName(h.language)) %></td>
		<td colspan="3" class="zc"><%=MT.f(p.getJob(h.language)) %>(<%=p.getTitle(h.language) %>)</td>
		<td class="jilu"><a href="#" onClick="parent.window.location.href='/html/folder/14091315-1.htm?tmember=<%=MT.enc(p.getProfile())%>';"><img src="/res/Home/structure/list11.png">交易记录</a></td>
	</tr>
	<tr>
		<td colspan="5" class="jj">
			<%=MT.f(p.getIntroduce(h.language)) %>
		</td>
	</tr>
	
  <tr>
  		<td class="pz" colspan="2">交易品种：<%=MT.f(t.getVarieties()) %></td>
  		<td class="fx" colspan="2">交易方向：<%=MT.f(t.getDirection()) %></td>
  		<td class="time">交易时间：<%=t.getTtime()==null?"":Entity.sdf2.format(t.getTtime()) %></td>
  </tr>
  <tr style="border-bottom:1px #ddd solid;height:14px;"><td colspan="7"></td></tr>
  <%
  }
  if(sum>10)out.print("<tr><td colspan='10' style='text-align:right;'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10));
}%>
</table>


</form>


</body>
</html>
