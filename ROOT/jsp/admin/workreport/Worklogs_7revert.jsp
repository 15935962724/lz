<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>


<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

tea.resource.Resource r=new tea.resource.Resource();



int worklog = Integer.parseInt(request.getParameter("worklog"));

String nexturl=request.getParameter("nexturl");
//String nexturl=request.getRequestURI()+"?worklog="+worklog;

%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1>问题回复管理</h1>
<form name="form1" method="POST" action="/servlet/EditWorkreport">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
<input type=hidden name="action" value="revertquestion"/>
<input type=hidden name="worklog" value="<%=worklog%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>

<%



Worklog obj=Worklog.find(worklog);
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>时间:　　 <%=obj.getTimeToString()%></td></tr>
<tr><td>提问人:　 <%=obj.getMember()%></td></tr>
<tr><td>内容:　　 <%=obj.getContent(teasession._nLanguage)%></td></tr>
</table>

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</td>
    <td nowrap><textarea  name="revertquestion"  rows="8" cols="70" ><%if(obj.getRevertQuestion()!=null)out.println(obj.getRevertQuestion());%></textarea>
    </td>
</tr>
<tr><td><input type="checkbox" name="checkbox1" >发送邮件</td><td><input type="checkbox" name="checkbox2" >内部邮件</td></tr>
</TABLE>

<input TYPE=SUBMIT onClick="return(submitText(foEdit.Text, '<%=r.getString(teasession._nLanguage,"InvalidParameter")%>'));" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>


