<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*"%>

<%

TeaSession teasession = new TeaSession(request);
String oceanorder=teasession.getParameter("oceanorder");


StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

String oceanorders ="";
if(teasession.getParameter("oceanorders")!=null && teasession.getParameter("oceanorders").length()>0)
{
  oceanorders= teasession.getParameter("oceanorders");
  sql.append(" and oceanorder = "+DbAdapter.cite(oceanorders));
  param.append("&oceanorders=").append(oceanorders);
}

String card = "";
if(teasession.getParameter("card")!=null && teasession.getParameter("card").length()>0)
{
  card = teasession.getParameter("card");
  sql.append(" and card = "+DbAdapter.cite(card));
  param.append("&card=").append(card);
}

if(teasession.getParameter("card")==null && teasession.getParameter("oceanorders")==null)
{
  sql.append(" and 1=2 ");
}
int count=Ocean.count(teasession._strCommunity,sql.toString());
%>
<html>
<head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<script type="">
function find_sub()
{
  if(form1.oceanorder.value=="" && form1.card.value=="" )
  {
    alert("订单号 和 证件号不能同时为空，请重新填写！");
    return false;
  }
  else
  {
    return true;
  }
}
</script>
</head>
<body bgcolor="#ffffff">

<h1>
查询制卡信息
</h1>
<form action="/jsp/ocean/OceanSearchInfo.jsp" name="form1" METHOD=POST >
<table id="tablecenter">
<tr><td>订单号：<input type="text" name="oceanorders" /></td>
</tr>
<tr><td>证件号：<input type="text" name="card" /></td>
</tr>
<tr><td><input type="submit" value="查询"  onclick="return find_sub()"/></td>
</tr>
</table>
</form>
<form action="/jsp/ocean/OceanWord.jsp"  name="form2">
<table id="tablecenter">
<tr><td>订单号</td><td>状态</td></tr>
<%
java.util.Enumeration eu = Ocean.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
if(!eu.hasMoreElements())
{
  out.print("<tr><td  colspan=6  >暂时没有信息</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
  int oid =Integer.parseInt( String.valueOf(eu.nextElement()));
  Ocean oce = Ocean.find(oid);

  //orderstatic; ///订单状态 0 没有完成交易  1 完成交易 2 完成制卡 3 完成发放
  String showinfo="";
  if(oce.getOrderstatic()==0)
  {
    showinfo="订单交易失败";
  }else   if(oce.getOrderstatic()==1)
  {
    showinfo="海洋护照正在制作中。。。";
  }else   if(oce.getOrderstatic()==2)
  {
    showinfo="您的海洋护照已经制作完成，请及时来领取。";
  }else   if(oce.getOrderstatic()==3)
  {
    showinfo="您的海洋护照已经发放，";
  }
  %>
  <tr>
    <td><%=oce.getOceanorder()%></td>
    <td><%=showinfo%></td>
</tr>
  <%
}
%>
</table>
</form>
</body>
</html>
