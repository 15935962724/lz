<%@page import="tea.entity.node.Service"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.node.NightShop"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.city.CityList"%>
<%@page import="tea.entity.Http"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.member.WomenOptions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request);
int size=10;
int pos=h.getInt("pos", 0);
%>
<ul>
<%
Enumeration e= Node.find(" and node="+h.node+"  AND n.type =65 and hidden = 0  and community = "+DbAdapter.cite(h.community), 0, 1);
if(e.hasMoreElements()){
	Service sv=Service.find(h.node, h.language);
	   if(sv.serShops.length()>1){
		   String sershops[]=sv.serShops.split("[|]");
		   for(int i=1;i<sershops.length;i++){
			   int shopnode=Integer.parseInt(sershops[i]);
			   Enumeration e2= Node.find(" and node="+shopnode+" AND n.type =45 and hidden = 0  and community = "+DbAdapter.cite(h.community), 0, 1);
			   if(e2.hasMoreElements())
				{ 
				  int node=((Integer)e2.nextElement()).intValue();
				  Node n=Node.find(node);
				  NightShop ns=NightShop.find(node, h.language);
				  %>
				  <li><a href="/html/nightshop/<%=node%>-<%=h.language%>.htm" target="_self"><%=n.getSubject(h.language) %></a></li>
				  <%
				}
		   }
	   }
}
%>
</ul>
 