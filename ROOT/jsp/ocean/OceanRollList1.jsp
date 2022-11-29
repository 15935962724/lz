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
sql.append(" and orderstatic=1 ");

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

String name = "";
if(teasession.getParameter("name")!=null && teasession.getParameter("name").length()>0)
{
  name = teasession.getParameter("name");
  sql.append(" and name = "+DbAdapter.cite(name));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));

//  param.append("&name=").append(name);
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
int count=Ocean.count(teasession._strCommunity,sql.toString());
sql.append("  order by id desc " );
%>
<html>
<head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<script type="">
function selectallf()
  {
    var a = document.getElementsByTagName("input");
    if(form2.selectall.checked==true)
    {
      for (var i=0; i<a.length; i++)
      {
        if (a[i].type == "checkbox" &&  (a[i].checked == false))
        {
          a[i].checked = true;
        }
      }
    }
    else
    {
      for (var i=0; i<a.length; i++)
      if (a[i].type == "checkbox" &&  (a[i].checked == true))
      {
        a[i].checked = false;
      }
    }
  }
</script>
<title>
等待制作的护照列表
</title>
</head>
<body bgcolor="#ffffff">

<h1>
等待制作的护照列表
</h1>
<form action="/jsp/ocean/OceanRollList1.jsp" name="form1" METHOD=POST >
<table id="tablecenter">
<tr>
<td>订单号：</td><td><input type="text"  name="oceanorders" value="<%=oceanorders%>" /></td><td>姓名</td><td><input type="text" name="name" value="<%=name%>" /></td><td>身份证：</td><td><input  type="text" name="card"  value="<%=card%>"/></td></tr>
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
%>>学生</option></select></td><td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>
<h1>列表(<%=count%>)</h1>
<form action="/jsp/ocean/OceanExcel.jsp"  name="form2">
<!--/jsp/ocean/OceanWord.jsp-->
<table id="tablecenter">
<tr><td>订单号</td><td>姓名</td><td>身份证</td><td>护照类型</td><td>电话号码</td><td></td></tr>
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
  %>
  <tr>
    <td><input type="checkbox" name="ids" value="<%=oid%>" /><%=oce.getOceanorder()%></td>
    <td><%=oce.getName()%></td>
    <td><%=oce.getCard()%></td>
    <td><%if(oce.getPassport()==1){out.print("学生");}else{out.print("成人");}%></td>
    <td><%=oce.getMobile()%></td>
    <td><input type="button" value="制作护照" onclick="window.open('/jsp/ocean/EditOceanRoll2.jsp?ids=<%=oid%>','_self')">
      <input type="button" value="导出word" onclick="window.open('/jsp/ocean/OceanWord.jsp?ids=<%=oid%>','_self')"></td>
</tr>
  <%
}
%>
  <tr>
    <td colspan="6"  ><input type="checkbox" name="selectall" onClick="selectallf();" class="1">全选</td>

  </tr>


  <tr><td colspan="6"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
</table>

<input type="submit" value="导出Excel" >
<!--<input type="submit" value="导出word" >-->
</form>
</body>
</html>
