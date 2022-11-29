<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/ui/member/message/Messages");
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
<h1><%=r.getString(teasession._nLanguage, "ManageFolders")%></h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>

  <div id="PathDiv"> <%=TeaServlet.hrefGlance(teasession._rv)%> ><%=r.getString(teasession._nLanguage, "ManageFolders")%></div>
  <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<%
for(Enumeration enumeration = MessageFolder.find(teasession._rv._strR); enumeration.hasMoreElements();)
{
  int id = ((Integer)enumeration.nextElement()).intValue();
  MessageFolder messagefolder = MessageFolder.find(id);
%>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td>
        <A href="/jsp/message/MessageFolderContents.jsp?messagefolder=<%=id%>" TARGET="_self"><%=messagefolder.getName(teasession._nLanguage)%></A>
      <td>      <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditMessageFolder?messagefolder=<%=id%>', '_self');">
            <%
            if(messagefolder.isLayerExisted(teasession._nLanguage))
            {%>
            <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('/servlet/DeleteMessageFolder?messagefolder=<%=id%>', '_self');}">
            <%}
				if(messagefolder.getType() != 0)
                {%>
            <input type="button" value="<%=r.getString(teasession._nLanguage, "CBInviteSubscription")%>" ID="CBInviteSubscription" CLASS="CB" onClick="window.open('/servlet/InviteMessage?messagefolder=<%=id%>', '_blank');">
            <input type="button" value="<%=r.getString(teasession._nLanguage, "CBMessageFolderSubscribers")%>" ID="CBMessageFolderSubscribers" CLASS="CB" onClick="window.open('/servlet/MessageFolderSubscribers?messagefolder=<%=id%>', '_blank');">
            <%
}
/*
			for(Enumeration enumeration1 = MessageFolder.findMessageFolderLayerx(teasession._rv._strR); enumeration1.hasMoreElements();)
            {
                String s1 = (String)enumeration1.nextElement();
                String s2 = MessageFolder.getMember(s1);
                MessageFolder messagefolder1 = MessageFolder.find(s2, s1);
                if(MessageFolder.getType(s1) != 0)
                {%>
          <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
                <td><A href="/servlet/MessageFolderContents?MessageFolder=<%=s1%>" TARGET="_self"><%=messagefolder1.getName(teasession._nLanguage)%></A>
            <input type="button" value="<%=r.getString(teasession._nLanguage, "CBInviteSubscription")%>" ID="CBInviteSubscription" CLASS="CB" onClick="window.open('/servlet/InviteMessage?MessageFolder=<%=s1%>', '_blank');">
            <%
            if((MessageFolder.getOptions(s1) & 1) != 0)
                    {%>
            <input type="button" value="<%=r.getString(teasession._nLanguage, "CBMessageFolderSubscribers")%>" ID="CBMessageFolderSubscribers" CLASS="CB" onClick="window.open('/servlet/MessageFolderSubscribers?MessageFolder=<%=s1%>', '_blank');">
            <%}
          }
        }*/
}%>
</table>
        <br/>
        <input type=BUTTON class="edit_button" ID="CBNew"  onClick="window.open('/servlet/EditMessageFolder', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "CBNew")%>">


        <div id="head6"><img height="6" src="about:blank" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
