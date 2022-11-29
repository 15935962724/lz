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
String menuid=request.getParameter("id");

if("POST".equals(request.getMethod()))
{
  String content=request.getParameter("content");
  CioFeedback.create(teasession._strCommunity,teasession._rv._strV,content);
  out.print("<script>alert('提交成功');</script>");
}
String member=teasession._rv._strV;

int ciocompany=0;
String tmp=request.getParameter("ciocompany");
if(tmp!=null)
{
  ciocompany=Integer.parseInt(tmp);
}else
{
  ciocompany=CioCompany.findByMember(member);
  if(ciocompany<1)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你不是代表","UTF-8"));
    return;
  }
}
CioCompany cc=CioCompany.find(ciocompany);


Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body  id="qiyelog_05">
<h1>意见建议</h1>
<div id='tes_body02'>
<div id="head6"><img height="6" src="about：blank"></div>
<br/>
<div id="div_001"><%=cc.getName()%>,参会负责人您好：</div>
<div id="div_0022">请提交您的意见建议！</div>
<h2>意见建议：</h2>
<form name="form1" action="?" method="post" onSubmit="return submitText(this.content,'无效-意见建议')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<div id="canh_ry222">
<table cellpadding='0' cellspacing='0' id='canh_ry_table222'>
  <tr>
    <td><textarea name="content" cols="50" rows="8"></textarea></td>
  </tr>
  <tr>
  <td><input type="submit" class="buttonclass" value="提交"/></td>
  </tr>
</table>
</div>
</form></div>
</body>
</html>
