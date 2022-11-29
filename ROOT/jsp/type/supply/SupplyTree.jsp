<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*" %>
<%@page import="java.util.*" %>

<%

TeaSession teasession=new TeaSession(request);

int root=Integer.parseInt(request.getParameter("root"));

Node n=Node.find(root);

//int step=nr.getPath().split("/").length;

//Node n=Node.find(teasession._nNode);
//String path=n.getPath();

if(request.getParameter("ajax")!=null)
{
  //step=Integer.parseInt(request.getParameter("step"));
  //tree1(out,root,teasession._nLanguage,step,path);
  out.print(n.getTreeToHtml(teasession._nLanguage,teasession._nNode));
  return;
}

%>



document.write("<%=n.getTreeToHtml(teasession._nLanguage,teasession._nNode)%>");
<%//tree1(out,root,teasession._nLanguage,0,path);%>

