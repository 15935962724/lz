<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" /><script language=JavaScript type="text/javascript" SRC="/sms/1660.js"></script>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource("/tea/ui/node/type/sms/EditUser");
//TeaServlet ts=new TeaServlet();
TeaSession teasession = new TeaSession(request);
String vertify=sms.password();
HttpSession httpsession = request.getSession(true);
httpsession.setAttribute("sms.vertify" ,vertify);
 String Node= request.getParameter("Node");

 String PhoneNumber = request.getParameter("PhoneNumber");
 if (PhoneNumber==null||PhoneNumber.equalsIgnoreCase("NULL") )
 PhoneNumber="";
	%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Verify")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

  <form name="find" action ="getpassword.jsp" method="post"  onSubmit="return isok2(this)">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "mobile1")%>:</TD>
        <td><input name="PhoneNumber" class="edit_input" maxlength=11 size=17 value=<%=PhoneNumber%>>
        <input name="Node" type='hidden' value=<%=Node%>>
        </td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Verify")%>:</TD>
        <td><input type="TEXT" class="edit_input"  size=17 name="vertify">
        </td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "VerificationCode")%>:</TD>
        <td><%=vertify%> </td>
      </tr>
      <tr>
        <TD></TD>
        <td><input  id="radio" type="radio" name="Lang" value="1" checked>
          <%=r.getString(teasession._nLanguage, "ChineseHandset")%>
          <input  id="radio" type="radio" name="Lang" value="0">
          <%=r.getString(teasession._nLanguage, "EnglishHandset")%></td>
      </tr>
      <tr>
        <TD></TD>
        <td colspan="2"></td>
      </tr>
      <tr>
        <TD></TD>
        <td colspan="2" ><%=r.getString(teasession._nLanguage, "Certain")%></td>
      </tr>

  </table>
  <input type="submit" name="Submit" class="edit_button" id="edit_submit" value="<%=r.getString(teasession._nLanguage, "CBSubmit")%>">
  <input type="reset" name="Submit2" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Reset")%>" >
  </form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

