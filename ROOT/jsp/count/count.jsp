<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.node.access.*" %><%@page import="tea.db.*" %><%@page import="java.text.*" %><%@page import="tea.ui.*" %>
<%!// 一个同步用的锁 
  private static final Object lock = new Object();%> 

<%!
DecimalFormat df = new DecimalFormat("#,##0");
%>

<%
TeaSession teasession=new TeaSession (request);
//int oldpv= 10809664 ;
//int oldip=8366701;
 
//int oldpv= 0 ;
//int oldip=0;
 
int oldpv= NodeAccessLast.countOldPv(teasession._strCommunity) ;
int oldip= NodeAccessLast.countOldIp(teasession._strCommunity) ;


NodeAccess na=NodeAccess.find(teasession._strCommunity);

long alltotal=0;//总访问量
long temp=na.getAllTotal()+oldpv;
//int daytotal=na.getDayTotal();
synchronized (lock) { 
if (application.getAttribute("edn.nodeaccess")!=null)
{
  alltotal=((Long)application.getAttribute("edn.nodeaccess")).longValue()+1;
  if (alltotal<temp) alltotal=temp;
 }else
 {
 alltotal=temp;
 }

application.setAttribute("edn.nodeaccess",new Long(alltotal));
}
%>

document.write("<%=df.format(alltotal)%>");


