<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@ page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int bulletin=Integer.parseInt(request.getParameter("bulletin"));

Resource r=new Resource();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	margin-top: 0px;
}
-->
</style>
<script type="">
function f_act(act,id)
{
  if(act=='delfile')
  {
    if(!confirm('确认删除?'))
    {
      return false;
    }
  }
  form1.act.value=act;
  form1.bullfile.value=id;
  form1.submit();
}
var attach=parent.document.getElementById('attach');
</script>
</head>
<body id="tablecenter" style="text-align:left">

<form name="form1" METHOD="post" action="/servlet/EditBulletin" ENCtype="multipart/form-data">
<input type="hidden" name="bulletin" value="<%=bulletin%>">
<input type="hidden" name="act" value="addfile">
<input type="hidden" name="bullfile" value="0">


<input type="button" style="position:absolute" value="上传附件">  <input type="file" name="file" style="position:absolute;width:10;cursor:hand;filter:Alpha(opacity=0)" onchange="f_act('addfile');"/>
<table border="0" cellpadding="0" cellspacing="0">
<%
int i=1;
java.util.Enumeration e=Bulletin.find(bulletin).findFile();
while(e.hasMoreElements())
{
  Object os[]=(Object[])e.nextElement();
  out.print("<tr><td>"+i+++"<td><a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode((String)os[1],"UTF-8")+"&name="+java.net.URLEncoder.encode((String)os[2],"UTF-8")+">"+os[2]+"</a>");
  out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=f_act('delfile','"+os[0]+"') />");
}
out.print("<script>attach.style.height='"+(i*25)+"px';</script>");
%>
</table>
</form>

