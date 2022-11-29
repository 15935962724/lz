<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@ page import="tea.entity.admin.erp.*" %><%@ page import="tea.db.*" %>
<%


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
param.append("?id=").append(request.getParameter("id"));
String num = "";
if(teasession.getParameter("num")!=null && teasession.getParameter("num").length()>0)
{
  num=teasession.getParameter("num");
}

String statics = "";
if(teasession.getParameter("statics")!=null && teasession.getParameter("statics").length()>0)
{
  statics = teasession.getParameter("statics");
}
int lsaddtype=0;
boolean falg=false;
int idss = 0;
if(teasession.getParameter("lsaddtype")!=null && teasession.getParameter("lsaddtype").length()>0)
{
  lsaddtype = Integer.parseInt(teasession.getParameter("lsaddtype"));

  AdminUsrRole adminobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());


  if(LeagueShop.findid(adminobj.getUnit())==0)
  {
    response.sendRedirect("/jsp/leagueshop/LeagueShopInfoOver.jsp");
    return;
  }
  LeagueShop leaobjfg = LeagueShop.find(LeagueShop.findid(adminobj.getUnit()));
  idss=leaobjfg.getId();
  if(leaobjfg.isExists())
  {

  }
  else
  {
    response.sendRedirect("/jsp/leagueshop/LeagueShopInfoOver.jsp");
    return;
  }
  falg=true;
}
else
{
  response.sendRedirect("/jsp/leagueshop/LeagueShopInfoOver.jsp");
  return;
}

LeagueShop leaobj= LeagueShop.find(idss);

sql.append("  and icsales in (select icsales from icsales where leagueshop="+idss);

String time_k="",time_j="";

if(teasession.getParameter("time_k")!=null && teasession.getParameter("time_k").length()>0)
{
  time_k= teasession.getParameter("time_k");
  sql.append("  and  time>").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);
}
if(teasession.getParameter("time_j")!=null && teasession.getParameter("time_j").length()>0)
{
  time_j= teasession.getParameter("time_j");
  sql.append("  and  time<").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);

}

sql.append(")");


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = ICSalesList.count(sql.toString());
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
<title>分店销售情况</title>
</head>
<body>
<h1>分店销售情况</h1>

<h2><%=leaobj.getLsname()%>　销售记录查询</h2>

<form  name="form2" action="/jsp/leagueshop/LeagueShopMonitor2.jsp"  method="GET">
<input type="hidden" value="<%=lsaddtype%>"  name="lsaddtype"/>
<input type="hidden" value="<%=statics%>" name="statics" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>销售时间:&nbsp;从&nbsp;
      <input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onclick="showCalendar('form2.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
        <input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onclick="showCalendar('form2.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    </td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>
<h2>列表(<%=count%>)</h2>
<form action="?" name="form1" method="POST">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>商品名称</td>
    <td nowrap>销售价</td>
    <td nowrap>商品数量</td>
    <td>销售时间</td>
  </tr>
  <%
  Enumeration eu = ICSalesList.find(sql.toString(),pos,20);
  for(int i=0;eu.hasMoreElements();i++)
  {
     int icid =  Integer.parseInt(String.valueOf(eu.nextElement()));
     ICSalesList icobjlt = ICSalesList.find(icid);

     ICSales icobj = ICSales.find(icobjlt.getIcsales());
     %>
     <tr>
       <td><%=icobjlt.getName()%></td>
       <td><%=icobjlt.getPrice()%></td>
       <td><%=icobjlt.getQuantity()%></td>
       <td><%=icobj.getTimeToString()%></td>
     </tr>
     <%
   }
  %>
  <tr>
    <td colspan="6" align="center">
      <input type=button value="返回" onClick="javascript:history.back()"/>
    </td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>账户余额：</td><td colspan="3">
    <%
    BigDecimal bbsum =  new BigDecimal("2000");
    if(leaobj.getSummoney()!=null)
    {
      if(bbsum.compareTo(leaobj.getSummoney())==1)
      {
        out.print("<font color=red>"+leaobj.getSummoney()+"</font>");
      }
      else
      {
        out.print(leaobj.getSummoney().abs());
      }
    }
    else
    {
      out.print("0.00");
    }
    %>　元 　　
      </td>
  </tr>
  <tr>
    <td>提货应付金额：</td><td><%if(LeagueShopImprest.SumMoney(" and lsid="+idss+" and lsistatic=1 and type=1 ")!=null){out.print(LeagueShopImprest.SumMoney(" and lsid="+idss+" and lsistatic=1 and type=1 "));}else{out.print("0.00");}%>　元</td>
  </tr>
  <tr>
    <td>退款返还金额：</td><td><%if(LeagueShopImprest.SumMoney("  and  lsid="+idss+" and lsistatic=1 and type=0 ")!=null){out.print(LeagueShopImprest.SumMoney("  and  lsid="+idss+" and lsistatic=1 and type=0 "));}else{out.print("0.00");}%>　元</td>
  </tr>
</table>
<%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>

