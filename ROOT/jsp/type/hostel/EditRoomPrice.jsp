<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
/*
if(!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
}
*/

r.add("/tea/resource/Hostel");

int roomprice=0;
String RoomType="";
String Breakfast="";
String Remark="";

String Retail="0";
String Proscenium="0";
String Net="0";
String Weekend="0";
if(teasession.getParameter("roomprice")!=null)
{
roomprice=Integer.parseInt(teasession.getParameter("roomprice"));
RoomPrice roomPrice=RoomPrice.find(roomprice);
Retail=String.valueOf(roomPrice.getRetail());
RoomType=roomPrice.getRoomtype(teasession._nLanguage);
Breakfast=(roomPrice.getBreakfast(teasession._nLanguage));
Remark=roomPrice.getRemark(teasession._nLanguage);
Proscenium=String.valueOf(roomPrice.getProscenium());
Net=String.valueOf(roomPrice.getNet());
Weekend=String.valueOf(roomPrice.getWeekend());
}



%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
  <script type="">window.name="self";</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "RoomType")%></h1>
 <div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv">
<%=node.getAncestor(teasession._nLanguage)%></div>

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "RoomType")%></td>
    <td><%=r.getString(teasession._nLanguage, "Retail")%></td>
    <td><%=r.getString(teasession._nLanguage, "Proscenium")%></td>
    <td><%=r.getString(teasession._nLanguage, "Net")%></td>
    <td><%=r.getString(teasession._nLanguage, "Weekend")%></td>
    <td><%=r.getString(teasession._nLanguage, "Breakfast")%></td>
    <td><%=r.getString(teasession._nLanguage, "Remark")%></td>
	<td></td>
  </tr>
<%
java.util.Enumeration enumer=tea.entity.node.RoomPrice.findByNode(teasession._nNode);
                while (enumer.hasMoreElements())
                {
                  int id=((Integer)enumer.nextElement()).intValue();
  tea.entity.node.RoomPrice obj=  tea.entity.node.RoomPrice.find(id);
%>
  <tr>
    <td><%=obj.getRoomtype(teasession._nLanguage)%></td>
    <td><%=obj.getRetail()%></td>
    <td><%=obj.getProscenium()%></td>
    <td><%=obj.getNet()%></td>
    <td><%=obj.getWeekend()%></td>
    <td><%=obj.getBreakfast(teasession._nLanguage)%></td>
    <td><%=obj.getRemark(teasession._nLanguage)%></td>
<td><input name="Edit" value="<%=r.getString(teasession._nLanguage, "Edit")%>" type="button" onClick="window.open('/jsp/type/hostel/EditRoomPrice.jsp?node=<%=teasession._nNode%>&roomprice=<%=obj.getRoomprice()%>','self')">
<input name="Delete" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" type="button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/EditRoomPrice?node=<%=teasession._nNode%>&roomprice=<%=obj.getRoomprice()%>&delete=ON','self');}">
</td>
  </tr>
<%}
%>
</table>


<form name="form1" method="post" action="/servlet/EditRoomPrice" target="self">
<input type='hidden' name="Node" VALUE="<%=teasession._nNode%>">
<input type='hidden' name="roomprice" VALUE="<%=roomprice%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr>
<td>
<%=r.getString(teasession._nLanguage, "RoomType")%>
<td>
    <input type="text" name="roomtype" value="<%=RoomType%>">

<tr>
<td>

    <%=r.getString(teasession._nLanguage, "Retail")%><td><input type="text" name="retail" value="<%=Retail%>">

<tr>
<td>

    <%=r.getString(teasession._nLanguage, "Proscenium")%><td><input type="text" name="proscenium" value="<%=Proscenium%>">
<tr>
<td>

    <%=r.getString(teasession._nLanguage, "Net")%><td>
    <input type="text" name="net" value="<%=Net%>">
<tr>
<td>

    <%=r.getString(teasession._nLanguage, "Weekend")%><td>
    <input type="text" name="weekend" value="<%=Weekend%>">
<tr>
<td>

    <%=r.getString(teasession._nLanguage, "Breakfast")%><td>
    <input type="text" name="breakfast" value="<%=Breakfast%>">
<tr>
<td>

    <%=r.getString(teasession._nLanguage, "Remark")%><td>
    <textarea cols="60" name="remark" rows="5"><%=Remark%></textarea>
</table>
<INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

