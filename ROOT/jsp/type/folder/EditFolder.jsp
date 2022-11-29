<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
TeaSession teasession=new TeaSession(request);

Resource r=new Resource();
Node node = Node.find(teasession._nNode);
if (!node.isCreator(teasession._rv) &&AccessMember.find(teasession._nNode, teasession._rv).getPurview()<1)
{
  response.sendError(403);
  return;
}
int i = node.getOptions1();
Category category = Category.find(teasession._nNode);

String title=r.getString(teasession._nLanguage, "Folder");
%>
<html>
<head>
<title><%=title%></title>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM name=foEdit METHOD=POST action="/servlet/EditFolder">
<input type='hidden' name='node' value="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td colspan=2><%=r.getString(teasession._nLanguage, "Folder")%></td>
  </tr>
  <tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Options")%>:</td>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="CategoryOOpen" value=null <%if((i & 1) != 0)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "CategoryOOpen")%>&nbsp;
        <input  id="CHECKBOX" type="CHECKBOX" name="CategoryONeedGrant" value=null <%if((i&2) != 0)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "CategoryONeedGrant")%>&nbsp;
         <input id="CHECKBOX" type="CHECKBOX" name="CategoryOContributors" value=null <%if((i & 4) != 0)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "是否投稿使用")%>&nbsp;
   		 <input id="CHECKBOX" type="CHECKBOX" name="CategoryORole" value=null <%if((i & 8) != 0)out.print(" checked='true'");%>><%=r.getString(teasession._nLanguage, "是否内容权限使用")%>
        <%=Mark.toHtml(teasession._strCommunity,0,node.getMark())%>
      </td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否显示发行选项")%>:</td>
      <td>
       <%

       	for(int cs = 0;cs<Node.CATEGORYOS_SUBSCRIBE.length;cs++)
       	{
       		 
       		out.print("<input type=checkbox name=categoryosubscribe value = "+cs);
       		if(node.getCategoryosubscribe()!=null && node.getCategoryosubscribe().indexOf("/"+cs+"/")!=-1)
    		{
       			
    			out.print(" checked = true ");
    		} 
       		out.print(">&nbsp;"+Node.CATEGORYOS_SUBSCRIBE[cs]);
       	}
       %>
      </td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Template")%>:</td>
      <td>
       <input type=BUTTON name="template" id="CBNew" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" onClick="window.open('/jsp/template/Templates.jsp?node=<%=teasession._nNode%>');">
      </td>
    </tr>
</table>
<input type=SUBMIT name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
