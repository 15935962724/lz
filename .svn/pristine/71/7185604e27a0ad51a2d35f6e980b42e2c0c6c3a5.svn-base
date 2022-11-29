<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=node.getCommunity();
if(!teasession._rv.isOrganizer(community))
{
  response.sendError(403);
}
String s =  request.getParameter("Pos");
            int i = s == null ? 0 : Integer.parseInt(s);
r.add("/tea/ui/node/general/SonNodes");
            boolean flag = false;
            if(teasession._rv != null)
                flag = teasession._rv.isOrganizer(node.getCommunity());
            boolean flag1 = node.isCreator(teasession._rv);
         String   path=request.getContextPath();



java.util.Enumeration enumer_type=tea.entity.node.Node.findByType(1,community);//查找当前会员的差点节点
int nodecode=-1;
while(enumer_type.hasMoreElements())
{
   nodecode=((Integer)enumer_type.nextElement()).intValue();
   tea.entity.node.Category cate=tea.entity.node.Category.find(nodecode);
   if(cate.getCategory()==64)
   {
     teasession._nNode=nodecode;
     break;
   }
}
%>




<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function clickfun(idname)
{
    var targetid,srcelement,targetelement;
	var strbuf;
	srcelement=window.event.srcElement;
//    	document.write(idname.id);
//    targetid="son"+srcelement.id;//srcelement.id+"son";
		targetelement=document.getElementById(idname);
		if (targetelement.style.display=="none")
		{
			targetelement.style.display='';
			strbuf=srcelement.src;
//			if(strbuf.indexOf("plus.gif")>-1)
				srcelement.src="/tea/image/tree/tree_minus.gif";
//			else
//				srcelement.src="/tea/image/tree/tree_minusl.gif";
		}
		else
		{
			targetelement.style.display="none";
			strbuf=srcelement.src;
//			if(strbuf.indexOf("minus.gif")>-1)
				srcelement.src="/tea/image/tree/tree_plus.gif";
//			else
//				srcelement.src="/tea/image/tree/tree_plusl.gif";
		}
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Score")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

  <h2><%=r.getString(teasession._nLanguage, "CBManager")%><%//=tea.entity.node.Node.countSons(teasession._nNode, teasession._rv)%></h2>

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr ID=tableonetr>
          <td ><%=r.getString(teasession._nLanguage, "MemberId")%></td>
          <td ><%=r.getString(teasession._nLanguage, "Time")%></td>
          <td></td>
          </tr>
          <% for(Enumeration enumeration = tea.entity.node.Node.findSons(nodecode); enumeration.hasMoreElements(); )
            {
                int j = ((Integer)enumeration.nextElement()).intValue();
               tea.entity.node. Node node1 = tea.entity.node.Node.find(j);%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td ><a href="/jsp/type/score/ScoreManage.jsp?node=<%=j%>"><%=node1.getSubject(teasession._nLanguage)%></a></TD>
     <td><a href="/jsp/type/score/ScoreInfo.jsp?node=<%=j%>" ><%=node1.getTimeToString()%></A></td>       <td>

              <!--input type=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/type/<%=Node.NODE_TYPE[node1.getType()].toLowerCase()%>/Edit<%=Node.NODE_TYPE[node1.getType()]%>.jsp?EditNode=ON&node=<%=j%>', '_self');"-->

              <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/DeleteNode?node=<%=j%>', '_self');}">

</td>
          </tr>
          <%}%>
        </table> <%//=new FPNL(teasession._nLanguage, "/servlet/SonNodes?node=" + teasession._nNode + "&Pos=", i, Node.countSons(teasession._nNode, teasession._rv))%>
  <div id="head6"><img height="6" src="about:blank"></div>
    <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

