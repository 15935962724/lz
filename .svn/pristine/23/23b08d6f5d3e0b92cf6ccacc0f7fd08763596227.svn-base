<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
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


Resource r=new Resource("/tea/resource/AdminList");

String member = teasession._rv._strV;
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl=request.getHeader("referer");
}
String name=request.getParameter("name");

AdminList al=AdminList.find(member,name);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function f_submit()
{
  var f="/";
  var op=form1.field1.options;
  for(var i=0;i<op.length; i++)
  {
    f=f+op[i].value+"/";
  }
  form1.field.value=f;
}
</script>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "定制列表栏目")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditAdminList" onsubmit="f_submit()" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="name" value="<%=name%>">
<input type="hidden" name="field" value="<%=al.getField()%>">

<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <TR id="tableonetr">
    <td align="right">选定</td>
    <td></td>
    <td>备选</td>
  </tr>
  <tr>
    <td align="right">
  <select name="field1" size="8" multiple style="WIDTH:140px;" ondblclick="move(form1.field1,form1.field2,true);">
  </select>
  </td>
  <td align="center">
    <input type="button" value=" ← " onClick="move(form1.field2,form1.field1,true);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.field1,form1.field2,true);">
    <br><br>
    <input type="button" value=" ↑ " onClick="move(form1.field1,null,true);" >
    <br>
    <input type="button" value=" ↓ "  onClick="move(form1.field1,null,false);">
    </td>
  <td>
  <select name="field2" size="8" multiple style="WIDTH:140px;" ondblclick="move(form1.field2,form1.field1,true);">
  <%
  String afs[]=al.getAllField().split("/");
  for(int i=1;i<afs.length;i++)
  {
    out.print("<option value="+afs[i]+">"+r.getString(teasession._nLanguage,name+"."+afs[i]));
  }
  %>
  </select>
  <script>
  var f0=form1.field.value;
  var f1=form1.field1.options;
  var f2=form1.field2.options;
  for(var i=0;i<f2.length;)
  {
    if(f0.indexOf("/"+f2[i].value+"/")!=-1)
    {
      f2[i].selected=true;
      move(form1.field2,form1.field1,true);
    }else
    {
      i++;
    }
  }
  </script>
  </td></tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onclick="history.back();">
</FORM>

<br/>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>
