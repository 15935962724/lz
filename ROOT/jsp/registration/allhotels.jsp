<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.*,tea.db.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %><!--Community的包-->
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
 <%
 request.setCharacterEncoding("UTF-8");
 if(session.getAttribute("tea.RV")==null)
 {
   response.sendRedirect("/servlet/Node?node=14856&language=1");
 }
 TeaSession teasession = new TeaSession(request);
 Community community=Community.find(teasession._strCommunity);
 String member = teasession.getParameter("member");
  %>
  <html>
  <head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body id="bodynone">
  <h1>酒店展示</h1>
  <div id="jspbefore" style="display:none">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>
  <form action="?">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
  <tr>
    <td>酒店名称</td><td>酒店星级</td><td>酒店价格</td>
  </tr>
  <%
  DbAdapter  db = new  DbAdapter();
  StringBuffer sql = new StringBuffer();
  sql.append("select distinct node from Hostel where node in (select node from Node where father=2221)");
  db.executeQuery(sql.toString());
  while(db.next())
  {
  Node node = Node.find(db.getInt(1));
  Hostel obj = Hostel.find(db.getInt(1));
  String[] str={"无要求","☆","☆☆","☆☆☆","☆☆☆☆","☆☆☆☆☆"};
  String star=str[obj.getStarClass()];
  %>
  <tr>
<td><a href="/jsp/registration/fhostel.jsp?node=<%=db.getInt(1)%>&language=1" TARGET="_self">
  <%=node.getSubject(db.getInt(1))%></a></td><td><%=star%></td><td><%=obj.getPrice()%></td>
  </tr>
  <%
  }%>
  </table>
  </form>
</body>
</html>
