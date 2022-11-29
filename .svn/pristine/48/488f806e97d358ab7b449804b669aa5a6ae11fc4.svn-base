<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/order/SaleOrders");
String s2 =  request.getParameter("Pos");
int l1 = s2 == null ? 0 : Integer.parseInt(s2);
            if(!teasession._rv.isAccountant())
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("Type");
            String s1 = request.getParameter("Status");
            boolean flag = s == null;
            boolean flag1 = s != null && s1 == null;
            boolean flag2 = s != null && s1 != null;
            boolean flag3 = teasession._rv.isReal() || teasession._rv.isAccountant();
            int j = Integer.parseInt(s==null?"0":s);
            int k = Integer.parseInt(s1==null?"0":s1);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "FgSaleSOrder2")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

	  <table border="0" cellspacing="0" cellpadding="0" id="tablecenter">

          <%
          for(Enumeration enumeration = tea.entity.node.SOrder.find(node.getCommunity(),teasession._rv._strR,Integer.parseInt(s1)); enumeration.hasMoreElements(); )
          {
            int j2 = ((Integer)enumeration.nextElement()).intValue();
            tea.entity.node.SOrder so_obj=       tea.entity.node.SOrder.find(j2,teasession._nLanguage);
            tea.entity.node.Node node_obj=                 tea.entity.node.Node.find(j2);
            RV rv = node_obj.getCreator();		%>
          <tr>
            <td><%=ts.hrefGlance(rv)%></td>
            <td><%=(new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(node_obj.getTime())%></td>
            <td><A href="EditSOrder.jsp?node=<%=j2%>">#<%=j2%></A> </td></tr>
          <%}%>
  </table>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
