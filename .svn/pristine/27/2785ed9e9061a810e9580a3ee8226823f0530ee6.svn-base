<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/community/Communities");

String s =  request.getParameter("Community");
if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s) && !teasession._rv.isManager(s))
{
  response.sendError(403);
  return;
}


String s1 =  request.getParameter("Pos");
int i = s1 != null ? Integer.parseInt(s1) : 0;
int j = GrantAccess.count(s);




%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Manager")%></h1>
<div id="head6"><img height="6" alt=""></div>

  <FORM name=foDelete METHOD=GET action="/servlet/DeleteGrant">
    <input type='hidden' name=Community VALUE="<%=s%>">
	<h2 hu="hu"><%=j%> <%=r.getString(teasession._nLanguage, "InPower")%></h2>
    <table cellspacing="0" id="tablecenter">
      <tr id="TableCaption">

      </tr>
      <tr>
        <td class="listing"><table cellspacing="0" cellpadding="0" class="listings">
            <%
            if(j != 0)
            {

              Row row;
              for(Enumeration enumeration = GrantAccess.find(s, i, 25); enumeration.hasMoreElements(); )
              {
                String s2 = (String)enumeration.nextElement();
%>
            <tr>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name="<%=s2%>" value=null></TD>
              <%--<td> <A href="/servlet/Glance?Member=webmaster" ID=MemberOnline>webmaster</A>
<A href="/servlet/Call?Receiver=webmaster" TARGET="_blank">
<IMG BORDER=0 SRC="/tea/image/Call.gif"></A>
<A href="/servlet/NewMessage?receiver=webmaster" TARGET="_blank">webmaster</A>
<A href="/servlet/NewMessage?receiver=support@website" TARGET="_blank">support@website</A>
 </td>--%>
              <%=new Cell(ts.getRvDetail(s2,s,teasession._nLanguage))%>
              <input type='hidden' name=Organizers VALUE="<%=s2%>">
              <%
                }
            }
            out.print(new FPNL(teasession._nLanguage, "/servlet/Manager?Community=" + s + "&Pos=", i, j));
%>
            </tr>
          </table></td>
      </tr>
    </table>
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/NewAccess?Community=<%=s%>', '_self');">
    <%          if(j != 0)
            {%>
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');}">
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDeleteAll")%>" ID="CBDeleteAll" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>')){window.open('/servlet/DeleteAllGrant?Community=<%=s%>', '_self');}">
    <%          }%>
  </form>
  <h2 hu="hu"><%=j%> <%=r.getString(teasession._nLanguage, "NoInPower")%></h2>
  <table cellspacing="0" id="tablecenter">
    <tr id="TableCaption">

    </tr>
    <tr>
      <td class="listing"><table cellspacing="0" cellpadding="0" class="listings">
          <%

                Row row1;
                for(Enumeration enumeration = GrantAccess.find(s, i, 25,false); enumeration.hasMoreElements();)
                {
                    String s2 = (String)enumeration.nextElement();
%>
          <tr ID=OddRow>
            <TD><%=new Cell(ts.getRvDetail(s2,s, teasession._nLanguage))%>
              <input type='hidden' name=Organizers VALUE="<%=s2%>">
              <%
                }
%>
            </TD>
          </tr>
        </table></td>
    </tr>
  </table>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>


