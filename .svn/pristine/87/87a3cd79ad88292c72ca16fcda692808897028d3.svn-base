<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.sup.SupQualification"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="title"><img src="/res/jskxcbs/structure/201401071539.png" style="float:left;margin-top:7px;margin-right:5px;" />相关书籍</div>
<div class="list">
<%
Http h=new Http(request);
int node= h.getInt("id", 14010168);
int father=Book.find(node).getType();
Enumeration e = Node.find(" AND b.type="+father+" and b.node!="+node+" order by n.click desc", 0, 6);
	for (int i = 0; e.hasMoreElements(); i++) {
		int no = ((Integer) e.nextElement()).intValue();
		Node n = Node.find(no);
		Book b = Book.find(no);
  String url = "/html/jskxcbs/folder/14011316-1.htm?node="+no;
  %>
  <div class="pic_pic"><div class="pic"><a href="<%=url %>"><img src="<%=b.getSmallPicture(h.language) %>" /></a></div>
  <div class="name"><a href="<%=url %>" title="<%=MT.f(n.getSubject(h.language)) %>"><%=MT.f(n.getSubject(h.language),20) %></a></div>
  <div class="price"><font color="red">&yen;<%=MT.f(b.getPrice().doubleValue(),2)%></font></div></div>
<%  
}

%>
</div>