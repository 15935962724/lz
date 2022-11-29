<%@page contentType="text/html;charset=UTF-8"  %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="java.util.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


String community=request.getParameter("community");
%>
<html>
<head>
<script type="text/javascript">
function change()
{
  if(document.form1.account.value.length==0)
  {
    document.form1.submit.disabled=true;
  }else
  {
    document.form1.submit.disabled=false;
  }
}
</script>
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

<form  name="form1" method="post">
  卡号:<input name="account" type="text" onchange="change()" onkeyup="change()" size="15">
起始日期:<input name="startDate" size="15" >
<a href="#" onclick="td_calendar('form1.startDate')"><img src="/tea/image/public/Calendar2.gif" ></a>
终止日期:<input name="ednDate" type="text" size="15">
<a href="#" onclick="td_calendar('form1.ednDate')"><img src="/tea/image/public/Calendar2.gif" ></a><br/><br/>
排序类别:
  <select name="order">
    <option value="[date]">交易日期</option>
    <option value="2">金额</option>
  </select>
  <input name="submit" type="submit" disabled>
</form>

  <TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
<tr ID=tableonetr>
    <td>交易日期</td>
    <td>收款人姓名</td>
    <td>收款人账号</td>
    <td>收款人开户行</td>
    <td>金额</td>
    <td>手续费</td>
    <td>交易类别</td>
     <td>状态</td>
     <td>用途</td>
  </tr>
  <%
  String  account=request.getParameter("account");
  if(account!=null)
  {
    String startDate=request.getParameter("startDate");
    if(startDate!=null&&startDate.length()>0)
    {
      startDate=" and [date]>"+DbAdapter.cite((startDate));
    }else
    startDate="";

    String endDate=request.getParameter("endDate");
    if(endDate!=null&&endDate.length()>0)
    endDate=" and [date]<"+DbAdapter.cite((endDate));
    else
    endDate="";

    String order=request.getParameter("order");
    if(order!=null)
    order=" order by "+order;
    else
    order="";

  tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
  try
  {
  dbadapter.executeQuery("select [date],chamberlain,acceptaddress,acceptbank,acceptaccount,money,capital,remark, purpose,type,state,poundage  from Transfer where account="+dbadapter.cite(account)+startDate+endDate+order);
while(  dbadapter.next())
{  %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=(new java.text.SimpleDateFormat("yyyy-MM-dd")).format(dbadapter.getDate(1))%></td>
    <td><%=dbadapter.getString(2)%></td>
    <td><%= (dbadapter.getString(5))%></td>
    <td><%= (dbadapter.getString(4))%></td>
    <td><%=dbadapter.getString(6)%></td>
    <td><%=  (dbadapter.getString(12))%></td>
    <td><%= (dbadapter.getString(10))%></td>
    <td><%= (dbadapter.getString(11))%></td>
    <td><%=dbadapter.getVarchar(1, 1,9)%></td>
</tr>
<%}
  }finally
  {
    dbadapter.close();
    }%>
<TR><TD><input type="Button"  onclick=window.open("/servlet/TransferSave?where=<%=org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("account="+tea.db.DbAdapter.cite(account)+startDate+endDate+order, request.getCharacterEncoding())%>") value="保存" >
<%}%>
</table>

