<%@page contentType="text/html;charset=utf-8" %>
<%@page import="java.math.*" %>


<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.resource.Resource r=new tea.resource.Resource();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<script >
function ShowCalendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
// window.open('/jsp/type/hostel/Calendar.jsp');
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "TravelShoppings")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="/servlet/EditTravelShopping?node=<%=teasession._nNode%>">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td></td><td>名称</td><td>单价</td><td>数量</td><td>总价</td><td></td>
</tr>
<%
java.util.Enumeration enumer=tea.entity.node.TravelShopping.findBySessionid(session.getId());
while(enumer.hasMoreElements())
{
int id=((Integer)enumer.nextElement()).intValue();
tea.entity.node.TravelShopping travels=tea.entity.node.TravelShopping.find(id);
tea.entity.node.Node obj=tea.entity.node.Node.find(travels.getNode());
tea.entity.node.Travel travel=tea.entity.node.Travel.find(travels.getNode(),teasession._nLanguage);
%>
<tr>
<td><input  id="CHECKBOX" type="CHECKBOX" name="travelshopping" value="<%=id%>"/></td>
  <td>
<%=obj.getSubject(teasession._nLanguage)%>
</td>
<td><%=travel.getPrice()%>
</td>
<td><input type="text" name="<%=id%>" value="<%=travels.getCounts()%>" size="5"></td>
<td><%=new java.math.BigDecimal(travels.getCounts()).multiply(travel.getPrice())%></td>
<td>
<input type="button" value="结账" onclick="location='/jsp/type/travel/EditTravelShopping.jsp?node=<%=teasession._nNode%>&travelshopping=<%=id%>';"/>
</td>
</tr>
<%
}
%>
</table>
<input name="delete" type="submit" value="删除" onclick="return confirm('确认删除');">
<input name="alter" type="submit" value="修改数量">
</form>
 <div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

