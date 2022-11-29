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
Resource r = new Resource();TeaSession teasession = new TeaSession(request);
     Node   node=Node.find(teasession._nNode);
            long i = node.getOptions();
            boolean flag = (i & 0x8000) != 0;
boolean flag1 = node.isCreator(teasession._rv);

            int j = 0;
            try
            {
                j = Integer.parseInt( request.getParameter("Pos"));
            }
            catch(Exception exception1) { }
            int k = Talkback.count(teasession._nNode);
final int pagesize=15;

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<!--<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>-->
<h1><%=r.getString(teasession._nLanguage, "反馈信息")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<TABLE border="0" CELLPADDING=0  CELLSPACING=0 id="tablecenter">
  <tr id=tableonetr>
    <td>&nbsp; </td>
    <td>主题</td>
    <td>时间</td>
    <td>发表人</td>
    <td>回复</td>
  </tr>
  <% for(Enumeration enumeration = Talkback.find(tea.entity.site.Community.find(teasession._strCommunity).getNode(), j, pagesize); enumeration.hasMoreElements();)
                {
                                          int l = ((Integer)enumeration.nextElement()).intValue();
                    Talkback talkback = Talkback.find(l);
                    RV rv = talkback.getCreator();
                    java.util.Date date = talkback.getTime();
                     String dat=(new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date);
                    talkback.getStatus();
                    int kk=talkback.getHint();
                    String pic=HintImg.HINT[kk];
                                        String subject=talkback.getSubject(1);
                                    String creator=rv._strR;
                                        if (creator=="")
                                                creator="匿名";
                                        %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <TD><IMG BORDER=0 SRC="/tea/image/hint/<%=pic%>.gif" alt=""></TD>
    <TD><A HREF="/jsp/talkback/Talkback.jsp?node=<%=teasession._nNode%>&Talkback=<%=l%>" ID=TalkbackIndex><%=subject%></A></TD>
    <TD><%=dat%></TD>
    <TD><%=creator%></TD>
    <TD><%=tea.entity.node.TalkbackReply.countByTalkback(l)%></TD>
    <TD> <% if(teasession._rv != null && (flag1 || rv.equals(teasession._rv) || teasession._rv.isOrganizer(node.getCommunity()) || teasession._rv.isWebMaster()||teasession._rv.isManager(node.getCommunity())))
                                        {%>
      <INPUT TYPE=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "Edit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/talkback/EditTalkback.jsp?node=<%=teasession._nNode%>&Talkback=<%=l%>', '_self');">
      <INPUT TYPE=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "Delete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteTalkback?node=<%=teasession._nNode%>&Talkback=<%=l%>', '_self')};"> </TD>
  </TR>
  <%}
}%>
</TABLE>
<%
final String url=request.getRequestURI()+"?node="+teasession._nNode+"Pos=";
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
<A href="<%=url%><%=(show-1)*pagesize%>" >
<%}out.print(show);%>
</A>
<%
}if((j+pagesize)<k){%>
<a href="<%=url+(j+pagesize)%>">下一页</a>
<%}}
%>
<!--<INPUT TYPE=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "CBDeleteAll")%>" ID="CBDeleteAll" CLASS="edit_button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>')){window.open('/servlet/DeleteAllTalkbacks?node=<%=teasession._nNode%>', '_self')};">-->
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

