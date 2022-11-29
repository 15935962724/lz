<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
int menu=h.getInt("menu");

WxMenu wm=WxMenu.find(menu);

out.print("<MsgType>text</MsgType>");
out.print("<Content><![CDATA["+wm.name+"]]></Content>");


%>
