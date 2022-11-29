<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.io.*" %><%@page import="tea.db.*" %><%@page import="tea.resource.*" %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

if("POST".equals(request.getMethod()))
{
  byte[] by=teasession.getBytesParameter("file");
  if(by==null)
  { 
    out.print("<script>alert('无效文件!');history.back();</script>");
    return;
  }
  String xls=application.getRealPath("/res/"+teasession._strCommunity+"/imp/"+Entity.sdf3.format(new Date()).replace(':','_')+".xls");
  Filex.write(xls,by);
  ProfileGolf.imp(new File(xls),teasession._strCommunity,"888888",out);
  return;
}
Http h=new Http(request);
int menuid=h.getInt("id");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>会员导入</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>Excel文件导入</h2>
<form action="?" method="POST" enctype="multipart/form-data">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter">
<tr><td>文件:
<input name="file" type="file" />
<input type="submit" value="提交" />
<input type="button" value="返回" onClick="history.back();"/>
</td></tr>
<tr><td>Excel文件的<a href="/jsp/include/DownFile.jsp?uri=/jsp/type/golf/Golf_Ex.xls">样表下载</a>
</td></tr>
</table>



</form>

</body>
</html>
