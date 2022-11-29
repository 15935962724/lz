<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/ui/member/profile/ProfileServlet");

String s = request.getParameter("Pos");
int i = s == null ? 0 : Integer.parseInt(s);

String sql=" AND member="+DbAdapter.cite(teasession._rv._strR);

int j = Associate.count(teasession._strCommunity,sql);


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=j%> <%=r.getString(teasession._nLanguage, "Associates")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv">
<A href="/servlet/Call?Receiver=<%=teasession._rv%>" TARGET="_blank"><%=teasession._rv%></A> >
<A href="/servlet/Profile"><%=r.getString(teasession._nLanguage, "Profile")%></A> &gt; <%=r.getString(teasession._nLanguage, "Associates")%></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <% if(j != 0)
{%>
  <tr id=tableonetr >
    <TD><%=r.getString(teasession._nLanguage, "MemberId")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Positions")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Managers")%></TD>
	<TD></TD>
  </tr>
  <%
  for(Enumeration enumeration = Associate.find(teasession._strCommunity,sql, i, 25); enumeration.hasMoreElements(); )
  {
    String s1 = (String)enumeration.nextElement();
    Associate associate = Associate.find(teasession._rv._strR, s1);
    int k = associate.getPositions();
    int l = associate.getManagers();
    int i1 = associate.getProviders0();
    int j1 = associate.getProviders1();

                    %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <TD><%=s1%></TD>

    <td>
      <% for(int k1 = 0; k1 < Associate.ASSOCIATE.length; k1++)
                        if((k & 1 << k1) != 0){
                          out.print(r.getString(teasession._nLanguage, Associate.ASSOCIATE[k1])+"&nbsp;");
                          }%></td>

    <td>      <%
      String role=tea.entity.admin.AdminUsrRole.find(s1,teasession._strCommunity).getRole();
      if(role!=null)
      {
        java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(role,"/");
        while(tokenizer_obj.hasMoreTokens())
        {
          int id=Integer.parseInt((String)tokenizer_obj.nextElement());
          tea.entity.admin.AdminRole ar_obj=tea.entity.admin.AdminRole.find(id);
          out.println(ar_obj.getName()+"&nbsp;");
        }
      }
    %></td>




      <% if(teasession._rv.isHR())
                    {%>
    <td><input name="BUTTON" type=BUTTON class="CB" id="CBEdit" onClick="window.open('/servlet/EditAssociate?Associate=<%=s1%>', '_self')" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>">
<input name="BUTTON" type=BUTTON class="CB" id="CBDelete" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteAssociate?Associate=<%=s1%>', '_self'); this.disabled=true;}" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"></td>
  </tr>
  <%                  }
                }

            }%>

        <%=new tea.htmlx.FPNL(teasession._nLanguage, "/servlet/Associates?Pos=", i, j)%>
        <%
            if(teasession._rv.isHR())
{%>

</table>
<input name="BUTTON2" type=BUTTON class="CB" id="BUTTON2" onClick="window.open('/servlet/EditAssociate', '_self');" value="<%=r.getString(teasession._nLanguage, "CBNew")%>">
<%}%>

<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

