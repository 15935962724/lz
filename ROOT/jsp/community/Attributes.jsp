<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%
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

tea.resource.Resource r=new tea.resource.Resource("/tea/ui/member/community/EditCommunity");

String community=request.getParameter("community");

String nexturl=request.getRequestURI()+"?"+request.getQueryString();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body id="bodynone">
<h1><%=r.getString(teasession._nLanguage, "AttributeManage")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2><%=r.getString(teasession._nLanguage, "AttributeManage")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

        <tr id=tableonetr>
          <td><%=r.getString(teasession._nLanguage, "Code")%></td>
          <td><%=r.getString(teasession._nLanguage, "Name")%></td>
          <td><%=r.getString(teasession._nLanguage, "Text")%></td>
          <td><%=r.getString(teasession._nLanguage, "operation")%></td>
        </tr>
        <%
        java.util.Enumeration enumeration=Attribute.findGoodstypeByCommunity(community);
        int id=0;
        while(enumeration.hasMoreElements())
        {
          id=((Integer)enumeration.nextElement()).intValue();
          GoodsType obj=GoodsType.find(id);

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
  <td><%=id%></td>
  <td><%=obj.getAncestor(teasession._nLanguage)%></td>
  <td><%=Attribute.countByGoodstype(id)%></td>
  <td>
    <a href="###" onClick="window.open('/jsp/community/EditAttribute.jsp?node=<%=teasession._nNode%>&community=<%=community%>&goodstype=<%=id%>','_self');" ><%=r.getString(teasession._nLanguage, "CBEdit")%></a>
    <a href="###" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){window.open('/servlet/EditAttribute?delete=ON&goodstype=<%=id%>&nexturl='+encodeURIComponent('<%=nexturl%>'), '_self');}" ><%=r.getString(teasession._nLanguage, "Delete")%></a>
  </td>
</tr>
<%
}
%>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>


