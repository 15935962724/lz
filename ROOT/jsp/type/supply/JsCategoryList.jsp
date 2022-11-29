<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.util.*" %>
<%
TeaSession teasession=new TeaSession(request);
//Node n=Node.find(teasession._nNode);

//Enumeration e=Node.find(" AND ( father="+teasession._nNode+" OR father IN(SELECT node FROM Node WHERE father="+teasession._nNode+") ) AND type<2 ORDER BY path",0,Integer.MAX_VALUE);

Enumeration e=Node.find(" AND  father="+teasession._nNode+"  AND type<2 ORDER BY path",0,Integer.MAX_VALUE);
for(int i=0;e.hasMoreElements();i++)
{
  int node=((Integer)e.nextElement()).intValue();
  Node n=Node.find(node);
  if(n.getType()==0)
  {
    if(i>0)
    {
      out.print("</Span>");
    }
    //out.print("document.write('<div style=width:100%;height:20px;></div>');");
    out.print("<div class=jtys><Span ID=NodeSupply><a href=javascript:cl_open("+node+")>"+n.getSubject(teasession._nLanguage)+"</a></Span><Span ID=SupplyList>");
  }else
  {
    out.print("<a href=javascript:cl_open("+node+")><Span ID=ListingOSonSubject>"+n.getSubject(teasession._nLanguage)+"</Span></a>");
  }
}
out.print("</Span>");

%>
<script>
function cl_open(v)
{
window.open("/servlet/Node?node=2196661&father="+v);
}
</script>
