<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
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


Resource r=new Resource().add("/tea/resource/deptuser");

String nexturl=teasession.getParameter("nexturl");

int adminrole=Integer.parseInt(teasession.getParameter("adminrole"));

AdminRole ar=AdminRole.find(adminrole);
String consign=ar.getConsign();

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function CheckForm()
{
  var consign="/";
  var op=form1.role1.options;
  for(var i=0;i<op.length; i++)
  {
    consign=consign+op[i].value+"/";
  }
  form1.consign.value=consign;
}
</script>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "UserManage")+" ( "+ar.getName()+" )"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2><%=r.getString(teasession._nLanguage, "AddUser")%></h2>


<form name="form1" method="post" action="/servlet/EditAdminPopedom" onsubmit="CheckForm();">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="act" value="setadminroleconsign">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <input type="hidden" name="adminrole" value="<%=adminrole%>">
  <input type="hidden" name="consign">
  <table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
    <tr align="center">
      <td><%=r.getString(teasession._nLanguage, "SelectRole")%></td>
      <td>&nbsp;</td>
      <td><%=r.getString(teasession._nLanguage, "StandbyRole")%></td>
    </tr>
    <tr>
      <td>
      <select name="role1" size="12" multiple style="WIDTH:140px;"  ondblclick="move(form1.role1,form1.role2,true);">
      <%
      String rs[]=consign.split("/");
      for(int i=1;i<rs.length;i++)
      {
        int id=Integer.parseInt(rs[i]);
        AdminRole ar_obj=AdminRole.find(id);
        if(ar_obj.isExists())
        {
          out.print("<option value="+id+" >"+ar_obj.getName());
        }
      }
      %>
    </select>
    </td>
    <td>
    <input type="button" value=" ← " onClick="move(form1.role2,form1.role1,true);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.role1,form1.role2,true);">    </td>
    <td>
    <select name="role2" ondblclick="move(form1.role2,form1.role1,true);" multiple style="WIDTH:140px;" size="12">
    <%
      Enumeration ar_enumer=AdminRole.findByCommunity(teasession._strCommunity,teasession._nStatus);
      while(ar_enumer.hasMoreElements())
      {
        int ar_id=((Integer)ar_enumer.nextElement()).intValue();
        if(consign.indexOf("/"+ar_id+"/")==-1)
        {
          AdminRole obj=AdminRole.find(ar_id);
          if(obj.getType()!=1)//1为默认角色
          out.print("<option value="+ar_id+" >"+obj.getName()+"</option>");
        }
      }%>
    </select>
    </td>
    </tr>
  </table>

  <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back();">
</FORM>

<BR>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</HTML>
