<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@ page import="java.io.*"%><%@ page import="java.util.*"%><%@ page import="tea.entity.*"%><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String path="/res/" + teasession._strCommunity + "/bbsphoto/";
String abspath=application.getRealPath(path);

java.io.File root=new java.io.File(abspath);
if (!root.exists())
{
  root.mkdirs();
}

if(request.getMethod().equals("POST"))
{
  if(teasession.getParameter("delete")!=null)
  {
    String name[]=request.getParameterValues("name");
    if(name!=null)
    {
      for(int index=0;index<name.length;index++)
      {
        new java.io.File(application.getRealPath(path+name[index])).delete();
      }
    }
  }else
  if(teasession.getParameter("auto_make")!=null)
  {
    java.io.File   files[]=  new java.io.File(application.getRealPath("/jsp/type/bbs/default_bbsphoto")).listFiles();
    if(files!=null)
    {
      for(int i=0;i<files.length;i++)
      {
        File f=new File(abspath+"/"+files[i].getName());
        if(f.exists())continue;
        Filex.copy(files[i].getPath(),f.getPath());
      }
    }
  }else
  {
    byte by[]=teasession.getBytesParameter("photo");
    if(by!=null)
    {
      java.io.File f = new java.io.File(application.getRealPath(path+teasession.getParameter("photoName")));
      java.io.ByteArrayOutputStream bytestream = new java.io.ByteArrayOutputStream();
      bytestream.write(by);
      java.io.OutputStream os = new java.io.FileOutputStream(f);
      bytestream.writeTo(os);
      os.close();
      bytestream.close();
    }
  }
  response.sendRedirect(request.getRequestURI()+"?node="+teasession._nNode+"&community="+teasession._strCommunity);
  return;
}


java.io.File files[]=root.listFiles();

Resource r=new Resource("/tea/ui/node/section/EditPicture");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "图片管理")%></h1>
<div id="head6"><img height="6" alt=""></div>
<form action="/jsp/type/bbs/InnerPhotoManage.jsp?node=<%=teasession._nNode%>" method="post" enctype="multipart/form-data" name="form1">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr><td>上传</td>
<td>
<input type="file" name="photo"/>&nbsp;<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"/>
</td>
<td><input type="submit" name="auto_make" value="<%=r.getString(teasession._nLanguage,"自动生成默认头像")%>"/></td>
  </tr>
</table>
</form>
<%
if(files!=null)
{%>
<form action="/jsp/type/bbs/InnerPhotoManage.jsp?node=<%=teasession._nNode%>" method="post"  name="form2" onSubmit="return confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>');">

<h2><%=r.getString(teasession._nLanguage, "PictureManage")%>:<%=files.length%></h2>
  <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr ID=tableonetr>
        <td></td>
        <td id="miniature"><%=r.getString(teasession._nLanguage, "Breviary")%></td>
        <td><%=r.getString(teasession._nLanguage, "Name")%></td>
        <td><%=r.getString(teasession._nLanguage, "Size")%></td>
        <td><%=r.getString(teasession._nLanguage, "Time")%></td>
      </tr>
      <%
      for(int i=0;i<files.length;i++)
      {
        if(files[i].isHidden())continue;
          %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
            <td><input  id="CHECKBOX" type="CHECKBOX" name="name" value="<%=files[i].getName()%>"/></td>
            <td id="miniature"><div style="width:100px;height:100px;border:1px solid #CCC;background:#FFF"><img name="img<%=i%>" src="<%=path+files[i].getName()%>"/></div></td>
            <td><A href="<%=path+files[i].getName()%>" target="_blank" ><%=files[i].getName()%></A></td>
            <td><%=files[i].length()/1024%> K</td>
            <td><%=MT.f(new Date(files[i].lastModified()),1)%></td>
          </tr>
       <%
       }
       %>
        </table>
        <input type=submit name="delete"  class="edit_button" onClick="" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/>
</form>
<script type="">
var imgs=document.getElementsByTagName("img");
if(imgs)
for(var i=1;i<imgs.length;i++)
{
  if(imgs[i].width>100||imgs[i].height>100)
  if(imgs[i].width>imgs[i].height)
  imgs[i].width=100;
  else
  imgs[i].height=100;
}
</script>
<%}%>

<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

