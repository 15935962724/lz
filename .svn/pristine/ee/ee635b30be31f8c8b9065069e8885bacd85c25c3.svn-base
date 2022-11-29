<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
String oceanorder=teasession.getParameter("oceanorder");

StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();


param.append("?community="+teasession._strCommunity);
sql.append(" and orderstatic=2 ");

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
  sql.append(" and oceanorder like "+DbAdapter.cite("%"+oceanorders+"%"));
  param.append("&oceanorders=").append(oceanorders);
}
String oceancards ="";
if(teasession.getParameter("oceancards")!=null && teasession.getParameter("oceancards").length()>0)
{
  oceancards= teasession.getParameter("oceancards");
  sql.append(" and oceancard like "+DbAdapter.cite("%"+oceancards+"%"));
  param.append("&oceancards=").append(oceancards);
}

String name = "";
if(teasession.getParameter("name")!=null && teasession.getParameter("name").length()>0)
{
  name = teasession.getParameter("name");
  sql.append(" and name like "+DbAdapter.cite("%"+name+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String card = "";
if(teasession.getParameter("card")!=null && teasession.getParameter("card").length()>0)
{
  card = teasession.getParameter("card");
  sql.append(" and card like "+DbAdapter.cite("%"+card+"%"));
  param.append("&card=").append(card);
}


int passport=3;

if(teasession.getParameter("passport")!=null && teasession.getParameter("passport").length()>0)
{
  passport =Integer.parseInt(teasession.getParameter("passport"));
  if(passport!=3)
  {
    sql.append(" and passport = "+passport);
    param.append("&passport=").append(passport);
  }
}

String fa1="",fa2="";
if(teasession.getParameter("fa1")!=null && teasession.getParameter("fa1").length()>0)
{
  fa1=teasession.getParameter("fa1");
  sql.append(" and maketime >"+DbAdapter.cite(fa1));
    param.append("&fa1=").append(fa1);
}
if(teasession.getParameter("fa2")!=null && teasession.getParameter("fa2").length()>0)
{
  fa2=teasession.getParameter("fa2");
  sql.append(" and maketime <"+DbAdapter.cite(fa2));
  param.append("&fa2=").append(fa2);
}

int count=Ocean.count(teasession._strCommunity,sql.toString());
sql.append("  order by id desc " );
%>
<html>
<head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<title>
等待发放的海洋护照列表
</title>
</head>
<body bgcolor="#ffffff">
<h1>
等待发放的海洋护照列表
</h1>
<form action="/jsp/ocean/OceanRollList2.jsp" name="form1">
<table id="tablecenter">
<tr>
<td>订单号：</td><td><input type="text"  name="oceanorders" value="<%=oceanorders%>" /></td>
  <td>姓名：</td><td><input type="text" name="name" value="<%=name%>" /></td>
    <td>身份证：</td><td><input  type="text" name="card"  value="<%=card%>"/></td>
</tr>
<tr>
<td>护照类型：</td><td><select name="passport"><option value="3"
<%
if(passport==3)
{
  out.print("checked");
}
%>
>------</option><option value="0" <%
if(passport==1)
{
  out.print("checked");
}
%>>成人</option><option value="1" <%
if(passport==0)
{
  out.print("checked");
}
%>>学生</option></select></td><td>海洋护照编号：</td><td><input type="text"  name="oceancards" value="<%=oceancards%>"/></td>
</tr>
<tr><td>制卡日期：</td><td colspan="2"><input type="text" readonly="readonly" name="fa1" value="<%=fa1%>" onClick="new Calendar('1997', '2010', 0,'yyyy-MM-dd').show(this);" /> 　
  <input type="text" readonly="readonly" name="fa2" value="<%=fa2%>" onClick="new Calendar('1997', '2010', 0,'yyyy-MM-dd').show(this);" /></td><td><input type="submit"  value="查询"/></td><td></td></tr>
</table>
</form>
<form action="/servlet/EditOceanExcel"  name="form2">
<input type="hidden" name="action" value="EditOceanExcel2">
<input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="Excel">
<input type="hidden" name="count" value="<%=count%>">
<h1>列表(<%=count%>)</h1>
<table id="tablecenter">
<tr><td>订单号</td><td>姓名</td><td>身份证</td><td>护照类型</td><td>电话号码</td><td>海洋护照编号</td><td>制卡日期</td><td></td></tr>
<%
java.util.Enumeration eu = Ocean.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
if(!eu.hasMoreElements())
{
  out.print("<tr><td colspan=7 >暂时没有信息</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
  int oid =Integer.parseInt( String.valueOf(eu.nextElement()));
  Ocean oce = Ocean.find(oid);
  %>
  <tr>
    <td><a href="/jsp/ocean/Oceanfafang.jsp?show=show&ids=<%=oid%>&oceancard=<%=oce.getOceancard()%>"><%=oce.getOceanorder()%></a></td>
    <td><a href="/jsp/ocean/Oceanfafang.jsp?show=show&ids=<%=oid%>&oceancard=<%=oce.getOceancard()%>"><%=oce.getName()%></a></td>
    <td><a href="/jsp/ocean/Oceanfafang.jsp?show=show&ids=<%=oid%>&oceancard=<%=oce.getOceancard()%>"><%=oce.getCard()%></a></td>
    <td><a href="/jsp/ocean/Oceanfafang.jsp?show=show&ids=<%=oid%>&oceancard=<%=oce.getOceancard()%>"><%if(oce.getPassport()==1){out.print("学生");}else{out.print("成人");}%></a></td>
    <td><a href="/jsp/ocean/Oceanfafang.jsp?show=show&ids=<%=oid%>&oceancard=<%=oce.getOceancard()%>"><%=oce.getMobile()%></a></td>
    <td><a href="/jsp/ocean/Oceanfafang.jsp?show=show&ids=<%=oid%>&oceancard=<%=oce.getOceancard()%>"><%=oce.getOceancard()%></a></td>
    <td><a href="/jsp/ocean/Oceanfafang.jsp?show=show&ids=<%=oid%>&oceancard=<%=oce.getOceancard()%>"><%=oce.getMaketimetoString()%></a></td>
    <td><input type="button" value="护照发放" onclick="window.open('/jsp/ocean/Oceanfafang.jsp?ids=<%=oid%>&oceancard=<%=oce.getOceancard()%>','_self')"></td></tr>
  <%
}
%>
  <tr><td colspan="7"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
<tr><td colspan="7" align="center"><input type="submit"  value="导出"/></td></tr>
</table>
</form>
<%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>
