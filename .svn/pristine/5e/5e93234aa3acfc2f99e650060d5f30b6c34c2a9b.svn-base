<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
if(!teasession._rv.isSupport())
{
      response.sendError(403);
      return;
}

Resource r=new Resource("/tea/ui/member/messagefolder/ManageMessageFolders");

String s = request.getParameter("MessageFolder");
String s1 = MessageFolder.getMember(s);
int i = MessageFolder.getType(s);
int j = MessageFolder.getOptions(s);
boolean flag = s1.equals(teasession._rv._strR);
byte byte0 = 100;

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "MessageFolderSubscribers")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>



    <%
if(flag)
{   MessageFolder messagefolder = MessageFolder.find(teasession._rv._strR, s);
    String s2 = messagefolder.getName(teasession._nLanguage);
	String s4 = request.getParameter("Pos");
	int k = s4 != null ? Integer.parseInt(s4) : 0;
	int i1 = MessageFolder.count(s);
	%>
    <div id="PathDiv"> <%=TeaServlet.hrefGlance(teasession._rv)%> ><A href="/servlet/ManageMessageFolders"><%=r.getString(teasession._nLanguage, "ManageFolders")%></A> ><A href="/servlet/MessageFolderContents?MessageFolder=<%=s%>" TARGET="_self"><%=s2%></A> </div>

    <FORM name=foDelete METHOD=GET action="/servlet/DeleteMessageFolderSubscribers">
          <input type='hidden' name=MessageFolder VALUE="<%=s%>">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td COLSPAN=10><%=i1%> <%=r.getString(teasession._nLanguage, "MessageFolderSubscribers")%></td>
            </tr>
            <%
    if(i1 != 0)
    {
        boolean flag1 = true;
        Row row = new Row();
        %>
            <tr ID=tableonetr>
              <td><%=r.getString(teasession._nLanguage, "To")%>
              <td><%=r.getString(teasession._nLanguage, "CcMembers")%>
              <td><%=r.getString(teasession._nLanguage, "Bcc")%>
              <td><%=r.getString(teasession._nLanguage, "Delete")%>
                <%      for(Enumeration enumeration = MessageFolder.findSubscribers(s, k, byte0); enumeration.hasMoreElements();)
        {
                    RV rv1 = (RV)enumeration.nextElement();
                    String s6 = rv1.toString();
%>
            <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
              <td><input  id="CHECKBOX" type="CHECKBOX" name=to value="<%=s6%>">
              <td><input  id="CHECKBOX" type="CHECKBOX" name=cc value="<%=s6%>">
              <td><input  id="CHECKBOX" type="CHECKBOX" name=bcc value="<%=s6%>">
              <td><input  id="CHECKBOX" type="CHECKBOX" name="<%=s6%>">
              <td><%=TeaServlet.getRvDetail(rv1, teasession._nLanguage)%>
                <input type='hidden' name=MessageFolderSubscribers VALUE="<%=s6%>">
                <%

         }
     }
%>
          </table>
        </FORM>
        <%=new tea.htmlx.FPNL(teasession._nLanguage, "/servlet/MessageFolderSubscribers?MessageFolder="+s+"&Pos=", k, i1, byte0)%>
        <%   if(i1 != 0)
      {%>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');}">
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBInsertMemberID")%>" ID="CBInsertMemberID" CLASS="CB" onClick="window.open('javascript:insertMemberID();', '_self');">
        <% }%>
        <%
}else
if(i != 0)
{
     MessageFolder messagefolder1 = MessageFolder.find(s1, s);
     String s3 = messagefolder1.getName(teasession._nLanguage);
%>
    <tr>
      <td><div id="PathDiv">
        <%=TeaServlet.hrefGlance(new RV(s1, s1))%> ><A href="/servlet/ManageMessageFolders"><%=r.getString(teasession._nLanguage, "ManageFolders")%></A> ><A href="/servlet/MessageFolderContents?MessageFolder=<%=s%>" TARGET="_self"><%=s3%></A>
        <%
     String s5 = request.getParameter("Pos");
     int l = s5 != null ? Integer.parseInt(s5) : 0;
     int j1 = MessageFolder.count(s);
%>
        <FORM name=foDelete METHOD=GET action="/servlet/DeleteMessageFolderSubscribers">
          <input type='hidden' name=MessageFolder VALUE="<%=s%>">
          <table cellspacing="5" cellpadding="0">
            <tr>
              <td COLSPAN=10><%=j1%> <%=r.getString(teasession._nLanguage, "MessageFolderSubscribers")%></td>
            </tr>
            <%   if(j1 != 0)
     {
         boolean flag2 = true;
         Row row1 = new Row();
%>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "To")%>
              <td><%=r.getString(teasession._nLanguage, "CcMembers")%>
              <td><%=r.getString(teasession._nLanguage, "Bcc")%>
                <%if(i == 3){%>
              <td><%=r.getString(teasession._nLanguage, "Delete")%>
                <%}
         for(Enumeration enumeration1 = MessageFolder.findSubscribers(s, l, byte0); enumeration1.hasMoreElements();)
         {
             RV rv1 = (RV)enumeration1.nextElement();
             String s7 = rv1.toString();
%>
            <tr id=<%=(flag2 ? "OddRow" : "EvenRow")%>>
              <td><input  id="CHECKBOX" type="CHECKBOX" name=to value=<%=s7%>>
              <td><input  id="CHECKBOX" type="CHECKBOX" name=cc value=<%=s7%>>
              <td><input  id="CHECKBOX" type="CHECKBOX" name=bcc value=<%=s7%>>
                <%			if(i == 3){%>
              <td><input  id="CHECKBOX" type="CHECKBOX" name=<%=s7%>>
                <%}%>
              <td><%=TeaServlet.getRvDetail(rv1, teasession._nLanguage)%>
                <input type='hidden' name=MessageFolderSubscribers VALUE="<%=s7%>">
                <%          flag2 = !flag2;
         }

     }
%>
          </table>
        </FORM>
        <FORM name=foDelete1 METHOD=GET action="/servlet/DeleteMessageFolderContents">
        <input type='hidden' name=Operation VALUE="">
        <input type='hidden' name=MessageFolder VALUE="<%=s%>">
        <input type='hidden' name=MessageFolder VALUE="<%=s%>">
        <%
    boolean flag3 = MessageFolder.isUseAsMyOwnMessageFolder(teasession._rv._strR, s);
    %>
        <%=r.getString(teasession._nLanguage, "UseAsMyOwnMessageFolder")%>: <%=new Radio("UseAsMyOwnMessageFolder", 1, flag3)%> <%=r.getString(teasession._nLanguage, "Yes")%> <%=new Radio("UseAsMyOwnMessageFolder", 0, !flag3)%> <%=r.getString(teasession._nLanguage, "No")%>&nbsp; <%=new Anchor("javascript:foDelete1.submit();",r.getString(teasession._nLanguage, "Submit"))%> <%=new tea.htmlx.FPNL(teasession._nLanguage, "MessageFolderSubscribers?MessageFolder="+s+"&Pos=", l, j1, byte0)%>
        <%if(i == 3 && j1 != 0){%>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');}">
        <%}if(j1 != 0){%>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBInsertMemberID")%>" ID="CBInsertMemberID" CLASS="CB" onClick="window.open('javascript:insertMemberID();', '_self');">
        <%}%>
        <%
} else
{
        out.print(r.getString(teasession._nLanguage, "Unviewable"));
        return;
}
%>
  </table>

  </td>
  </tr>
  </table>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

