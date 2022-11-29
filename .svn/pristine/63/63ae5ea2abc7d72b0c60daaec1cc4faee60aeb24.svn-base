<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.Entity"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.entity.RV"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
    out.print("请先登录系统");
    return;
}

%>

<html>
<head>
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
</head>
<%
int size = Integer.parseInt(teasession.getParameter("size"));


out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablechat'>");
int i = 0;
 
  for(Enumeration enumeration = Chat.find(teasession._nNode, teasession._rv, i,0,size); enumeration.hasMoreElements();)
  {
	
    i = ((Integer)enumeration.nextElement()).intValue();
    Chat chat = Chat.find(i);
    RV rv = chat.getFrom();
    RV rv1 = chat.getTo();
    Profile pobj = Profile.find(rv.toString());
    String member = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
    if(member==null)
    {
    	member = rv.toString();
    }
    
    

    String s = rv.toString();

    int j = chat.getAction();


      out.print("<tr><td class=td01><span class=name>"+member+"</span>");

    
      out.print("：</td><td class=td02>　"+chat.getText(teasession._nLanguage));
      String attach=chat.getAttach();
 
	out.print("　<span class=time>");
	out.print(chat.getTimeToString());
	out.print("</span></td></tr>");
  

    
  }
out.print("</table>");


%>

