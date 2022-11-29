<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>

  <h1>年财政报告</h1>
  <div id="head6"><img height="6" alt=""></div>

  <table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
<TR id="tableonetr">
    <td nowrap="nowrap">年份</td>
    <td></td>
    <td nowrap="nowrap">提交者</td>
    <td nowrap="nowrap">提交时间</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td nowrap="nowrap">提交者</td>
    <td nowrap="nowrap">提交时间</td>


<%
java.util.Enumeration enumer=tea.entity.admin.FormsYear.find();
while(enumer.hasMoreElements())
{
  int formsyear=((Integer)enumer.nextElement()).intValue();
  tea.entity.admin.FormsYear fm_obj=  tea.entity.admin.FormsYear.find(formsyear);
 %>
 <tr>
  <td nowrap="nowrap"><%=formsyear+"-"+(formsyear+1)%></td>
  <td nowrap="nowrap"><a href="/jsp/admin/schoolfinance/EditSubsidyOutlay.jsp?formsyear=<%=formsyear%>" >津贴</a></td>
  <td nowrap="nowrap"><%=fm_obj.getMember()%></td>
  <td nowrap="nowrap"><%=fm_obj.getTimeToString()%></td>
  <td nowrap="nowrap"><a href="/jsp/admin/schoolfinance/SubsidyTotal.jsp?formsyear=<%=formsyear%>" >总结</a></td>
  <td nowrap="nowrap"><a href="/jsp/admin/schoolfinance/SubsidyPayout.jsp?formsyear=<%=formsyear%>" >支出预算</a></td>
<td></td>
    <td nowrap="nowrap"><a href="/jsp/admin/schoolfinance/EditSFAccountOutlay.jsp?formsyear=<%=formsyear%>" >流动现金</a></td>
    <td nowrap="nowrap"><%=fm_obj.getSfaMember()%></td>
    <td nowrap="nowrap"><%=fm_obj.getSfaTimeToString()%></td>
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



