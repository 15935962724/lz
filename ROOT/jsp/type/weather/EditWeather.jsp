<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

if(!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(14))
{
  response.sendError(403);
  return;
}

Weather aweather[] = new Weather[Weather.DAY_TYPE.length];
Calendar calendar = Calendar.getInstance();
calendar.setTime(new Date(System.currentTimeMillis()));
calendar.set(11, 0);
calendar.set(12, 0);
calendar.set(13, 0);
calendar.set(14, 0);
int i = 0;
do
{
  aweather[i] = Weather.find(teasession._nNode, calendar.getTime());
  calendar.add(5, 1);
} while(++i < Weather.DAY_TYPE.length);
StringBuffer stringbuffer = new StringBuffer();
int k = 0;
do
stringbuffer.append("&&submitInteger(this.Low" + k + ", '" + r.getString(teasession._nLanguage, "InvalidLowTemp") + "')" + "&&submitInteger(this.High" + k + ", '" + r.getString(teasession._nLanguage, "InvalidHighTemp") + "')");
while(++k < Weather.DAY_TYPE.length);

r.add("/tea/resource/Weather");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Weather")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM name=foEdit METHOD=POST action="/servlet/EditWeather" onSubmit="return(true<%=stringbuffer.toString()%>);">
<input type='hidden' name=Node VALUE="<%=teasession._nNode%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
  <td><%=r.getString(teasession._nLanguage, "Date")%></td>
  <td><%=r.getString(teasession._nLanguage, "Type")%></td>
  <td><%=r.getString(teasession._nLanguage, "LowTemp")%></td>
  <td><%=r.getString(teasession._nLanguage, "HighTemp")%></td>
  <td><%=r.getString(teasession._nLanguage, "Wind")%></td>
</tr>
<%
for(int j=0;j<Weather.DAY_TYPE.length;j++)
{
  %>
  <tr>
    <td><%=Weather.sdf.format( aweather[j].getTime() )%></td>
    <td>
    <%
    out.print("<select name=Type0"+j+">");
    for(int index=0;index<Weather.WEATHER_TYPE.length;index++)
    {
      out.print("<option value="+index);
      if(index==aweather[j].getType())
      out.print(" selected ");
      out.print(" >"+r.getString(teasession._nLanguage, Weather.WEATHER_TYPE[index]));
    }
    out.print("</select>"+r.getString(teasession._nLanguage,"WeatherChange"));

    out.print("<select name=Type1"+j+">");
    for(int index=0;index<Weather.WEATHER_TYPE.length;index++)
    {
      out.print("<option value="+index);
      if(index==aweather[j].getType2())
      out.print(" selected ");
      out.print(" >"+r.getString(teasession._nLanguage, Weather.WEATHER_TYPE[index]));
    }
    out.print("</select>");
    %>
    </td>
    <td><input type="TEXT"  name="Low<%=j%>" size="5" VALUE="<%=aweather[j].getLow()%>"></td>
      <td><input type="TEXT"  name="High<%=j%>" size="5" VALUE="<%=aweather[j].getHigh()%>"></td>
        <td><input type="TEXT"  name="Wind<%=j%>" size="40" VALUE="<%if(aweather[j].getWind()!=null)out.print(aweather[j].getWind());%>"></td>
  </tr>
  <%}%>


  </table>
  <P ALIGN=CENTER>
    <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
  </P>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>
