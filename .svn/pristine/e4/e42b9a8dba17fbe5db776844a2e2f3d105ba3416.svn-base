<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

String pagelist = teasession.getParameter("pagelist");
String listname = teasession.getParameter("listname");

CioCustomList ccl = CioCustomList.find("pagelist");
String showlists = ccl.getShowlist();
String changelists = ccl.getChangelist();


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
window.name="ccldialog";
function test(theform)
{

  theform.submit();
  window.close();
}
</script>
</head>
<body bgcolor="#ffffff">
<h1>
自定义显示列表
</h1>
<form name="form1" action="/servlet/EditCioPart" method="post" target="ccldialog">
<input type="hidden" value="ciocustomlist" name="act" />
<input type="hidden" value="<%=pagelist%>" name="pagelist"/>
<input type="hidden" value="<%=listname%>" name="listname"/>
<%
if("showlist".equals(listname))
{
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenterleft" >
<tr><td><input type="checkbox" name="checkbox" value="0"   <%if(showlists.indexOf(","+0+",")!=-1){  out.print(" checked ");}%>/></td><td>序号</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="1"  <%if(showlists.indexOf(","+1+",")!=-1){  out.print(" checked ");}%>/></td><td>姓名</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="2"  <%if(showlists.indexOf(","+2+",")!=-1){  out.print(" checked ");}%>/></td><td>性别</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="3"  <%if(showlists.indexOf(","+3+",")!=-1){  out.print(" checked ");}%>/></td><td>职务</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="4" <%if(showlists.indexOf(","+4+",")!=-1){  out.print(" checked ");}%>/></td><td>企业（集团）名称</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="5" <%if(showlists.indexOf(","+5+",")!=-1){  out.print(" checked ");}%>/></td><td>部门或子企业</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="6" <%if(showlists.indexOf(","+6+",")!=-1){  out.print(" checked ");}%>/></td><td>是否发言</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="7" <%if(showlists.indexOf(","+7+",")!=-1){  out.print(" checked ");}%>/></td><td>观光意向</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="8" <%if(showlists.indexOf(","+8+",")!=-1){  out.print(" checked ");}%>/></td><td>是否住宿</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="9" <%if(showlists.indexOf(","+9+",")!=-1){  out.print(" checked ");}%>/></td><td>代表号</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="10" <%if(showlists.indexOf(","+10+",")!=-1){  out.print(" checked ");}%>/></td><td>到达航班/车次</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="11" <%if(showlists.indexOf(","+11+",")!=-1){  out.print(" checked ");}%>/></td><td>返回航班/车次</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="12" <%if(showlists.indexOf(","+12+",")!=-1){  out.print(" checked ");}%>/></td><td>接送人姓名</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="13" <%if(showlists.indexOf(","+13+",")!=-1){  out.print(" checked ");}%>/></td><td>酒店名</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="14" <%if(showlists.indexOf(","+14+",")!=-1){  out.print(" checked ");}%>/></td><td>房型</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="15" <%if(showlists.indexOf(","+15+",")!=-1){  out.print(" checked ");}%>/></td><td>入住时间</td></tr>
<tr><td colspan="2"><input type="submit" value="提交" onclick="test(this.form);" /></td></tr>
</table>
<%
}else if ("changelist".equals(listname))
{
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenterleft" >
<tr><td><input type="checkbox" name="checkbox" value="d_cpame"  <%if(changelists.indexOf(",d_cpame,")!=-1){  out.print(" checked ");}%>/></td><td>姓名</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_sex"  <%if(changelists.indexOf(",d_sex,")!=-1){  out.print(" checked ");}%>/></td><td>性别</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_job"  <%if(changelists.indexOf(",d_job,")!=-1){  out.print(" checked ");}%>/></td><td>职务</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_ccname" <%if(changelists.indexOf(",d_ccname,")!=-1){  out.print(" checked ");}%>/></td><td>企业（集团）名称</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_dept" <%if(changelists.indexOf(",d_dept,")!=-1){  out.print(" checked ");}%>/></td><td>部门或子企业</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_talk" <%if(changelists.indexOf(",d_talk,")!=-1){  out.print(" checked ");}%>/></td><td>是否发言</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_tourism" <%if(changelists.indexOf(",d_tourism,")!=-1){  out.print(" checked ");}%>/></td><td>观光意向</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_room" <%if(changelists.indexOf(",d_room,")!=-1){  out.print(" checked ");}%>/></td><td>是否住宿</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_member" <%if(changelists.indexOf(",d_member,")!=-1){  out.print(" checked ");}%>/></td><td>代表号</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_cometrain" <%if(changelists.indexOf(",d_cometrain,")!=-1){  out.print(" checked ");}%>/></td><td>到达航班/车次</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_backtrain" <%if(changelists.indexOf(",d_backtrain,")!=-1){  out.print(" checked ");}%>/></td><td>返回航班/车次</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_cioclerkid" <%if(changelists.indexOf(",d_cioclerkid,")!=-1){  out.print(" checked ");}%>/></td><td>接送人姓名</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_rname" <%if(changelists.indexOf(",d_rname,")!=-1){  out.print(" checked ");}%>/></td><td>酒店名</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_rchamber" <%if(changelists.indexOf(",d_rchamber,")!=-1){  out.print(" checked ");}%>/></td><td>房型</td></tr>
<tr><td><input type="checkbox" name="checkbox" value="d_rstime" <%if(changelists.indexOf(",d_rstime,")!=-1){  out.print(" checked ");}%>/></td><td>入住时间</td></tr>
<tr><td colspan="2"><input type="submit" value="提交" onclick="test(this.form);" /></td></tr>
</table>
<%
}
%>
</form>
</body>
</html>
