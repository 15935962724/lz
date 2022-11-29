<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp" %>
<%
String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <TITLE>用户列表</TITLE>
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
	<BODY leftMargin="0" text="#000000" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
		<DIV align="center" class="Big1"><br>
	    人员列表（全体）
	      <hr color="#CB9966" size="1">
		</DIV>
		<br/>
                <%
                java.util.Enumeration enumer=tea.entity.admin.Conductor.findByCommunity(community);

                for(int intCount=1;enumer.hasMoreElements();intCount++)
                {
                  String unltid=((String)enumer.nextElement());

                  %>
                <table class="small" cellSpacing="1" cellPadding="3" width="100%" bgColor=#F4F4F4  align="center" border="0">
                  <TBODY>
                    <TR class="TableHeader" title="点击伸缩列表">
                      <td noWrap align="middle"><A href="editconductor.jsp?member=<%=unltid%>&community=<%=community%>" target="dept_user"><%=unltid%></A></td>
                    </tr>
                  </TBODY>
                </TABLE>
		<%
              }
		%>
	</BODY>
</html>



