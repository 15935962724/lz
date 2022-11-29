<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp" %>
<%!
private void  tree1(java.io.Writer jw,int nodecode,int step)throws Exception
{
    for(java.util.Enumeration enumeration = tea.entity.admin.Area.findByFather(nodecode); enumeration.hasMoreElements(); )
    {
        int j = ((Integer)enumeration.nextElement()).intValue();
        tea.entity.admin.Area node1 = tea.entity.admin.Area.find(j);
        for(int loop=1;loop<step;jw.write("<img src=/tea/image/tree/tree_line.gif align=absmiddle>"),loop++);
        if(step>0)jw.write("<img src=/tea/image/tree/tree_line.gif align=absmiddle>");
        jw.write("<img onclick='f_open(this)' src=/tea/image/tree/tree_plus.gif align=absmiddle><a onclick='f_open(this)' target='right_area' href='EditArea.jsp?sub=0&MenuId="+j+"'>"+node1.getName()+"</a><br/>");
        jw.write("<div style='display:none'>");
        tree1(jw,j,step+1);
        jw.write("</div>");
    }
}
%>
<%
int root=tea.entity.admin.Area.getRootId(node.getCommunity());

%>
<html>
<head>
  <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function f_open(img)
{
  if(img.tagName=="A")
  {
    img=img.previousSibling;
  }
  var div=img.nextSibling.nextSibling.nextSibling;
  if(div.style.display=='')
  {
    div.style.display='none';
    img.src='/tea/image/tree/tree_plus.gif';
  }else
  {
    div.style.display='';
    img.src='/tea/image/tree/tree_minus.gif';
  }
}
</script>
<style type="text/css">
<!--
body {
margin-left: 10px;
margin-top: 10px;
margin-right: 0px;
margin-bottom: 0px;
}
-->
</style>
<script>
window.open("/jsp/admin/popedom/EditArea.jsp?MenuId=<%=root%>&community=<%=teasession._strCommunity%>","right_area");
</script>
</head>
<body>

<div align="left">
<%
if(root!=0)
{
%>
<A target="right_area" href="EditArea.jsp?sub=0&MenuId=<%=root%>"><%=tea.entity.admin.Area.find(root).getName()%></A>
<br/>
<%
tree1(out,root,0);
}
%>

</div>
</BODY>
</html>
