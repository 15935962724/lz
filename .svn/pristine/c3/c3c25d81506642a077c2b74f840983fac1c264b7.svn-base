<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%
  if (request.getMethod().equals("POST")) {
    byte by[] = teasession.getBytesParameter("content");
    String name =new String(teasession.getParameter("contentName").getBytes("ISO-8859-1"));
    while(name.charAt(0)=='_')
    {
      name=name.substring(1);
    }
    }
    java.io.File file = new File(getServletContext().getRealPath("/tea/image/type/" + teasession._rv.toString() + "_" + name));
    if (!file.exists()) {
      java.io.FileOutputStream fw = new FileOutputStream(file);
      fw.write(by);
      fw.close();
    }
  }else
  {
    if(teasession.getParameter("delete")!=null)
    {
      String name=new String(teasession.getParameter("name").getBytes("ISO-8859-1"));
      if(name.startsWith(teasession._rv.toString()+"_"))
      new File(getServletContext().getRealPath("/tea/image/type/" +name)).delete();
    }
  }
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EGazetteer")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<%
  java.io.File file = new File(getServletContext().getRealPath("/tea/image/type/"));
  java.io.File files[] = file.listFiles();
  for (int index = 0; index < files.length; index++) {
    if (files[index].getName().startsWith(teasession._rv.toString() + "_")) {
      String name = files[index].getName();
%>
<%=name%>  <input type="button" value="删除" onClick="if(confirm('确认删除')){window.open('GazetteerUp.jsp?delete=ON&name=<%=name%>', '_self')};"><br>
<%
  }
      }
%>
<form method="POST" enctype="multipart/form-data">
  <input type="file" name="content"/>
  <input name="up" value="上传" type="submit"/>
</form>
<center>
  <INPUT TYPE=button NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
  <INPUT TYPE=button onclick="window.open('/servlet/Gazetteer')" name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</center>
<div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</html>

