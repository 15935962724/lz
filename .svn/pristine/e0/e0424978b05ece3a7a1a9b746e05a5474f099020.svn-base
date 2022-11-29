<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>

  <h1>每月财政报告</h1>
<div id="head6"><img height="6" alt=""></div>
<h2></h2>

  <table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
<TR id="tableonetr">
    <td nowrap="nowrap">月份</td>
    <td nowrap="nowrap">提交者</td>
    <td nowrap="nowrap">提交时间</td>
  <%
 java.util.Enumeration enumer=tea.entity.admin.FormsMonth.find();
while(enumer.hasMoreElements())
{
  java.util.Date date=(java.util.Date)enumer.nextElement();
  tea.entity.admin.FormsMonth fm_obj=  tea.entity.admin.FormsMonth.find(date);
  String strDate=tea.entity.admin.FormsMonth.sdf.format(date);
 %>
 <tr>
  <td nowrap="nowrap"><A href="/jsp/admin/schoolfinance/EditSubsidyForms.jsp?formsmonth=<%=strDate%>" ><%=strDate%></A></td>
  <td nowrap="nowrap"><%=fm_obj.getMember()%></td>
    <td nowrap="nowrap"><%=fm_obj.getTimeToString()%></td>
 </tr>
 <%

}
  %>
  </table>
  <br/>
  <div id="head6"><img height="6" src="about:blank"></div>



   <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
   </body>
</html>



