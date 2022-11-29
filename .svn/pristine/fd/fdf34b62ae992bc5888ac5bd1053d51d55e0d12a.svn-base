<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

r.add("/tea/ui/member/request/Requests").add("/tea/ui/member/request/AdRequests");
if(!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
}

String s =  request.getParameter("Pos");
int i = s != null ? Integer.parseInt(s) : 0;
int j = Aded.countRequests(teasession._nNode);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "AdRequests")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr>
    <td> <div id="PathDiv">
      <%=ts.hrefGlance(teasession._rv)%> ><A HREF="/servlet/Requests"><%=r.getString(teasession._nLanguage, "Requests")%></A> ><A HREF="/servlet/AdRequestNodes"><%=r.getString(teasession._nLanguage, "AdRequestNodes")%></A> ><%=r.getString(teasession._nLanguage, "AdRequests")%>
      <FORM name=foGrant METHOD=POST action="/servlet/GrantAdRequests">
        <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
          <tr>
            <td ><%=j%> <%=r.getString(teasession._nLanguage, "AdRequests")%></TD>
          </tr>
          <tr>
            <td> <%
 if(j != 0)
{%>
              <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
              <input type='hidden' name=Pos VALUE="<%=i%>">
              <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
                <tr>
                  <TD> <%=r.getString(teasession._nLanguage, "Ad")%>
                  <TD><%=r.getString(teasession._nLanguage, "Sponsor")%>
                  <TD><%=r.getString(teasession._nLanguage, "Time")%>
                  <TD><%=r.getString(teasession._nLanguage, "StartTime")%>
                  <TD><%=r.getString(teasession._nLanguage, "StopTime")%>
                    <%
 for(Enumeration enumeration = Aded.findRequests(teasession._nNode, i, 25); enumeration.hasMoreElements(); )
{
                    int k = ((Integer)enumeration.nextElement()).intValue();
                    Aded aded = Aded.find(k);
                    String s1 = aded.getAlt(teasession._nLanguage);
                    aded.getClickUrl(teasession._nLanguage);
                    String s2 = aded.getPictureUrl(teasession._nLanguage);
                    if(s2!=null&&s2.length() == 0)
                        s2 = "AdedPicture?node=" + teasession._nNode + "&Aded=" + k;%>
                <tr>
                  <td> <input type='hidden' name=AdRequests VALUE="<%=k%>">
                    <input  id="CHECKBOX" type="CHECKBOX" name=<%=Integer.toString(k)%> value=null checked >
                    <%--
<A href="/servlet/Aded?node=<%=teasession._nNode+%>&Aded=<%=k%>" ></A> >--%> </td>
                  <td><%=new Anchor("/servlet/Aded?node=" + teasession._nNode + "&Aded=" + k, new tea.html.Image(s2, s1))%> <%=ts.hrefGlance(aded.getCreator())%> </td>
                  <td> <%=(new SimpleDateFormat("MM.dd HH:mm")).format(aded.getTime())%> </td>
                  <%                    java.util.Date date = aded.getStartTime();
                    if(date == null)
                    {%>
                  <td> <%=r.getString(teasession._nLanguage, "Forever")%>
                    <%} else
                    {%>
                  <td> <%=(new SimpleDateFormat("MM.dd HH:mm")).format(date)%>
                  <td><%=(new SimpleDateFormat("MM.dd HH:mm")).format(aded.getStopTime())%>
                    <%    }
                }%>
              </table>
              <%=new GrantDeny(teasession._nLanguage)%>
              <%
}
%></td>
          </tr>
        </table>
      </form>
  </tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

