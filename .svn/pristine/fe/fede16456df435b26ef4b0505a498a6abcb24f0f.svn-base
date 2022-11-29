<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
  String vertify = sms.password();
  Community community = Community.find(teasession._strCommunity);

  String nexturl = request.getParameter("nexturl");
  int destine = 0;
  if(request.getParameter("destine")!=null && request.getParameter("destine").length()>0)
     destine = Integer.parseInt(request.getParameter("destine"));
  Destine d = Destine.find(destine);
  Node n = Node.find(d.getNode());
  Profile p = Profile.find(d.getMember());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<div id="jspbefore" style="display:none"><%=community.getJspBefore(teasession._nLanguage)%></div>
<div id="tablebgnone" class="register">
  <h1>审核订单</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
 <form action="/servlet/EditDestine" name="form1" method="POST">
<input type="hidden" name="destine" value="<%=destine%>" />
<input type="hidden" name="act" value="deal" />
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="center">申请人</td>

  <td><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage) %></td>
</tr>
<tr>
  <td  align="center">酒店名称</td>
  <td><%=n.getSubject(teasession._nLanguage)%></td>
</tr>
<tr>

  <td align="center">入住时间段</td>
  <td><%=d.getKipdateToString()+"-"+d.getLeavedateToString()%></td>
</tr>
<tr>
<td align="center">审核意见</td>
<td><textarea cols="40" rows="3" name="idea"></textarea></td>
</tr>
<tr>
<td align="center">是否信箱提示</td>
<td>
<input id="gender_10" type="radio" name="emiletype" value="0" checked="checked"/>
<label for="gender_10">是</label>
<input id="gender_11" type="radio" name="emiletype" value="1"/>
<label for="gender_11">否</label>
</td>
</tr>
<tr>
<td align="center">选择定单状态</td>
<td>
<input id="gender_5" type="radio" name="state" value="1" checked="checked"/>
<label for="gender_5">已受理</label>
<input id="gender_6" type="radio" name="state" value="2"/>
<label for="gender_6">入住正常</label>
<input id="gender_2" type="radio" name="state" value="3"/>
<label for="gender_2">LESSSHOW</label>
<input id="gender_3" type="radio" name="state" value="4"/>
<label for="gender_3">延住</label>
<input id="gender_4" type="radio" name="state" value="5"/>
<label for="gender_4">NOSHOW</label>
</td>

</tr>
<tr>
<td align="center">是否同意</td>
<td>
<input id="gender_0" type="radio" name="ideatype" value="0" checked="checked"/>
<label for="gender_0">同意</label>
<input id="gender_1" type="radio" name="ideatype" value="1"/>
<label for="gender_1">不同意</label>
</td>

</tr>
</table>
<input type="submit"  class="edit_button" id="edit_submit" value="提交"/>
<input type=button value="返回" onClick="javascript:history.back()">
</form>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
</html>
