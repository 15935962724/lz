<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  return;
}

String member=teasession._rv._strV;

StringBuilder h=new StringBuilder();
h.append("<tr class='lzj_bian'><td style='text-align:left;line-height:150%;padding-left:15px;padding-top:8px;'>欢迎您：<span style='COLOR:#f00'>"+member+"</span></td></tr>");

if(member.equals("admin"))//管理者
{
  h.append("<tr class='lzj_bian'><td  height='50' style='padding-left:20px;'><a href='/jsp/admin/?node="+teasession._nNode+"' ><img src='/res/cavendishgroup/u/0810/081060575.jpg'></a><br/></td></tr>");
}else
{
  int ccid=CioCompany.findByMember(member);
  if(ccid<1||CioCompany.find(ccid).getContact()==null)
  {
    h.append("<tr class='lzj_bian'><td height='50' style='padding-left:20px;'><a href='/jsp/cio/EditCioCompany.jsp?community="+teasession._strCommunity+"' ><img src='/res/cavendishgroup/u/0810/081011517.jpg'></a><br/></td></tr>");
  }else
  {
    h.append("<tr class='lzj_bian'><td  height='50' style='padding-left:20px;'><a href='/jsp/admin/?node="+teasession._nNode+"' ><img src='/res/cavendishgroup/u/0810/081011523.jpg'></a><br/></td></tr>");
  }
}
out.print("document.write(\""+h.toString()+"\");");

%>
