<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@ page import="java.util.*"%><%@ page import="tea.entity.member.*"%><%@ page import="javax.servlet.*"%><%@ page import="tea.entity.*"%><%@ page import="tea.entity.site.*"%><%@ page import="tea.html.*"%><%@ page import="tea.htmlx.*"%><%@ page import="tea.resource.Resource"%><%@ page import="tea.ui.*"%><% request.setCharacterEncoding("UTF-8");

response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin");
  return;
}

String s =request.getParameter("community");
if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
{
  response.sendError(403);
  return;
}

Http h=new Http(request,response);


Resource r = new Resource("/tea/ui/member/community/Organizers");

tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}


tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
String nr = tea.ui.node.general.NodeServlet.getButton(node,h, am,request);

String s1 =  request.getParameter("Pos");
int i = s1 == null ? 0 : Integer.parseInt(s1);
int j = Organizer.count(s);


%>
<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<%=nr%>
<h1><%=j%> <%=r.getString(teasession._nLanguage, "Organizers")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="PathDiv"><%out.print("<A href=/jsp/access/Glance.jsp?Member=" +teasession._rv+" >"+teasession._rv+"</A> ");%> ><A href="/servlet/Communities"><%=r.getString(teasession._nLanguage, "Communities")%></A> ><A href="/servlet/OrganizingCommunities"><%=r.getString(teasession._nLanguage, "OrganizingCommunities")%></A> ><%=s%>:<%=r.getString(teasession._nLanguage, "Organizers")%></div>

<FORM name=foDelete METHOD=GET action="/servlet/DeleteOrganizers">
<input type='hidden' name=community VALUE="<%=s%>">


<%          if(j != 0)
            {
              %>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
<td></td>
<td><%=r.getString(teasession._nLanguage,"MemberId")%></td>
</tr>
              <%
                for(Enumeration enumeration = Organizer.find(s, i, 25); enumeration.hasMoreElements();)
                {
                    Organizer s2 = (Organizer)enumeration.nextElement();
                    String member=s2.getMember();
                    Profile p=Profile.find(member);
                    %>
  <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td><input  id="CHECKBOX" type="CHECKBOX" name="Organizers" value="<%=s2.getMember()%>" >
        <td>
          <%
          out.print("<A href=/jsp/access/Glance.jsp?Member=" +member+" >"+member+"</A> ");
          out.print("<A href=mailto:"+p.getEmail()+" >"+p.getEmail()+"</A>");
                }
%>
			</td></tr>
    </table>
<%
            out.print(new FPNL(teasession._nLanguage,request.getRequestURI()+"?community=" + s + "&Pos=", i, j));
            }


            %>

</FORM>
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/NewOrganizers?community=<%=s%>', '_self');">
  <%        if(j != 0)
            {%>
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" iD="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');this.disabled=true;}">
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDeleteAll")%>" ID="CBDeleteAll" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>')){window.open('/servlet/DeleteAllOrganizers?community=<%=s%>', '_self');this.disabled=true;}">
  <%}%>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>


