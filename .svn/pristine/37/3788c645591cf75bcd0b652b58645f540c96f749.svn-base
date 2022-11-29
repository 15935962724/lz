<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

TeaSession teasession=new TeaSession(request);
StringBuffer  sql =new StringBuffer(" and ciocompany>0 and ciocompany in(select ciocompany from ciocompany where receipt=1) and backroom is not null and cometime is not null");
int sum=0,hwSum=0,dwSum=0,hmSum=0,dmSum=0;
sum=CiopCount.findSumCount(sql.toString());
hwSum=CiopCount.findSumCount("and sex=0 and room=1"+sql.toString());
dwSum=CiopCount.findSumCount("and sex=0 and room=0"+sql.toString());
hmSum=CiopCount.findSumCount("and sex=1 and room=1"+sql.toString());
dmSum=CiopCount.findSumCount("and sex=1 and room=0"+sql.toString());


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body id="qiyelog">
<h1>已安排住宿人员统计</h1>
  <div id="head6"><img height="6" src="about:blank"></div>
    <br/>


    <div id="mihu">
    <table width="40%">
    <tr>
    <td colspan="2" >共住宿人员数：<a href="/jsp/cio/CioMeetingyapfan.jsp"><%=sum%></a></td>
    </tr>
        <tr>
    <td>合住男士：<a href="/jsp/cio/CioMeetingyapfan.jsp?sex=1&room=1"><%=hmSum%></a></td><td>合住女士：<a href="/jsp/cio/CioMeetingyapfan.jsp?sex=0&room=1"><%=hwSum%></a></td>
    </tr>
        <tr>
    <td>单住男士：<a href="/jsp/cio/CioMeetingyapfan.jsp?sex=1&room=0"><%=dmSum%></a></td><td>单住女士：<a href="/jsp/cio/CioMeetingyapfan.jsp?sex=0&room=0"><%=dwSum%></a></td>
    </tr>
    </table>
    </div>
    <h2 >按日期分布需预定房间情况分析表：</h2>
    <table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'>
      <tr id='tableonetr'>
        <td id='riqi' width='15%'>日期</td>
        <td id="sum" width='15%'>共住宿人员数</td>
        <td id='hw' width='10%'>合住女士</td>
        <td id='dw' width='10%'>单住女士</td>
        <td id='hm' width='10%'>合住男士</td>
        <td id='dm' width='10%'>单住男士</td>
        <td id='dm' width='10%'>需双人标间</td>
        <td id='dm' width='10%'>需单人标间</td>
      </tr>
 <%
 Enumeration e = CiopCount.findDate(sql.toString(),0,100);
 int sumCount=0,hw=0,dw=0,hm=0,dm=0,simHouse=0,douHouse=0;
 while(e.hasMoreElements())
 {
   String d = (String)e.nextElement();
   sumCount = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0"+sql.toString());
   hw = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0 and sex=0 and room=1"+sql.toString());
   System.out.print(hw);
   dw = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0 and sex=0 and room=0"+sql.toString());
   hm = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0 and sex=1 and room=1"+sql.toString());
   dm = CiopCount.findSumCount(" and datediff(day,cometime,'"+d+"')=0 and sex=1 and room=0"+sql.toString());
   douHouse = hw/2 + hm/2;
   simHouse = (hw%2==0?dw:(dw+1)) + (hm%2==0?dm:(dm+1));
   out.print("<tr><td align=center>"+d+"</td>");
   out.print("<td align=center>"+sumCount+"</td>");
   out.print("<td align=center>"+hw+"</td>");
   out.print("<td align=center>"+dw+"</td>");
   out.print("<td align=center>"+hm+"</td>");
   out.print("<td align=center>"+dm+"</td>");
   out.print("<td align=center><a href='/jsp/cio/CioMeetingyapfan.jsp?cometime="+d+"&room=1'>"+douHouse+"</a></td>");
   out.print("<td align=center><a href='/jsp/cio/CioMeetingyapfan.jsp?cometime="+d+"&room=0'>"+simHouse+"</a></td></tr>");
 }%>
    </table>
    <div id="tablebottom_button02">
      <input type="button" value="返回" onclick="window.location.href='/jsp/cio/CioMeetingyapfan.jsp';"/>
    </div>
<div  id="tablebottom_02">说明：<br/>
统计数据仅供参考。	</div>

    <br>
    <div id="head6"><img height="6" src="about:blank"></div>
      <map name="Map"><area shape="rect" coords="208,615,361,639" href="/jsp/cio/OkCioCompan12.jsp">
      </map>
  </body>
</html>
