<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="java.util.Date"%>

<%@page import="tea.entity.Entity"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.util.ZoomOut"%>
<%@page import="java.util.ArrayList" %>



<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.entity.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
return;
}
Resource r = new Resource();

r.add("/tea/ui/node/type/chat/SendChat");
String text = teasession.getParameter("buffer");
String member = teasession._rv.toString();
String attach = teasession.getParameter("attach");
int action = Integer.parseInt(teasession.getParameter("action"));

StringBuffer sp = new StringBuffer();

sp.append("<table border='0' cellpadding='0' cellspacing='0' id='tablechat'><tr><td class=td01><span class=name>"+member+"</span>");
sp.append("&nbsp;");

sp.append(r.getString(teasession._nLanguage, Chat.CHAT_ACTION[action]));

sp.append("：</td><td class=td02>　"+text);


if(attach!=null&&attach.length()>0)
{
	sp.append("<br />");
  String ex=attach.substring(attach.lastIndexOf('.')+1).toLowerCase();
  if(ex.equals("jpg")||ex.equals("png")||ex.equals("gif")||ex.equals("bmp"))
	  sp.append("<img src='"+attach+"' />");
  else
	  sp.append("<a href='"+attach+"'>"+r.getString(teasession._nLanguage, "Download")+"</a>");
}


sp.append("<span class=time>");
sp.append(Entity.sdf2.format(new Date())); 
sp.append("</span></td></tr></table>");



ArrayList al_say=new ArrayList(); 






if(application.getAttribute("accp")==null)
{
	al_say=(ArrayList)application.getAttribute("accp"); 
	al_say.add(sp.toString()); 	
}else
{
	al_say=(ArrayList)application.getAttribute("accp"); 
	al_say.add(sp.toString()); 
}



String community = teasession._strCommunity;
RV rv = new RV(teasession.getParameter("to"));


tea.entity.RV currentlyrv;
if(teasession._rv == null)
{
    currentlyrv = new RV(member,community);
} else
{
    currentlyrv = teasession._rv;
}



if(attach != null && attach != null)
{
    File f = new File(getServletContext().getRealPath(attach)); 
    BufferedImage bi = ImageIO.read(f);
    if(bi != null)
    {
        ZoomOut zo = new ZoomOut();
        bi = zo.imageZoomOut(bi,300,200);
        ImageIO.write(bi,"JPEG",f);
    }
} 



if(text.trim().length() != 0 ) 
{
    Chat.create(teasession._nNode,currentlyrv,action,rv,teasession._nLanguage,text,attach);
}






response.sendRedirect("/jsp/type/chat/SendChat.jsp?community="+teasession._strCommunity);

%>