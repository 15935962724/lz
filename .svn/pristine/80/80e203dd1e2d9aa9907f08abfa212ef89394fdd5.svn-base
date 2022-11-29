<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession=new TeaSession(request);
Resource r=new Resource("/tea/resource/Lucene");
String community=teasession._strCommunity;

String act = request.getParameter("act");
if(act!=null){
  out.println("检索索引生成中....<br/><span id=indexcount>0</span><script>var c=document.getElementById('indexcount'); function p(v){ c.innerHTML=v; }</script>");
    out.flush();
  if(act.equals("1")){

    LuceneList.indexPicture(teasession._strCommunity,out);
    out.println("<br>完成");
  }else
  {
    Lucene.index_diff(teasession._strCommunity,out);
    out.println("<br>完成");
    return;
  }
}
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
<body style="margin:0;">
<div id="wai">
<h1>
索引文件
</h1>
<input type="button" value="生成索引文件" onclick="window.location.href='/jsp/bpicture/SearchIndex.jsp?act=1'"/>
<!--<input type="button" value="差异索引文件" onclick="window.location.href='/jsp/bpicture/SearchIndex.jsp?act=2'"/>-->
</div>

</body>
</html>
