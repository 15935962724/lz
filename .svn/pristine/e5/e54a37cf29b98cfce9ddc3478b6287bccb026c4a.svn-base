<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/node/Nodes");
String s = request.getParameter("Pos");
int i = s != null ? Integer.parseInt(s) : 0;
int j = tea.entity.node.Talkback.countEdNodes2(teasession._rv);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "TalkbackedNodes")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
<div id="PathDiv"> <%=ts.hrefGlance(teasession._rv)%> ><A href="/jsp/node/Nodes.jsp"><%=r.getString(teasession._nLanguage, "Nodes")%></A> ><%=r.getString(teasession._nLanguage, "TalkbackedNodes")%></div>
<h2><%=j%> <%=r.getString(teasession._nLanguage, "TalkbackedNodes")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <%
for(Enumeration enumeration = Talkback.findEdNodes2(teasession._rv, i, 25); enumeration.hasMoreElements();)
{
                int k = ((Integer)enumeration.nextElement()).intValue();
                                tea.entity.node.Talkback obj=tea.entity.node.Talkback.find(k);
                           int kk=obj.getHint();
  String pic=HintImg.HINT[kk];
                %>
          <tr>
          <TD><%=Node.find(obj.getNode()).getAncestor(teasession._nLanguage)%></TD>
            <TD><IMG BORDER=0 SRC="/tea/image/hint/<%=pic%>.gif"><%=obj.getAnchor(teasession._nLanguage)  %></TD>
            <td><%=obj.getTimeToString()%></td>
            <TD><%=tea.entity.node.TalkbackReply.countByTalkback(k)%></TD>
          </tr>
          <%}
%>
</table><br>
<%=new FPNL(teasession._nLanguage, "/jsp/node/TalkbackedNodes2.jsp?Pos=", i, j)%>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

