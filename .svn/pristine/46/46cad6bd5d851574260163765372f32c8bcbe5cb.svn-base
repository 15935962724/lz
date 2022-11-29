<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/include/Header.jsp"%>

<%


if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(49))
  {
    response.sendError(403);
    return;
  }
}

  r.add("/tea/resource/Flight");


  String mark,week,types,start,terminus,eat,remark,logo;
  java.util.Date takeoff,descent;
  float price=0.0f,tax=0.0f;
int startaerodrome=0,terminusaerodrome=0,company=0,fly=0;
boolean nonstop=true;

  tea.entity.node.Flight flight=tea.entity.node.Flight.find(teasession._nNode);
  if(flight.isExists())
  {
    mark=flight.getMark();
    week=flight.getWeek();
    types=flight.getTypes(teasession._nLanguage);
    start=flight.getStart(teasession._nLanguage);
    terminus=flight.getTerminus(teasession._nLanguage);
    takeoff=flight.getTakeoff();
    descent= flight.getDescent();
    eat=flight.getEat(teasession._nLanguage);
    remark=flight.getRemark(teasession._nLanguage);
    price=flight.getPrice();
    logo=flight.getLogo();
    tax=flight.getTax();
    startaerodrome=flight.getStartaerodrome();
    terminusaerodrome=flight.getTerminusaerodrome();
    company=flight.getCompany();
    nonstop=flight.isNonstop();
    fly=flight.getFly();
  }else
  {
    takeoff=descent=null;
    mark=week=types=start=terminus=eat=remark=logo="";
  }

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditFlight")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
<%--
java.util.Enumeration enumeration=tea.entity.node.Flight.findByNode(teasession._nNode);
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
      <td><%=r.getString(teasession._nLanguage, "FlightCode")%></td>
      <td><%=r.getString(teasession._nLanguage, "AeronefType")%></td>
      <td><%=r.getString(teasession._nLanguage, "Course")%></td>
      <td><%=r.getString(teasession._nLanguage, "Takeoff")%></td>
      <td><%=r.getString(teasession._nLanguage, "Descent")%></td>
      <td><%=r.getString(teasession._nLanguage, "Eat")%></td>
    <td>&nbsp;</td>
  </tr>
        <%
while(enumeration.hasMoreElements())
{
  int id_temp=((Integer)enumeration.nextElement()).intValue();
  tea.entity.node.Flight flightObj=tea.entity.node.Flight.find(id_temp);
%>
<tr>
    <td><%if(id_temp==flightCode)out.print("<font color=\"#FF0000\">");out.print(flightObj.getMark());%></td>
    <td><%=flightObj.getTypes(teasession._nLanguage)%></td>
    <td><%=flightObj.getStart(teasession._nLanguage)%>--<%=flightObj.getTerminus(teasession._nLanguage)%></td>
    <td><%=flightObj.getTakeoffToString()%></td>
    <td><%=flightObj.getDescentToString()%></td>
    <td><%=flightObj.getEat(teasession._nLanguage)%></td>
    <td>
     <input type=button class="edit_button"value="<%=r.getString(teasession._nLanguage, "Berth")%>" onclick="location='/jsp/type/ticket/EditBerth.jsp?node=<%=teasession._nNode%>&flight=<%=id_temp%>';">

     <input name="button" type=button class="edit_button" onClick="window.open('EditFlight.jsp?node=<%=teasession._nNode%>&flight=<%=flightObj.getFlight()%>','_self')" value="<%=r.getString(teasession._nLanguage, "Edit")%>">
     <input name="button" type=button class="edit_button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/EditTicket?node=<%=teasession._nNode%>&flight=<%=flightObj.getFlight()%>&delete=ON','_self');}" value="<%=r.getString(teasession._nLanguage, "Delete")%>">
    </td>
</tr><%}%>
</table>
--%>
<form name=f1 action="/servlet/EditTicket?node=<%=teasession._nNode%>" method="post"  ENCtype=multipart/form-data   onsubmit="return(submitIdentifier(this.mark, '<%=r.getString(teasession._nLanguage, "InvalidParamter")%>')&&submitFloat(this.price, '<%=r.getString(teasession._nLanguage, "Price")%>'))">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Name")%>:</td>
      <td><input type="text" name="name" value="<%=node.getSubject(teasession._nLanguage)%>"></td>
    </tr>
    <tr>
      <td nowrap>Logo:</td>
      <td>  <INPUT TYPE=FILE NAME=logo  class="edit_input"><%=r.getString(teasession._nLanguage, "Or")%><input type="text" name="logopath" value="<%=logo%>" size="30"/>
</td>
    </tr>


    <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "FlightCode")%></td>
        <td><input name="mark" type="text" id="mark" value="<%=mark%>" size="40"></td>
      </tr>
    <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "AeronefType")%></td>
    <td><input name="types" type="text" id="types" value="<%=types%>"></td>
  </tr>
    <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Course")%></td>
    <td><input name="start" type="text" id="start" value="<%=start%>" size=20>
    --<input name="terminus" type="text" id="terminus" value="<%=terminus%>" size=20>
    </td>
    </tr>
	    <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Date")%></td>
    <td>
      <input name="week7"  id="CHECKBOX" type="CHECKBOX" value="7"<%if(week.indexOf("/7/")!=-1)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "Sunday")%>
      <input name="week1"  id="CHECKBOX" type="CHECKBOX" value="1"<%if(week.indexOf("/1/")!=-1)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "Monday")%>
      <input name="week2"  id="CHECKBOX" type="CHECKBOX" value="2"<%if(week.indexOf("/2/")!=-1)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "Tuesday")%>
      <input name="week3"  id="CHECKBOX" type="CHECKBOX" value="3"<%if(week.indexOf("/3/")!=-1)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "Wednesday")%>
      <input name="week4"  id="CHECKBOX" type="CHECKBOX" value="4"<%if(week.indexOf("/4/")!=-1)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "Thursday")%>
      <input name="week5"  id="CHECKBOX" type="CHECKBOX" value="5"<%if(week.indexOf("/5/")!=-1)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "Friday")%>
      <input name="week6"  id="CHECKBOX" type="CHECKBOX" value="6"<%if(week.indexOf("/6/")!=-1)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "Saturday")%>
    </td>
    </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Takeoff")%></td>
    <td>
	<select name="takeoffhour">
        <%
        java.util.Calendar c=java.util.Calendar.getInstance();
        if(takeoff!=null)
        c.setTime(takeoff);
        for(int index=0;index<24;index++)
        {
          out.print("<option value="+index);
          if(index==          c.get(java.util.Calendar.HOUR_OF_DAY))
          out.print(" SELECTED");
          out.print(">"+index);
        }
        %>
	</select>时
	<select name="takeoffminute">
                <%
        for(int index=0;index<60;index=index+5)
        {
          out.print("<option value="+index);
                    if(index==          c.get(java.util.Calendar.MINUTE))
          out.print(" SELECTED");
          out.print(">"+index);
        }
        %>
	</select>分&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<B><%=r.getString(teasession._nLanguage, "Aerodrome")%>:</B>
	<select name="startaerodrome" >
	<option value="0" selected="selected">-------------</option>
        <%
java.util.Enumeration enumer_startaerodrome=  tea.entity.site.Aerodrome.findByCommunity(node.getCommunity());
while(enumer_startaerodrome.hasMoreElements())
{
int id=((Integer)enumer_startaerodrome.nextElement()).intValue();
tea.entity.site.Aerodrome obj=tea.entity.site.Aerodrome.find(id);
out.print("<option ");
if(startaerodrome==id)
out.print("selected ");
out.print("value="+id+">"+obj.getName(teasession._nLanguage)+"</option> ");

}%>
	</select>
</td>

  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Descent")%></td>
    <td>
    	<select name="descenthour">
        <%
             if(descent!=null)
        c.setTime(descent);
        for(int index=0;index<24;index++)
        {
          out.print("<option value="+index);
                    if(index==          c.get(java.util.Calendar.HOUR_OF_DAY))
          out.print(" SELECTED");
          out.print(">"+index);
        }
        %>
	</select>时
	<select name="descentminute">
                <%

        for(int index=0;index<60;index=index+5)
        {
          out.print("<option value="+index);
                              if(index==          c.get(java.util.Calendar.MINUTE))
          out.print(" SELECTED");
          out.print(">"+index);
        }
        %>
	</select>
	分&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <B> <%=r.getString(teasession._nLanguage, "Aerodrome")%>: </B>
		<select name="terminusaerodrome" >
	<option value="0">-------------</option>
        <%
java.util.Enumeration enumer_terminusaerodrome=  tea.entity.site.Aerodrome.findByCommunity(node.getCommunity());
while(enumer_terminusaerodrome.hasMoreElements())
{
int id=((Integer)enumer_terminusaerodrome.nextElement()).intValue();
tea.entity.site.Aerodrome obj=tea.entity.site.Aerodrome.find(id);
out.print("<option ");
if(terminusaerodrome==id)
out.print("selected ");
out.print("value="+id+">"+obj.getName(teasession._nLanguage)+"</option> ");

}%>
	</select>
	</select>
<input type="button" value="<%=r.getString(teasession._nLanguage, "All")%>" onClick="location='/jsp/type/flight/Aerodromes.jsp?node=<%=teasession._nNode%>';"/>
</td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Eat")%></td>
    <td><input type="text" name="eat" value="<%=eat%>"></td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Remark")%></td>
    <td><textarea  name="remark" cols="70" rows="4" class="edit_input" id="remark"><%=remark%></textarea>
	</td>
  </tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "Price")%>:</td>
        <td><input type="text" name="price" value="<%=price%>">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><%=r.getString(teasession._nLanguage, "Tax")%>:</b><input type="text" name="tax" value="<%=tax%>">
		</td>
      </tr>
	      <tr>
        <td height="23" nowrap><%=r.getString(teasession._nLanguage, "Company")%>:</td>
        <td>
		<select name="company" >
	<option value="0">-------------</option>
        <%
java.util.Enumeration enumer=        tea.entity.node.Node.findByType(21,node.getCommunity());
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  tea.entity.node.Node node=  tea.entity.node.Node.find(id);
  %>
  <option value="<%=id%>" <%=getSelect(company==id)%>><%=node.getSubject(teasession._nLanguage)%></option>
<%}    %>
	</select>
		</td>
      </tr>
	  <tr><td><%=r.getString(teasession._nLanguage, "Nonstop")%>:</td>
	  <td><input name="nonstop"  id="CHECKBOX" type="CHECKBOX" value="" <%=getCheck(nonstop)%>></td>
	  </tr>
	  <tr><td><%=r.getString(teasession._nLanguage, "FlyType")%>:</td>
	  <td><input name="fly"  id="radio" type="radio" value="0"  checked="checked"><%=r.getString(teasession._nLanguage, "OneWay")%>
          <input name="fly"  id="radio" type="radio" value="1"  <%=getCheck(fly==1)%>><%=r.getString(teasession._nLanguage, "Cruise")%>
          <input name="fly"  id="radio" type="radio" value="2"  <%=getCheck(fly==2)%>><%=r.getString(teasession._nLanguage, "Linkage")%>
          </td>
	  </tr>

</table>
<INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
  <input type=SUBMIT name="GoNext" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>" >
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
</form>
<script>document.f1.name.focus()</script>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

