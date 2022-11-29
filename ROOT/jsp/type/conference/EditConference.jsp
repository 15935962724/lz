<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@page import="javax.mail.*" %>
<%@ page import="java.net.Socket"%>
<%@page import="javax.mail.internet.*" %>
<%@ page import=" tea.db.DbAdapter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.ui.member.order.*"%>
<%@ page import="tea.http.RequestHelper"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
String getSelect(boolean i)
{
	return i?" SELECTED ":" ";
}

String getNull(Object strNull)
{	return strNull==null?"":String.valueOf(strNull);
}
String getNull(int intValue)
{	return intValue==0?"":String.valueOf(intValue);
}
String getNull(float floatValue)
{	return floatValue==0f?"":String.valueOf(floatValue);
}
String getDisplay(boolean bool)
{
    return bool?" style=\"display:\" ":" style=\"display:none\" ";
}
TeaServlet ts=new TeaServlet();
Resource r = new Resource();
Node node;
TeaSession teasession;
%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
teasession = new TeaSession(request);
if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
return;
}
if(!tea.entity.util.Safety.find(teasession._rv.toString(),teasession._strCommunity,7).isExists()&&!tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
  out.print(new tea.html.Script("window.alert('对不起,你没有权限.');history.back();"));
  return;
}

node=Node.find(teasession._nNode);
%>
<!--
WorkShop A The Trend of Economic Globalization and Its Implications
-->
<%--@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" --%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<LINK href="/tea/CssJs/21shiji.css" REL="stylesheet" TYPE="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/CssJs/21shiji.js"></SCRIPT>
<LINK href="/tea/CssJs/21shiji1.css" REL="stylesheet" TYPE="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/CssJs/21shiji.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
body {
	margin-left: 10px;
	margin-top: 5px;
	margin-right: 5px;
	margin-bottom: 0px;
}
-->
</style></head>
<body >
<div align="left" style="margin-bottom:0px;">会议议题管理</div>
<table id=user border="1" cellpadding="0" cellspacing="0" width=100% style="border-collapse:collapse;margin-bottom:15px">
<tr bgcolor="#FFFBF0">
    <td nowrap>&nbsp;议题中文名称</td>
    <td nowrap>&nbsp;议题英文名称</td>
    <td nowrap>&nbsp;操作</td>
  </tr>
<%java.util.Enumeration enumer=tea.entity.node.Conference.findByCommunity(node.getCommunity());
int conference;
while(enumer.hasMoreElements())
{
  conference=((Integer)enumer.nextElement()).intValue();
  tea.entity.node.Conference obj=tea.entity.node.Conference.find(conference);
  %>
  <tr>
    <td>&nbsp;<%=obj.getName()%></td>
    <td>&nbsp;<%=obj.getEname()%></td>
    <td>
      &nbsp;
      <input type="button" class=in name="edit" value="编辑" onclick="formsubmit.name.value='<%=obj.getName()%>';formsubmit.ename.value='<%=obj.getEname()%>';formsubmit.conference.value='<%=conference%>';">
      <input type="button" class=in  name="delete" value="删除"  onClick="if(confirm('确认删除')){window.open('/servlet/EditConference?delete=ON&conference=<%=conference%>', '_self');}">
    </td>
  </tr>
<%}%>
</table>

<form action="/servlet/EditConference" method="post" name="formsubmit"  onsubmit=" return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.ename, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')">
  议题中文名称:
    <input type="text" name="name">
  议题英文名称:
  <input type="text" name="ename">
<input type="hidden" name="conference" value="0" />
<input  class=in type="submit" name="Submit" value="提交">
</form>
</body>
</html>

