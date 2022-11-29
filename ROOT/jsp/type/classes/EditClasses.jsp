<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();


int classid=0;
if(request.getParameter("classid")!=null)
{
  classid=Integer.parseInt(request.getParameter("classid"));
}


int type=0;
if(request.getParameter("type")!=null)
{
  type=Integer.parseInt(request.getParameter("type"));
}
String name=null;
if(classid!=0)
{
  Classes c=Classes.find(classid);
  name=c.getName();
}else
{
  name="";
}
String title=r.getString(teasession._nLanguage, "EditClasses");
%>
<html>
<head>
<title><%=title%></title>
<base target="dialog"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.name.focus();">
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name="form1" METHOD=POST action="/servlet/EditClasses" onsubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>');">
<input type='hidden' name="node" VALUE="<%=teasession._nNode%>">
<input type='hidden' name="classid" VALUE="<%=classid%>">
<input type='hidden' name="type" VALUE="<%=type%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Classes")%>:</td>
    <td><input type="TEXT" class="edit_input"  name="name" value="<%=name%>"></td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBClose")%>" onClick="window.close();">
</FORM>

<iframe style="display:none" name="dialog"></iframe>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
