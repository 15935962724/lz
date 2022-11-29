<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
int  bulletin = Integer.parseInt(teasession.getParameter("bulletin"));
Bulletin obj = Bulletin.find(bulletin);
if(!obj.isExists())
{
       out.print("<script  language='javascript'>alert('抱歉!您查看的文件已经删除!');window.close();</script> ");
}
else
{
Profile p = Profile.find(obj.getMember());

//int i = Integer.parseInt(request.getParameter("message"));
//Message mobj = Message.find(i);
//mobj.setReader(teasession._rv.toString());

obj.set();

IfNotRead.create(bulletin,teasession._rv._strV);


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>查看公告通知</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>


<table border="0" cellpadding="0" cellspacing="0" >
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap align="right">标　　题</td>
      <td nowrap><%=obj.getCaption() %></td></tr>
      <tr >
        <td nowrap align="right">发 布 人</td>
        <td nowrap><%=p.getName(teasession._nLanguage) %></td>
      </tr>
      <tr>
        <td nowrap align="right">发布时间</td>
        <td nowrap><%=obj.getIssuetimeToString() %></td>
      </tr>
  </table>

  <h1>公告详细内容</h1>
  <table border="0" cellpadding="0" cellspacing="0" id="neirong">
    <tr align="center"><td height="40px"><b><%=obj.getCaption() %></b></td></tr>
    <tr><td><%=obj.getContent()%></td></tr>
    <tr>
      <td nowrap>　　附件：
      <%
      java.util.Enumeration e=obj.findFile();
      while(e.hasMoreElements())
      {
        Object os[]=(Object[])e.nextElement();
        out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode((String)os[1],"UTF-8")+"&name="+java.net.URLEncoder.encode((String)os[2],"UTF-8")+">"+os[2]+"</a><br/>");
      }
    %>
    　</td></tr>
    <tr align="right" class="TableControl">
      <td colspan="2">
        <input type="button" value="关闭"  onClick="javascript:window.close();">      </td>
    </tr></table>
</body>
</HTML>

<%} %>

