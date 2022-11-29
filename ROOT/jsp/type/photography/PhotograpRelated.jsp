<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import=" tea.htmlx.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


Resource r=new Resource("/tea/resource/Photography");


Node nobj = Node.find(teasession._nNode);
%>

<table border=0 cellpadding=0 cellspacing=0>
<tr>
  <%   
  
  	Enumeration e = Node.findPhotography_np(teasession._strCommunity,"n.time"," and n.node !="+teasession._nNode+" and n.audit = 1 and n.rcreator = "+DbAdapter.cite(nobj.getCreator().toString())+" order by n.time  desc ",0,20);
  
  //	System.out.print(" and n.node !="+teasession._nNode+" and n.audit = 1 and n.rcreator = "+DbAdapter.cite(nobj.getCreator().toString())+" order by n.time  desc ");
   
  	while(e.hasMoreElements()){
  		int nid = ((Integer)e.nextElement()).intValue();
  		Photography pobj = Photography.find(nid);
 
  %> 
			<td>
  			  <a id ="prid" name="prid" href="/html/photography/<%=nid %>-<%=teasession._nLanguage %>.htm" target="_blank" title="<%=Node.find(nid).getSubject(teasession._nLanguage) %>" style="cursor:pointer">
  			 	 <img src="<%=pobj.getAbbpicpath(teasession._nLanguage) %>"/>
  			  </a> 	
            </td>  
        
<%} %>   
      </tr>
</table>	 	 
 
  

