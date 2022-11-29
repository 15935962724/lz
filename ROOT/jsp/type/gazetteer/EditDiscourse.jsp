<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%
tea.entity.node.Discourse obj=tea.entity.node.Discourse.find(teasession._rv.toString());
boolean boold = teasession.getParameter("act").startsWith("d");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
* {	font-size: 9pt;
	color: #000000;
	text-decoration: none;
}

-->
</style>
</head>
<body style="background-color:transparent">
<h1><%=r.getString(teasession._nLanguage, "EditDiscourse")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
String name,time=null;
long len;
java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm");
if(boold)
{
  name=obj.getDiscourseName();
  if(obj.getDiscourse()!=null)
  {
    java.io.File file=new java.io.File(getServletContext().getRealPath(obj.getDiscourse()));
    if(file.exists())
    time=sdf.format(new java.util.Date(file.lastModified()));
  }
}else
{
  name=obj.getSyllabusName();
  if(obj.getSyllabus()!=null)
  {
    java.io.File file=new java.io.File(getServletContext().getRealPath(obj.getSyllabus()));
    if(file.exists())
    time=sdf.format(new java.util.Date(file.lastModified()));
  }
}
if(name!=null&&time!=null&&name.length()>0)
{
%>
  <tr>
    <td><a href="/servlet/EditDiscourse?act=down<%=boold?"discourse":"syllabus"%>"><%=name%></A></td>
    <td><%= time%> </td>
    <td><!--input class="edit_button" type="button" value="<%=r.getString(teasession._nLanguage,"Edit")%>" onClick="form1.style.visibility='';"-->
      <input class="edit_button" type="button" value="<%=r.getString(teasession._nLanguage,"Delete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/EditDiscourse?delete=ON&act=<%=boold?"discourse":"syllabus"%>', '_self')};"></td>
  </tr>
  <%}%>
</table>
<form method="POST" action="/servlet/EditDiscourse" enctype="multipart/form-data" name="form1" <%//if(index==-1)out.print(" style='visibility:hidden' ");%> >
  <div align="center">
    <input  class="edit_input" type="file" name="content"/>
    <input  class="edit_input" type="hidden" name="act" value="<%=boold?"discourse":"syllabus"%>"/>
    <input  class="edit_button" name="discourse" value="<%=r.getString(teasession._nLanguage,"Submit")%>" type="submit"/>
  </div>
</form>
<center>
  <input class="edit_button" type="button" value="<%=r.getString(teasession._nLanguage,"Close")%>" onclick="window.close();" />
</center>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

