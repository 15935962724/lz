<%
try
{
  StringBuffer sb=new StringBuffer();
  sb.append("<H1>Parameter</H1><hr align=left width=100 size=5 noshade>");
  java.util.Enumeration enumer=request.getParameterNames();
  while(enumer.hasMoreElements())
  {
    String name=enumer.nextElement().toString();
    sb.append(name+"<hr align=left width=100 size=5 noshade>"+request.getParameter(name)+"<hr size=5 noshade>");
  }

  sb.append("<br/><H1>Header</H1><hr align=left width=100 size=5 noshade>");
  enumer=request.getHeaderNames();
  while(enumer.hasMoreElements())
  {
    String name=enumer.nextElement().toString();
    sb.append(name+"<hr align=left width=100 size=5 noshade>"+request.getHeader(name)+"<hr size=5 noshade>");
  }

  sb.append("<br/><H1>Session</H1><hr align=left width=100 size=5 noshade>");
  enumer=session.getAttributeNames();
  while(enumer.hasMoreElements())
  {
    String name=enumer.nextElement().toString();
    sb.append(name+"<hr align=left width=100 size=5 noshade>"+session.getAttribute(name).toString()+"<hr size=5 noshade>");
  }

  sb.append("<br/><H1>Other</H1><hr align=left width=100 size=5 noshade>");
  sb.append("URL<hr align=left width=100 size=5 noshade>"+request.getRequestURL().toString()+"<hr size=5 noshade>");
  sb.append("IP<hr align=left width=100 size=5 noshade>"+request.getRemoteAddr()+"<hr size=5 noshade>");
  sb.append("Method<hr align=left width=100 size=5 noshade>"+request.getMethod()+"<hr size=5 noshade>");
  /*  sb.append("message<hr align=left width=100 size=5 noshade>"+info+"<hr size=5 noshade>");

  tea.entity.site.Community community=tea.entity.site.Community.find(node.getCommunity());
  String webn=community.getName(teasession._nLanguage);
  String conent=new String(sb.toString().getBytes(tea.ui.TeaServlet.CHARSET[teasession._nLanguage]),"iso-8859-1");
  String str=new String((request.getServerName()+":"+request.getHeader("REFERER")).getBytes(tea.ui.TeaServlet.CHARSET[teasession._nLanguage]),"iso-8859-1");
  int k = tea.entity.member.Message.create(null, community.getEmail(), 0, 0, 2, 0, teasession._nLanguage, str, conent,null,null,"",null,"liuhongyan@redcome.com","", "", null, null, 0, 0);

  tea.service.Robot.activateRoboty(teasession._nNode,k);
  */
} catch (Exception _ex)
{}
%>

