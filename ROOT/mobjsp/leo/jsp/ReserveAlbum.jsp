<%@page import="tea.entity.MT"%>
<%@page import="java.text.Format"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.node.Reserve"%>
<%@page import="com.sun.jndi.url.dns.dnsURLContext"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.node.Album"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
StringBuffer sql=new StringBuffer();
StringBuffer htmlx=new StringBuffer();
sql.append("SELECT distinct reserveNode FROM Album where reserveNode is not null");
DbAdapter db=new DbAdapter();
db.executeQuery(sql.toString());
while(db.next()){
Node n=null;
int reserve=db.getInt(1);
db.executeQuery("select top 1 node from album where reservenode = "+reserve+"");
if(db.next()){
	n=Node.find(db.getInt(1));
}

String href="/xhtml/papc/category/"+MT.f(n.getFather())+"-1.htm";
htmlx.append("<li><a href='"+href+"'>"+MT.f(n.getSubject(1))+"国家级自然保护区昆虫生态图鉴"+"</a></li>");
}

%>
<div class="list">
<ul>
	<li><a href="/xhtml/papc/category/13110233-1.htm">云南高黎贡国家级自然保护区昆虫生态图鉴</a></li>
	<li><a href="/xhtml/papc/category/13115002-1.htm">河北雾灵山国家级自然保护区昆虫生态图鉴</a></li>
	<%-- <%=htmlx.toString() %> --%>
</ul>
</div>