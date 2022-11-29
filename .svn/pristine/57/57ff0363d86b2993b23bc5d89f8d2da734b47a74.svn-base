<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.net.*"%>
<%
request.setCharacterEncoding("UTF-8");

/*
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/fun");
*/

String community=request.getParameter("community");
String ip=request.getParameter("ip");
String context=request.getParameter("context");

DecimalFormat df=new DecimalFormat("#,##0");
Date time=new Date();
int day=Integer.parseInt(new SimpleDateFormat("dd").format(time));

Community c = Community.find(community);
c.getSmallMap(1);
int count_aur=AdminUsrRole.count(community," AND role!='/'");
int count_ol=OnlineList.countByCommunity(community," AND member IN ( SELECT member FROM AdminUsrRole WHERE role!='/' )");

out.print("document.write(\"");
//out.print("document.getElementById('span_"+community+"').innerHTML=\"");
out.print("<div id=xleft>节点数:"+df.format(Node.count(" AND community="+DbAdapter.cite(community))));
out.print("<br>访问量:"+df.format(NodeAccess.find(community).getAllTotal()));
out.print("<br>会员数:"+df.format(Subscriber.count(community,"")));
out.print("<br>工作人员:"+df.format(count_aur));
//out.print("<br>目录:"+context);
 out.print("<br>状态:"+Community.STATE_TYPE[Community.find(community).getState()]);
out.print("<br></div><div id=xleft>今日节点数:"+df.format(Node.count(" AND community="+DbAdapter.cite(community)+" AND time="+DbAdapter.cite(Community.sdf.format(time)))));
out.print("<br>今日访问量:"+df.format(NodeAccess.find(community).getDayTotal()));
out.print("<br>在线数:"+df.format(OnlineList.countByCommunity(community,"")-count_ol));
out.print("<br>在线数:"+count_ol);
out.print("<br>IP:"+ip+"</div>");
//out.print("\";");
out.print("\");");

%>



