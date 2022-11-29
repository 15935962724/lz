<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.node.type.Reserves"%>
<%
	Http h=new Http(request,response);
	//int node = h.getInt("reserve");
	int node = h.node;
	Node n = Node.find(node);
	String sql = " AND rname like '%"+n.getSubject(h.language)+"%'";
	int count = Specimen.count(sql);
	if(count > 0){
		out.print("<a href='/xhtml/papc/folder/13113599-1.htm?reserve="+node+"'><img src='/res/papc/structure/specimenBtn.jpg'/></a>");	
	}
%>

