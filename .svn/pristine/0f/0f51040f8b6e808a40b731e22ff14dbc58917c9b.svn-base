<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.site.Community" %>
<%@ page import = "tea.entity.node.Node" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import="tea.ui.TeaServlet"%>

<%
TeaSession teasession = new TeaSession(request);


Resource r = new Resource("/tea/ui/util/SignUp");
r.add("/tea/resource/Photography");
Community community = Community.find(teasession._strCommunity);

String ss = community.getTerm(teasession._nLanguage);
String act = teasession.getParameter("act");
String membertype= teasession.getParameter("membertype");


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body id="bodynone">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<h1><%=r.getString(teasession._nLanguage, "ServerArticle")%></h1>
 <p><%=tea.entity.admin.mov.RegisterInstall.getNavigation(Integer.parseInt(membertype),teasession._nLanguage,"zccg",1) %></p>

  <div id="head6"><img height="6" src="about:blank"></div>

  <%=ss%>
  <!--<FORM name=foSignUp method="POST" action="/jsp/orth/choice.jsp">--> <table width="100%" border="0" cellspacing="0" cellpadding="0" id="order_input">
  <FORM name=foSignUp method="POST" action="/jsp/mov/register.jsp">
    <input type="hidden" name="membertype" value="<%=membertype%>"/>
    <input type="hidden" name="act" value="<%=act%>"/>
        <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
       
       
          <tr>
            <td width="17%" align="right">&nbsp; <input type="radio"  value="1" name="radio1"  onClick="document.getElementById('regyes').disabled=false;foSignUp.radio1.checked=true;foSignUp.radio2.checked=false;"></td>
            <td width="37%" align="left"><a href=### onClick="document.getElementById('regyes').disabled=false;foSignUp.radio1.checked=true;foSignUp.radio2.checked=false;"><%=r.getString(teasession._nLanguage,"9859018774") %></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td width="3%" align="left">
            <input type="radio" value="2" name="radio2"  onclick="document.getElementById('regyes').disabled=true;foSignUp.radio1.checked=false;foSignUp.radio2.checked=true;"></td>
            <td width="27%" align="left"><a href=### onClick="document.getElementById('regyes').disabled=true;foSignUp.radio1.checked=false;foSignUp.radio2.checked=true;"><%=r.getString(teasession._nLanguage,"5623339906") %></a></td>
            <td width="16%" align="left">&nbsp;
              <input type=SUBMIT id="regyes" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage,"8278492237") %>" disabled="disabled" style="height:18px;">
  <!--  <input type=SUBMIT id="regno"class="edit_button" name="DoNotAgree" VALUE="" onClick="javascript:location.href='/servlet/Node?node=<%=teasession._nNode%>';return(false);"> -->
	<!-- <input type="button" value="不同意离开"  onClick="javascript:window.close();" style="height:18px;">--></td>
          </tr>
        
   
        
    
  </form></table>

 <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
