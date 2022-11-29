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
body{background:none;}
</style>
<table id="tablecenter" cellspacing="0">

<%
if(sum<1)
{
  out.print("<tr><td colspan='10' style='text-align:center;'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY ctime desc");
  Enumeration e=Transactions.find(sql.toString(), pos, 5);
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
   <tr >
   
   <td onClick="parent.window.location.href='/xhtml/folder/14091315-1.htm?tmember=<%=MT.enc(p.getProfile())%>';">
   		<div class="cont01"><img src="<%=picture%>"></div>
		<div class="cont02"><em><%=MT.f(p.getName(h.language)) %></em><%=MT.f(p.getJob(h.language)) %></div>
		<div class="cont02" style="top:34px;">交易品种：<%=MT.f(t.getVarieties()) %></div>
		<div class="cont02" style="top:54px;">交易方向：<%=MT.f(t.getDirection()) %></div>
		<div class="cont03"><%=MT.f(t.getContent(),70) %></div>
   
   
   </td>
   </tr>
  <%
  }
  if(sum>5)out.print("<tr><td colspan='10' style='text-align:right;'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,5));
}%>
</table>


</form>


</body>
</html>
