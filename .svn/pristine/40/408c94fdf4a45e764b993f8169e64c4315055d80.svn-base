<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.node.Node" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="tea.entity.node.Report" %>
<%@ page import="tea.entity.MT" %>
<%
	Http h=new Http(request);
	int node=18;
	if(h.node>0){
		node=h.node;
	}
	Node cnode=Node.find(node);
	int size=10;
	if(h.getInt("size")>0){
		size=h.getInt("size");
	}
	
	int words=20;
	if(h.getInt("words")>0){
		words=h.getInt("words");
	}

	Enumeration e=Node.findReport(h.community, " and finished=1 and hidden=0 and father="+node+" order by n.time desc", 0, size);
	boolean stime="true".equals(h.get("stime"));
	
%>
<html>
<style>
#tspan{display:<%=h.get("title")!=null&&"true".equals(h.get("title"))?"none":"block"%>;line-height:30px;background:#<%=h.get("btlcolor")%>;}
#tspan a{color:#333;text-decoration:none;font-weight:bold;}
#tablecentert td{color:#<%=h.get("color")%>;font-size:<%=h.get("fsize")%>px;}
#tablecentert td a{text-decoration:none;color:#<%=h.get("acolor")%>;}
#tablecentert td a:hover{text-decoration:underline;color:#<%=h.get("ahover")%>;}
.sp1{padding: 2px 0px 2px 10px;float:left;text-align:left;display:block;}
.sp2{display:inline-block;float:right;padding-left:10px;}
#dy{height:auto;}
</style>
	<head>
		<title>预览</title>
		
	</head>
	<body style="background-color:transparent" id="dy">
		<span id="tspan"><a href="<%="/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + node + "-" + h.language + ".htm"%>" target="_bank"><%=cnode.getSubject(h.language) %></a></span>
		<table id="tablecentert" width="100%" cellspacing="0" >
		<%if(e.hasMoreElements()){
			while(e.hasMoreElements()){
				int nnode=(Integer)e.nextElement();
				Node rnode=Node.find(nnode);
				Report r=Report.find(nnode);
			
				String word=rnode.getSubject(h.language);
				if(word.length()>words){
					
					word=Node.bSubstring(word,words*2)+"...";
				}
				
				
			out.print("<tr><td><span class='sp1'><a  target='_bank' href='/"+(h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + rnode._nNode + "-" + h.language + ".htm"+"'>"+ word+"</a></span>");
			if(!stime){
				out.print("<span class='sp2' >"+rnode.getTimeToString()+"</span>");
			}
			out.print("</td></tr>");
			}
		}else{
			out.print("<tr><td>暂无记录！</td></tr>");
		} %>
			<tr><td></td></tr>
		</table>
		
	</body>
</html>