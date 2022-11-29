<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Community c=Community.find(teasession._strCommunity);

Resource r=new Resource();

StringBuffer par=new StringBuffer();
StringBuffer sql=new StringBuffer();

par.append("?community=").append(teasession._strCommunity);

int id=0;
String tmp=request.getParameter("id");
if(tmp!=null)
{
  id=Integer.parseInt(tmp);
}
sql.append(" AND id=").append(id);
par.append("&id=").append(id);

int type=0;
tmp=request.getParameter("type");
if(tmp!=null)
{
  type=Integer.parseInt(tmp);
}

par.append("&type=").append(type);
sql.append(" AND type=").append(type);


int pos=0;
tmp=(request.getParameter("pos"));
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
par.append("&pos=");

int count=Help.countByCommunity(teasession._strCommunity,sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_ref()
{
  var id=getParameter("id",parent.m.location.href);
  if(id!=null&&id!=<%=id%>)
  {
    location.replace("?id="+id+"&type=<%=type%>&community=<%=teasession._strCommunity%>");
  }
}
setInterval(f_ref,500);
function f_open(help)
{
  window.open("/jsp/site/HelpContent.jsp?community=<%=teasession._strCommunity%>&help="+help,'','width=500,height=400,resizable=1,scrollbars=1');
}
</script>
</head>
<body>

<h1>系统帮助</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>帮助主题 (<%=count%>)</h2>

<table border="0" cellpadding="0" cellspacing="0" id="bzzt">
<%
Enumeration e=Help.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
if(!e.hasMoreElements())
{
  out.print("<tr><td>暂无帮助");
}else
{
  for(int i=1;e.hasMoreElements();i++)
  {
    int help=((Integer)e.nextElement()).intValue();
    Help obj=Help.find(help);
    out.print("<tr onMouseOver=bgColor='' onMouseOut=bgColor=''>");
    out.print("<td><a href=javascript:f_open("+help+");>"+obj.getSubject(teasession._nLanguage)+"</a>");
  }
  out.print("<tr><td>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,10));
}
%>
</table>

<input type="button" value="<%=r.getString(teasession._nLanguage,"留言")%>" onClick="window.open('/servlet/Node?node=<%=c.getMessageboard()%>');">


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
