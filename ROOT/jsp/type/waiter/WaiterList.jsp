<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*" %>
<%@include file="/jsp/Header.jsp"%>
<%
int zone=Integer.parseInt(request.getParameter("zone"));
Conductor con_obj= Conductor.find(teasession._rv._strR,node.getCommunity());
boolean exist = (con_obj.getZone()!=null&&con_obj.getZone().indexOf("/"+zone+"/")!=-1)||  tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv._strR);

String delete=request.getParameter("delete");
if(exist&&delete!=null)
{
  Node del_obj=Node.find(Integer.parseInt(delete));
  response.sendRedirect(request.getRequestURI()+"?node="+del_obj.getFather()+"&zone="+zone);
  del_obj.delete(teasession._nLanguage);
  return;
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<script>
function f_edit(n,m)
{
  window.location='/jsp/type/waiter/EditWaiter.jsp?node='+n+'&member='+encodeURIComponent(m)+'&nexturl='+encodeURIComponent(location);
}
</script>
</head>
<body>
<h1><%
    AdminZone az_obj=AdminZone.find(zone);
    if(az_obj.isExists() )
    out.print(az_obj.getName());
    else
    out.print("其它");
  %></h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id=tableonetr>
    <td nowrap>会员ID</td>
    <td nowrap>姓名</td>
    <td nowrap>性别</td>
    <td nowrap>手机</td>
    <td nowrap>年龄</td>
    <td nowrap>地址</td>
    <td nowrap>&nbsp;</td>
  </tr>
  <%
    java.util.Enumeration enumer= tea.entity.node.Waiter.findByZone(zone);
  while(enumer.hasMoreElements())
  {
    int node=((Integer)enumer.nextElement()).intValue();
    Node node_obj=Node.find(node);
//    tea.entity.node.Waiter obj=tea.entity.node.Waiter.find(node,teasession._nLanguage);
    Profile profile_obj=Profile.find(node_obj.getCreator()._strR);
%>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
  <td><a href="/jsp/type/waiter/WaiterPreview.jsp?node=<%=node%>"><%=(node_obj.getCreator())%></A></td>
  <td>&nbsp;<%=profile_obj.getFirstName(teasession._nLanguage)%></td>
  <td>&nbsp;<%=profile_obj.isSex()?"男":"女"%></td>
  <td>&nbsp;<%=profile_obj.getMobile()%></td>
  <td>&nbsp;<%=profile_obj.getBirthToString()%></td>
  <td>&nbsp;<%=profile_obj.getAddress(teasession._nLanguage)%></td>
  <td>&nbsp;
    <%if(exist){%>
    <input type="submit" name="Submit" onClick="f_edit('<%=node%>','<%=node_obj.getCreator()%>');" value="编辑">
    <INPUT TYPE="BUTTON" VALUE="删除"  onClick="if(confirm('确认删除?')){window.open('<%=request.getRequestURI()%>?delete=<%=node%>&node=<%=node%>&zone=<%=zone%>', '_self')};"/>
<%}%>
</td>
</tr>
<%}%>
</table>
  <br>
  <input type="submit" name="Submit" onClick="f_edit('<%=teasession._nNode%>','');" value="创建">
  <br>
  <br>
  <br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

