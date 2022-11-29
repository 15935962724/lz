<%@page contentType="text/html;charset=gbk" %>
<%@ page language="java"   import="java.util.*"%>
<%@ page import="tea.db.DbAdapter"%>

<%@ page  import="java.text.SimpleDateFormat"  %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.node.*" %>
<%@page  import="tea.entity.site.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.ui.*" %>

<!--<SCRIPT language=JAVASCRIPT src="/jsp/type/newspaper/6L1.js"></SCRIPT>-->
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<SCRIPT id=oMapScript for=pagepicmap event=onmouseover()>
 drawLine(event.srcElement);
</SCRIPT>

<SCRIPT id=oMapScript1 for=pagepicmap event=onmouseout()>
 MouseOutMap();
</SCRIPT>

<SCRIPT id=oMapScript2 for=pagepicmap event=onclick()>
 clickmap(event.srcElement);
</SCRIPT>
<SPAN
style="Z-INDEX: 100; POSITION: absolute; BORDER-RIGHT-WIDTH: 0px; WIDTH: 210px; BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; HEIGHT: 34px; BORDER-LEFT-WIDTH: 0px; TOP: 123px; CURSOR: hand; LEFT: 233px"
id=leveldiv title=点击查看内容></SPAN>

<%

TeaSession teasession=new TeaSession(request);
 Cluster c = Cluster.getInstance();

//int nodeid=Integer.parseInt(teasession.getParameter("node"));
int nodeid=teasession._nNode;
Node node=Node.find(nodeid);

if(node.getType()==0)
{DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT top 1 node FROM Node WHERE father=" + nodeid + "   AND  hidden=0 order by  sequence asc");
           if(db.next())
            {
              nodeid=(db.getInt(1));
              node=Node.find(nodeid);
             // System.out.println("nodeid:"+nodeid);
            } 
         } finally
        {
            db.close();
        }

}
if(node.getType()==39){
nodeid=node.getFather();
node=Node.find(node.getFather());
}
Enumeration enum1=Node.findSons(nodeid);
 java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyMM");

                 %>
<img   style="cursor:pointer" id="hotpic" src="<%=node.getPicture(1)%>" width="350" border="0" usemap="#pagepicmap">
      <map name="pagepicmap">
<%
//request.setCharacterEncoding("UTF-8");

while(enum1.hasMoreElements())
{
  int n=((Integer)enum1.nextElement()).intValue();
  Node snode=Node.find(n);
  Report report=Report.find(n);

%>
  <area shape="polygon" coords="<%=report.getCoordinate()%>"  
  alt="<%=snode.getSubject(1) %>"   onclick=window.open('/servlet/NewsPaper?Node=<%=n%>','_self');>
 
<%
//  href="/servlet/NewsPaper?Node=  target=_self 
  }
   %>
</map>


