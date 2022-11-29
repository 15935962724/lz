<%@page contentType="text/html;charset=UTF-8" %><%@include file="/jsp/Header.jsp"%>

<%@ page import = "tea.entity.node.Sms" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<jsp:useBean id="profile" scope="page" class="tea.entity.member.Profile" />
<jsp:useBean id="sendsms" scope="page" class="com.SMS" />

<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource("/tea/ui/node/type/sms/EditUser");
TeaSession teasession = new TeaSession(request);
	String PhoneNumber = request.getParameter("PhoneNumber");
   String Node= request.getParameter("Node");

     HttpSession httpsession = request.getSession(true);
		String vertify=(String)httpsession.getAttribute("sms.vertify");
   		String vertify1 = request.getParameter("vertify");
       	if (!vertify.equals(vertify1.trim()))
  {

       		response.sendRedirect( "/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "ConfirmCodeError"),"UTF-8"));

	httpsession.invalidate();

  }

 String password=profile.getPassword(PhoneNumber);
   String msg;
if(request.getParameter("Lang").equals("1"))
	msg="您好!您在"+request.getRequestURL() +"上注册的密码是"+password;
else
	msg="How are you!Password that you register on the "+request.getRequestURL() +" is "+password;
boolean bool=sendsms.SubmitPassword( PhoneNumber,msg,password);
//System.out.println(bool);
String str="<a href=fixpwd.jsp>"+r.getString(teasession._nLanguage, "ClickHere")+"</a>";
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "RetrievePassword")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<a href="/servlet/StartLogin?node=<%=Node%>"> <%=r.getString(teasession._nLanguage, "ClickHereLogin")%></a>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td width=258 bgcolor="ffffff" > ·<%=r.getString(teasession._nLanguage, "Success")%> </td>
  </tr><tr><td bgcolor="ffffff" >
      <p>·<%=RequestHelper.format(r.getString(teasession._nLanguage, "1Minute"), str)%></p></td>
  </tr></table>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

