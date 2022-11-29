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

int warid = 0;
if(teasession.getParameter("warid")!=null && teasession.getParameter("warid").length()>0)
{
  warid = Integer.parseInt(teasession.getParameter("warid"));
}
String nexturl = teasession.getParameter("nexturl");
Warehouse wobj = Warehouse.find(warid);
if("EditWarehouse".equals(teasession.getParameter("act")))//添加仓库
{

  String warname = teasession.getParameter("warname");
  String contact = teasession.getParameter("contact");
  String telephone = teasession.getParameter("telephone");
  String address = teasession.getParameter("address");
  if(warid>0)
  {
     wobj.set(warname,contact,telephone,address,teasession._rv.toString());
  }else
  {
    Warehouse.create(warname,contact,telephone,address,teasession._rv.toString(),teasession._strCommunity);
  }
  response.sendRedirect(nexturl);
  return;
}
if("delete".equals(teasession.getParameter("act")))
{
  wobj.delete();
  response.sendRedirect(nexturl);
  return;
}


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
  function f_submit()
  {
     if(form1.warname.value== '')
     {
        alert('仓库名称不能为空，请重新填写！');
        form1.warname.focus();
        return false;
     }
  }
</script>
<h1>仓库管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name="form1" action="?" method="POST" onsubmit="return f_submit(this);">
<input type="hidden" name="act" value="EditWarehouse">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="warid" value="<%=warid%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>仓库名称:</td>
    <td><input type="text" name="warname" value="<%=wobj.getWarname()%>">&nbsp;(仓库名称必须填写)</td>
  </tr>
  <tr>
    <td nowrap>联系人:</td>
    <td><input type="text" name="contact" value="<%=wobj.getContact()%>"></td>
  </tr>
  <tr>
    <td nowrap>电话:</td>
    <td><input type="text" name="telephone" value="<%=wobj.getTelephone()%>"></td>
  </tr>
  <tr>
    <td nowrap>仓库地址:</td>
    <td><input type="text" name="address" value="<%=wobj.getAddress()%>"></td>
  </tr>
   <tr>
    <td nowrap>预警下限数值:</td>
    <td><input type="text" name="" value=""></td>
  </tr>
</table>
<br>
<input type="submit" value="提交"/>&nbsp;
<input type=button value="返回" onClick="javascript:history.back()">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
