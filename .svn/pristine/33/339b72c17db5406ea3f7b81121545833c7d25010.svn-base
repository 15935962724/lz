<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="java.util.*"%><%@page import="java.net.*"%><%@page import="tea.entity.site.*" %>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
if("test".equals(request.getQueryString()))
{
  System.out.println("保侍会话:"+teasession._rv);
}


String url=request.getParameter("url");
String tree=request.getParameter("tree");
if(tree==null)tree="about:blank";

Community c=Community.find(teasession._strCommunity);

String desktop=c.getDesktop();
if(desktop==null||desktop.length()<1)
{
  desktop=("DefaultDesktop.jsp");
}
if(url==null)
{
  url=desktop;
}
/*
//默认的显示菜单的 一个id
int root=AdminFunction.getRootId(teasession._strCommunity,teasession._nStatus);
java.util.Enumeration e = AdminFunction.findByFather(root);
AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
String popedom=aur.getAdminfunction();
String trss = "about:blank";
while(e.hasMoreElements())
{
  int afid = ((Integer)e.nextElement()).intValue();
  if(popedom.indexOf("/"+afid+"/")!=-1)
  {
    AdminFunction af = AdminFunction.find(afid);
    if(af.isHidden())
    {
      if(af.getType()==0)
      {
        trss="/jsp/admin/index_leftup.jsp?id="+afid+"&node="+teasession._nNode+"&community="+teasession._strCommunity;
        break;
      }else//功能菜单
      {
        //out.print("<a id='ToDesktop' href='/jsp/admin/right.jsp?id="+afid+"&node="+teasession._nNode+"&community="+teasession._strCommunity+"&info="+java.net.URLEncoder.encode(af.getName(teasession._nLanguage),"UTF-8")+"' target='"+af.getTarget()+"' >"+af.getName(teasession._nLanguage)+"</a>");
        //trss="/jsp/admin/index_leftup.jsp?id="+afid+"&node="+teasession._nNode+"&community="+teasession._strCommunity;
        //break;
      }
    }
  }
}
//默认左侧菜单
if(tree==null)
{
  tree=trss;//"/jsp/admin/index_leftup.jsp?id="+id_a+"&node="+teasession._nNode+"community="+teasession._strCommunity;
}
*/

%>
<!doctype html>
<html>
<script>
window.name=null;
function fchangetitle()
{
  var newt="<%=c.getName(teasession._nLanguage)%>";
  try
  {
    var b=window.m.document.title;
    if(b)newt=b+" "+newt;
  }catch(e)
  {}
  if(window.document.title!=newt)window.document.title=newt;
}
window.setInterval("fchangetitle();",1000);
</script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<frameset id="frame" rows="120,*"  frameborder="NO" border="0" framespacing="0">
  <frame src="index_head.jsp?community=<%=teasession._strCommunity%>&url=<%=java.net.URLEncoder.encode(desktop,"UTF-8")%>" name="topFrame" id="topFrame" marginheight="10" scrolling="NO" noresize>
  <frameset id="frame2" cols="180,*,0" rows="*" frameborder="no" border="0" framespacing="0">
     <frameset id="frame3" cols="*" rows="*,90" frameborder="no" border="0" framespacing="0">
       <frame id="MenuFrame" name="MenuFrame" src="<%=tree%>" >
       <frame name="MenuFrameyu" id="MenuFrameyu" src="/jsp/admin/index_profile.jsp?community=<%=teasession._strCommunity%>&showcount=10&igd=0">
     </frameset>
    <frame name="m" src="<%=url%>">
    <frame id="RightFrame" name="RightFrame" src="about:blank">
  </frameset>
</frameset>


</html>
