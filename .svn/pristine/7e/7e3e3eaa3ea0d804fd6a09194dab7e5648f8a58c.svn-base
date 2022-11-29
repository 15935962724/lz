<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@include file="/jsp/Header.jsp"%>

<%

r.add("/tea/ui/site/MemberOverview");

tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);
}

Http h=new Http(request,response);



tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
String nr = tea.ui.node.general.NodeServlet.getButton(node,h, am,request);
%>


<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<script type="">
function ShowCalendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
</head>
<body>
<%=nr%>
<h1><%=r.getString(teasession._nLanguage, "CBMemberOverview")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
<td><%=r.getString(teasession._nLanguage, "Date")%></td>
<td><%=r.getString(teasession._nLanguage, "NewMembers")%></td>
<td><%=r.getString(teasession._nLanguage, "LoginMembers")%></td>
</tr>
<%long l = System.currentTimeMillis();
                int i = 0;
                do
                {
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(new Date(l - (long)i * 24L * 60L * 60L * 1000L));
                    calendar.set(11, 0);
                    calendar.set(12, 0);
                    calendar.set(13, 0);
                    java.util.Date date = calendar.getTime();
                    calendar.set(11, 23);
                    calendar.set(12, 59);
                    calendar.set(13, 59);
                    Date date1 = calendar.getTime();%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"><td><%=java.text.DateFormat.getDateInstance().format(date)%></td>
  <td><a href="/jsp/site/MemberList.jsp?action=NewMembers&date=<%= date.getTime()%>"><%=Profile.count(date, date1)%></a> </td>
  <td><a href="/jsp/site/MemberList.jsp?action=LoginMembers&date=<%= date.getTime()%>"><%=Logs.count(date, date1)%></a>
<%                  //  cell1.setAlign(3);

                } while(++i < 7);
             %>

</td></tr></table>
<form action="MemberList.jsp" method="get" name="form1">
FROM<input name="from" readonly="" type="text" id="from" size="9"><input type="button" name="Submit" value="..." onClick="ShowCalendar('form1.from')">
TO<input name="to"  readonly=""type="text" id="to" size="9"><input type="button" name="Submit" value="..." onClick="ShowCalendar('form1.to')">
ID<input name="member" type="text" id="member">
NAME<input name="name" type="text" id="name">
 <input type="submit"  value="<%=r.getString(teasession._nLanguage, "Search")%>">
 <input type="hidden" name="action" value="Search">
 <input type="hidden" name="pos" value="1">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

