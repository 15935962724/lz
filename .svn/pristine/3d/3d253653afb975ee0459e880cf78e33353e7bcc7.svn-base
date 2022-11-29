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


String nexturl = request.getRequestURI();

String years = teasession.getParameter("years");


StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer();
sql.append(" and becometime is not null  and remittance!=0 and period=0");

sql.append(" and years = ").append(years);
param.append("&years=").append(years);



String memberid =teasession.getParameter("memberid");
if(memberid!=null && memberid.length()>0)
{
	memberid = memberid.trim();
	sql.append(" and member like ").append(DbAdapter.cite("%"+memberid+"%"));
	param.append("&memberid=").append(URLEncoder.encode(memberid,"UTF-8"));
}
int remtype = -1;
if(teasession.getParameter("remtype")!=null && teasession.getParameter("remtype").length()>0)
{
	remtype = Integer.parseInt(teasession.getParameter("remtype"));
	sql.append(" and remtype = ").append(remtype);
	param.append("&remtype=").append(remtype);
}





int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}



int count=UpgradeMember.countMember(teasession._strCommunity,sql.toString());



%>

<html>
<head>
<title>代理会员的代理用户</title>
<base target="tar"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<script type="text/javascript">
window.name='tar';



</script>



 
<form name="form1" action ="?" method="get" target="tar">

<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="community" value="<%=request.getParameter("community") %>">
<input type="hidden" name="years" value="<%=years %>">


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
	   		<td>用户名：</td>
	   		<td><input type="text" name="memberid" value="<%=Entity.getNULL(memberid)%>"></td>
	   		<td>汇款方式：</td>
	   		<td>
	   		<select name="remtype">
	   		<option value="">-汇款方式-</option>
	   			<%
		   			for(int i=0;i<MemberOrder.REM_TYPE.length;i++)
					{
						out.print("<option value="+i);
						if(remtype==i)
						{
							out.print(" selected  ");
						}
						out.print(">"+MemberOrder.REM_TYPE[i]+"&nbsp;");
						out.println("</option>");
					}
	   			%>
	   			</select>
	   		</td>
	   		<td><input type="submit" value="查询"></td>
	   </tr>
	   
  </table>






<h2>汇款会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员汇款&nbsp;)&nbsp;</h2>

 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			 
  			  <td nowrap>会员ID</td>
  			  <td>汇款金额</td>
  			  <td nowrap>汇款方式</td>
	    </tr>
	    
    <%

	    java.util.Enumeration e =UpgradeMember.find(teasession._strCommunity, sql.toString(), pos, pageSize);
		 if(!e.hasMoreElements())
		 {
		     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
		 }
    	for(int i=1;e.hasMoreElements();i++)
    	{
    		int umid = ((Integer)e.nextElement()).intValue();
    		UpgradeMember uobj = UpgradeMember.find(umid);
    		
    		String member = uobj.getMember();
    		
    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
     
    
      <td><%=member %></td>
      <td><%=uobj.getRemittance() %>&nbsp;元</td>
      <td><%=MemberOrder.REM_TYPE[uobj.getRemtype()] %></td>
      </tr>
      
	  
<%} %>

	   
    </tr>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
