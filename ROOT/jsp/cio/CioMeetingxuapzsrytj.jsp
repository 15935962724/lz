<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

TeaSession teasession=new TeaSession(request);

int sum=0,hwSum=0,dwSum=0,hmSum=0,dmSum=0;
sum=CiopCount.findSumCount(" and rname is null and cometime is not null");
hwSum=CiopCount.findSumCount("and sex=0 and room=1 and rname is null and cometime is not null");
dwSum=CiopCount.findSumCount("and sex=0 and room=0 and rname is null and cometime is not null");
hmSum=CiopCount.findSumCount("and sex=1 and room=1 and rname is null and cometime is not null");
dmSum=CiopCount.findSumCount("and sex=1 and room=0 and rname is null and cometime is not null");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="">
  function f_action(act,ccid)
  {
    switch(act)
    {
      case "go":
      form1.action="?";
      form1.method="get";
      break;
      case "delete":
      if(!confirm("确认删除?"))
      {
        return false;
      }
      break;
    }
    form1.ciocompany.value=ccid;
    form1.act.value=act;
    form1.submit();
  }
  </script>
  </head>
  <body id="qiyelog">
<h1>需安排住宿人员统计</h1>
  <div id="head6"><img height="6" src="about:blank"></div>
    <br/>

    <div id="mihu">
    <table width="40%">
    <tr>
    <td colspan="2" >共住宿人员数：<a href="/jsp/cio/EditRoomCioPart.jsp"><%=sum%></a></td>
    </tr>
        <tr>
    <td>合住男士：<a href="/jsp/cio/EditRoomCioPart.jsp?room=1&sex=1"><%=hmSum%></a></td><td>合住女士：<a href="/jsp/cio/EditRoomCioPart.jsp?room=1&sex=0"><%=hwSum%></a></td>
    </tr>
        <tr>
    <td>单住男士：<a href="/jsp/cio/EditRoomCioPart.jsp?room=0&sex=1"><%=dmSum%></a></td><td>单住女士：<a href="/jsp/cio/EditRoomCioPart.jsp?room=0&sex=0"><%=dwSum%></a></td>
    </tr>
    </table>
    </div>
    <h2 >按日期分布需预定房间情况分析表：</h2>
    <table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'>

      <tr id='tableonetr'>
        <td id='riqi' width='20%'>日期</td>
        <td id="sum" width='20%'>共住宿人员数</td>
        <td id='hw' width='10%'>合住女士</td>
        <td id='dw' width='10%'>单住女士</td>
        <td id='hm' width='10%'>合住男士</td>
        <td id='dm' width='10%'>单住男士</td>
      </tr>
  <% Enumeration e = CiopCount.findDate(" and rname is null and cometime is not null",0,0);
  int sumCount=0,hw=0,dw=0,hm=0,dm=0;
    while(e.hasMoreElements()){
      String d = (String)e.nextElement();
      sumCount = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0 and rname is null");
      hw = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0 and sex=0 and room=1 and rname is null and cometime is not null");
      dw = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0 and sex=0 and room=0 and rname is null and cometime is not null");
      hm = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0 and sex=1 and room=1 and rname is null and cometime is not null");
      dm = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0 and sex=1 and room=0 and rname is null and cometime is not null");
      out.print("<tr><td align=center>"+d+"</td>");
      out.print("<td align=center>"+sumCount+"</td>");
      out.print("<td align=center>"+hw+"</td>");
      out.print("<td align=center>"+dw+"</td>");
      out.print("<td align=center>"+hm+"</td>");
      out.print("<td align=center>"+dm+"</td></tr>");
    }%>
    </table>
    <div id="tablebottom_button02">
      <input type="button" value="返回" onclick="history.back();"/>
    </div>
<div  id="tablebottom_02">说明：<br/>
统计数据仅供参考。	</div>

    <br>
    <div id="head6"><img height="6" src="about:blank"></div>
      <map name="Map"><area shape="rect" coords="208,615,361,639" href="/jsp/cio/OkCioCompan12.jsp">
      </map>
  </body>
</html>
