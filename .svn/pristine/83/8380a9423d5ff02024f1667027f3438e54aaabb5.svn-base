<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=request.getParameter("community");
int  archives = Integer.parseInt(teasession.getParameter("archives"));
Archives obj = Archives.find(archives);

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

<h1>文件登记详细内容</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr >
    	 <td nowrap>发布人</td> <td nowrap><%=obj.getMember() %></td>
      </tr>
      <tr><td nowrap>发布时间</td><td nowrap><%=obj.getTimes() %><td></tr>
      <tr><td nowrap>标题</td><td nowrap><%=obj.getCaption() %></td></tr>
      <tr><td nowrap>内容</td><td ><%=obj.getContent()%></td></tr>
      <tr><td nowrap>附件文件</td><td nowrap>

      <%
	out.print("<a href =\"/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(obj.getFileurl(),"UTF-8")+"&name="+java.net.URLEncoder.encode(obj.getFilename(),"UTF-8")+"\">"+obj.getFilename()+"</a><br>");
    %>
      </td></tr>
      <tr align="center" class="TableControl">
      <td colspan="2">
        <input type="button" value="关闭"  onClick="javascript:window.close();">
      </td>
    </tr>
    </table>
</body>
</html>



