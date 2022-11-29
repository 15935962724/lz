<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/member/node/Nodes");

 String s = request.getParameter("Pos");
 int pos = s == null ? 0 : Integer.parseInt(s);

 String _strType = request.getParameter("type");
 int type = _strType == null ? 0 : Integer.parseInt(_strType);



%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "FavoriteNodes")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv">
<%
out.print(TeaServlet.hrefGlance(teasession._rv) + " >" + new tea.html.Anchor("/jsp/node/Nodes.jsp", r.getString(teasession._nLanguage, "Nodes")) + ">" + r.getString(teasession._nLanguage, "FavoriteNodes"));
%></div>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr ID=tableonetr>
     <td><%=r.getString(teasession._nLanguage,"Subject")%></td>
   <td></td>
</tr>
<%
if(type==0)
{
  for(;type<Node.NODE_TYPE.length;type++)
  {
    out.print(toHtml(teasession,type,r,pos));
  }
}else
{
  out.print(toHtml(teasession,type,r,pos));
}


%>

</table>
<br>
  <div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
<%!
private String toHtml(TeaSession teasession,int type,Resource r,int pos)throws Exception
{
  int count = Favorite.countNodes(teasession._strCommunity,teasession._rv,type);
  if(count>0)
  {
    StringBuffer html=new StringBuffer();
    for(java.util.Enumeration enumeration = Favorite.findNodes(teasession._strCommunity,teasession._rv,type, pos, 25); enumeration.hasMoreElements(); )
    {
      int k = ((Integer)enumeration.nextElement()).intValue();
      Node obj=Node.find(k);
      if(obj.getCreator()!=null)
      {
        html.append("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"><td>"+obj.getAncestor(teasession._nLanguage,""));
        html.append("<td>"+new tea.html.Button(1, "CB", "CBDelete", r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('/servlet/DeleteFavorite?nodes=" + k + "', '_self');}"));
        html.append("</td></tr>");
      }
    }
    if(html.length()>0)
    {
      html.insert(0,"<tr><td><h2>"+r.getString(teasession._nLanguage,Node.NODE_TYPE[type])+" ( "+count+" )</h2></td></tr>");
    }
    return html.toString();
  }
  return "";
}

%>
