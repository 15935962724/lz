<%@page import="java.io.File"%>
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
		out.print("<a href='/"+(h.status==1?"xhtml":"html")+"/papc/folder/13113599-1.htm?reserve="+node+"'><img src='/res/papc/structure/specimenBtn.jpg'/></a>&nbsp;&nbsp;&nbsp;");	
	}
	int count2= RAnimal.count(" and rname is not null and rname like '%"+n.getSubject(h.language)+"%'");
	if(count2 > 0){
		out.print("<a href='/"+(h.status==1?"xhtml":"html")+"/papc/folder/13113593-1.htm?rname="+n.getSubject(h.language)+"'><img src='/res/papc/structure/animalBtn.jpg'/></a>&nbsp;&nbsp;&nbsp;");	
	}
	int count3= Infrared.count(" and bhqname like '%"+n.getSubject(h.language)+"%'");
	if(count3 > 0){
		out.print("<a href='/"+(h.status==1?"xhtml":"html")+"/papc/folder/13100959-1.htm?bhqname="+n.getSubject(h.language)+"'><img src='/res/papc/structure/InfraredBtn.png'/></a>");	
	}
	
%>
<%
String path="/res/papc/kmz/"+h.node+".kmz";
File file = new File(Http.REAL_PATH+path);
if (file.exists()) {
	   out.print("&nbsp;&nbsp;&nbsp;<a href='"+path+"'><img src='/res/papc/structure/kmzBtn.png'/></a>");
}
%>

