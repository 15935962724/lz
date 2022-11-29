<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.netdisk.*"%>
<jsp:directive.page import="java.math.BigDecimal"/>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String community = teasession._strCommunity;
StringBuffer sql=new StringBuffer(" and type=0 ");
StringBuffer sql2=new StringBuffer("");
//eatype,ctime,paydate
Date dates = new Date();
Calendar cal = Calendar.getInstance();
cal.setTime(dates);

cal.set(cal.YEAR,cal.get(cal.YEAR)-1);

String time_k="",time_j="",firstname="";
if(teasession.getParameter("time_k")!=null && teasession.getParameter("time_k").length()>0)
{
  time_k= teasession.getParameter("time_k");
  sql.append("  and  ctime>").append(DbAdapter.cite(time_k));
  sql2.append("  and  paydate>").append(DbAdapter.cite(time_k));
}
else
{
  time_k=ProjectNotPay.sdf.format(cal.getTime());
  sql.append("  and  ctime>").append(DbAdapter.cite(time_k));
  sql2.append("  and  paydate>").append(DbAdapter.cite(time_k));
}
if(teasession.getParameter("time_j")!=null && teasession.getParameter("time_j").length()>0)
{
  time_j= teasession.getParameter("time_j");
  sql.append("  and  ctime<").append(DbAdapter.cite(time_j));
  sql2.append("  and  paydate<").append(DbAdapter.cite(time_j));
}
else
{
  time_j= ProjectNotPay.sdf.format(dates);
  sql.append("  and  ctime<").append(DbAdapter.cite(time_j));
  sql2.append("  and  paydate<").append(DbAdapter.cite(time_j));
}
 //总收益（盈利项目公司总利润-非盈利项目整体投入成本-非项目支出合计，可为负值）
 //盈利项目公司总利润
 java.math.BigDecimal earnings =new java.math.BigDecimal(Flowitem.getCompanyProfits(teasession._strCommunity,sql.toString()+" and eatype = 0 ")[0]);
 //非盈利项目投入
 java.math.BigDecimal NOearnings =Flowitem.getNoCollect(teasession._strCommunity,sql.toString()+" and eatype = 1 ");
 //非项目支出
 java.math.BigDecimal spending =ProjectNotPay.sumPaymoney(teasession._strCommunity,sql2.toString());
%>
<!doctype html>
<html><head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<style type="text/css">
#tablecenter td{padding:1px 5px;height:25px;}
</style>
</head>
<body >
<h1>收益总表</h1>

<form name="form3" action="/jsp/admin/SumFlowitem.jsp" method="post"  enctype="multipart/form-data"  onSubmit="return f_submit();">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>
      <h2>从<%=time_k%> 开始 到 <%=time_j%> 公司整体收益一览表<h2><input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onclick="showCalendar('form3.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
      <input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onclick="showCalendar('form3.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;&nbsp;
      <input type="submit"  style="color:#A4462C" value="重新计算" /></td>
  </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td  width="120" align="right">公司总项目收入</td>
    <td colspan="5"><font style="font-weight:bold;"><a  style="color:#000000;font-weight:bold" href="/jsp/admin/workreport/EarningStaSum.jsp?time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"overallmoney",sql.toString()) %></a></font></td>
  </tr>
  <tr >
    <td align="right" width="120" >总体实际收入</td>
    <td colspan="5"><font color="red" style="font-weight:bold;"><a  style="color:#000000;font-weight:bold" href="/jsp/admin/workreport/EarningStaSum.jsp?time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getAmountTotal(teasession._strCommunity,sql.toString()) %></a></font></td>
  </tr>
  <tr>
    <td rowspan="3" align="right" width="120" >市场费用成本</td>
    <td rowspan="3"  width="120"><font style="font-weight:bold;"><a  style="color:#000000;font-weight:bold" href="/jsp/admin/workreport/EarningStaSum.jsp?time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"1",sql.toString()) %></a></font></td>
    <td align="right"  width="120">盈利项目</td>
    <td><font color="red" style="font-weight:bold;"><a  style="color:#ff0000;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=0&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"1",sql.toString()+" and eatype=0 ") %></a></font></td>

  </tr>
  <tr>
    <td rowspan="2" align="right"  width="120">非盈利项目</td>
    <td rowspan="2" width="120"><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"1",sql.toString()+" and eatype=1 ") %></a></font></td>
    <td align="right"  width="120">未结款</td>
    <td><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&overallmoney=1&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"1",sql.toString()+ " and overallmoney!=0 and eatype=1 ") %></a></font></td>
  </tr>
  <tr>
    <td align="right"  width="120">非即时收益</td>
    <td><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&overallmoney=0&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"1",sql.toString()+" and overallmoney=0  and eatype=1 ") %></a></font></td>
  </tr>
  <tr>
    <td rowspan="3"   align="right" width="120" >人工费用成本</td>
    <td rowspan="3"  width="120" ><font style="font-weight:bold;"><a  style="color:#000000;font-weight:bold" href="/jsp/admin/workreport/EarningStaSum.jsp?time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getMembercost(teasession._strCommunity,sql.toString()) %></a></font></td>
    <td align="right"    width="120">盈利项目</td>
    <td width="120"  ><font color="red" style="font-weight:bold;"><a  style="color:#ff0000;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=0&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getMembercost(teasession._strCommunity,sql.toString()+" and eatype=0 ") %></a></font></td>
    <td colspan="2"  >&nbsp;</td>

  </tr>
  <tr>
    <td rowspan="2" align="right"   width="120">非盈利项目</td>
    <td rowspan="2" width="120" ><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getMembercost(teasession._strCommunity,sql.toString()+" and eatype=1 ") %></a></font></td>
     <td align="right"  width="120" >未结款</td>
    <td ><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&overallmoney=1&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getMembercost(teasession._strCommunity,sql.toString()+(" and overallmoney!=0 ")+(" and eatype=1 ")) %></a></font></td>
  </tr>
  <tr>
   <td align="right"  width="120" >非即时收益</td>
    <td ><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&overallmoney=0&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getMembercost(teasession._strCommunity,sql.toString()+(" and overallmoney=0  and eatype=1 ")) %></a></font></td>
  </tr>
  <tr>
    <td rowspan="3" align="right"  width="120">其他费用成本</td>
    <td rowspan="3"  width="120"><font style="font-weight:bold;"><a  style="color:#000000;font-weight:bold" href="/jsp/admin/workreport/EarningStaSum.jsp?time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"2",sql.toString()) %></a></font></td>
    <td align="right"  width="120">盈利项目</td>
    <td ><font color="red" style="font-weight:bold;"><a  style="color:#ff0000;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=0&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"2",sql.toString()+" and eatype=0 ") %></a></font></td>

  </tr>
  <tr>
    <td rowspan="2" align="right"  width="120">非盈利项目</td>
    <td rowspan="2" width="120"><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"2",sql.toString()+" and eatype=1 ") %></a></font></td>
    <td align="right"  width="120">未结款</td>
    <td><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&overallmoney=1&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"2",sql.toString()+(" and overallmoney!=0 ")+(" and eatype=1 ")) %></a></font></td>
  </tr>
  <tr>
    <td align="right"  width="120">非即时收益</td>
    <td><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&overallmoney=0&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=Flowitem.getCollect(teasession._strCommunity,"2",sql.toString()+(" and overallmoney=0 ")+(" and eatype=1 ")) %></font></td>
  </tr>
  <tr>
    <td align="right"   width="120">发放奖金合计</td>
    <td colspan="5" ><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=0&time_c=<%=time_k%>&time_d=<%=time_j%>"><%out.print( Flowitem.getCompanyProfits(teasession._strCommunity,sql.toString())[1] ); %></a></font></td>
  </tr>
  <tr>
    <td align="right"  width="120">非项目支出合计</td>
    <td colspan="5"><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/flow/ProjectNotPay.jsp"><%=spending%></a></font></td>
  </tr>
  <tr>
    <td align="right"   width="120">盈利项目利润合计</td>
    <td colspan="5" ><font color="red" style="font-weight:bold;"><a  style="color:#ff0000;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=0&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=earnings  %></a></font></td>
  </tr>
  <tr>
    <td align="right"  width="120">非盈利项目投入合计</td>
    <td colspan="5"><font color="green" style="font-weight:bold;"><a  style="color:green;font-weight:bold" href="/jsp/admin/workreport/EarningsSta.jsp?eatype=1&time_c=<%=time_k%>&time_d=<%=time_j%>"><%=NOearnings %></a></font></td>
  </tr>
  <tr>
    <td align="right"   width="120">总收益</td>
    <td colspan="5" ><font color="red" style="font-weight:bold;"><%
   //总收益（盈利项目公司总利润-非盈利项目整体投入成本-非项目支出合计，可为负值）
   out.print(earnings.subtract(NOearnings).subtract(spending));
    %></font></td>
  </tr>
</table>
</form>
</body>
</html>



