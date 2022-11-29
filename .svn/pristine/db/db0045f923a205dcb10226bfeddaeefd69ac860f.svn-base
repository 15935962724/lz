<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter"  %><%@page import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %><%@page import="java.net.*"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String rt=teasession.getParameter("Type");
if (rt==null)
{
  rt=teasession.getParameter("type");//不区分大小写
}

Resource r=new Resource();

String field=request.getParameter("field");

String name=request.getParameter("name");

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
  pos=Integer.parseInt(_strPos);
}

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&field=").append(field);

StringBuffer sql=new StringBuffer();
if (name != null && (name = name.trim()).length() > 0)
{
	sql.append(" AND bl.name LIKE " ).append( DbAdapter.cite("%" + name.replaceAll(" ", "%") + "%"));
	param.append("&name=").append(URLEncoder.encode(name,"UTF-8"));
}
param.append("&pos=");

int count=Brand.countByCommunity(teasession._strCommunity,sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_click(v)
{
  window.opener.<%=field%>.value=v;
  window.close();
}
</script>
</head>
<body>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="field" value="<%=field%>"/>

<TABLE  cellSpacing="0" cellPadding="0" id="tablecenter" border="0">
<tr id="tableonetr">
<td colspan="5"><%=r.getString(teasession._nLanguage,"Name")%>:<input name="name" type="text" value="<%if(name!=null)out.print(name);%>"><input name="" type="submit" value="搜索" id="btt"> </td>
</tr>
</table>
</form>

<TABLE  cellSpacing="0" cellPadding="0" id="tablecenter" class="table">
<tr id="tableonetr">
<td width=1>&nbsp;</td>
<td><%=r.getString(teasession._nLanguage,"Name")%></td>
<td>Logo</td>
</tr>
<%
java.util.Enumeration enumer=Brand.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
for(int i=1;enumer.hasMoreElements();i++)
{
  Brand obj=Brand.find(((Integer)enumer.nextElement()).intValue());
  String logo=obj.getLogo();

  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor='' style=cursor:hand onClick=f_click('"+obj.getBrand()+"')>");
  out.print("<td width=1>"+i);
  out.print("<td>"+obj.getName());
  out.print("<td>&nbsp;");
  if(logo!=null&&logo.length()>0)
  {
    out.print("<img src="+logo+" onerror=\"style.display='none';\">");
  }
  out.print("</tr>");
}
%>
<tr><td colspan="3" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)%></td></tr>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>

</body>
</html>
