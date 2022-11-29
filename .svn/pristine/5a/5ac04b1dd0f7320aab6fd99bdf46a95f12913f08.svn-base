<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
AdminUnit au=AdminUnit.find(aur.getUnit());

if(aur.getUnit()==0 || au.isHiddenorg())//不显在组织机构中跳转无权访问页面
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("对不起，您无权限访问此页面！","utf-8"));
  return;
}

String act=request.getParameter("act");
if(act!=null)
{
  Community c=Community.find(teasession._strCommunity);
  if(act.equals("before"))
  {
    String picex=au.getPictureEx();
   // out.print(picex!=null?"<div style='margin:-15px 0px 0px -10px;'><img src='"+picex+"' /></div>":c.getJspBefore(teasession._nLanguage));
    
    
    //style="<%if(picex!=null)out.print("background-image:url("+picex+")");
     
	out.println("<link href=\"/res/"+teasession._strCommunity+"/cssjs/community.css\" type=\"text/css\"  rel=\"stylesheet\">");
    out.print("<body ><table width=\"100%\" height=\"100%\"  border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"toutable\" ");
    if(picex!=null)
    { 
    	out.print("style=\"background:url("+picex+") no-repeat left top;\"  ");
    }
     out.print(">");
    out.println("<tr><td></td></tr>"); 
    out.println("</table></body>");
    
  }else if(act.equals("after"))
  {
    out.print(c.getJspAfter(teasession._nLanguage));
  }
  return;
}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<html>
<frameset rows="80,*" frameborder="no" border="0" framespacing="0">
  <frame src="/jsp/admin/popedom/AdminUnitFrame.jsp?community=<%=teasession._strCommunity%>&act=before" scrolling="No" noresize="noresize">
  <FRAMESET border=0 frameSpacing=0 rows=* frameBorder=YES cols=190,*>
    <FRAME name="function_funlist" src="/jsp/admin/popedom/AdminUnitTree.jsp?community=<%=teasession._strCommunity%>" frameBorder=NO noResize scrolling=yes>
    <FRAME name="adminunit_main" src="/jsp/admin/popedom/AdminUnitList.jsp?community=<%=teasession._strCommunity%>" noResize scrolling=yes>
  </FRAMESET>
  <!--
  <frame src="/jsp/admin/popedom/AdminUnitFrame.jsp?community=<%=teasession._strCommunity%>&act=after" scrolling="No" />
  -->
</frameset>
</html>
