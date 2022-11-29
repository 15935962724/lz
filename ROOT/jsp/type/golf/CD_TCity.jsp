<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");


Http h=new Http(request);
Iterator it=Table.find(Table.CITY,h.community,"",0,200).iterator();
while(it.hasNext())
{
  Table t=(Table)it.next();
  int sum=Node.count(h.community," AND type=62 AND EXISTS (SELECT node FROM Golf g WHERE g.node=n.node AND g.area="+DbAdapter.cite(String.valueOf(t.tid))+" )");
  out.print("<li><a href=\"javascript:fsubmit('"+t.tid+"');\" >"+t.name+" "+sum+"</a></li>");

}

%>
