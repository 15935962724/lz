<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


%>
<form name="form1" action="/jsp/volunteer/Volunteersearch.jsp" method="GET">
<input name="name"  class="zyz_kuan" />
<select name="choose" class="zyz_kuan1">
<option value="0">---</option>
<option value="1">姓名</option>
<option value="2">手机</option>
<option value="3">Email</option>
</select> 
<input  type="submit" value="" class="zyz_an" />
</form>
