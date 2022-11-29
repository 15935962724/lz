<%@page contentType="text/html;charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.node.access.*"%>
<%@page import="tea.db.*"%><%
int nid=1;
String url=request.getHeader("referer");

if(url==null)return;
int of=url.indexOf("/html/",10);
if(of==-1)return;

Enumeration e=Node.find(" AND syncid="+DbAdapter.cite(url.substring(of+6)),0,1);
nid=e.hasMoreElements()?((Integer)e.nextElement()).intValue():1;
Node n=Node.find(nid);
NodeAccess.Access(n,request,session);


if(true)return;
%>
