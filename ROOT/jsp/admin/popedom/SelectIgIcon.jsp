<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.io.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/fun");

String field=request.getParameter("field");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
<style>
span
{
	width:100px;
	height:100px;
	cursor:hand;
	
	float:left;
	border:1px solid #DBE6F4;
	margin:2px;
	padding:10px;
}
</style>
<script>
function sel(value)
{
window.opener.document.<%=field%>.value="/tea/image/igicon/"+value;
window.close();
}
function load()
{
  var s=document.getElementsByTagName("SPAN");
  for(var i=0;i<s.length;i++)
  {
     s[i].onmouseover=function(){"this.style.background='#BCD1E9'"};
     s[i].onmouseout=function(){"this.style.background=''"};
  }
}
</script>
</head>
<body >

<h1><%=r.getString(teasession._nLanguage, "MenuManage")%></h1>
<div id="head6"><img height="6" alt=""></div>


<form method="post" name="form1" action="/servlet/EditAdminPopedom">
<input  type="hidden" name="Node" value="<%=teasession._nNode%>">
<input  type="hidden" name="community" value="<%=teasession._strCommunity%>">

<%
String fs[]=new File(application.getRealPath("/tea/image/igicon/")).list();
if(fs!=null)
{
	for(int i=0;i<fs.length;i++)
	{
		//if(!"Thumbs.db".equals(fs[i]))
		out.println("<SPAN onmouseover=\"this.style.background='#BCD1E9';\" onmouseout=\"this.style.background='';\"  onclick=\"sel('"+fs[i]+"');\"><img src=/tea/image/igicon/"+fs[i]+"><br>"+fs[i]+"</SPAN>");
	}
}
%>

</form>

<br>
<div id="head6"><img height="6" alt=""></div>
</body>
</html>


