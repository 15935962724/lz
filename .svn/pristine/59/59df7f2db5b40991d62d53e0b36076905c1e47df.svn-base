<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int fileendorse = Integer.parseInt(request.getParameter("fileendorse"));
String member = request.getParameter("member");
FileEndorse f = FileEndorse.find(fileendorse,member);
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


  <body>

  <h1>文件会签</h1>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>


    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

      <tr >
        <td nowrap><b>不批准的原因:</b><%=f.getContent2() %></td>

      </tr>
<tr align="center" class="TableControl">
      <td colspan="2">
        <input type="button" value="关闭"  onClick="javascript:window.close();">
      </td>
    </tr>
        </table>

<br>


<div id="head6"><img height="6" src="about:blank"></div>
    </body>
  </html>



