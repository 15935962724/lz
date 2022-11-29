<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NodePreview")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
  DbAdapter dbadapter = new DbAdapter();
    DbAdapter dbadapter2 = new DbAdapter();
  String table = Node.NODE_TYPE[node.getType()];
  dbadapter.executeQuery("sp_columns " + table);
  try {
  r.add("/tea/resource/"+table);
  }
  catch (Exception ex) {
  }
  while (dbadapter.next()) {

    String name = dbadapter.getString(4);
    if(name.equalsIgnoreCase("language"))
    continue ;
String datatype= dbadapter.getString(6);
%>
  <tr>
    <td width=20% nowrap> <%=r.getString(teasession._nLanguage,name.substring(0,1).toUpperCase()+name.substring(1).toLowerCase())%>:</td>
    <td><%
  try {
    if("ntext".equals(datatype))
    {
      dbadapter2.executeQuery("SELECT DATALENGTH(" + name + "),"+name+" FROM " + table + " WHERE node=" + teasession._nNode + " and language=" + teasession._nLanguage);
      if(dbadapter2.next())
      out.print(dbadapter2.getText(teasession._nLanguage,teasession._nLanguage,1));
    }else
    {
      dbadapter2.executeQuery("SELECT " + name + " FROM " + table + " WHERE node=" + teasession._nNode + " and language=" + teasession._nLanguage);
      if(dbadapter2.next())
      out.print(dbadapter2.getVarchar(teasession._nLanguage,teasession._nLanguage,1));
    }
  }
  catch (Exception ex) {

    if("ntext".equals(datatype))
    {
      dbadapter2.executeQuery("SELECT DATALENGTH(" + name + "),"+name+" FROM " + table + " WHERE node=" + teasession._nNode);
      if(dbadapter2.next())
      out.print(dbadapter2.getText(1,1,1));
    }else
    {
      dbadapter2.executeQuery("SELECT " + name + " FROM " + table + " WHERE node=" + teasession._nNode );
      if(dbadapter2.next())
      out.print(dbadapter2.getVarchar(1,1,1));
    }
  }
%></td>
  </tr>
  <%
  }
      dbadapter.close();
      dbadapter2.close();
%>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Text")%></td>
    <td><%
  if((node.getOptions() & 0x40) == 0)
  {
    out.print((tea.html.Text.toHTML(node.getText(teasession._nLanguage))));
  }else
      out.print((node.getText(teasession._nLanguage)));
  %></td>
  </tr>
</table>
<INPUT class="edit_button" TYPE=Button NAME="CBBack" onclick="javaScript:window.close();" VALUE="<%=r.getString(teasession._nLanguage,"Close")%>">
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

