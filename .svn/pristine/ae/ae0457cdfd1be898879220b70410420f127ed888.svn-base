<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
 response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
 return;
}
Resource r = new Resource();
     Node   node=Node.find(teasession._nNode);
            long i = node.getOptions();
            boolean flag = (i & 0x8000) != 0;
boolean flag1 = node.isCreator(teasession._rv);

            int j = 0;
            try
            {
                j = Integer.parseInt( request.getParameter("Pos"));
            } catch(Exception exception1) { }
            int k = Talkback.count(teasession._nNode);
final int pagesize=15;



%>


<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>
<DIV id="edit_Bodydiv">
 <div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form action="/servlet/DeleteTalkback?node=<%=teasession._nNode%>" >

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%

boolean bool2=(teasession._rv != null && (flag1 || teasession._rv.isOrganizer(node.getCommunity()) || teasession._rv.isWebMaster()||teasession._rv.isManager(node.getCommunity())));
for(Enumeration enumeration = Talkback.find(teasession._nNode, j, pagesize); enumeration.hasMoreElements();)
{
  int l = ((Integer)enumeration.nextElement()).intValue();
  Talkback talkback = Talkback.find(l);

  RV rv = talkback.getCreator();
  boolean bool=(teasession._rv != null && (bool2|| rv.equals(teasession._rv)));
  if(!bool&&talkback.isHidden())
  {
    continue ;
  }
  String dat=talkback.getTimeToString();
  talkback.getStatus();
  int kk=talkback.getHint();
  String pic=HintImg.HINT[kk];
  String subject=talkback.getSubject(1);
  String creator=rv._strR;
  if (creator==null||creator=="")
  creator="匿名";
  else
  creator=new String(creator.getBytes("ISO-8859-1"));
%>
<TR>
  <%if(bool2)
  {%>
  <td><input  id="CHECKBOX" type="CHECKBOX" name="Talkback" value="<%=l%>"/></td>
<%  }%>
<TD><IMG BORDER=0 SRC="/tea/image/hint/<%=pic%>.gif"></TD>
<TD><A HREF="Talkback.jsp?node=<%=teasession._nNode%>&Talkback=<%=l%>" ID=TalkbackIndex>
  <%=talkback.getAnchor(teasession._nLanguage)

  %>
</A></TD>
<TD>  </TD>
<TD><%=dat%></TD>
<TD> </TD>
<TD><%=creator%></TD>
<TD><%=tea.entity.node.TalkbackReply.countByTalkback(l)%></TD>
<TD>
  <%
  if(bool)
{%>
<INPUT TYPE=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "Edit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('EditTalkback.jsp?node=<%=teasession._nNode%>&Talkback=<%=l%>', '_self');">
<INPUT TYPE=BUTTON  name="Delete" VALUE="<%=r.getString(teasession._nLanguage, "Delete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteTalkback?node=<%=teasession._nNode%>&Talkback=<%=l%>&Delete=ON', '_self')};">
<%}%>
</TD></TR>
<%
} if(bool2){
%>
<tr><td>
    <INPUT TYPE=submit name="Hidden" VALUE="<%=r.getString(teasession._nLanguage, "Hide")%>" ID="CBDelete" CLASS="CB" onClick="">
      <INPUT TYPE=submit  name="Show" VALUE="<%=r.getString(teasession._nLanguage, "Show")%>" ID="CBDelete" CLASS="CB" onClick="">
  </td>
</tr>
<%}%>
</TABLE>
</form>
<INPUT TYPE=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "CBTalkbacks")%>" ID="CBPostTalkback" CLASS="edit_button" onClick="window.open('EditCebbankTalkback.jsp?node=<%=teasession._nNode%>', '_self');">


<%
final String url=request.getRequestURI()+"?node="+teasession._nNode+"&Pos=";
int pagesum=k/pagesize;
if(k%pagesize!=0)
pagesum++;
if(pagesum>1){
if(j>0){%>
<a href="<%=url+(j-pagesize)%>">上一页</a>
<%}
for(int show=1;show<=pagesum;show++)
{
  if(show!=(j/pagesize)+1){
  %>
<A href="<%=url%><%=(show-1)*pagesize%>" ><%}out.print(show);%></A>
  <%
}if((j+pagesize)<k){%><a href="<%=url+(j+pagesize)%>">下一页</a>
    <%}}
%>

<!--<INPUT TYPE=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "CBDeleteAll")%>" ID="CBDeleteAll" CLASS="edit_button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>')){window.open('/servlet/DeleteAllTalkbacks?node=<%=teasession._nNode%>', '_self')};">-->

 <div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</DIV>
</body>
</html>

