<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="tea.entity.site.*"%>
<%@ page import=" tea.resource.*"%>
<%@ page import=" tea.db.DbAdapter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.member.order.*"%>
<%@ page import="tea.http.RequestHelper"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%
Resource r = new Resource();
TeaSession teasession = new TeaSession(request);
Node  node = Node.find(teasession._nNode);
%>
<html>
  <head>
  <script>
function td_calendar(fieldname)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
        </script>


  <style type="text/css">
<!--
*{font-size:9pt;}
-->
  </style>
</head>
<body  style="margin:0px;padding:0px;border:0px;">
 <div style="border-left:4px solid #000;margin:4px;padding-left:10px;color:#E0181A;font-size:14px;font-weight:600">新闻检索</div>
 <form  NAME="condition" style=" padding:0px; margin:0px" method="post" action="/servlet/Node?node=8378&Listing=3945"   target="_parent" >
   <input type="hidden" name="Node" value="24057"/>
      <input type="hidden" name="Listing" value="5114"/>
  <div style="background:#EEEEEE;padding:10px;">
    <input name="keyword" type="text" class="in" size="15">
    <select name="radiobutton">
      <option value="1">标题</option>
      <option value="2">全文</option>
    </select>
      　开始时间
      <input name="begin_date" type="text"  onclick="td_calendar('condition.begin_date');" size="15" readonly/>
结束时间<input name="end_date" type="text"  onclick="td_calendar('condition.end_date');" size="15" readonly/>
      <input name="Submit" type="image" value="Submit" src="/tea/image/section/12395.jpg" width="48" height="19">
</div>
</form>
</body>
</html>

