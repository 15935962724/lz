<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/node/general/AddToFavorite");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAddToFavorites")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%
           // Favorite.create(teasession._strCommunity, teasession._rv,teasession._nNode);

            Object aobj[] = {"<A HREF=/servlet/FavoriteNodes>"+r.getString(teasession._nLanguage, "ClickHere")+"</A>",
               "<A HREF=/servlet/Node?Node="+teasession._nNode+">"+r.getString(teasession._nLanguage, "ClickHere")+"</A> ."
            };

            out.print(java.text.MessageFormat.format(r.getString(teasession._nLanguage, "InfViewFavorites"), aobj));
%>
     <jsp:forward page="/servlet/FavoriteNodes_1"></jsp:forward>
</td>
  </tr>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</html>
