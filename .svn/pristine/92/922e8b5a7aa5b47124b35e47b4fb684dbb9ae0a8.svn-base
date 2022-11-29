<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/member/node/Nodes");

int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("menuid"));

String sn=request.getServerName()+":"+request.getServerPort();
String jsessionid=request.getParameter("jsessionid");
if(jsessionid!=null)
	jsessionid="&jsessionid="+jsessionid;
else
	jsessionid="";

int type =  Integer.parseInt(request.getParameter("type"));

int j=1;

for(java.util.Enumeration enumeration = Favorite.findNodes(teasession._strCommunity,teasession._rv,type, 0, showcount); enumeration.hasMoreElements();j++)
{
  int k = ((Integer)enumeration.nextElement()).intValue();
  Node obj=Node.find(k);
  if(obj.getCreator()!=null)
  {
	String content=obj.getText(teasession._nLanguage);
	if(content.length()>100)
		content=content.substring(0,100)+"...";
	out.println("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
	out.println("  <a target=_blank href=http://"+sn+"/servlet/Node?node="+k+"&Language="+teasession._nLanguage+jsessionid+" >"+obj.getSubject(teasession._nLanguage)+"</a><br>");
	out.println("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
	out.println(content);
	out.println("  </div>");
	out.println("</div>");
  }
}

%>


