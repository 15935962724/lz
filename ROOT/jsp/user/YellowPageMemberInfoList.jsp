<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditHome")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<form action="" method="post" enctype="multipart/form-data" name="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr style="background-color: #3775CA; padding:4px; padding-left:10px;font-weight:bold;color:#ffffff;">
    <td nowrap>企业名称(中英文)</TD>
    <td nowrap>会员ID</TD>
    <td nowrap>时间</TD>
    </tr>
<%
if(!tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv._strR))
{
  response.sendError(403);
  return;
}

java.util.Enumeration enumer=tea.entity.member.YellowPageInfo.find();
while(enumer.hasMoreElements())
{
  tea.entity.member.YellowPageInfo ypi_obj=tea.entity.member.YellowPageInfo.find((String)enumer.nextElement());
  String member=new String(getNull(ypi_obj.getMember()).getBytes("ISO-8859-1"));
  %>
    <tr>
    <td ><%=getNull(ypi_obj.getName())%></td>
    <td ><a href="/jsp/user/YellowPageMemberInfo.jsp?member=<%=member%>"><%=member%></A></td>
    <td ><%=getNull(ypi_obj.getTime())%></td>
    </tr>
  <%
}%>
</table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

