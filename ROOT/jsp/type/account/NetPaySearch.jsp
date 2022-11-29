<%@page contentType="text/html;charset=UTF-8"  %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="java.util.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


String community=request.getParameter("community");
%>
<html>
<head>
<style type="text/css">
<!--
body{margin:0;padding:10px;border:1px solid #ccc;}
img {border:0;}
-->
</style>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>

<body>



<form name="form1" method="post" action="" style="border:1px solid #ccc;padding:5px">
  卡号：
  <input name="account" type="text" size="15">
  开始日期:
  <input name="startDate" type="text" onclick="showCalendar('form1.startDate')" size="15">
  结束日期
  <input name="endDate" type="text"  onclick="showCalendar('form1.endDate')" size="15"><br/>
<br/> 排序
       <select name="order">
        <option value="[date]">日期</option>
        <option value="money">金额</option>
      </select>
  <input type="submit" name="Submit" value="提交">
</form>

  <TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
  <tr>
       <td>帐号</td>
    <td>金额</td>
    <td>日期</td>
    <td></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <%
String account=  request.getParameter("account");
if(account!=null)
{
    String startDate=request.getParameter("startDate");
    if(startDate!=null&&startDate.length()>0)
    startDate=" and [date]>"+DbAdapter.cite((startDate));
    String endDate=request.getParameter("endDate");
    if(endDate!=null&&endDate.length()>0)
    endDate=" and [date]< "+DbAdapter.cite((endDate));

    DbAdapter dbadapter=new DbAdapter();
    try
    {
      dbadapter.executeQuery("select money,date  from NetPay where account="+dbadapter.cite(account)+startDate+endDate+" order by "+request.getParameter("order"));
      while(dbadapter.next())
      {
    %>
    <tr>
      <td><%=account%></td>
      <td><%=dbadapter.getString(1)%></td>
      <td><%=(new java.text.SimpleDateFormat("yyyy-MM-dd")).format(dbadapter.getDate(2))%></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr><%
  }
}finally
{
  dbadapter.close();
}%>
<TR><TD><input type="Button"  onclick=window.open("/servlet/NetPaySave?where=<%=org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("account="+DbAdapter.cite(account)+startDate+endDate+" order by "+request.getParameter("order"), request.getCharacterEncoding())%>") value="保存" >
<%}%>
</table>

