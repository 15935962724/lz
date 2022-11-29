<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.ocean.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{

  param.append("&id=").append(menu_id);
}
String num = "";
if(teasession.getParameter("num")!=null && teasession.getParameter("num").length()>0)
{
  num=teasession.getParameter("num");
}
%>
<html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script>if(parent.lantk) {document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; }</script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>分店进货记录</title>
</head>
<body>
<h1>分店进货记录</h1>
<%if(num.equals("1"))
{


}
else
{
%>

<h2>查询</h2>
<form accept="?" name="form2">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>提货日期:&nbsp;从&nbsp;
      <input name="time_k" size="7"  value=""><A href="###"><img onclick="showCalendar('form2.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
      <input name="time_j" size="7"  value=""><A href="###"><img onclick="showCalendar('form2.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    </td>

    <td>提货人:&nbsp;<input type="text" name="" value=""/></td>
    <td>提货仓库:<select name="">
<option>----------</option>
<option>北京仓库</option>
</select> </td>

    <td><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>
<h2>列表(1)</h2>
  <form action="?" name="form1" method="POST">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>提货单号</td>
      <td nowrap>提货日期</td>
      <td nowrap>提货人</td>
      <td nowrap>提货仓库</td>
      <td nowrap>提货数量</td>
      <td nowrap>提货金额</td>
      <td nowrap>实付金额</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center"><a href="/jsp/erp/PaidinfullShow.jsp">20090414002</a></td>
      <td align="center">2009-04-14</td>
      <td align="center">李先生</td>
      <td align="center"><a href="#">北京仓库</a></td>
      <td align="center">10</td>
      <td align="center">6552.50</td>
      <td align="center">6552.50</td>
    </tr>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center"><a href="/jsp/erp/PaidinfullShow.jsp">20090414009</a></td>
      <td align="center">2009-04-14</td>
      <td align="center">李先生</td>
      <td align="center"><a href="#">北京仓库</a></td>
      <td align="center">15</td>
      <td align="center">9552.50</td>
      <td align="center">9552.50</td>
    </tr>

    <tr>
    <td  colspan="7" align="center"><input type=button value="返回" onClick="javascript:history.back()"/></td>
    </tr>
    <tr><td nowrap="nowrap"><font color="red">账户余额：256144元</font></td></tr>
  </table>
<%
}%>
<%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>

