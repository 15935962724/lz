<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/deptuser");

Communitybbs community= Communitybbs.find(teasession._strCommunity);
boolean _bCommunityManage=teasession._rv._strR.equals(community.getSuperhost());
if(!_bCommunityManage&&!teasession._rv.isWebMaster())
{
  response.sendError(403);
  return;
}
if("POST".equals(request.getMethod()))
{
  if(request.getParameter("communitymember")!=null)
  {
    String superhost=request.getParameter("superhost");
    if(!Profile.isExisted(superhost))
    {
      out.print("<script>alert('"+r.getString(teasession._nLanguage,"InvalidMemberId")+"');history.back();</script>");
      return;
    }
    community.set(superhost);
  }else
  {
    String member=request.getParameter("member");
    boolean flag=Boolean.parseBoolean(request.getParameter("flag"));
    AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,member);
    if(flag)
    aur_obj.setBbsExpert("/");
    else
    aur_obj.setBbsHost("/");
  }
  response.sendRedirect(request.getRequestURI()+"?community="+teasession._strCommunity);
  return;
}


%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_act(act,flag,m)
{
  if(act=='del')
  {
    if(!confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))return false;
    form1.member.value=m;
    form1.flag.value=flag;
    form1.submit();
    return;
  }
  if(m)m="&member="+encodeURIComponent(m);
  var rs=window.showModalDialog('/jsp/type/bbs/AddBBSHost.jsp?community=<%=teasession._strCommunity%>&flag='+flag+m+'&t='+new Date().getTime(),self,'status:0;help:0;dialogWidth:600px;dialogHeight:400px;');
  if(rs)location.reload();
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "版主管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/jsp/type/bbs/EditBBSHost.jsp" method="post" onSubmit="">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="flag">
<input type="hidden" name="member">

<h2><%=r.getString(teasession._nLanguage,"版主管理")%></h2>
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td><%=r.getString(teasession._nLanguage, "ID")%></td>
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
<%
java.util.Enumeration pfbyu_enumer=AdminUsrRole.find(teasession._strCommunity," AND bbshost LIKE '/_%'",0,Integer.MAX_VALUE);
for(int iCount=1;pfbyu_enumer.hasMoreElements();iCount++)
{
  String member_temp=(String)pfbyu_enumer.nextElement();
  Profile pf_obj_temp=Profile.find(member_temp);
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+member_temp);
  out.print("<td>"+pf_obj_temp.getName(teasession._nLanguage));
  out.print("<td><input type='button' onclick=f_act('edit',false,'"+member_temp+"') value="+r.getString(teasession._nLanguage, "CBEdit")+"> ");
  out.print("<input type='button' onclick=f_act('del',false,'"+member_temp+"') value="+r.getString(teasession._nLanguage, "CBDelete")+">");
}
%>
</table>
<input type='button' onclick=f_act('new',false,''); value="添加">


<h2><%=r.getString(teasession._nLanguage,"专家管理")%></h2>
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td><%=r.getString(teasession._nLanguage, "ID")%></td>
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
<%
pfbyu_enumer=AdminUsrRole.find(teasession._strCommunity," AND bbsexpert LIKE '/_%'",0,Integer.MAX_VALUE);
for(int iCount=1;pfbyu_enumer.hasMoreElements();iCount++)
{
  String member_temp=(String)pfbyu_enumer.nextElement();
  Profile pf_obj_temp=Profile.find(member_temp);
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+member_temp);
  out.print("<td>"+pf_obj_temp.getName(teasession._nLanguage));
  out.print("<td><input type='button' onclick=f_act('edit',true,'"+member_temp+"') value="+r.getString(teasession._nLanguage, "CBEdit")+"> ");
  out.print("<input type='button' onclick=f_act('del',true,'"+member_temp+"') value="+r.getString(teasession._nLanguage, "CBDelete")+">");
}
%>
</table>
<input type='button' onclick=f_act('new',true,'') value="添加">

<h2><%=r.getString(teasession._nLanguage,"SuperHost")%></h2>
<input type="text" name="superhost" value="<%if(community.getSuperhost()!=null)out.print(community.getSuperhost()); %>"/>
<input type="submit" name="communitymember" value="<%=r.getString(teasession._nLanguage,"Submit")%>" onClick="return submitIdentifier(form1.superhost,'<%=r.getString(teasession._nLanguage,"InvalidMemberId")%>');"/>

</form>

<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</BODY>
</html>
