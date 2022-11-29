<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"  %>
<%@ page import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.criterion.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int item=Integer.parseInt(request.getParameter("item"));

String community=request.getParameter("community");

Item obj=Item.find(item);

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/deptuser");
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1>项目组人员联系信息</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<TABLE  cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
  <TR id="tableonetr">
    <TD valing=middle>用户名</TD>
    <TD valing=middle>姓名</TD>
    <TD valing=middle>E-Mail</TD>
    <TD valing=middle>电话</TD>
    <TD valing=middle>手机</TD>
    <TD valing=middle>部门</TD>
    <TD valing=middle>职务</TD>
    <TD valing=middle>角色</TD>
  </TR>
<%
tea.entity.member.Profile profile;
String au_name,email,name;
if(obj.getPrincipal()!=null&&obj.getPrincipal().length()>0)
{
  out.print("<tr valign=\"bottom\"   onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"> ");

  profile=tea.entity.member.Profile.find(obj.getPrincipal());
  tea.entity.admin.AdminUsrRole aur=tea.entity.admin.AdminUsrRole.find(community,obj.getPrincipal());
  if(aur.getUnit()!=0)
  {
    tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(aur.getUnit());
    if(au_obj.isExists())
    au_name=au_obj.getName();
    else
    au_name="该部门已经不存在.";
  }else
  {
    au_name=r.getString(teasession._nLanguage, "NoDept");
  }
  email=profile.getEmail();

  name=profile.getFirstName(teasession._nLanguage);
  if(name!=null)
  name+=" "+profile.getLastName(teasession._nLanguage);
  else
  name="";

  out.print("<td>"+obj.getPrincipal());

  out.print("<td>"+name);

  out.print("<td>");
  if(email!=null)out.print("<A href=mailto:"+email+" >"+email+"</A>");

  out.print("<td>");
  if(profile.getTelephone(teasession._nLanguage)!=null)out.print(profile.getTelephone(teasession._nLanguage));

  out.print("<td>");
  if(profile.getMobile()!=null)out.print(profile.getMobile());

  out.print("<td>"+au_name+"<td>");
  if(profile.getJob(teasession._nLanguage)!=null)
  out.print(profile.getJob(teasession._nLanguage));

  out.print("<td>"+Item.ROLE_PRINCIPAL);//标准处管理员
}


if(obj.getDirector()!=null&&obj.getDirector().length()>0)
{
  out.print("<tr valign=\"bottom\"   onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"> ");

  profile=tea.entity.member.Profile.find(obj.getDirector());
  tea.entity.admin.AdminUsrRole aur=tea.entity.admin.AdminUsrRole.find(community,obj.getDirector());
  if(aur.getUnit()!=0)
  {
    tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(aur.getUnit());
    if(au_obj.isExists())
    au_name=au_obj.getName();
    else
    au_name="该部门已经不存在.";
  }else
  {
    au_name=r.getString(teasession._nLanguage, "NoDept");
  }

  email=profile.getEmail();

  name=profile.getFirstName(teasession._nLanguage);
  if(name!=null)
  name+=" "+profile.getLastName(teasession._nLanguage);
  else
  name="";

  out.print("<td>"+obj.getDirector());
  out.print("<td>"+name);
  out.print("<td>");
  if(email!=null)out.print("<A href=mailto:"+email+" >"+email+"</A>");

  out.print("<td>");
  if(profile.getTelephone(teasession._nLanguage)!=null)out.print(profile.getTelephone(teasession._nLanguage));

  out.print("<td>");
  if(profile.getMobile()!=null)out.print(profile.getMobile());

  out.print("<td>"+au_name+"<td>");
  if(profile.getJob(teasession._nLanguage)!=null)
  out.print(profile.getJob(teasession._nLanguage));

  out.print("<td>"+Item.ROLE_DIRECTOR);//标准所管理员

}

//AdminUnit au_out=AdminUnit.find(obj.getEditgroup());

if(obj.getEditgroup()!=0)
{
  java.util.Enumeration enumer=AdminUsrRole.findByUnit(obj.getEditgroup(),community);
  while(enumer.hasMoreElements())
  {
    out.print("<tr valign=\"bottom\"   onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"> ");
    String member=(String)enumer.nextElement();
    AdminUsrRole aur=AdminUsrRole.find(community,member);
    profile=tea.entity.member.Profile.find(member);
    if(aur.getUnit()!=0)
    {
      tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(aur.getUnit());
      if(au_obj.isExists())
      au_name=au_obj.getName();
      else
      au_name="该部门已经不存在.";
    }else
    {
      au_name=r.getString(teasession._nLanguage, "NoDept");
    }

    email=profile.getEmail();

    name=profile.getFirstName(teasession._nLanguage);
    if(name!=null)
    name+=" "+profile.getLastName(teasession._nLanguage);
    else
    name="";

    out.print("<td>"+member);
    out.print("<td>"+name);
    out.print("<td>");
    if(email!=null)out.print("<A href=mailto:"+email+" >"+email+"</A>");

    out.print("<td>");
    if(profile.getTelephone(teasession._nLanguage)!=null)out.print(profile.getTelephone(teasession._nLanguage));

    out.print("<td>");
    if(profile.getMobile()!=null)out.print(profile.getMobile());

    out.print("<td>"+au_name+"<td>");
    if(profile.getJob(teasession._nLanguage)!=null)
    out.print(profile.getJob(teasession._nLanguage));

    int adimrole_id=tea.entity.admin.AdminRole.findByName(Item.ROLE_SUPERMANAGER,community);
    if(aur.getRole().indexOf("/"+adimrole_id+"/")!=-1)
    out.print("<td>"+Item.ROLE_SUPERMANAGER);//编制组高级管理员
    else
    out.print("<td>"+Item.ROLE_MANAGER);//编制组高级管理员
  }
}




/*
if(obj.getSupermanager()!=null&&obj.getSupermanager().length()>0)
{
  out.print("<tr valign=\"bottom\"   onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"> ");

  profile=tea.entity.member.Profile.find(obj.getSupermanager(),community);
  tea.entity.admin.AdminUsrRole aur=tea.entity.admin.AdminUsrRole.find(community,obj.getPrincipal());
  if(aur.getUnit()!=0)
  {
    tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(aur.getUnit());
    if(au_obj.isExists())
    au_name=au_obj.getName();
    else
    au_name="该部门已经不存在.";
  }else
  {
    au_name=r.getString(teasession._nLanguage, "NoDept");
  }

  email=profile.getEmail();

  name=profile.getFirstName(teasession._nLanguage);
  if(name!=null)
  name+=" "+profile.getLastName(teasession._nLanguage);
  else
  name="";

  out.print("<td>"+obj.getSupermanager());
  out.print("<td>"+name);
  out.print("<td>");
  if(email!=null)out.print("<A href=mailto:"+email+" >"+email+"</A>");

  out.print("<td>");
  if(profile.getTelephone(teasession._nLanguage)!=null)out.print(profile.getTelephone(teasession._nLanguage));

  out.print("<td>");
  if(profile.getMobile()!=null)out.print(profile.getMobile());

  out.print("<td>"+au_name+"<td>");
  if(profile.getJob(teasession._nLanguage)!=null)
  out.print(profile.getJob(teasession._nLanguage));

  out.print("<td>"+Item.ROLE_SUPERMANAGER);//编制组高级管理员
}
*/




/*
if(obj.getManager()!=null&&obj.getManager().length()>0)
{
  profile=tea.entity.member.Profile.find(obj.getManager(),community);
  out.print("<tr valign=\"bottom\"   onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"> ");
  tea.entity.admin.AdminUsrRole aur=tea.entity.admin.AdminUsrRole.find(community,obj.getPrincipal());
  if(aur.getUnit()!=0)
  {
    tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(aur.getUnit());
    if(au_obj.isExists())
    au_name=au_obj.getName();
    else
    au_name="该部门已经不存在.";
  }else
  {
    au_name=r.getString(teasession._nLanguage, "NoDept");
  }

  email=profile.getEmail();

  name=profile.getFirstName(teasession._nLanguage);
  if(name!=null)
  name+=" "+profile.getLastName(teasession._nLanguage);
  else
  name="";

  out.print("<td>"+obj.getManager());
  out.print("<td>"+name);
  out.print("<td>");
  if(email!=null)out.print("<A href=mailto:"+email+" >"+email+"</A>");

  out.print("<td>");
  if(profile.getTelephone(teasession._nLanguage)!=null)out.print(profile.getTelephone(teasession._nLanguage));

  out.print("<td>");
  if(profile.getMobile()!=null)out.print(profile.getMobile());

  out.print("<td>"+au_name+"<td>");
  if(profile.getJob(teasession._nLanguage)!=null)
  out.print(profile.getJob(teasession._nLanguage));

  out.print("<td>"+Item.ROLE_MANAGER);//编制组管理员"
}
*/






/*
String personnel=obj.getPersonnel();
if(personnel!=null)
{
  String arrays[]=personnel.split("/");
  for(int index=1;index<arrays.length;index++)
  {
    out.print("<tr valign=\"bottom\"   onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"> ");

    profile=tea.entity.member.Profile.find(arrays[index],community);
    tea.entity.admin.AdminUsrRole aur=tea.entity.admin.AdminUsrRole.find(community,obj.getPrincipal());
    if(aur.getUnit()!=0)
    {
      tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(aur.getUnit());
      if(au_obj.isExists())
      au_name=au_obj.getName();
      else
      au_name="该部门已经不存在.";
    }else
    {
      au_name=r.getString(teasession._nLanguage, "NoDept");
    }

    email=profile.getEmail();

    name=profile.getFirstName(teasession._nLanguage);
    if(name!=null)
    name+=" "+profile.getLastName(teasession._nLanguage);
    else
    name="";


    out.print("<TD >"+arrays[index]+"</TD>");
    out.print("<TD >"+name+"</TD>");
    out.print("<TD >");
    if(email!=null)out.print("<A href=mailto:"+email+" >"+email+"</A>");

    out.print("<td>");
    if(profile.getTelephone(teasession._nLanguage)!=null)out.print(profile.getTelephone(teasession._nLanguage));

    out.print("<td>");
    if(profile.getMobile()!=null)out.print(profile.getMobile());

    out.print("<td>"+au_name+"<td>");
    if(profile.getJob(teasession._nLanguage)!=null)
    out.print(profile.getJob(teasession._nLanguage));

    out.print("<TD >编制组项目成员</TD></TR>");
  }
}*/
%>

</TABLE>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

