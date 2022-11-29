<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*"%>
<%@page import="tea.resource.*"%>
<%@page import="javax.servlet.ServletConfig"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.*"%>
<%
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  Resource r = new Resource();
  TeaSession teasession = new TeaSession(request);
  tea.ui.TeaServlet ts = new tea.ui.TeaServlet();
  int j = teasession._nLanguage;
  Node node = Node.find(teasession._nNode);
  long i = node.getOptions();
  if (teasession._rv == null ) {
    response.sendRedirect("/servlet/StartLogin");
    return;
  }
  String community=node.getCommunity();
    int pagesize=5;
  int pos=1;
  if(request.getParameter("pos")!=null)
  pos=Integer.parseInt(request.getParameter("pos"));
  tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
  String param;
  if("webmaster".equals(teasession._rv.toString()))
  param="";
  else
  param=" AND Node.rcreator=" + dbadapter.cite(teasession._rv._strR) + " AND Node.vcreator=" + dbadapter.cite(teasession._rv._strV) ;
int count=dbadapter.getInt("SELECT count(DISTINCT talkback) FROM Talkback,Node WHERE Node.community="+dbadapter.cite(community)+" AND Talkback.node=Node.node"+param);
dbadapter.executeQuery("SELECT DISTINCT talkback FROM Talkback,Node WHERE Node.community="+dbadapter.cite(community)+" AND Talkback.node=Node.node"+param);
int pagesum=count/pagesize;
if(count%pagesize!=0)
pagesum++;
%>  <html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CreateAllTalkbackList")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
总数为:<%=count%> 页数为:<%=pagesum%>

  <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <TR>
    <TD>主题</TD>
    <TD>时间</TD>
    <TD> 发表人</TD><TD> 所在节点</TD>
  </TR>
  <%
for(int hiddencount=0;hiddencount<pagesize*(pos-1)&&dbadapter.next();hiddencount++);
  for (int showcount=0;showcount<pagesize&&dbadapter.next();showcount++) {
    int j4 = dbadapter.getInt(1);
    Talkback talkback = Talkback.find(j4);
    RV rv1 = talkback.getCreator();
    Date date = talkback.getTime();
    talkback.getStatus();%>
    <tr><td>
<%=(new HintImg( talkback.getHint()))%>
<A HREF="/jsp/talkback/Talkback.jsp?node=<%=teasession._nNode%>&Talkback=<%=j4%>"><%=talkback.getSubject(1)%></A>
<td><%=(new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date)%>
  <td>
<%    try {
      out.print(new Text(ts.hrefGlanceWithName(rv1, j)));
    }
    catch (Exception exception2) {}
    %>
    <td>
      <A href="/servlet/Node?node=<%=talkback.getNode()%>"><%=tea.entity.node.Node.find(talkback.getNode()).getSubject(1)%></a>
    <td>
    <INPUT TYPE="BUTTON" VALUE="删除" ID="CBDeleteTalkback" CLASS="CB" onClick="if(confirm('你真想删除这个吗?')){window.open('/servlet/DeleteTalkback?node=<%=i%>&Talkback=<%=j4%>&nexturl=<%=request.getRequestURI() + "?" + request.getQueryString()%>', '_self');}"/>
    <%

  }
  dbadapter.close();
%></table>
<%
if(pagesum>1)
{
  if(pos>1)
  {
    %>  <A href="<%=request.getRequestURI()+"?pos="+(pos-1)%>" >上一页</A>
    <%}
    int index=(pos-4);
    if(pos+4-pagesum>0)
    index=index-(pos+4-pagesum);
    if(index<1)index=1;
    int showlist=pagesum;
    if(showlist>pos+4)
    showlist=pos+4;
    if(pos-4<0)
    showlist+=5-pos;
    for(;index<=showlist;index++){
      if(index!=pos){
        %>
        <A href="<%=request.getRequestURI()+"?pos="+index%>" ><%}out.print(index);%></A>
        <%}
        if(pos<pagesum){
          %>
          <A href="<%=request.getRequestURI()+"?pos="+(pos+1)%>" >下一页</A>
          <%  }%>
          <input  name="pos" size="3" value="<%=pos%>"/><input type="button" value="GO" onclick="window.open('<%=request.getRequestURI()%>?pos='+document.all['pos'].value,'_self')"/>
          <% }%>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

