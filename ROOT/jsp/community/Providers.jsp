<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/community/Providers");

String s =  request.getParameter("community");
if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
{
  response.sendError(403);
  return;
}

String s1 =  request.getParameter("Pos");
int i = s1 == null ? 0 : Integer.parseInt(s1);
int j = tea.entity.site.Provider.count(s);
%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=j%> <%=r.getString(teasession._nLanguage, "Providers")%></h1>
 <div id="head6"><img height="6" src="about:blank"></div>
 <div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%> ><A href="/servlet/Communities"><%=r.getString(teasession._nLanguage, "Communities")%></A> ><A href="/servlet/OrganizingCommunities"><%=r.getString(teasession._nLanguage, "OrganizingCommunities")%></A> ><%=s%>:<%=r.getString(teasession._nLanguage, "Providers")%></div>
      <FORM name=foDelete METHOD=GET action="/servlet/DeleteProviders">
      <input type='hidden' name=community VALUE="<%=s%>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <%
            if(j != 0)
            {
                Row row;
                for(Enumeration enumeration = tea.entity.site.Provider.find(s, i, 25); enumeration.hasMoreElements(); )
                {
                    String s2 = (String)enumeration.nextElement();
                    tea.entity.site.Provider provider = tea.entity.site.Provider.find(s, s2);
                    int k = provider.getProviders0();
                    int l = provider.getProviders1();
                 %>
            <tr >
              <td><input  id="CHECKBOX" type="CHECKBOX" name=<%=s2%> value=null></td>
              <%=new Cell(ts.getRvDetail(s2,s, teasession._nLanguage))%>
              <input type='hidden' name=Providers VALUE="<%=s2%>">
              <td><%
                    for(int i1 = 0; i1 < Node.NODE_TYPE.length; i1++)
                        if(((i1 < 32 ? k : l) & 1 << i1 % 32) != 0)
                            out.println(""+r.getString(teasession._nLanguage, Node.NODE_TYPE[i1]) + "  ");
%>
              <td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/community/EditProvider.jsp?community=<%=s%>&Member=<%=s2%>', '_self');"></td>
            </tr>
            <%
                }

            }
%>
          </table>
    </FORM>

  <%=new FPNL(teasession._nLanguage, "/servlet/Providers?Community=" + s + "&Pos=", i, j)%>
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/jsp/community/EditProvider.jsp?community=<%=s%>', '_self');">
  <%            if(j != 0)
            {%>
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');}">
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDeleteAll")%>" ID="CBDeleteAll" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>')){window.open('/servlet/DeleteAllProviders?community=<%=s%>', '_self');}">
  <%}%>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>


