<%@page contentType="text/html;charset=UTF-8" %><%@ include file="/jsp/Header.jsp" %>
<%!
String path;
private void  tree1(java.io.Writer jw,int nodecode,int step)throws Exception
{
    for(java.util.Enumeration enumeration = tea.entity.admin.AdminZone.findByFather(nodecode); enumeration.hasMoreElements(); )
    {
        int j = ((Integer)enumeration.nextElement()).intValue();
        tea.entity.admin.AdminZone node1 = tea.entity.admin.AdminZone.find(j);
        for(int loop=1;loop<step;jw.write("&nbsp;│&nbsp;&nbsp;"),loop++);
        if(step>0)jw.write("<img src=/tea/image/tree/tree_line.gif align=absmiddle>");
        jw.write("<A HREF='#' onclick=\"if(document.all('divid"+j+"').style.display==''){document.all('divid"+j+"').style.display='none';document.all('img"+j+"').src='/tea/image/tree/tree_plus.gif';}else{document.all('divid"+j+"').style.display='';document.all('img"+j+"').src='/tea/image/tree/tree_minus.gif';}\" ><img id=img"+j+" src=/tea/image/tree/tree_plus.gif align=absmiddle></A><A target=t href=editzone.jsp?sub=0&MenuId="+j+">"+node1.getName()+"</A><br/>");
        jw.write("<Div id=divid"+j+" style=display:none>");
        tree1(jw,j,++step);
        jw.write("</Div>");
        step--;
    }
}

%><html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
text-align:left;
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body>
<%
int root=tea.entity.admin.AdminZone.getRootId(teasession._strCommunity);
if(root!=0)
{
  %>
  <A target=t href=editzone.jsp?sub=0&MenuId=<%=root%>><%=tea.entity.admin.AdminZone.find(root).getName()%></A><br/>
  <%
  tree1(out,root,0);
}
%>
</body>
</html>


