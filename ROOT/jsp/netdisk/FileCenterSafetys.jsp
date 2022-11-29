<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/NetDisk");


int filecenter=Integer.parseInt(request.getParameter("filecenter"));

FileCenter obj=FileCenter.find(filecenter);
if(!obj.isExists())
{
  out.print("不存在...");
  return;
}


%><HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>

function f_edit(id)
{
  form1.filecentersafety.value=id;
  form1.action='EditFileCenterSafety.jsp';
  form1.submit();
}

function f_delete(id)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    form1.filecentersafety.value=id;
    form1.act.value="delete";
    form1.submit();
  }
}

function f_extend(obj)
{
  if(!obj.checked)
  {
    if(!confirm('选择这个选项表示应用到子文件夹的父项权限项目不会应用到该文件夹上.'))
    {
      obj.checked=!obj.checked;
      return;
    }
  }
  form1.act.value="extend";
  form1.submit();
}

function f_reset()
{
  if(confirm('这将删除所有子对象的明确定义过的对象,并允许将可继承权限传播给那些子文件夹.\r\n是否继续?'))
  {
    form1.act.value="reset";
    form1.submit();
  }
}
</script>
</HEAD>
<body>

<h1><%=r.getString(teasession._nLanguage, "编辑权限")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=obj.getAncestor(-1)%></td>
  </tr>
</table>

<form name="form1" action="/servlet/EditFileCenterSafety" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="filecenter" value="<%=filecenter%>">
<input type="hidden" name="filecentersafety" >
<input type="hidden" name="act" >

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"  style="border-collapse:collapse">
<tr id="tableonetr">
  <td nowrap>序号</td>
  <td nowrap><%=r.getString(teasession._nLanguage, "权限")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage, "角色")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage, "部门")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage, "会员")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage, "继承于")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage, "应用于")%></td>
  <td nowrap>操作</td>
</tr>
<%
Enumeration e=FileCenterSafety.findByFileCenter(filecenter,"");
for(int j=1;e.hasMoreElements();j++)
{
  int id=((Integer)e.nextElement()).intValue();
  FileCenterSafety s=FileCenterSafety.find(id);
  FileCenter nd=FileCenter.find(s.getFileCenter());
  String ms[]=s.getMember().split("/");
  //System.out.println(id+":"+s.getFileCenter()+":"+nd.getPath());
  out.print("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''>");
  out.print("<td align=center>"+j);
  out.print("<td align=center>"+FileCenterSafety.PUR_TYPE[s.getPurview(obj.getPath())]);
  out.print("<td>"+s.getRoleToHtml("</SPAN><SPAN class=jueseshouquan>"));
  out.print("<td>"+s.getUnitToHtml("</SPAN><SPAN class=bumenshouquan>"));
  out.print("<td>"+s.getMemberToHtml("</SPAN><SPAN class=huiyuanshouquan>"));
  out.print("<td align=center>"+nd.getAncestor(-1));
  out.print("<td nowrap>"+FileCenterSafety.APPLY_STYLE[s.getStyle()]);
  out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=f_edit('"+id+"');>");
  out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=f_delete('"+id+"');>");
}
%>
</table>

<input type="button" value="添加" onClick="f_edit('0');"/>

<table border="1" cellpadding="0" cellspacing="0" id="tablecenter" style="border-collapse:collapse">
<%
if(obj.getFather()>0)
{
  out.print("<tr><td><input type=checkbox name=extend ");
  if(obj.isExtend())out.print(" checked ");
  out.print(" onClick=f_extend(this);>允许父项的继承权限传播到该文件夹和所有文件夹.</td></tr>");
}
%>
<tr><td><input type="button" onClick="f_reset();" value="应用到该文件夹并替代所有子文件夹的权限"/></td></tr>
</table>

</form>

</body>
</html>
