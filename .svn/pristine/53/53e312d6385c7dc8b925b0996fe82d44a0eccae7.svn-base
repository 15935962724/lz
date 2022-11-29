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
<body class="OceanPassport">
<div class="body">
    <div class="Ocean">
      <div class="Ocean_top">
      </div>
      <div class="Ocean_con">
        <div class="Ocean_bottom">
          <div class="Ocean_bottom_con">
             <div class="huzhaoxx"></div>
<form action="/jsp/ocean/OceanSearchInfo.jsp" name="form1" METHOD=POST >

<table id="huzhaocx">
<tr><td style="font-size:12px;font-weight:bold;color:#fff;">填写下列任意一组编号即可查询</td></tr>
<tr><td>*订单号：<input type="text" name="oceanorders" /></td>
</tr>
<tr><td>*证件号：<input type="text" name="card" /></td>
</tr>
<tr><td><input type="submit" value="" class="chax" onClick="return find_sub()"/></td>
</tr>
</table>
</form>
<div class="Introduction2"><a href="/jsp/ocean/OceanFlack.jsp"　target="_blank"><img src="/res/bj-sea/u/0902/090264978.jpg"/></a></div>
<input  type="button"  id="goumaihuzhao" onClick="window.open('/jsp/ocean/OceanProfile.jsp','_self')"/>
<!--/jsp/ocean/EditOceanOver.jsp-->
 </div>
        </div>
      </div>
    </div>

<div class="footer">Copyright(c)2001-2005 北京海洋馆·版权所有 地址：北京海淀区高粱桥斜街乙18号（北京动物园北门内）<br/>
定票热线：（010）62123910 网址：www.BJ-sea.com</div>
</div>
</body>
</html>
