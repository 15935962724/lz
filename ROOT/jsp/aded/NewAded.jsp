<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
            if(!teasession._rv.isAdManager())
            {
                response.sendError(403);
                return;
            }
%>



<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAdeds")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="aaaaaa">
<input type='hidden' name=vmember VALUE="aaaaaa">



<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td><%=r.getString(teasession._nLanguage, "AdingNode")%></td>
    <td><%=r.getString(teasession._nLanguage, "Style")%></td>
    <td>终端位置</td>
    <!-- 
    <td><%=r.getString(teasession._nLanguage, "StartTime")%></td>
    <td><%=r.getString(teasession._nLanguage, "StopTime")%></td>
    <td><%=r.getString(teasession._nLanguage, "CPM")%></td>
     -->
    <td colspan="2">&nbsp;</td>
  </tr><%
Iterator enumeration = Ading.find_(node, teasession._nStatus, -1, true).iterator();
while(enumeration.hasNext())
{
  //int i = ((Integer)enumeration.nextElement()).intValue();
  //Ading ading = Ading.find(i);
  Ading ading = (Ading)enumeration.next();
  int j = ading.getNode();
  int k = ading.getStyle();
  java.util.Date date = ading.getStartTime();
  java.util.Date date1 = ading.getStopTime();
  int l = ading.getCurrency();
  java.math.BigDecimal bigdecimal = ading.getCpm();
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td>"+ading.getName(teasession._nLanguage)+"</td>");
  out.print("<td>"+Node.find(j).getAnchor(teasession._nLanguage)+"</td>");
%>
<td><%=r.getString(teasession._nLanguage, Section.APPLY_STYLE[k])%></td>
<td><%=(ading.status==0?"电脑端":"手机端")%></td>

<!-- 
<td><%
if(date == null)
{
      %><%=r.getString(teasession._nLanguage, "AdingOForever")%>
<td>
<%}else{%>

   <%=(new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(date)%>
<td>
  <%=(new SimpleDateFormat("yyyy.MM.dd HH:mm")).format(date1)%>
<%}%>
<td>
  <%=r.getString(teasession._nLanguage, Common.CURRENCY[l]) + bigdecimal%>
   -->
<td>
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBContinue")%>" ID="CBContinue" CLASS="CB" onClick="window.open('/servlet/EditAded?Ading=<%=ading.ading%>&node=<%=teasession._nNode%>', '_self');">
<% }%>

</td>
      </tr>
    </table>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>



