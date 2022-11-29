<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.resource.*"%>
<%@include file="/jsp/Header.jsp"%>
<%
Resource r = new Resource();
  tea.entity.node.Download download=   tea.entity.node.Download.find(teasession._nNode,teasession._nLanguage);
  String id=request.getParameter("id");
  if(request.getParameter("delete")!=null)
  download.delete(Integer.parseInt(id));
  else
  if(request.getMethod().equals("POST"))
  {
    String url=request.getParameter("url");
    if(id!=null&&id.length()>0)
    {
      int idcode=Integer.parseInt(id);
      download.set(idcode,request.getParameter("name"),url);
    }else
    {
      java.util.StringTokenizer name=new java.util.StringTokenizer(request.getParameter("name"),"\r\n");
      java.util.StringTokenizer tokenizerUrl=new java.util.StringTokenizer(url,"\r\n");
      while(name.hasMoreTokens()&&tokenizerUrl.hasMoreTokens())
      {
        String down_url=tokenizerUrl.nextToken();
        download.create(name.nextToken(),down_url);
      }
    }
  if(download.getSize()<=0)
  {
    int len=0;
    url=new String(url.getBytes("ISO-8859-1"));
    if(url.startsWith("/tea/download/"))
    {
      len=(int)(new java.io.File(application.getRealPath(url)).length()/1024);
    }else
    {
      try
      {
        java.net.URLConnection urlconn = new java.net.URL(url).openConnection();
        len = urlconn.getContentLength()/1024;
      }catch(Exception e)
      {}
    }
    if (len >0)
    {
      download.setSize(len);
    }
  }
}
java.util.Enumeration enumer=download.getId();

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
  function downadd(templet,name,url)
  {
    count=0;
   index= url.value.indexOf("\r\n");
   while(index!=-1)
   {
     count++;
     index= url.value.indexOf("\r\n",index+1);
   }
   name.value='';
   if(url.value.charAt(url.value.length-1)!='\n')
   count++;
   for(index=0;index<count;index++)
   {
     name.value+=templet.value.replace('index',index+1)+'\r\n';
   }
  }
   function downadd2(templet,name,url)
  {

var    index=templet.value.indexOf("\\tea\\");

if(index!=-1)
{
var str=templet.value.substring(index);
while(str!=str.replace("\\","/"))
{
str=str.replace("\\","/");
}
url.value+=str;
index=templet.value.lastIndexOf("\\");
var endindex=templet.value.lastIndexOf(".");
if(endindex<index+1)
name.value+=templet.value.substring(index+1);
else
name.value+=templet.value.substring(index+1,endindex);
}
}
  </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Download")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
<form method="POST" name="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>链接文字:</td>
<td>下载地址</td><td></td>
  </tr><tr><td>

  <textarea cols="25" name="name" rows="10" wrap="OFF"></textarea>
</td><td>
  <textarea name="url" cols="60" rows="10" wrap="OFF"></textarea>
  <input type="hidden" name="id" value=""/>
  </td><td>
  <input name=templet value="下载地址 index" />
  <input type="button" name="我叫小刘" value="生成链接文字" onclick="downadd(form1.templet,form1.name,form1.url)"/>
  <br>
  <input name="file" type="file">
  <input type="button" name="我叫小刘" value="生成下载地址" onclick="downadd2(form1.file,form1.name,form1.url)"/>
  <br/>


</td></tr></table>
  <input type=submit />

<input type="button" name="Pictureview" id="Pictureview" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture', '_blank');">
<input type="button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>" onclick="window.open('EditDownload.jsp?node=<%=teasession._nNode%>','_self');">
</form>
<!--input type="button" value="<%=r.getString(teasession._nLanguage, "Finish")%>" onclick="window.open('/servlet/Node?node=<%=teasession._nNode%>','_self');"-->
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
if(enumer!=null)
{
int idcode;
while(enumer.hasMoreElements())
{
idcode=((Integer)enumer.nextElement()).intValue();
String name=download.getName(idcode);
String url=download.getUrl(idcode);
%>
  <tr>
    <td><%=new tea.html.Anchor(url,name).toString()%>
    <td><%=url%>
    <td><%
//if(url.startsWith("http"))
try
{
out.print(new java.net.URL(url).openConnection().getContentLength());
}catch(Exception eurl)
{}
%>
    <td><input type="button" value="编辑" onclick="form1.name.value='<%=name%>';form1.url.value='<%=url%>';form1.id.value='<%=idcode%>';">
      <input type="button" value="删除" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('<%=request.getRequestURI()%>?node=<%=teasession._nNode%>&id=<%=idcode%>&delete=ON','_self');}">
      <%
}
}
%>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>

