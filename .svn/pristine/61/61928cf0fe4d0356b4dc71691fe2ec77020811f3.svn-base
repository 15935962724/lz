<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter"  %><%@page import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %><%@page import="java.net.*"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String rt=teasession.getParameter("Type");
if (rt==null)
{
  rt=teasession.getParameter("type");//不区分大小写
}

Resource r=new Resource();

String _strId=request.getParameter("id");

String name=request.getParameter("name");

Community communitys=Community.find(teasession._strCommunity);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
  pos=Integer.parseInt(_strPos);
}

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql=new StringBuffer();
if (name != null && (name = name.trim()).length() > 0)
{
	sql.append(" AND bl.name LIKE " ).append( DbAdapter.cite("%" + name.replaceAll(" ", "%") + "%"));
	param.append("&name=").append(URLEncoder.encode(name,"UTF-8"));
}
param.append("&pos=");

int count=Brand.countByCommunity(teasession._strCommunity,sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body id="bodynone">

<script src="<%=communitys.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></script>



<h1><%=r.getString(teasession._nLanguage, "品牌管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form action="/jsp/type/brand/ManageBrand.jsp">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>

<TABLE  cellSpacing="0" cellPadding="0" id="tablecenter" border="0">
<tr id="tablehead1">
<td colspan="5"><%=r.getString(teasession._nLanguage,"品牌名称")%>:
  <input name="name" type="text" value="<%if(name!=null)out.print(name);%>"><input name="" type="submit" value="搜索" id="btt"> </td>
</tr></table>
</form>

<div id="table">

<h2>列表</h2>
<TABLE  cellSpacing="0" cellPadding="0" id="tablecenter" class="table">
<tr id="tableonetr">
<td>&nbsp;</td>
<td><%=r.getString(teasession._nLanguage,"Name")%></td>
<td>Logo</td>
<td>&nbsp;</td>
</tr>
<%
java.util.Enumeration enumer=Brand.findByCommunity(teasession._strCommunity,sql.toString(),pos,25);
for(int i=1;enumer.hasMoreElements();i++)
{
  Brand obj=Brand.find(((Integer)enumer.nextElement()).intValue());
  String logo=obj.getLogo();
 %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  id="list">
    <%
    out.print("<td width=1>"+i);
    out.print("<td>");
//    if(obj.getNode()>0)
//    {
//    	out.print("<a href=/servlet/Node?node="+obj.getNode()+"&Language="+teasession._nLanguage+" target=_blank>");
//    }
	out.print(obj.getName());
    //out.print("</a>");

    out.print("<td>&nbsp;");
    if(logo!=null&&logo.length()>0)
    {
      out.print("<img src="+logo+" onerror=\"style.display='none';\">");
    }
    %>
    <td>
      <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" onclick="window.open('/jsp/type/brand/EditBrand.jsp?community=<%=teasession._strCommunity%>&brand=<%=obj.getBrand()%>', '_self');">
      <input type="button" value="<%=r.getString(teasession._nLanguage, "批修")%>" onclick="window.open('/jsp/type/brand/EditBrandPrice.jsp?community=<%=teasession._strCommunity%>&brand=<%=obj.getBrand()%>&nexturl='+encodeURIComponent(location), '_self');">
      <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/EditBrand?community=<%=teasession._strCommunity%>&brand=<%=obj.getBrand()%>&delete=ON', '_self');this.disabled=true;}" ></td>
  </tr>
<%
}
%>
<tr><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count)%></td></tr>
</table>

</div>
<br/>
<!--input type=BUTTON VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>" ID="CBNew" CLASS="CB" onClick="window.open('/jsp/type/report/EditReport.jsp?node=<%=teasession._nNode%>&type=<%=rt%>', '_self');"-->

<input name="BUTTON" type=BUTTON class="CB" id="CBNew" onClick="window.open('/jsp/type/brand/EditBrand.jsp?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&type=<%=rt%>', '_self');" value="<%=r.getString(teasession._nLanguage, "CBNew")%>">

<input type="button" value="<%=r.getString(teasession._nLanguage, "CBAccessMembers")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/type/brand/BrandRole.jsp?node=<%=teasession._nNode%>', '_self');">

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>


<script src="<%=communitys.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></script>

</body>
</html>
