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

StringBuffer par=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

int id=0;
String tmp=request.getParameter("id");
if(tmp!=null)id=Integer.parseInt(tmp);
if(id>0)
{
  sql.append(" AND id!=").append(id);
  par.append("&id=").append(id);
}

String q=request.getParameter("q");
if(q!=null)
{
  par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
  String q_ = DbAdapter.cite("%" + q.replace(' ', '%') + "%");
  sql.append(" AND help IN ( SELECT help FROM HelpLayer WHERE language=").append(teasession._nLanguage).append(" AND subject LIKE ").append(q_).append(" OR content LIKE ").append(q_).append(")");
}


int type=0;
tmp=request.getParameter("type");
if(tmp!=null)
{
  type=Integer.parseInt(tmp);
}
par.append("&type=").append(type);
sql.append(" AND type=").append(type);

int pos=0;
tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);
par.append("&pos=");

int count=Help.countByCommunity(teasession._strCommunity,sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1>系统帮助</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 action="?" onSubmit="">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="type" value="<%=type%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><input name="q" value="<%if(q!=null)out.print(q);%>"><input type="submit" value="GO"/></td></tr>
</table>


<h2>帮助主题 (<%=count%>)</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
int i=0;
if(id>0&&pos<1)
{
  java.util.Enumeration enumer=Help.findByCommunity(teasession._strCommunity," AND id="+id,0,100);
  while(enumer.hasMoreElements())
  {
    int help=((Integer)enumer.nextElement()).intValue();
    Help obj=Help.find(help);
    if(i<1)out.print("<script>window.open('/jsp/site/HelpContent.jsp?community="+teasession._strCommunity+"&help="+help+"','help_content');</script>");
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td><a href='/jsp/site/HelpContent.jsp?community="+teasession._strCommunity+"&help="+help+"' target='help_content'>"+obj.getSubject(teasession._nLanguage)+"</a>");
    i++;
  }
}
if(i<10)
{
  java.util.Enumeration enumer=Help.findByCommunity(teasession._strCommunity,sql.toString(),pos,10-i);
  for(;enumer.hasMoreElements();i++)
  {
    int help=((Integer)enumer.nextElement()).intValue();
    Help obj=Help.find(help);
    if(i<1)out.print("<script>window.open('/jsp/site/HelpContent.jsp?community="+teasession._strCommunity+"&help="+help+"','help_content');</script>");
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td><a href='/jsp/site/HelpContent.jsp?community="+teasession._strCommunity+"&help="+help+"' target='help_content'>"+obj.getSubject(teasession._nLanguage)+"</a>");
  }
}
if(count>10)out.print("<tr><td>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,10));
%>
</table>

<%--
<input type="button" value="<%=r.getString(teasession._nLanguage,"留言")%>" onClick="window.open('/servlet/Node?node=<%=c.getMessageboard()%>');">
--%>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
