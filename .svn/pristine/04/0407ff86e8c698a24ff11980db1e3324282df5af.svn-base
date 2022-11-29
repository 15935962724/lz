<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
if("del".equals(request.getParameter("act")))
{
  String member=request.getParameter("member");
  Profile.delete(member);
}
Http h=new Http(request);

int role=h.getInt("role");

String sql=" AND golf IS NOT NULL AND golf!='/'";
int sum=AdminUsrRole.count(teasession._strCommunity,sql);

Resource r=new Resource().add("/tea/resource/deptuser");


%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分球会-会员</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_edit(m)
{
  location.href="/jsp/type/golf/EditGolfRole.jsp?community=<%=teasession._strCommunity%>&role=<%=role%>&member="+encodeURIComponent(m);
}
function f_delete(m)
{
  if(confirm('确认删除“'+m+'”会员吗?'))
  {
    window.open('/jsp/type/golf/GolfRole.jsp?act=del&community=<%=teasession._strCommunity%>&role=<%=role%>&member='+encodeURIComponent(m),'_self')
  }
}
</script>
</head>
<BODY>
<h1>分球会-会员 <%="（"+sum+"）"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<TABLE  cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
  <TR id="tableonetr">
    <td align="center">序号</td>
    <TD><%=r.getString(teasession._nLanguage, "ID")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Username")%></TD>
    <TD>手机号</TD>
    <TD><%=r.getString(teasession._nLanguage, "operation")%></TD>
  </TR>
  <%
  Enumeration e=AdminUsrRole.find(teasession._strCommunity,sql,0,1000);
  for(int i=1;e.hasMoreElements();i++)
  {
    String _member=(String)e.nextElement();
    AdminUsrRole obj=AdminUsrRole.find(teasession._strCommunity,_member);
    Profile pf_obj_temp=Profile.find(_member);
    //AdminUnit au=AdminUnit.find(obj.getUnit());
    %>
    <tr onMouseOver="bgColor='#BCD1E9'" onMouseOut="bgColor=''">
      <td align="center"><%=i%></td>
      <TD><%=obj.getMember()%></TD>
      <TD><%=pf_obj_temp.getName(teasession._nLanguage)%></TD>
      <TD><%=pf_obj_temp.getMobile()%></TD>
      <TD><input type="button" onclick="f_edit('<%=_member%>');" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>">
        <input type="button" onclick="f_delete('<%=_member%>');" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>">
      </TD>
    </TR>
<%}
%>
  </TABLE>
  <br>

  <input type="button" value="添加" onclick="f_edit('')">


</BODY></html>
