<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page import="tea.entity.site.*" %><%@ page  import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.map.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String _strId=request.getParameter("id");
String name=request.getParameter("name");
String hidden=request.getParameter("hidden");

StringBuffer param = new StringBuffer();
param.append("&id=").append(_strId);
param.append("&community=").append(teasession._strCommunity);

StringBuffer sql = new StringBuffer();
sql.append(" AND node IN (SELECT node FROM Node WHERE community=").append(DbAdapter.cite(teasession._strCommunity)).append(")");

boolean bool=teasession._rv.isOrganizer(teasession._strCommunity)||License.getInstance().getWebMaster().equals(teasession._rv);

if(!bool)
{
  sql.append(" AND member=").append(DbAdapter.cite(teasession._rv._strV));
}
if (name != null && (name = name.trim()).length() > 0)
{
  sql.append(" AND node IN ( SELECT node FROM NodeLayer WHERE subject LIKE ").append(DbAdapter.cite("%"+name+"%")).append(")");
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}
if (hidden != null && hidden.length() > 0)
{
  sql.append(" AND hidden=").append(hidden);
  param.append("&hidden=").append(hidden);
}

int count=GMap.count(sql.toString());

String order=request.getParameter("order");
String desc=request.getParameter("desc");
if(order!=null)
{
  if(desc==null)
  desc="";
  param.append("&order=").append(order);
  param.append("&desc=").append(desc);
  sql.append(" ORDER BY ").append(order).append(" ").append(desc);
}

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
param.append("&pos=");

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

<h1>地图标点</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <form name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>
   <%
   if(order!=null)out.print("<input type=hidden name=order value="+order+" >");
   if(desc!=null)out.print("<input type=hidden name=desc value="+desc+" >");
   %>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称:<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td>状态:<select name="hidden">
       <option value="">-----------
       <option value="1" <%if("1".equals(hidden))out.print("selected");%>>-----未批------
       <option value="0" <%if("0".equals(hidden))out.print("selected");%>>-----已批------
       </select>
       </td>
       <td><input type="submit" value="查询"/></td></tr>
   </table>
</form>
<br>


<h2>列表 ( <%=count%> )</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1">&nbsp;</td>
     <td><%
     if("name".equals(order))
     {
       out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
     }else
     {
       out.print("<A href=?order=name"+param.toString()+pos+" >名称</a>");
     }
     %></td>
     <td nowrap><%
     if("hidden".equals(order))
     {
       out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >状态 "+("desc".equals(desc)?"▼":"▲")+"</a>");
     }else
     {
       out.print("<A href=?order=hidden"+param.toString()+pos+" >状态</a>");
     }
     %></td>
     <td nowrap><%
     if("time".equals(order))
     {
       out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >时间 "+("desc".equals(desc)?"▼":"▲")+"</a>");
     }else
     {
       out.print("<A href=?order=time"+param.toString()+pos+" >时间</a>");
     }
     %></td>
     <td nowrap>&nbsp;</td>
     </tr>
<%
Enumeration e=GMap.find(sql.toString(),pos,25);
for(int index=1;e.hasMoreElements();index++)
{
  GMap obj=(GMap)e.nextElement();
  int nodeid=obj.getNode();
  Node node=Node.find(nodeid);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=node.getSubject(teasession._nLanguage)%></td>
    <td>&nbsp;<%=obj.isHidden()?"X":"√"%></td>
    <td>&nbsp;<%=obj.getTimeToString()%></td>
    <td>
<%--
    <input type=button value=查看 onclick="window.open('http://channel.mapabc.com/openmap/map.jsp?id=<%=sid%>&uid=7246&eid=102341&w=600&h=500','','edge:raised;help:0;resizable:1;dialogWidth:620px;dialogHeight:558px;');">
--%>
    <input type=button value=编辑 onclick="window.open('/jsp/admin/map/EditGMap.jsp?community=<%=teasession._strCommunity%>&node=<%=nodeid%>','_blank','width=600,height=500');" >
    <input type=button value=删除 onclick="if(confirm('确定删除吗？'))window.open('/servlet/EditGMap?community=<%=teasession._strCommunity%>&act=del&node=<%=nodeid%>&nexturl='+encodeURIComponent(location),'_self');" >
    <%
    if(bool&&obj.isHidden())
    {
    	out.print("<input type=button value=批准 onclick=\"window.open('/servlet/EditGMap?community="+teasession._strCommunity+"&node="+nodeid+"&act=hidden&hidden=false&nexturl='+encodeURIComponent(location),'_self');\" >");
    }
    %>
    </td>
 </tr>
<%
}
%>
<tr><td colspan="6"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>
<!--
<input type=button value=添加 onclick="window.open('/jsp/admin/map/EditMapabc.jsp?community=<%=teasession._strCommunity%>&nexturl='+encodeURIComponent(location),'_self');" >
-->
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
