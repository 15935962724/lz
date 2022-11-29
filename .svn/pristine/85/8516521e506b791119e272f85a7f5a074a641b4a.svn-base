<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.bbs.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
Node node=Node.find(teasession._nNode);

int count = Node.count(" and hidden =0 and path like "+DbAdapter.cite("%/"+teasession._nNode+"/%")+" and type =57 ");

int countReply = 0;
Enumeration  e = Node.find(" and hidden =0 and path like "+DbAdapter.cite("%/"+teasession._nNode+"/%")+" and type =57 ",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
	int nodeid = ((Integer)e.nextElement()).intValue();
	countReply = countReply+ BBSReply.count(nodeid,teasession._nLanguage);
}

int countMember = 0;
Enumeration  e2 = Node.find(" and hidden =0 and path like "+DbAdapter.cite("%/"+teasession._nNode+"/%")+" and exists (select node from Category c where n.node=c.node and c.category=57) ",0,Integer.MAX_VALUE);
while(e2.hasMoreElements())
{
	int nodeid2 = ((Integer)e2.nextElement()).intValue();
	countMember =countMember+Profile.count(" and community= "+DbAdapter.cite(teasession._strCommunity)+" and bbspermissions like "+DbAdapter.cite("%/"+nodeid2+"/%")+" ");
}

 


%>

<%=count%>&nbsp;主题&nbsp;&nbsp;<%=countReply%>&nbsp;回复&nbsp;&nbsp;成员:<%=countMember %>







