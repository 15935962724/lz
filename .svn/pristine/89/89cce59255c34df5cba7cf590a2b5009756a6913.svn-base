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
Enumeration e= Node.find(" and node="+h.node+"  AND n.type =45 and hidden = 0  and community = "+DbAdapter.cite(h.community), 0, 1);
if(e.hasMoreElements()){
	NightShop ns=NightShop.find(h.node, h.language);
	
	   if(ns.services.length()>1){
		   String service[]=ns.services.split("[|]");
		   for(int i=1;i<service.length;i++){
			   int sernode=Integer.parseInt(service[i]);
			   Enumeration e2= Node.find(" and node="+sernode+" AND n.type =65 and hidden = 0  and community = "+DbAdapter.cite(h.community), 0, 1);
			   if(e2.hasMoreElements())
				{ 
				  int node=((Integer)e2.nextElement()).intValue();
				  Node n=Node.find(node);
				  Service sv=Service.find(node, h.language);
				  %>
                  <li>
				    <p class="p01"><span id="ServiceIDpicture"><a href="/html/service/<%=node%>-<%=h.language%>.htm" target="_self"><img border="0" src="<%=sv.getPicture()%>"></a></span></p>
				    <p class="p02"><span id="ServiceIDSubject"><a href="/html/service/<%=node%>-<%=h.language%>.htm" target="_self"><%=n.getSubject(h.language) %></a></span>
				    <span id="ServiceIDtime"><%=sv.getTime() %></span>
				    <span class="yuan">¥</span>
				    <span id="ServiceIDprice"><%=sv.getPrice() %></span>
				    <span id="ServiceIDsynopsis"><%=sv.getSynopsis() %></span>
				    </p>
				  </li>
				  <%
				}
		   }
	   }
}
%>
</ul>

 