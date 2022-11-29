<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  if(teasession._rv.toString()==null)
 {
  response.sendRedirect("/servlet/Node?node=14856&language=1");
  return ;
 }
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
  String vertify = sms.password();
  Community community = Community.find(teasession._strCommunity);
  String member =   teasession._rv._strV;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js" type="text/javascript"></script>
  <%--
    <script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
    <script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
    <script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>
  --%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<div id="jspbefore" style="display:none"><%=community.getJspBefore(teasession._nLanguage)%></div>
<div id="tablebgnone" class="register">
  <h1>会员中心</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" action="?">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <th nowrap>
        <a href="/jsp/registration/myorders.jsp?node=2221&member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>">我的订单</a>
      </th>
    </tr>
    <tr>
      <th nowrap>
        <a href="">我收藏的酒店</a>
      </th>
    </tr>
    <tr>
      <th nowrap>
        <a href="">我的评论</a>
      </th>
    </tr>
    <tr>
      <th nowrap>
        <a href="">我的消费记录</a>
      </th>
    </tr>
    <tr>
      <th nowrap>
        <a href="/jsp/registration/edituser.jsp?member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>&nexturl=<%=request.getRequestURL()%>">我的资料</a>
      </th>
    </tr>
  </table>
  </FORM>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
</div>
<div id="jspafter" style="display:none"><%=community.getJspAfter(teasession._nLanguage)%></div>
</body>
</html>
