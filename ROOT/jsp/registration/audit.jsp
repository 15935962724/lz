<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="tea.ui.TeaSession" %><!--导入Teasession的包-->
<%@ page import="tea.entity.site.*" %><!--导入Community的包-->
<%@page import="tea.entity.node.*" %><!--导入node的包-->
<%@page import="tea.resource.*" %>
<%@page import="tea.db.*" %>
<%@ page import="tea.entity.member.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<html>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/Node?node=14856&language=1");
  return ;
}
String member = teasession.getParameter("member");
Community community = Community.find(teasession._strCommunity);
Hotel_application obj = Hotel_application.find(member);
Profile pro = Profile.find(member);
%>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>audit</title>
</head>
<body id="bodynone">
<div id="jspbefore" style="display:none">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="register">
<h1>审核</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<form action="/jsp/registration/EditAudit.jsp" name="form1" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input type="hidden" name="Node" value="<%=teasession._nNode%>" />
<input type="hidden"  name="Language" value="<%=teasession._nLanguage%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="center">*申请人</td>
  <td><%=obj.getMember()%>
    <input type="hidden" name="member" value="<%=obj.getMember() %>" />
    <input type="hidden" name="nodeid" value="<%=teasession._nNode %>"/>
</td>
</tr>
<tr>
  <td  align="center">*联系方式</td>
  <td><%=pro.getMobile()%><input type="hidden" name="telephone" value="<%=pro.getMobile()%>"/> </td>
</tr>
<tr>
  <td align="center">*申请说明</td>
  <td><%=obj.getIntroduce() %><input  type="hidden" name="introduce" value="<%=obj.getIntroduce()%>" ></td>
</tr>
<tr>
  <td align="center">*资质证明文件</td>
  <td><a href="/jsp/registration/doc.jsp?path=<%=obj.getDocuments()%>">资质证明文件</a>
    <input type="hidden" name="documents" value="<%=obj.getDocuments()%>"/></td>
</tr>
<tr>
<td align="center">*批准意见</td>
<td>
<input id="gender_0" type="radio" name="yn" value="1" checked="checked"/>
<label for="gender_0">同意</label>
<input id="gender_1" type="radio" name="yn" value="0"/>
<label for="gender_1">不同意</label>
</td>
</tr>
</table>
<br /><br />
<input type="submit"  class="edit_button" id="edit_submit" value=" 提交 "/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=button value="返回" onClick="javascript:history.back()">
</form>
</div>
<div id="head6"><img alt="" src="about:blank" height="6"/></div>
</body>
</html>
