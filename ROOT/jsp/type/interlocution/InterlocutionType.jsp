<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();TeaSession teasession = new TeaSession(request);
Node   node=Node.find(teasession._nNode);

if(teasession._rv==null || !teasession._rv._strV.equals("webmaster"))
{
	out.print("您没有权限访问");
	return;
}
 
int id = 0;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
{
	id = Integer.parseInt(teasession.getParameter("id"));
}
InterlocutionType itobj =  InterlocutionType.find(id);

if("delete".equals(teasession.getParameter("act")))
{
	itobj.delete();
	response.sendRedirect("/jsp/type/interlocution/InterlocutionType.jsp");
	return;
}
%>
<html>
  <head>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
  <h1>问答类别管理</h1>


  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>
  </div>
  
   <table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
      <tr>
	      <td>类别名称</td>
	      <td>操作</td>
      <tr>
      <%
      	java.util.Enumeration enumers = InterlocutionType.findall();
        for(int index = 1 ; enumers.hasMoreElements();index++)
        {
          int  idnum = Integer.parseInt(enumers.nextElement().toString());
          InterlocutionType inttypes =  InterlocutionType .find(idnum);
          
    
    
       %>
   		<tr>
   			<td><%=inttypes.getTypes() %></td>
   			<td><a href="?node=<%=teasession._nNode %>&id=<%=idnum %>">编辑</a>&nbsp;<a  href="?act=delete&id=<%=idnum %>">删除</a></td>
   		</tr>
		<%} %>

      </table>
  
  
  
  <FORM NAME=form_create METHOD=POST action="/servlet/EditInterlocution"  onSubmit="">
  <input type="hidden" name="id" value="<%=id %>">
 <INPUT TYPE=HIDDEN NAME=community VALUE="<%=teasession._strCommunity%>"/>
    <INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>"/>
      <INPUT TYPE=HIDDEN NAME=act VALUE="createtype"/>
      <table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
      <tr><td>类别名称</td><td><input name="createtype"  value="<%if(itobj.getTypes()!=null && itobj.getTypes().length()>0){out.print(itobj.getTypes());} %>"  size="12"/></td><tr>
      <tr><td colspan="2"><input type="submit" name="" value="提交"></td><tr>

      </table>
  </FORM>

  </body>
</html>

