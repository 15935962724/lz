<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource("/tea/ui/node/type/sms/EditUser");


TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Community commobj=Community.find(teasession._strCommunity);


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=commobj.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body>


<div id="bigborder">



<div id="regsuccess02">
<%=teasession._rv.toString()%>&nbsp;用户，您已经注册成功!
<br>

<input type="button" value="进入我的后台" onClick="window.open('/jsp/admin/indextop.jsp','_self');">
<input type="button" value="返回首页" onClick="window.open('/','_self');">
<!--</fieldset>-->


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div></div>
</div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=commobj.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>






<%----------------------------不要册除以下代码（以前使用SMS注册时所使用的代码）----------------------------------------------------



<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<jsp:useBean id="sendsms" scope="page" class="com.SMS" />

<%response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource("/tea/ui/node/type/sms/EditUser");
//TeaServlet ts=new TeaServlet();
TeaSession teasession = new TeaSession(request);
   String s2 = request.getParameter("Node");
	String PhoneNumber = request.getParameter("PhoneNumber");
   String password=sms.GetPassword(PhoneNumber);
   System.out.println(password);
   String msg="您好!您在"+request.getRequestURL().toString().replaceAll(request.getRequestURI(),"").replaceAll(request.getQueryString(),"")+"上注册的密码是"+password;
   sendsms.SubmitPassword( PhoneNumber,msg,password);
String str="<a href=regsuccess.jsp?PhoneNumber="+PhoneNumber+">"+r.getString(teasession._nLanguage, "ClickHere")+"</a>";
	%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>

<DIV ID="edit_BodyDiv">
  <fieldset>
<legend><%=r.getString(teasession._nLanguage, "NoteUserLogin")%></legend>
	·<%=r.getString(teasession._nLanguage, "Success")%>
	<FORM action="logined.jsp?node=<%=s2%>" method=post>
				  <input type='hidden' name="PhoneNumber" value="<%=PhoneNumber%>">
				  <%=r.getString(teasession._nLanguage, "Password")%>：<input name="password" size=20 type=password maxlength=10  ><br/>
          <input type="submit" name="Submit" value="<%=r.getString(teasession._nLanguage, "LogLogin").replaceAll("","").replaceAll("","")%>">
	</form>
	 ·<%=RequestHelper.format(r.getString(teasession._nLanguage, "1Minute"), str)%>
</fieldset>

<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</div></body></html>




-----%>

