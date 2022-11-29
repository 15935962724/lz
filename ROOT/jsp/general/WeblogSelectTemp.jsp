<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%


request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r = new Resource();
Node node=Node.find(teasession._nNode);
String community=request.getParameter("community");
Blog blog=Blog.find(node.getCommunity(),teasession._rv._strR);
node=Node.find(blog.getHome());
if(request.getMethod().equals("POST"))
{
  node.move(Integer.parseInt(request.getParameter("NewFather")),true);
  blog.revert();
  out.print(new tea.html.Script("alert('修改成功');history.back();"));
  return;
}
%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "选择模板")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="<%=request.getRequestURI()%>">
<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
java.util.Enumeration enumer=tea.entity.site.Template2.findByCommunity(node.getCommunity());
if(enumer.hasMoreElements())
{
  out.print("<input type=\"submit\" name=\"Submit\" value=\"提交\">");
}else
{
  out.print("<tr><td>暂无记录</td></tr>");
}
for(int index=0;enumer.hasMoreElements();index++)
{
tea.entity.site.Template2 temp= tea.entity.site.Template2.find(((Integer)enumer.nextElement()).intValue());
if(index%5==0)
out.print("<TR>");
%>
  <td><A href="<%=temp.getPicture()%>" target="_blank"><img alt="" width="130" height="100" src="<%=temp.getPicture()%>"/></A>
<br/>
<input  id="radio" type="radio" <%if(node.getFather()==temp.getNode())out.print("checked=checked");%>  name="NewFather" value="<%=temp.getNode()%>" id="<%=index%>"/><label for="<%=index%>"><%=temp.getName()%></label>
</td>
<%}%>
</table>
<input type="hidden" name="Node" value="<%=blog.getHome()%>"/>
</form>

<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>注意:</td></tr>
<tr><td>如果修改模板,则DIY样式 被删除</td></tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

