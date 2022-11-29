<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"  %>
<%@ page import="tea.entity.*"  %>
<%@ page import="tea.resource.Resource"  %>
<%@ page import="tea.entity.node.*"  %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/Node?node=2198284&language=1");
  return;

}

String popedom=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR).getAdminfunction();
int id=Integer.parseInt(request.getParameter("id"));
System.out.print(popedom);
if(popedom.indexOf("/"+id+"/")!=-1)
{
  AdminFunction af_node =AdminFunction.find(id);
  String url=af_node.getUrl(teasession._nLanguage);
  if("".equals(url))
  {
    out.print("无效菜单");
    //url="/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("&#27492;&#21151;&#33021;&#24320;&#21457;&#24314;&#35774;&#20013;!","UTF-8");
  }else
  if(url.startsWith("javascript:"))
  {
    out.print("<script>"+url.substring(11)+"</script>");
  }else
  {
    url=url+(url.indexOf("?")==-1?"?":"&")+"node="+teasession._nNode+"&community="+teasession._strCommunity;
    String info=request.getParameter("info");
    if(info!=null)
    {
      url=url+"&info="+java.net.URLEncoder.encode(info,"UTF-8");
    }
    String debug=request.getParameter("debug");
    if(url.startsWith("http://")||"127.0.0.01".equals(request.getServerName())||"v609".equals(debug))
    {
      response.sendRedirect(url);
    }else
    {
      Logs.create(teasession._strCommunity, teasession._rv, 10, id,af_node.getName(teasession._nLanguage));
      application.getRequestDispatcher(url).forward(request,response);
      /*
      %>
      <jsp:forward page="<%=url%>">
        <jsp:param name="node" value="<%=teasession._nNode%>"/>
          <jsp:param name="community" value="<%=teasession._strCommunity%>"/>
            <jsp:param name="info" value="<%=request.getParameter("info")%>"/>
      </jsp:forward>
      <%
      */
    }
  }
  return;
}

response.sendError(403);

%>
