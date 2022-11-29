<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

 int membertype = 0;
 if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
 {
    membertype = Integer.parseInt(teasession.getParameter("membertype"));
 }
  MemberType myobj = MemberType.find(membertype);

int getabove=myobj.getAbove();
//如果会员已经申请了 基于的会员，就不用在申请了
String sp = teasession.getParameter("sp");

if(getabove==0)
{
	  response.sendRedirect("/jsp/mov/AdminSuccess.jsp?membertype="+membertype+"&memberorder=0");
	  return;	
}


 String nexturl = request.getRequestURI()+"?membertype="+membertype+"&sp="+sp+"&act=re"+request.getContextPath();
String NewNode = null;
if(Node.getNC(teasession._strCommunity,teasession._rv.toString())>0)
{
  NewNode ="NewNode";
}

if(!"re".equals(teasession.getParameter("act"))){
  //
  //   MemberType myobj =MemberType.find(membertype);
  RegisterInstall riobj = RegisterInstall.find(membertype);
  //注册设置里面的 是否关联填写类别信息relatednews

  if(riobj.getRelated()==1)
  {
    if(riobj.getRelatednews()==21) // 公司
    {
      response.sendRedirect("/jsp/mov/EditCompany.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"&NewNode="+NewNode+"&membertype="+membertype+"&father="+riobj.getFathernode());
      return ;
    }else
    {
      response.sendRedirect("/jsp/type/dynamicvalue/EditDynamicValue.jsp?NewNode=O&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"N&Type="+riobj.getRelatednews()+"&node="+riobj.getFathernode());
      return;
      //NewNode=ON&Type=" + j3 + "&node=" + node_code
    }
  }
}
	

  
%>


