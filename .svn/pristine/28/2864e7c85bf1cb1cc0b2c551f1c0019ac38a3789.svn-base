<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.admin.*"%><%

tea.ui.TeaSession  teasession=new tea.ui.TeaSession(request);
if(teasession._rv!=null)
{
  Conductor obj=Conductor.find(teasession._rv._strR,teasession._strCommunity);
  String value=request.getParameter("value");
  if(value==null)
  value="";

// 如果( 后台会员||网站管理员|| 选定角色)
  if(obj.isExists()||  tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv._strR)||AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR).getRole().length()>1)
  {
    %><input id="accessbutton" type="button" value="<%=value%>" onclick="window.open('/jsp/admin/indextop.jsp?node=<%=teasession._nNode%>','_top');"><%
  }else
  if(AdminRole.findByType(teasession._strCommunity,1).hasMoreElements())//||后台有个"会员默认角色"
  {
    out.print("<input id=\"membercenter\" type=\"button\" value='"+value+"' onclick=\"window.open('/jsp/admin/?node="+teasession._nNode+"','_top');\" >");
  }
}

if(true)
return;
%>



