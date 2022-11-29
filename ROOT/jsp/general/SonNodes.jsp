<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@page import="tea.ui.*" import="tea.entity.node.*" import="tea.html.*" import="tea.db.*" import="tea.entity.site.*" import="tea.resource.*" import="java.util.*" import="java.io.*"%>
<%

TeaSession teasession=new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
AccessMember am =AccessMember.find(teasession._nNode, teasession._rv);
if(am.getPurview()==0 || am.getPurview()==4)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Http h=new Http(request,response);


String s =  request.getParameter("Pos");
int i = s == null ? 0 : Integer.parseInt(s);
Resource r=new Resource("/tea/ui/node/general/SonNodes");

Node node = Node.find(teasession._nNode);
boolean flag = false;
if(teasession._rv != null)
flag = teasession._rv.isOrganizer(teasession._strCommunity);
boolean flag1 = node.isCreator(teasession._rv);

int count=Node.countSons(teasession._nNode, teasession._rv);

String title=r.getString(teasession._nLanguage, "CBSonNodes")+" ( "+count+" )";


%><html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function fclick(value)
{
  if(document.getElementById("img"+value).src.indexOf("tree_plus.gif")!=-1)
  {
    document.getElementById("img"+value).src='/tea/image/tree/tree_minus.gif';
    document.getElementById("ifr"+value).src='<%=request.getRequestURI()%>?node='+value;
    document.getElementById("ifr"+value).height=500;
  }else
  {
    document.getElementById("img"+value).src='/tea/image/tree/tree_plus.gif';
    document.getElementById("ifr"+value).height=0;
  }
}
</script>
</head>
<body>
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
  <h1><%=title%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
  <%
  if(am.getPurview()==3){
  %>
  <!--详细列表-->
  <input type="button" id="ebuttonid"  value="<%=r.getString(teasession._nLanguage, "1167979712093")%>" onClick="window.location='/jsp/admin/Frame.jsp?tree=NodeTree.jsp&node=<%=teasession._nNode%>'"/>

  <input type="button" id="ebuttonid"  value="<%=r.getString(teasession._nLanguage, "ExportToExcel")%>" onClick="window.location='/servlet/ExportSonNodes?node=<%=teasession._nNode%>'"/>
  <input type="button" id="ebuttonid"  value="<%=r.getString(teasession._nLanguage, "ExportToHtml")%>" onClick="window.location='/servlet/ExportNodeToHtml?node=<%=teasession._nNode%>'"/>

  <!--重置子节点选项-->
  <input type="button" id="ebuttonid"  value="<%=r.getString(teasession._nLanguage, "1167979839312")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "1167981480562")%>')){ window.location='/servlet/ApplyNode?node=<%=teasession._nNode%>'; }"/>
<%} %>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr><td><%
      int ia = 1;
	  Enumeration e=Node.find(" AND father="+teasession._nNode+" AND finished=1 ORDER BY node",i,25);
      while(e.hasMoreElements())
      {
        int j = ((Integer)e.nextElement()).intValue();
        Node node1 = Node.find(j);
        am=AccessMember.find(j,teasession._rv);
        boolean flag2 = node1.isCreator(teasession._rv);
        //System.out.println(j+":"+(flag2||am.isAuditing()||am.isEdit()||am.isDelete()));
        if(flag2||am.isAuditing()||am.getPurview()>1)
        {
	              %>
	              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	              <%if(am.getPurview()==3 ){ %>
	                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="###" onclick ="fclick(<%=j%>);" ><img id="img<%=j%>" alt="" src="/tea/image/tree/tree_plus.gif"/></a>&nbsp;&nbsp;</td>
                    <%} %>
                    <td><%=ia+i %></td>
	                <td><%=node1.getAnchor(teasession._nLanguage)%></td><td>
	                  <%

                  if(flag2||am.getPurview()>1)
                  {
                    if(node1.getType()>=1024)
                    {
                      %>
                    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/type/dynamicvalue/EditDynamicValue.jsp?EditNode=ON&node=<%=j%>', '_self');">
                      <%
                    }else
                    if(node1.getType()==0||node1.getType()==1)
                    {
                    %>

                   <!-- <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditNode?EditNode=ON&node=<%=j%>', '_self');">-->
                    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open(' /jsp/general/EditNode.jsp?EditNode=ON&node=<%=j%>', '_self');">


                    <%}else{%>
                      <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/type/<%=Node.NODE_TYPE[node1.getType()].toLowerCase()%>/Edit<%=Node.NODE_TYPE[node1.getType()]%>.jsp?EditNode=ON&node=<%=j%>', '_self');">
                        <% }
                        }
                        if((flag || flag1 || flag2||am.getPurview()>2) && node1.isLayerExisted(teasession._nLanguage))
                        {%>
                        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/DeleteNode?node=<%=j%>', '_self');this.disabled=true;}">
                          <%}if((flag1||am.isAuditing())&& node1.isHidden())
                          {%>
                          <input type="button" value="<%=r.getString(teasession._nLanguage, "CBGrant")%>" ID="CBGrant" CLASS="CB" onClick="window.open('/servlet/GrantNodeRequests?Go=Grant&node=<%=teasession._nNode%>&NodeRequests=<%=j%>', '_self');">
                            <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDeny")%>" ID="CBDeny" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/GrantNodeRequests?Go=Deny&node=<%=teasession._nNode%>&NodeRequests=<%=j%>', '_self');}">
                              <%}%><tr><td><td colspan="20"><iframe height="0" width="600" src="" id="ifr<%=j%>"></iframe>
                                <%
                                }
                                ia++;
                              }

%></td></tr>
        </table> <%=new tea.htmlx.FPNL(teasession._nLanguage, "?node=" + teasession._nNode + "&Pos=", i, count)%>


<%
e=Node.find(" AND father="+teasession._nNode+" AND finished=0",0,25);
if(e.hasMoreElements())
{
	out.print("<h2>"+r.getString(teasession._nLanguage, "NoFinished")+"</h2>");
	out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'><tr><td>");
	while(e.hasMoreElements())
	{
		int j = ((Integer)e.nextElement()).intValue();
        Node node1 = Node.find(j);
        out.print("<tr><td>"+node1.getAnchor(teasession._nLanguage)+"</td><td>");
        if(node1.getType()>=1024)
        {
                      %>
                    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/type/dynamicvalue/EditDynamicValue.jsp?EditNode=ON&node=<%=j%>', '_self');">
                      <%
                    }else
if(node1.getType()==0||node1.getType()==1){
    %>
           <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditNode?EditNode=ON&node=<%=j%>', '_self');">
              <%}else{%>
              <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/type/<%=Node.NODE_TYPE[node1.getType()].toLowerCase()%>/Edit<%=Node.NODE_TYPE[node1.getType()]%>.jsp?EditNode=ON&node=<%=j%>', '_self');">
              <% }%>
                            <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/DeleteNode?node=<%=j%>', '_self');}">
<%            }
out.print("</td></tr></table>");
}
%>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>
</body>
</html>
