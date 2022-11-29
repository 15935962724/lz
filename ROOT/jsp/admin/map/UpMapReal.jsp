<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.admin.map.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String view=request.getParameter("view");
if(view!=null)
{
  %>
<APPLET CODE="ptviewer.class" ARCHIVE="/tea/applet/ptviewer.jar" WIDTH=400 HEIGHT=300>
<PARAM NAME=file VALUE="<%=view%>">
<PARAM NAME=cursor VALUE="MOVE">
<!--
<PARAM NAME=pan VALUE=-105>
<PARAM NAME=showToolbar VALUE="true">
<PARAM NAME=imgLoadFeedback VALUE="false">
<PARAM NAME=hotspot0 VALUE="X21.3 Y47.7 u'Sample27L2.htm' n'Hotspot description'">
<PARAM NAME=wait VALUE="/res/chinaserve/u/0710/071040557.jpg">
-->
</APPLET>
  <%
  return;
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel=stylesheet type=text/css>
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_seq(v)
{
  form1.seq.value=v;
  return submitText(eval('form1.pic'+v),'无效-图片');
}
</script>
</head>
<body>

<h1>上传合景图图</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form NAME="form1" ACTION="/servlet/EditMapReal" METHOD="post" enctype="multipart/form-data" onSubmit="">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
 <input type='hidden' name="repository" value="mapreal">
 <input type='hidden' name="watermark" value="false">
 <input type='hidden' name="act" value="up">
 <input type='hidden' name="seq" value="0">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
  int count=0;
  for(int i=0;i<8;i++)
  {
    String pic="/res/"+teasession._strCommunity+"/mapreal/"+teasession._nNode+"_"+i+".jpg";
    File f=new File(application.getRealPath(pic));
    out.println("<tr><td>图"+(i+1)+"</td>");
    out.println("<td><input type=file name=pic"+i+">");
    if(f.length()>0L)
    {
      out.print("<a href="+pic+" target=_blank>"+f.length()+"</a>");
      count++;
    }
    out.println("  　<input type=submit onclick=\"return f_seq("+i+");\" value=上传></td>");
  }
%>
</TABLE>
<script>
function f_con()
{
  if(<%=count%>==0)
  {
    alert("请先上传图片");
    return false;
  }
  if(<%=count%><8&&!confirm('没有上传够8张,确认生成?'))
  {
    return false;
  }
  form1.act.value="360";
  return true;
}
</script>

<input TYPE="submit" VALUE="生成全景图" onclick="return f_con();">

<%
String pic="/res/"+teasession._strCommunity+"/mapreal/"+teasession._nNode+".jpg";
File f=new File(application.getRealPath(pic));
if(f.exists())
{
  out.print("<input TYPE=button VALUE=查看 onclick=window.open('?view="+pic+"','_self');>");
}
%>

</FORM>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
