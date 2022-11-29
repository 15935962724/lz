<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
  /*      if(!node.isCreator(teasession._rv))
        {
             response.sendError(403);
            return;
        }*/
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBListings")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<%-- div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div--%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "")%>用户账号 </td>
    <td><%=r.getString(teasession._nLanguage, "")%>用户序号ID</td>
    <td><%=r.getString(teasession._nLanguage, "")%>所属企业标识 </td>
    <td><%=r.getString(teasession._nLanguage, "")%>用户全名</td>
    <td><%=r.getString(teasession._nLanguage, "")%>员工类型</td>
  </tr>
  <%
java.util.Enumeration enumeration = tea.entity.member.Nethduser.find(0,Integer.MAX_VALUE);
	while( enumeration.hasMoreElements() )
	{
          tea.entity.member.Nethduser obj = ((tea.entity.member.Nethduser)enumeration.nextElement());

          %>
          <tr >
            <td><%=obj.getMember()%></td>
            <td><%=obj.getOudn()%></td>
            <td><%=obj.getOudn()%></td>
            <td><%=obj.getFullname()%></td>
            <td><%=obj.getUsertype()%></td>
          </tr>
          <%
	}
%>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

