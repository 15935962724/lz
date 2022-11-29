<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);
int type = -1;//创建文件
if(teasession.getParameter("type")!=null)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}

int membertype =0;//创建文件s
if(teasession.getParameter("membertype")!=null)
{
  membertype = Integer.parseInt(teasession.getParameter("membertype"));
}
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
%>

<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="<%
if(type==0)
{
  out.print("sAlert('您的稿件已经上传成功,我的工作人员会尽快处理.<a id=do_OK  href =/jsp/type/report/contributors/ContributorsList.jsp?node="+teasession._nNode+"&membertype="+membertype+">查看我的稿件</a>','稿件上传提示','<input type=button value=返回  onClick=javascript:window.history.go(-1);>');");
}else if(type == 1)
{
  out.print("sAlert('您的稿件已经修改成功,我的工作人员会尽快处理.<a id=do_OK  href =/jsp/type/report/contributors/ContributorsList.jsp?node="+teasession._nNode+"&membertype="+membertype+">查看我的稿件</a>','稿件上传提示','<input type=button value=返回  onClick=javascript:window.history.go(-1);>');");
}else if(type == 2)
{
   out.print("sAlert('您的稿件已经删除成功.<a id=do_OK  href =/jsp/type/report/contributors/ContributorsList.jsp?node="+teasession._nNode+"&membertype="+membertype+">查看我的稿件</a>','稿件上传提示','<input type=button value=返回  onClick=javascript:window.history.go(-1);>');");
}else
{
 out.print("sAlert('您的操作好像不正确，请检查下吧.','稿件上传提示','<input type=button value=关闭  onClick=javascript:window.close();>');");
}
%>

">
<table style="width:100%;height:90%;">
<tr><td valign="top" ><SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT></td></tr>
<tr><td></td></tr>
<tr><td valign="bottom"><SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT></td></tr>
</table>
</body>

</html>
