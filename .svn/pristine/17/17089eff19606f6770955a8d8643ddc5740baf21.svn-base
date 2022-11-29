<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.db.*" %><%@ page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");
String email=request.getParameter("email");
if("POST".equals(request.getMethod())|| email!=null)
{
  String nodes[]=request.getParameterValues("nodes");
  if(nodes==null)
  {
    out.print("<script>alert('无效的订阅项.');</script>");
    return;
  }
  StringBuffer sb=new StringBuffer("/");
  for(int index=0;index<nodes.length;index++)
  {
    sb.append(nodes[index]+"/");
  }
  Subscibe obj=Subscibe.find(teasession._strCommunity,email);
  if(obj.isExists())
  {
    out.print("<script>alert('"+email+" 此邮箱已订阅过');</script>");
  }else
  {
    Subscibe.create(teasession._strCommunity,email,sb.toString());
    out.print("<script>alert('"+email+" 订阅成功.');</script>");
  }
  return;
}
Resource r=new Resource();
%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>

  <h1><%=r.getString(teasession._nLanguage, "Subscibe")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<form name="form_subscibe" method="post" action="<%=request.getRequestURI()%>" TARGET="form_subscibe_iframe" onSubmit="return submitEmail(this.email,'无效邮件地址');" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<iframe name="form_subscibe_iframe" id="form_subscibe_iframe" src="about:blank" style="display:none"></iframe>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT DISTINCT n.node FROM Node n,Category c WHERE n.node=c.node AND n.community="+db.cite(teasession._strCommunity)+" AND n.type=1 AND c.category=39");
  for(int i=0;db.next();i++)
  {
    int node=db.getInt(1);
    if(i%5==0)
    {
      out.print("<tr>");
    }
    out.println("<td><input name=nodes type=checkbox value="+node+" />"+Node.find(node).getSubject(teasession._nLanguage));
  }
}finally
{
  db.close();
}
%>
</table>
<br>
E-Mail:<input type="text" name="email">
<input type="submit" value="订阅杂志" >
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
