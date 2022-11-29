<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/unitlist");

String nexturl=teasession.getParameter("nexturl");

int adminunit=0;
String tmp=teasession.getParameter("adminunit");
if(tmp!=null&&tmp.length()>0)
{
  adminunit=Integer.parseInt(tmp);
}

int root=AdminUnit.getRootId(teasession._strCommunity);

boolean usepic=true; boolean hiddenorg = false;
int pid=2001,father=root,len_pic=0,adminunittype=0,adminunitorg=0;
String name=null,ename=null,tel=null,fax=null,picture=null,linkmanname=null,address=null,content=null;
if(adminunit>0)
{
  AdminUnit au=AdminUnit.find(adminunit);
  name=au.getName();
  ename=au.getEName();
  tel=au.getTel();
  fax=au.getFax();
  linkmanname=au.getLinkmanname();
  address=au.getAddress();
  content=au.getContent();
  pid=au.getPid();
  father=au.getFather();
  picture=au.getPicture();
  if(picture!=null&&picture.length()>0)
  {
    len_pic=(int)new File(application.getRealPath(picture)).length();
  }
  usepic=au.isUsePic();
  hiddenorg = au.isHiddenorg();
  adminunittype=au.adminunittype;
  adminunitorg=au.adminunitorg;
}

%><html>
<head>
<title><%=r.getString(teasession._nLanguage, "DeptManage")%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT language="JavaScript" type="">
function f_submit()
{
  return( submitInteger(form1.pid,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Code")%>')
		&&submitText(form1.name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>'));
}
function f_load()
{
  form1.name.focus();
}
function f_show(u)
{
  window.showModalDialog("/jsp/admin/popedom/"+u+"?community=<%=teasession._strCommunity%>",self,'dialogwidth:500px;dialogheight:500px');
}
</SCRIPT>
</head>
<BODY onLoad="f_load();" id="bodynone">
<div id="wai">
<h1><%=r.getString(teasession._nLanguage, "AddDept")%></h1>
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="/servlet/EditAdminPopedom" method="post" enctype="multipart/form-data">
<input type=hidden name="adminunit" value="<%=adminunit%>">
<input type=hidden name="act" value="editadminunit"/>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="sequence" />

<table cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
<tr>
  <td><%=r.getString(teasession._nLanguage, "Code")%>：</td>
  <td><input name="pid" value="<%=pid%>">&nbsp;*</td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Name")%>：</td>
  <td><input name="name" value="<%if(name!=null)out.print(name);%>" size="40" >&nbsp;*</td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "英文名称")%>：</td>
  <td><input name="ename" value="<%if(ename!=null)out.print(ename);%>" size="40" ></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "负责人")%>：</td>
  <td><input name="linkmanname" value="<%if(linkmanname!=null)out.print(linkmanname);%>" size="40" ></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Telephone")%>：</td>
  <td><input value="<%if(tel!=null)out.print(tel);%>" size="40" name="tel"></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Fax")%>：</td>
  <td><input size="40" name="fax" value="<%if(fax!=null)out.print(fax);%>" ></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Address")%>：</td>
  <td><input size="60" name="address" value="<%if(address!=null)out.print(address);%>"></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "说明")%>：</td>
  <td><textarea name="content" cols="40" rows="3"><%if(content!=null)out.print(content);%></textarea></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Picture")%>：</td>
  <td><input type="file" size="40" name="picture">
  <%
  if(len_pic > 0)
  {
    out.println("<a href="+picture+" target=_blank>"+len_pic + r.getString(teasession._nLanguage, "Bytes")+"</a>");
    out.println("<input type=checkbox name=clear onClick=form1.picture.disabled=this.checked; >"+r.getString(teasession._nLanguage, "Clear"));
  }
  %>
  <br>
    <input type=checkbox name="usepic" <%if(usepic)out.print(" checked ");%> >是否启用个性化设置　　　　<input type="checkbox" name="hiddenorg" value="1" <%if(hiddenorg)out.print(" checked ");%>/>不显在组织机构中
  </td>
</tr>
<!--上级部门-->
<tr>
  <td><%=r.getString(teasession._nLanguage, "1168928321515")%>：</td>
  <td>
    <select name="father"><option value="<%=root%>">------------------------</option>
    <%
    Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity,"");
    while(e.hasMoreElements())
    {
      AdminUnit au=(AdminUnit)e.nextElement();
      int auid=au.getId();
      out.print("<option value="+auid);
      if(father==auid)out.print(" selected='true'");
      out.print(">"+au.getPrefix()+au.getName());
    }
    %>
    </select>
  </td>
</tr>
<%
int sum=AdminUnitType.count(" AND community="+DbAdapter.cite(teasession._strCommunity));
if(sum>0)
{
  out.print("<tr><td>分类：</td><td><select name='adminunittype'><option value='0'>----------------");
  Iterator it=AdminUnitType.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,200).iterator();
  while(it.hasNext())
  {
    AdminUnitType aut=(AdminUnitType)it.next();
    out.print("<option value='"+aut.adminunittype+"'");
    if(aut.adminunittype==adminunittype)out.print(" selected=''");
    out.print(">"+aut.name);
  }
  out.print("</select> <a href='###'  onclick=f_show('AdminUnitTypes.jsp')>管理</a></td>");
}
sum=AdminUnitOrg.count(" AND community="+DbAdapter.cite(teasession._strCommunity));
if(sum>0)
{
  out.print("<tr><td>所属机构：</td><td><select name='adminunitorg'><option value='0'>----------------");
  Iterator it=AdminUnitOrg.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,200).iterator();
  while(it.hasNext())
  {
    AdminUnitOrg aut=(AdminUnitOrg)it.next();
    out.print("<option value='"+aut.adminunitorg+"'");
    if(aut.adminunitorg==adminunitorg)out.print(" selected=''");
    out.print(">"+aut.name);
  }
  out.print("</select> <a href='###' onclick=f_show('AdminUnitOrgs.jsp')>管理</a></td>");
}
%>
<TR align="center">
  <td  colSpan="2" class="TableControl">
    <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" name="cbsubmit" onClick="return f_submit();" >
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back();"/>
</td>
</tr>
</table>
</form>

<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</div>
</body>
</html>
