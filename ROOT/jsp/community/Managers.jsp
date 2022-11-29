<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/community/Communities");
         String s;
        s =  request.getParameter("Community");
        if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
        {
             response.sendError(403);
            return;
        }
			String s1 =  request.getParameter("Pos");
            int i = s1 != null ? Integer.parseInt(s1) : 0;
            int j = Organizer.count(s);

%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Manager")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(teasession._nLanguage, "Manager")%></h2>

<FORM name=foDelete METHOD=GET action="/servlet/DeleteManager">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <input type='hidden' name=Community VALUE="<%=s%>">

      
      <%
     if(j != 0)
            {
                boolean flag = true;
                Row row;
                for(Enumeration enumeration = tea.entity.site.Manager.find(s, i, 25); enumeration.hasMoreElements();)
                {
                    String s2 = (String)enumeration.nextElement();%>

            <tr>
              <TD><input  id="CHECKBOX" type="CHECKBOX" name=<%=s2%> value=null></TD>

        <td><%-- <A href="/servlet/Glance?Member=<%=s2%>" ID=MemberOnline>webmaster</A> <A href="/servlet/Call?Receiver=<%=s2%>" TARGET="_blank">
<IMG BORDER=0 SRC="/tea/image/Call.gif"></A> <A href="/servlet/NewMessage?receiver=<%=s2%>" TARGET="_blank">webmaster</A> <A href="/servlet/NewMessage?Receiver=support@website" TARGET="_blank">support@website</A> </td>
<input type='hidden' name=Organizers VALUE="webmaster">--%>
          <%=s2%><%//=ts.getRvDetail(s2, teasession._nLanguage)%>
          <input type='hidden' name=Organizers value=<%=s2%>>
          <%

                   // row.setId(flag ? "OddRow" : "EvenRow");
                    flag = !flag;
                }
            }
 out.print(new FPNL(teasession._nLanguage, "Manager?Community=" + s + "&Pos=", i, j));
%> </tr>
  </table>
      </form>
      
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/NewManager?Community=<%=s%>', '_self');">
  <%       if(j != 0)
            {%>
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');}">
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDeleteAll")%>" ID="CBDeleteAll" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>')){window.open('/servlet/DeleteAllManager?Community=<%=s%>', '_self');}">
  <%        }%>

<h2><%=r.getString(teasession._nLanguage, "User")%></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     
   
    <%
                for(Enumeration enumeration = tea.entity.site.Manager.find(s, i, 25,false); enumeration.hasMoreElements(); )
                {
                    String s2 = (String)enumeration.nextElement();%>
          <tr >
            <td nowrap><%=s2%><%//=ts.getRvDetail(s2, teasession._nLanguage)%>
              <input type='hidden' name=Organizers value=<%=s2%>></TD>  </tr>
              <%
                }
%>

        </table>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>


</body>
</html>


