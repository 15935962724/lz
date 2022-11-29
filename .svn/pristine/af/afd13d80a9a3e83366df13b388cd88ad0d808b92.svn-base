<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %><%@page import="tea.entity.*"%><%@page import="tea.resource.Resource" %><%@page import="tea.ui.node.general.*" %>
<%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}



StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menu=h.getInt("id");
par.append("?id="+menu);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND community LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+Http.enc(name));
}

int state=h.getInt("state");
if(state>0)
{
  sql.append(" AND state="+state);
  par.append("&state="+state);
}

par.append("&community="+h.community);


Resource r=new Resource("/tea/ui/member/community/Communities");

String title=r.getString(h.language, "OrganizingCommunities");




Node node=Node.find(h.node);


String ra=request.getRemoteAddr();
boolean local=ra.equals("127.0.0.1")||ra.startsWith("192.168.");

int pos=h.getInt("pos");
par.append("&pos=");

%>
<html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<%=NodeServlet.getButton(node,h,AccessMember.find(h.node,h.username),request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv">
<%out.print("<A href=/jsp/access/Glance.jsp?Member="+h.username+" >"+h.username+"</A> ");%>><A href="/servlet/Communities"><%=r.getString(h.language, "Communities")%></A> ><%=r.getString(h.language, "OrganizingCommunities")%>
</div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">社区：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">类型：</td><td><select name="state"><%=h.options(Community.STATE_TYPE,state)%></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<h2>列表</h2>
<form name="form2" action="/Communitys.do" method="post" target="_ajax">
<input type="hidden" name="community"/>
<input type="hidden" name="act"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id=tableonetr>
    <td width="1">&nbsp;</td>
    <td><%=r.getString(h.language,"Community")%></td>
    <td><%=r.getString(h.language,"Name")%></td>
    <td><%=r.getString(h.language,"Status")%></td>
    <td><%=r.getString(h.language,"Time")%></td>
    <td>&nbsp;</td>
  </tr>
<%
int sum=Community.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  ArrayList al=Community.find(sql.toString(),pos,20);
  for(int i=0;i<al.size();i++)
  {
    Community c=(Community)al.get(i);
    int root=c.getNode();
%>
<tr>
  <td width=1><%=i+1%></td>
  <td>
  <%
  out.print("<a href='");
  if(!local)
    out.print("http://"+c.webName);
  out.print("/servlet/Node?node="+c.node+"'>"+c.community+"</a>");
  %>
  </td>
  <td><%=MT.f(c.getName(h.language),50)%></td>
  <td><%=Community.STATE_TYPE[c.state]%></td>
  <td><%=MT.f(c.starttime)%></td>
  <td>
<input type="button" value="<%=r.getString(h.language,"CBJoinRequests")%>" CLASS="edit_button" onClick="window.open('/servlet/JoinRequests?Community=<%=c.community%>', '_self');">
<input type="button" value="<%=r.getString(h.language,"CBSubscribers")%>" CLASS="edit_button" onClick="window.open('/servlet/Subscribers?community=<%=c.community%>', '_self');">
<input type="button" value="<%=r.getString(h.language,"CBOrganizers")%>" CLASS="edit_button" onClick="window.open('/jsp/community/Organizers.jsp?community=<%=c.community%>', '_self');">
<input type="button" value="<%=r.getString(h.language,"CBProviders")%>" CLASS="edit_button" onClick="window.open('/jsp/community/Providers.jsp?community=<%=c.community%>', '_self');">
<input type="button" value="<%=r.getString(h.language,"CBEdit")%>" CLASS="edit_button" onClick="window.open('/jsp/community/EditCommunity.jsp?community=<%=c.community%>', '_self');">
<input type="button" value="导出" onclick="mt.act('htm','<%=c.community%>')"/>
<%
    if(c.isLayerExisted(h.language))
    {
      out.print("<input type='button' value="+r.getString(h.language, "CBDelete")+" onClick=\"if(confirm('"+r.getString(h.language, "ConfirmDelete")+"')){window.open('/servlet/DeleteCommunity?community="+c.community+"', '_self');this.disabled=true;}\">");
    }
  }
  out.print("<tr><td colspan='6' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}
%>
</table>

<input type="button" value="<%=r.getString(h.language, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/jsp/community/EditCommunity.jsp?new=on&community=<%=h.community%>', '_self');">
<input type="button" value="<%=r.getString(h.language, "AccessAnalyse")%>" ID="CBNew" CLASS="CB" onClick="window.open('/jsp/count/AccessAnalyse.jsp', '_self');">
<input type="button" value="<%=r.getString(h.language, "DomainNameBangding")%>" ID="CBNew" CLASS="CB" onClick="window.open('/jsp/site/EditDNS.jsp?community=Home', '_self');">
</form>

<script>
mt.act=function(a,v)
{
  form2.act.value=a;
  form2.community.value=v;
  if(a=='htm')
  {
    mt.show(null,0);
  }
  form2.submit();
};
</script>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
