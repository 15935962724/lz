<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.site.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
Resource r=new Resource("/tea/resource/Photography");
 
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
} 
String phonode = teasession.getParameter("phonode");//投稿作品引用jsp 的node
String talnode = teasession.getParameter("talnode");//jsp/type/photography/MemberTalkback.jsp 引用node

Community c = Community.find(teasession._strCommunity);
StringBuilder sql = new StringBuilder();

sql.append(" AND node IN(SELECT node FROM Node WHERE path LIKE '/"+ c.getNode() + "/%')");
sql.append(" and hidden = 1 ");
sql.append(" AND audittime >=").append(DbAdapter.cite(Entity.sdf.format(new Date())+" 00:00"));
sql.append(" AND audittime <=").append(DbAdapter.cite(Entity.sdf.format(new Date())+" 23:59"));


int count = Talkback.count(sql.toString());
Profile pobj = Profile.find(teasession._rv.toString());

////
//jsp/type/photography/MemberTalkback.jsp
%>
<span id="mlid"><%=r.getString(teasession._nLanguage,"100500553") %>&nbsp;
<span style="color:#FF0000;">
<%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage) %></span>&nbsp;<span class="hyzq11_rk"><a href="/jsp/admin/indexpho.jsp" target="_blank"><%=r.getString(teasession._nLanguage,"1387075774") %></a></span><br />
  
<%=r.getString(teasession._nLanguage,"806380223") %>：<%

 
int lk =0;
java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
java.util.Date now = new Date();
java.util.Date date=Logs.getLastLogin(teasession._rv.toString());
long l=now.getTime()-date.getTime();


long day=l/(24*60*60*1000);
long hour=(l/(60*60*1000)-day*24);
long min=((l/(60*1000))-day*24*60-hour*60);
long s=(l/1000-day*24*60*60-hour*60*60-min*60);
	if(day>0)
	{
		out.println((int)day);
		out.print(r.getString(teasession._nLanguage,"252591772"));
	}else if(hour>0)
	{
		out.print((int)hour+r.getString(teasession._nLanguage,"940685624"));
	}else if(min>0)
	{
		out.println((int)min);
		out.print(r.getString(teasession._nLanguage,"751490849"));
	}else if(s>0)
	{
		out.print((int)s+r.getString(teasession._nLanguage,"867478540"));
	}
%>
<br/>  
<%=r.getString(teasession._nLanguage,"130786108") %>：<a href="/html/category/<%=phonode %>-<%=teasession._nLanguage %>.htm" style="color:#FF0000;"><%=Node.countPhotography(teasession._strCommunity," and n.type = 94   and n.rcreator="+DbAdapter.cite(teasession._rv.toString())) %></a><br/>
<%if(count>0){ %>
<%=r.getString(teasession._nLanguage,"1214448435") %>：<a href ="/html/category/<%=talnode %>-<%=teasession._nLanguage %>.htm" style="color:#FF0000;"><%=count %></a>
<%} %>
</span>