<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
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

String q=request.getParameter("q");

StringBuilder sql=new StringBuilder();
if(q!=null)
{
  sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+q+"%"));
}

if("POST".equals(request.getMethod()))
{
  String content=request.getParameter("content");
  CioFeedback.create(teasession._strCommunity,teasession._rv._strV,content);
  out.print("<script>alert('提交成功');</script>");
}

String menuid=request.getParameter("id");

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1>意见建议</h1>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<div id="mihu2"><input type="text" name="q" value="<%if(q!=null)out.print(q);%>">　<a href="###" onClick="form1.submit();">模糊查找</a></div>
</form>

<table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'>
  <tr id='tableonetr'>
    <td id='xuhao'>序号</td>
    <td id='gongs'>公司</td>
    <td id='yongh'>用户</td>
    <td id='neir'>内容</td>
    <td id='shij'>时间</td>
    <td id='caoz'>操作</td>
  </tr>
<%
java.util.Enumeration e=CioFeedback.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
  CioFeedback cf=(CioFeedback)e.nextElement();
  int cfid=cf.getCioFeedback();
  String member=cf.getMember();
  String ccname="--";
  int ccid=CioCompany.findByMember(member);
  if(ccid>0)
  {
    ccname=CioCompany.find(ccid).getName();
  }
  String content=cf.getContent();
  if(content.length()>100)
  {
    content=content.substring(0,100)+"...";
  }
  if(q!=null&&q.length()>0)
  {
    content=content.replaceAll(q,"<font color='red'>"+q+"</font>");
  }
  out.print("<tr><td id='xuhao'>"+i);
  out.print("<td id='gongs'>"+ccname);
  out.print("<td id='yongh'>"+member);
  out.print("<td id='neir'>"+content);
  out.print("<td id='shij'>"+cf.getTimeToString());
  out.print("<td id='caoz'><a href='/jsp/cio/ViewCioFeedback.jsp?community="+teasession._strCommunity+"&ciofeedback="+cfid+"&ciocompany="+ccid+"'>查看</a>");
}
%>
</table>

</body>
</html>
