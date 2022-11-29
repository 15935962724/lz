<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%!
String path;
private void  tree1(java.io.Writer jw,int nodecode,int step)throws Exception
{
    for(Enumeration enumeration = tea.entity.admin.SubsidyMenu.findByFather(nodecode); enumeration.hasMoreElements(); )
    {
        int j = ((Integer)enumeration.nextElement()).intValue();
        tea.entity.admin.SubsidyMenu node1 = tea.entity.admin.SubsidyMenu.find(j);
        for(int loop=1;loop<step;jw.write("<img src="+path+"/tea/image/tree/tree_line.gif  align=absmiddle >"),loop++);
        if(step>0)jw.write("<img src="+path+"/tea/image/tree/tree_line.gif  align=absmiddle >");
		if(!node1.isType())
          {
		   jw.write("<A HREF='#' onclick=\"if(document.all('"+j+"').style.display==''){document.all('"+j+"').style.display='none';document.all('img"+j+"').src='"+path+"/tea/image/tree/tree_plus.gif';}else{document.all('"+j+"').style.display='';document.all('img"+j+"').src='"+path+"/tea/image/tree/tree_minus.gif';}\" ><img id=img"+j+" src="+path+"/tea/image/tree/tree_plus.gif  align=absmiddle></A><A target=t href=EditSubsidyMenu.jsp?id="+j+">"+node1.getName(teasession._nLanguage)+"</A><br/>");
		  }else//功能菜单
		  {
		  jw.write("<IMG SRC="+path+"/tea/image/tree/tree_blank.gif BORDER=0 align=absmiddle ID=img"+j+" />");
		   jw.write("<A target=t href=EditSubsidyMenu.jsp?id="+j+">"+node1.getName(teasession._nLanguage)+"</A><br/>");
		  }

        jw.write("<Div id="+j+" style=display:none>");
        tree1(jw,j,++step);
        jw.write("</Div>");
        step--;
    }
}
%>

<html>
	<head>
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>


<style type="text/css">
<!--
body {text-align:left;
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 0px;
	margin-bottom: 0px;
}
img{ border:0px}
-->
</style>
</head>
<body>
<%
int rootid=tea.entity.admin.SubsidyMenu.getRootId(node.getCommunity());
path=request.getContextPath();
tea.entity.admin.SubsidyMenu node1 = tea.entity.admin.SubsidyMenu.find(rootid);
%>
<A target=t href=EditSubsidyMenu.jsp?id=<%=rootid%>><%=node1.getName(teasession._nLanguage)%></A><br/>
<%tree1(out,rootid,0);%>

	</BODY>
</html>



