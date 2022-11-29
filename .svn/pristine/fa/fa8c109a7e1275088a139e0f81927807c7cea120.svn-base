<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&nexturl=").append(java.net.URLEncoder.encode(nexturl,"UTF-8"));

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Warehouse.count(teasession._strCommunity,sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<body>
<script type="">
   function f_edit(igd)
   {
       form1.warid.value=igd;
       form1.action="/jsp/erp/EditWarehouse.jsp"
       form1.submit();
   }
   function f_delete(igd)
   {
     form1.warid.value=igd;
     form1.act.value='delete';
     form1.action="/jsp/erp/EditWarehouse.jsp"
     form1.submit();
   }
</script>
<h1>仓库管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name="form1" action="?">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="warid"/>
<input type="hidden" name="act"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>

<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>仓库名称</td>
    <td nowrap>联系人</td>
    <td nowrap>电话</td>
    <td nowrap>仓库地址</td>
    <td nowrap>操作</td>
  </tr>
  <%
  java.util.Enumeration e = Warehouse.find(teasession._strCommunity,sql.toString(),pos,pageSize);
  while(e.hasMoreElements())
  {
    int warid = ((Integer)e.nextElement()).intValue();
    Warehouse wobj =  Warehouse.find(warid);
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center"><%=wobj.getWarname() %></td>
      <td align="center"><%=wobj.getContact()%></td>
      <td align="center"><%=wobj.getTelephone()%></td>
      <td align="center"><%=wobj.getAddress()%></td>
      <td align="center"><a href="#" onclick="f_edit('<%=warid%>');">编辑</a>&nbsp;<a href="#" onclick="f_delete('<%=warid%>');">删除</a> </td>
    </tr>

      <%}if (count > pageSize) {  %>
        <tr><td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%> </td>   </tr>
      <%}  %>

</table>
<br />
<input type="button" value="添加仓库" onclick="window.open('/jsp/erp/EditWarehouse.jsp?nexturl=<%=nexturl%>','_self');"/>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>
