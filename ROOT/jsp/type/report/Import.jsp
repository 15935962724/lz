<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Import")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<DIV ID="edit_BodyDiv">
 <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
 <form action="/servlet/ImportReport" enctype=multipart/form-data method="POST">
     <input type=FILE name="content" class="edit_input">
         <input type=submit name="submit" name="value"/>
 </form>
   
</DIV>
 <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

