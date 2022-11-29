<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%
  if (request.getMethod().equals("POST")) {
    byte by[] = teasession.getBytesParameter("content");
    StringBuffer name = new StringBuffer(new String(teasession.getParameter("contentName").getBytes("ISO-8859-1")));
    for (int index = 0; index < name.length(); index++) {
      if (name.charAt(index) == '_') {
        name.deleteCharAt(index);
        index--;
      }
    }
    java.io.File file = new File(getServletContext().getRealPath("/tea/image/type/" + teasession._rv.toString() + "_" + name.toString()));
    if (!file.exists()) {
      java.io.FileOutputStream fw = new FileOutputStream(file);
      fw.write(by);
      fw.close();
    }
  }
  else
  {
    if (request.getParameter("delete") != null)
    {
      String name = new String(request.getParameter("name").getBytes("ISO-8859-1"));
      if (name.startsWith(teasession._rv.toString() + "_"))
        new File(getServletContext().getRealPath("/tea/image/type/" + name)).delete();
    }
  }
  int type=Integer.parseInt(request.getParameter("Type"));
    if(type==58||type==60)teasession._nLanguage=1;
  else
  teasession._nLanguage=0;
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
<body>
<h1><%=r.getString(teasession._nLanguage, "GazetteerUp")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
  java.io.File file = new File(getServletContext().getRealPath("/tea/image/type/"));
  java.io.File files[] = file.listFiles();
  for (int index = 0; index < files.length; index++) {
    if (files[index].getName().startsWith(teasession._rv.toString() + "_")) {
      String name = files[index].getName();
%>
  <tr>
    <td><%=name%></td>
    <td><input class="edit_button" type="button" value="<%=r.getString(teasession._nLanguage,"Delete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('GazetteerUp.jsp?Type=<%=type%>&delete=ON&name=<%=name%>', '_self')};"></td>
  </tr>
  <%
  }
  }

      String str = "";
  switch (type) {
  case 58:
    str = "/jsp/type/register/EditRegister.jsp";
    break;
  case 59:
    str = "/jsp/type/eregister/EditERegister.jsp";
    break;
  case 60:
    str = "/jsp/type/gazetteer/EditGazetteer.jsp";
    break;
  case 61:
    str = "/jsp/type/egazetteer/EditEGazetteer.jsp";
    break;
  }
%>
</table>
<form method="POST" enctype="multipart/form-data">
  <div align="center">
    <input  class="edit_input" type="file" name="content"/>
    <input type="hidden" name="Type" value="<%=request.getParameter("Type")%>"/>
    <input  class="edit_button" name="up" value="<%=r.getString(teasession._nLanguage,"Submit")%>" type="submit"/>
  </div>
</form>
<center>
  <input class="edit_button" type="button" value="<%=r.getString(teasession._nLanguage,"Close")%>" onclick="window.close();" />
</center>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

