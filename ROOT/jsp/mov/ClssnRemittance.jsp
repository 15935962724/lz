<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



Resource r=new Resource("/tea/resource/Photography");



%>

<html>
<head>
<title>汇款信息统计</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<script>
	function f_on(igd)
	{
		 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:600px;dialogHeight:470px;'; 
		 var url = '/jsp/mov/ClssnRemMember.jsp?community='+form1.community.value+'&years='+igd+'&t='+new Date().getTime();
		 var rs = window.showModalDialog(url,self,y);
		 if(rs==1)
		 {
			 window.location.reload();
		 }
	}
</script>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">


<h1>当前汇款信息统计(最后一次汇款统计)</h1>

 
<form name="form1" action ="?" method="post">

 <input type="hidden" name="community" value="<%=teasession._strCommunity %>">
 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  
  <tr  id=tableonetr>
  	<td>金额</td>
  	<td>会员统计</td>
  	<td>金额统计</td>
  </tr>
  <%
  	DbAdapter db = new DbAdapter();
  BigDecimal tarcount = new BigDecimal("0");
  int ca = 0;
	try
	{
		db.executeQuery("select m.remittance from Profile p, MemberOrder m where p.member=m.member and m.remittance!=0 and m.remittance is not null   group by m.remittance ");
		while(db.next())
		{
			BigDecimal remittance = db.getBigDecimal(1,2);
			int co = MemberOrder.countMP(teasession._strCommunity," and m.remittance = "+remittance);
			
			BigDecimal rco = remittance.multiply(new BigDecimal(co));
			ca = ca+co;
			
			tarcount = tarcount.add(rco);
			%>
			
			  <tr>
  			 	<td><%=remittance%></td>
  				<td><%=co %></td>
  				<td><%=rco %></td>
	   	      </tr>
			<%
		}
		
	}finally
	{
		db.close();
	}
  %>
  <tr>
  	<td align="right">合计：</td>
  	<td><%=ca %></td>
  	<td><%=tarcount %></td>
  </tr>
  
	
	    
    
  </table>
  
  <h1>系统缴费历史总统计金额</h1>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr  id=tableonetr>
	  	<td>汇款年份</td>
	  	<td>汇款用户</td>
	  	<td>汇款总金额</td>
	  </tr>
  
  <%
  BigDecimal addR = new BigDecimal("0.0");
  int cb = 0;
  	DbAdapter db2 = new 	DbAdapter();
  try
  {
	  db2.executeQuery(" select years from UpgradeMember   group by years order by years asc");
	  while(db2.next())
	  { 
		  int y = db2.getInt(1);
		  BigDecimal cr = UpgradeMember.countRemittance(teasession._strCommunity," and becometime is not null  and remittance!=0 and period =0 and years = "+y);
		  addR =addR.add(cr);
		  int coa = UpgradeMember.countMember(teasession._strCommunity," and becometime is not null  and remittance!=0 and period=0 and years = "+y);
		  cb = cb+coa;
	  
  %>
	  <tr  id=tableonetr>
	  	<td><%=y %></td>
	  	<td><a href="###" onclick="f_on('<%=y%>');"><%=coa%></a></td>
	  	<td><%=cr%></td>
	  </tr>
  <%
	  }
  }finally
  {
	  db2.close();
  }
  %>
  <tr>
   <td align="right">合计：</td>
  <td><%=cb %></td>
 
  <td><%=addR %></td>
  </tr>
  </table>
  <br>
   <input type="button" value="关闭"  onClick="javascript:window.close();">
</form>
</body>
</html>
