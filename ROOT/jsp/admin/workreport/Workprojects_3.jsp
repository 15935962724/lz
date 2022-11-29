<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page  import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
String fieldname=request.getParameter("fieldname");
if(fieldname==null)
{
  fieldname="form1.goods";
}
Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+community);

StringBuffer sql=new StringBuffer();//SELECT n.node,nl.subject

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

int pos=0,sizepage=10;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count=Workproject.count(teasession._strCommunity,sql.toString());



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
<body>
<script>
function f_c(igd2)
{
  window.opener.document.<%=fieldname%>.value=igd2;
  window.close();
}
</script>
<!--客户或项目管理-->
<br>
<div id="head6"><img height="6" src="about:blank"></div>


<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
   <form name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td><%=r.getString(teasession._nLanguage,"客户或项目")%>:<!--名称--><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td><input type="submit" value="GO"/></td></tr>
   </table>
</form>
<br>
<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"><script>var i=0;</script></td>
       <td nowrap><%=r.getString(teasession._nLanguage,"客户名称")%></td>
     </tr>
   <%
   java.util.Enumeration enumer=Workproject.find(community,sql.toString(),pos,sizepage);
   if(!enumer.hasMoreElements())
   {
     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }
   for(int index=1;enumer.hasMoreElements();index++)
   {
     int workproject=((Integer)enumer.nextElement()).intValue();
     Workproject obj=Workproject.find(workproject);
     %>


    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" onclick="f_c('<%=workproject%>');">
       <td width="1" align="center"><%=index%></td>
       <td  align="center"><%=obj.getName(teasession._nLanguage)%></td>
     </tr>
     <%
     }
     %>
     <%if(count>sizepage){ %>
     <tr><td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,sizepage)%></td></tr>
     <%} %>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


