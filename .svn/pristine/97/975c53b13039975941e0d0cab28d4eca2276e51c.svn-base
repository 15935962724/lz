<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Node n=Node.find(teasession._nNode);
if(n.getType()>1)teasession._nNode=n.getFather();


out.print("document.write('");

///////////////////////////////////
out.print("本版版主有:");
java.util.Enumeration pfbyu_enumer=AdminUsrRole.find(teasession._strCommunity," AND bbshost LIKE '%/"+teasession._nNode+"/%'",0,Integer.MAX_VALUE);
if(!pfbyu_enumer.hasMoreElements())
{
  out.print("暂无");
}else
while(pfbyu_enumer.hasMoreElements())
{
  String member_temp=(String)pfbyu_enumer.nextElement();
  //Profile pf_obj_temp=Profile.find(member_temp);
  out.print("　"+member_temp);
}
///////////////////////////////////
out.print("　本版专家有:");
pfbyu_enumer=AdminUsrRole.find(teasession._strCommunity," AND bbsexpert LIKE '%/"+teasession._nNode+"/%'",0,Integer.MAX_VALUE);
if(!pfbyu_enumer.hasMoreElements())
{
  out.print("暂无");
}else
while(pfbyu_enumer.hasMoreElements())
{
  String member_temp=(String)pfbyu_enumer.nextElement();
  //Profile pf_obj_temp=Profile.find(member_temp);
  out.print("　"+member_temp);
}

out.print("');");
%>
