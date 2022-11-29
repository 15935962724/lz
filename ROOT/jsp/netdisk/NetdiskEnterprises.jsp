<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.site.*" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.member.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

StringBuffer sql=new StringBuffer();
String dn=request.getParameter("dn");
if(dn!=null&&dn.length()>0)
{
  sql.append(" AND dn LIKE "+DbAdapter.cite("%"+dn.trim()+"%"));
}

String fullname=request.getParameter("fullname");
if(fullname!=null&&fullname.length()>0)
{
  sql.append(" AND fullname LIKE "+DbAdapter.cite("%"+fullname.trim()+"%"));
}
String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onLoad="document.form1.add.focus();">
<h1>企业管理</h1>
<div id="head6"><img  height="6"></div>
<h2>查询</h2>
<form action="<%=request.getRequestURI()%>" method="get">
<input type="hidden" name="menu" value="<%=request.getParameter("menu")%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<TABLE  cellSpacing="0" id="tablecenter">
  <tr>
    <td>标识:<input type="text" name="dn" value="<%if(dn!=null)out.print(dn);%>"></td>
    <td>名称:<input type="text" name="fullname" value="<%if(fullname!=null)out.print(fullname);%>"></td>
    <td><input type="submit" value="查询"></td>
  </tr>
</table>

</form>
<h2>列表</h2>
<form name="form1" action="/servlet/Admin" method="post" onSubmit="return submitText(this.community,'无效-企业标识.')&&submitText(this.fullname,'无效-企业全名.');">
<input type="hidden" name="act" value="EditCommunity">
<input type="hidden" name="community" value="">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<TABLE  cellSpacing="0" id="tablecenter">
<TR id="tableonetr">
  <td>标识</td>
  <td>名称</td>
  <td>会员数</td>
  <td>空间</td>
  <td></td>
</tr>
<%
java.util.Enumeration enumer=NetdiskEnterprise.find(sql.toString(),0,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  String community_id=(String)enumer.nextElement();
  NetdiskEnterprise obj=NetdiskEnterprise.find(community_id);

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=community_id%></td>
  <td><%=obj.getFullname()%></td>
  <td><A href="/jsp/user/Members.jsp?community=<%=community_id%>"></A><%=Profile.countByCommunity(community_id)%></td>
  <td><%=obj.getProductid()%>M</td>
  <td>
<input type="button" onClick="window.open('/jsp/netdisk/EditNetdiskEnterprise.jsp?community=<%=community_id%>&nexturl=<%=nexturl%>','_self')" value="编辑"/>
<input type="submit" name="delete" onClick="document.form1.community.value='<%=community_id%>';return confirm('确认删除');" value="删除"/>
<!--
<input type="button" value="CSS" onClick="window.open('/jsp/admin/SetCommunityCss.jsp?community=<%=community_id%>&nexturl=<%=nexturl%>','_self');"/>

<input type="button" value="菜单" onClick="window.open('/jsp/admin/MenuFrame.jsp?community=<%=community_id%>&nexturl=<%=nexturl%>','_self');"/>
 --> </td>
  </tr>
  <%
}
%>
</table>

<input name="add" type="button" onClick="window.open('/jsp/netdisk/EditNetdiskEnterprise.jsp?nexturl=<%=nexturl%>','_self')" value="添加"/>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

