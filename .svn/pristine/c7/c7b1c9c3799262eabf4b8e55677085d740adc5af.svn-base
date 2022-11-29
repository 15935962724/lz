<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.service.version.Version" %>
<%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
/*
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
*/

Version v=new Version();
String path=request.getSession().getServletContext().getRealPath("/");
v.getversion(path+"\\version\\version.properties");
Resource r=new Resource("/tea/resource/Lucene");
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>
升级包列表
</title>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "升级包列表")%></h1>
<p>当前版本是<%=v.getCurversion()%></p>
<div id="head6"><img height="6" alt=""></div>
<br>

<table border="1" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
<td>升级文件</td>
<td>操作</td>
</tr>
<%

 File f = new File(path+"\\version");
 if (f.exists())
            {
     File fs[] = f.listFiles();
     for (int i = 0; i < fs.length; i++)
{
 String filename1=fs[i].getName();
 String filename=filename1.substring(0,filename1.lastIndexOf("."));
 String extent=filename1.substring(filename1.lastIndexOf(".")+1);
 if (extent.equals("zip"))
  {%>
  <tr>
   <form action="/servlet/ExecuteUpdate">
   <input type="hidden" name="filename" value="<%=filename%>">
    <td><%=filename%></td>
     <td><input type="submit" value="升级"></td>
 </form>


  </tr>
<%}
}
            }
%></table>




<div id="head6"><img height="6" alt=""></div>

</body>
</html>
