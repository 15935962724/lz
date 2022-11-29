<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*,tea.entity.node.*" %>
<%@ page import="tea.entity.member.Profile" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%

 request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
Community community=Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js"></script>
<%--
<script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>
--%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone" >
<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="register">
<h1><%=r.getString(teasession._nLanguage, "会员统计各酒店订单")%></h1>
<h2><%=r.getString(teasession._nLanguage,"列表")%></h2>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
  <FORM name="form1" METHOD="POST" ACTION="">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
  <tr>
  <td>所定酒店</td><td>订单总数</td><td>已受理数</td><td>未受理数</td><td>过期订单数</td>
  </tr>
 <%
 StringBuffer str = new StringBuffer();
 java.util.Enumeration e = Destine.find(teasession._strCommunity);
 while(e.hasMoreElements())
 {
   int node = ((Integer)e.nextElement()).intValue();
   Node obj = Node.find(node);
  int  allorders = Destine.count(teasession._strCommunity," AND node = "+node);
  int  has = Destine.count(teasession._strCommunity," AND  dstate = 1 AND node = "+node);
  int  not = Destine.count(teasession._strCommunity," AND dstate = 0 AND node ="+node);
  int  pass = Destine.count(teasession._strCommunity," AND dstate = 2  AND node = "+node);
 %>
 <tr>
 <td><a href=""><%=obj.getSubject(teasession._nLanguage)%></a></td>
<td><%=allorders %></td>
<td><%=has %></td>
<td><%=not%></td>
<td><%=pass %></td>
 </tr>
<%} %>
 <tr>
    <td align="center">
    <% // <input type="submit" class="edit_button" id="edit_submit"   value="<%=r.getString(teasession._nLanguage, "导出成 EXCEL 表格")>"></td> %>
      <input type="button" value="<%=r.getString(teasession._nLanguage, "导出成 EXCEL 表格")%>" onClick="window.location='/servlet/ExportSonNodes?node=<%=teasession._nNode%>'"/>
    </tr>
  </table>
  </FORM>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
</div>
<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
</body>
</html>
