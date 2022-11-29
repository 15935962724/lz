<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/resource/NetDisk");
String nexturl=request.getParameter("nexturl");
String act=request.getParameter("act");
int filecenterunit=Integer.parseInt(request.getParameter("filecenterunit"));
if(act!=null&&act.length()>0)
{
  if(act.equals("delete"))
  {
    FileCenterUnit fcu=FileCenterUnit.find(filecenterunit);
    fcu.delete();
  }else if(act.equals("edit"))
  {
    String name=request.getParameter("name");
    if(filecenterunit>0)
    {
      FileCenterUnit fcu=FileCenterUnit.find(filecenterunit);
      fcu.set(name);
    }else
    {
      boolean rs=FileCenterUnit.create(teasession._strCommunity,name);
      if(!rs)
      {
        out.print("<script>alert('“"+name+"”已经存在！不能重复添加');location.replace('"+nexturl+"');</script>");
        return;
      }
    }
  }
  response.sendRedirect(nexturl);
  return;
}

String name="";
if(filecenterunit>0)
{
  FileCenterUnit fcu=FileCenterUnit.find(filecenterunit);
  name=fcu.getName();
}

%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</HEAD>
<body>

<h1><%=r.getString(teasession._nLanguage, "编制部门")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?" onsubmit="return submitText(this.name,'无效-名称')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="filecenterunit" value="<%=filecenterunit%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="edit">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>名称</td>
  <td><input type="text" name="name" value="<%=name%>"/></td>
</tr>
</table>

<input type=submit value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
<input type=button value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="history.back()">
</form>

</body>
</html>
