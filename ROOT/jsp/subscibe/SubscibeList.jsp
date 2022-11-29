<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String community=request.getParameter("community");

CommunityOption co=CommunityOption.find(teasession._strCommunity);
String nodes[]=co.get("subnode").split("/");

%>
<html>
  <head>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8">

      <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
        <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
        <style type="text/css">
      <!--
      body {
      margin-left: 0px;
      margin-top: 0px;
      margin-right: 0px;
      margin-bottom: 0px;
      }
      -->
      </style>
  </head>
  <BODY leftMargin="0" text="#000000" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<DIV align="center" class="Big1"><br>
	    <%//=r.getString(teasession._nLanguage, "PersonnelList")%>
<hr color="#CB9966" size="1">
</DIV>
<br/>
<table class="small" cellSpacing="1" cellPadding="3" width="100%" bgColor=#F4F4F4  align="center" border="0">
<%
for(int i=1;i<nodes.length;i++)
{
	
  int node=Integer.parseInt(nodes[i]);
 
  out.print("<tr class='TableHeader' style='CURSOR:hand'><td noWrap align='middle'><a href='/jsp/subscibe/SendSubscibe.jsp?node="+node+"&community="+community+"' target='send_subscibe'>"+Node.find(node).getSubject(teasession._nLanguage)+"</a></td></tr>");
}
%>
</table>
<br>
<hr color="#CB9966" size="1">
</BODY>
</html>
