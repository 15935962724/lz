<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

Http h=new Http(request,response);


if(!teasession._rv.isWebMaster())
{
  response.sendError(403);
  return;
}

tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}


tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
String nr = tea.ui.node.general.NodeServlet.getButton(node,h,am,request);

Resource r=new Resource("/tea/ui/site/TypeAliases");

String s = request.getParameter("pos");
int pos = s == null ? 0 : Integer.parseInt(s);
int j = TypeAlias.count();

String community=request.getParameter("community");

String title=r.getString(teasession._nLanguage, "TypeAliases")+" ( "+j+" )";
%>
<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<title><%=title%></title>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_edit(id)
{
  window.open('/jsp/site/EditTypeAlias.jsp?community=<%=community%>&typealias='+id, '_self');
}
function f_del(obj,id)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    window.open('/servlet/EditTypeAlias?community=<%=community%>&act=delete&typealias='+id, '_self');
    obj.disabled=true;
  }
}
</script>
</head>
<body>
<%=nr%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Type")%></td>
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td><%=r.getString(teasession._nLanguage, "Picture")%></td>
    <td></td>
<%
Enumeration e = TypeAlias.find(pos, 25);
if(e.hasMoreElements())
{
  while(e.hasMoreElements())
  {
    int k = ((Integer)e.nextElement()).intValue();
    TypeAlias typealias = TypeAlias.find(k);
    int tyep=typealias.getType();
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>");
    if(tyep<1024)
    {
      out.print(r.getString(teasession._nLanguage,Node.NODE_TYPE[tyep]));
    }else
    {
      Dynamic obj=Dynamic.find(tyep);
      out.print(obj.getName(teasession._nLanguage));
    }
    out.print("<td>"+typealias.getName(teasession._nLanguage));
    out.print("<td>&nbsp;");
    String picture=typealias.getPicture(teasession._nLanguage);
    if(picture!=null&&picture.length()>0)
    {
      out.print(new tea.html.Image(picture, typealias.getAlt(teasession._nLanguage)));
    }
    out.print("<td><input type='button' value="+r.getString(teasession._nLanguage, "CBEdit")+" ID=CBEdit CLASS=CB onClick=f_edit("+k+");>");
    out.print("<input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" ID=CBDelete CLASS=CB onClick=f_del(this,"+k+");>");
  }
  if(j>25)out.print("<tr><td colspan=5>"+new tea.htmlx.FPNL(teasession._nLanguage, "?community="+community+"&pos=", pos, j));
}else
{
  out.print("<tr><td colspan=5>"+r.getString(teasession._nLanguage, "暂无记录"));
}
%>
</table>

<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_edit(0);">

<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
