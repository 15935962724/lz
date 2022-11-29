<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page  import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="javax.mail.Folder" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String member=teasession._rv._strV;

StringBuffer sb=new StringBuffer();
String[] FLOW_TYPE={"","发文","收文"};
for(int i=1;i<3;i++)
{
  StringBuffer sql=new StringBuffer();
  String flow=request.getParameter("flow"+i);
  sql.append(" AND flow IN("+ flow+")");
  sql.append(" AND step>0 AND fb.flowbusiness IN( SELECT flowbusiness FROM Flowview f1 WHERE ");
  //{member}可以办理的事务//
  sql.append(" (state<2 AND(transactor="+DbAdapter.cite(member)+" OR consign="+DbAdapter.cite(member)+") AND EXISTS(SELECT * FROM (SELECT flowbusiness,MAX(step) AS step FROM Flowview WHERE flowprocess!=0 GROUP BY flowbusiness) AS f2 WHERE f1.flowbusiness=f2.flowbusiness AND f1.step=f2.step)           )");
  sql.append(")");
  sb.append("<a style='color:#FFFFFF' href='/jsp/admin/cec/Flowbusiness.jsp?community="+teasession._strCommunity+"&flow="+flow+"'>您还有 "+Flowbusiness.countByCommunity(teasession._strCommunity,sql.toString())+" 个"+FLOW_TYPE[i]+"待处理</a> ");
}
out.print("<script>var h=document.getElementsByTagName('H2');h=h[h.length-1];h.innerHTML+=\"　　"+sb.toString()+"\";</script>");



Resource r=new Resource();
int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("menuid"));

String sn=request.getServerName()+":"+request.getServerPort();
String jsessionid=request.getParameter("jsessionid");
if(jsessionid!=null)
	jsessionid="&jsessionid="+jsessionid;
else
	jsessionid="";


Iterator e=Message.find(teasession._strCommunity,member, 0," AND reader NOT LIKE " + DbAdapter.cite("%/" + member+ "/%")+" ORDER BY message DESC",0, 100).iterator();
if(!e.hasNext())
{
  out.print("暂无消息!");
}else for(int j=1;e.hasNext();j++)
{
  int k = ((Integer)e.next()).intValue();
  Message message=Message.find(k);
  String fmember=message.getFMember();
  Profile p=Profile.find(fmember);
  String subject = message.getSubject(teasession._nLanguage);
  subject=MT.f(subject,34);
  String content=message.getContent(teasession._nLanguage);
  if(content.length()>150)
  {
    content=content.substring(0,150)+"...</b></script></style></a>";
  }
  out.print("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
  out.print("  <a target=_blank href='http://"+sn+"/jsp/message/Message.jsp?folder=0&community="+teasession._strCommunity+"&message="+k+jsessionid+"' >");
  if(message.isReader(teasession._rv._strV))
  {
    out.print(subject);
  }else
  {
    out.print("<b>"+subject+"</b><img src=/tea/image/public/new.gif>");
  }
  out.print("</a><br/>");
  out.print("<div class=EmailSource>"+p.getName(teasession._nLanguage)+"　");
  out.print(message.getTimeToString()+"</div>");
  out.print("</div>");
}
%>

