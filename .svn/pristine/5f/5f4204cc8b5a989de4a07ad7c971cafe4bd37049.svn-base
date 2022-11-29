<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.admin.mov.UpgradeMember"%>
<%@page import="tea.entity.admin.mov.MemberOrder"%>

<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
response.setHeader("Content-Disposition", "attachment; filename=impadd.doc ");//邮寄发票用户地址

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<BODY>

<%

String v = teasession.getParameter("memberorderall");

if(v!=null && v.length()>0)
{

for(int i=1;i<v.split("/").length;i++ )
{

	String memberorder = v.split("/")[i];
	MemberOrder m = MemberOrder.find(memberorder);
	Profile p = Profile.find(m.getMember());
	  String cname="";
	    
	    Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(p.getCity(teasession._nLanguage));
	
	     
	    if(isNum.matches()&&p.getCity(teasession._nLanguage)!=null && p.getCity(teasession._nLanguage).length()>0 && !"--------------".equals(p.getCity(teasession._nLanguage)))
	    {
	    	tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(p.getCity(teasession._nLanguage)));
	    	cname = cobj.toString(); 
	    }
	    cname = cname +p.getAddress(teasession._nLanguage);
 


%>
	
     <div>邮编：<%=p.getZip(teasession._nLanguage) %></div>
     <br>
	<div>　　地址：<%=cname %></div>
	<br>
	<div>　　收件人：<font size=4><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage) %></div>


<br>
<br>


<%
}
} 
%>
</BODY>
</HTML>
