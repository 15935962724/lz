<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%!
class DirFilter implements java.io.FilenameFilter {
  private java.util.regex.Pattern pattern;
  public DirFilter(String regex) {
    pattern = java.util.regex.Pattern.compile(regex);
  }
  public boolean accept(java.io.File dir, String name) {
    // Strip path information, search for regex:
    return pattern.matcher(new java.io.File(name).getName()).matches();
  }
}
java.util.Vector vector=new java.util.Vector();
public void find(java.io.File file,String filter)
{
    java.io.File path[] = file.listFiles(new DirFilter(filter));
    for(int i = 0; i < path.length; i++)
    {
      vector.addElement(path[i]);
      if(path[i].isDirectory())
        find(path[i],filter);
    }
}
public String getDir(String path,String url)throws java.io.IOException
{
  //String path=file.getCanonicalPath();
  StringBuffer sb=new StringBuffer("/");
  StringBuffer sb2=new StringBuffer("/<a href=\"NetDiskShareList.jsp\">共享根目录</a>/");
  java.util.StringTokenizer tokenizer=new java.util.StringTokenizer(path,"/");
  while(tokenizer.hasMoreTokens())
  {
    String label=tokenizer.nextToken();
    sb.append(label+"/");
    sb2.append(new tea.html.Anchor(contextPath+url+"&url="+java.net.URLEncoder.encode(sb.toString(),"UTF-8"),label)+"/");
  }
  return(sb2.toString());
}
String contextPath="";
%>
<%
r.add("/tea/resource/NetDisk");
boolean find=request.getParameter("find")!=null;
contextPath=request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-left: 10px;
	margin-top: 5px;
	margin-right: 5px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Sharelist")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>
<%
String url=request.getParameter("url");
String prefix=request.getParameter("prefix");
tea.entity.member.NetDiskShare nds_obj=tea.entity.member.NetDiskShare.find(teasession._rv._strR,node.getCommunity(),(prefix+url));
if(!nds_obj.isExists())
{
   response.sendError(403);
   return;
}
//prefix=new String(prefix.getBytes("ISO-8859-1"),"UTF-8");
//url=new String(url.getBytes("ISO-8859-1"),"UTF-8");
java.io.File root_file_obj=new java.io.File(application.getRealPath(prefix+url));
if(!root_file_obj.exists())
{
  response.sendRedirect("NetDiskShareList.jsp");
  return;
}
out.print("路径:"+getDir(url,request.getRequestURI()+"?prefix="+prefix));/*
java.util.StringTokenizer tokenizer=new java.util.StringTokenizer(url,"/");
String temp="/";
while(tokenizer.hasMoreTokens())
{
  String label=tokenizer.nextToken();
  temp+=label+"/";
  tea.html.Anchor a=new tea.html.Anchor("/jsp/netdisk/EditNetDisk.jsp?url="+temp,label);
  out.print(a.toString()+"/");
}*/
String nexturl=request.getRequestURI()+"?"+(request.getQueryString());
%>
          </td>
          <td align="right" ><a href="javascript:location.reload()"><img src="/tea/image/other/refresh.gif" alt="刷新" border="0"></a><a href="NetDiskHelp.jsp" target="_blank"><img src="/tea/image/other/help.gif" alt="帮助" border="0"></a></td>
        </tr>
      </table>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td> 　文件名&nbsp;&nbsp;</td>
          <%if(find){%>
          <td align=center class="huiditable">路径</td>
          <%}%>
          <td align=center class="huiditable">大小</td>
          <td align=center class="huiditable">修改时间 </td>
          <td align="center" class="huiditable">操作</td>
        </tr>
        <%
java.io.File files[];
if(find)
{
vector.clear();
String name=request.getParameter("name");
if(name.length()==0||name.equals("*"))
name=".*";
//else
//name=new String(name.getBytes("ISO-8859-1"),"UTF-8");
find(root_file_obj,name);
files=new java.io.File[vector.size()];
for(int index=0;index<vector.size();index++)
files[index]=(java.io.File)vector.get(index);
}else
files=root_file_obj.listFiles();

java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
for(int index=0;files!=null&&index<files.length;index++)
{
  String strpath=files[index].getAbsolutePath().substring(application.getRealPath(prefix).length()).replaceAll("\\\\","/");
  String name=files[index].getName();
%>
              <tr class="TableLine1">
                <td class="huiditable"> 　
                    <%
    String ico=null;
    boolean dir=false;
    if(files[index].isDirectory())
    {
      dir=true;%>
                    <a href="<%=request.getRequestURI()%>?prefix=<%=prefix%>&url=<%=java.net.URLEncoder.encode((find)?(strpath+"/"):(url+name+"/"),"UTF-8")%>"><img src="/tea/image/netdisk/.gif"  align="ABSMIDDLE" border="0"><%=name%></a>


                  <!--form action="<%=request.getRequestURI()%>" onsubmit="" method="POST" name="formdelete<%=index%>"  STYLE="width:100px;float:left;padding:0px; margin:0px">
                    <input type="hidden" name="prefix" value="<%=prefix%>"/>
                    <input type="hidden" name="url" value="<%if(find)out.print(strpath+"/");else out.print(url+name+"/");%>"/>
                    <a href="#" onClick="formdelete<%=index%>.submit();"/><img src="/tea/image/other/directory.gif"  align="ABSMIDDLE" border="0"><%=name%></A>
                    </form-->


                      <%    }else
                    {
      int location =name.lastIndexOf(".");
      if(location !=-1)
      {
        ico=name.substring(location +1);
      } else
      ico="defaut";
if(false)//      tea.entity.util.Safety.find(teasession._rv.toString(),1).isExists())
    {%>
                 <a href="<%=request.getRequestURI()%>?prefix=<%=prefix%>&url=<%=java.net.URLEncoder.encode(url+name,"UTF-8")%>"><%}%><img src="/tea/image/netdisk/<%=ico%>.gif"  onerror="if(this.src.indexOf('/defaut.gif')==-1)this.src='/tea/image/netdisk/defaut.gif';" align="ABSMIDDLE" border="0"><%=name%></a>
                 <%    }
    %>
                </td>
                <%if(find){%>
                <td  class="huiditable">
                <%=getDir(strpath,request.getRequestURI()+"?prefix="+prefix)%>
                </td>
                <%}%>
                <td align="center" class="huiditable"><%if(!dir)out.print(((int)((files[index].length()/1024f)*100)/100f)+"KB");%>　</td>
                <td align="center" class="huiditable"><%=sdf.format(new java.util.Date(files[index].lastModified()))%></td>
                <td align="center" class="huiditable"> 　
                    <%--&nbsp;<a href="index.php?id=&action=copier&sens=0&ordre=&rep=&fic=odbcconf.log"><img src="/tea/image/other/copier.gif" alt="复制" width="20" height="20" border="0"></a>
      <a href="index.php?id=&action=deplacer&ordre=&sens=0&rep=&fic=odbcconf.log"><img src="/tea/image/other/deplacer.gif" alt="移动" width="20" height="20" border="0"></a>
   --%>
                    <%
                    if(nds_obj.getPurview()==2)
  {%>


                    <form action="/servlet/EditNetDisk" method="POST" name="formrename<%=index%>" STYLE="width:30px;float:left;padding:0px; margin:0px">
                    <input type="hidden" name="url" value="<%=url%>"/>
                    <input type="hidden" name="name" value="<%=name%>"/>
                    <input type="hidden" name="prefix" value="<%=prefix%>"/>
                    <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
                    <input type="hidden" name="newname" value=""/>
                    <a href="javascript:var newname=window.prompt('<%=r.getString(teasession._nLanguage, "InputNewName")%>:','<%=name%>');if(newname!=null){formrename<%=index%>.newname.value=newname;formrename<%=index%>.submit();}" ><img src="/tea/image/other/renommer.gif" alt="" width="20" height="20" border="0"></a>
                    </form>

                    <form action="/servlet/EditNetDisk" method="POST" name="formdelete<%=index%>"  STYLE="width:30px;float:left;padding:0px; margin:0px">
                    <input type="hidden" name="url" value="<%=url%>"/>
                    <input type="hidden" name="name" value="<%=name%>"/>
                    <input type="hidden" name="prefix" value="<%=prefix%>"/>
                    <input type="hidden" name="delete" value="ON"/>
                    <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
                    <a href="#" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){formdelete<%=index%>.submit();}"/><img src="/tea/image/other/supprimer.gif" alt="" width="20" height="20" border="0"></A>
                    </form>

                    <!--a href="javascript:var newname=window.prompt('请输入新的名字:','<%=name%>');if(newname!=null)window.open('/servlet/EditNetDisk?url=<%=url%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>&name=<%=name%>&newname='+newname,'_self')" ><img src="/tea/image/other/renommer.gif" alt="重命名" width="20" height="20" border="0"></a>

                    <a href="#" onClick="if(confirm('确认删除')){window.open('/servlet/EditNetDisk?url=<%=url%>&name=<%=name%>&delete=ON&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>', '_self');}"/><img src="/tea/image/other/supprimer.gif" alt="删除" width="20" height="20" border="0"-->


                      <%   }%>
                    <%--            <img src="/tea/image/other/pixel.gif" width="20" height="20">--%>
                    <%
                    //if(!dir)
                    {%>

                    <form action="/jsp/netdisk/NetDiskDownload.jsp" method="POST" name="formdown<%=index%>"  STYLE="width:30px;float:left;padding:0px; margin:0px">
                    <input type="hidden" name="prefix" value="<%=prefix%>"/>
                    <input type="hidden" name="url" value="<%=url%>"/>
                    <input type="hidden" name="name" value="<%=name%>"/>
                    <a href="#" onClick="formdown<%=index%>.submit();"/><img src="/tea/image/other/download.gif" alt="" width="20" height="20" border="0"></A>
                    </form>

                    <%}%>                </td>
              </tr>
              <%}%>
          </table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
if(nds_obj.getPurview()>=1)
{
%>
<tr>
  <td><img src="/tea/image/other/upload.gif" align="ABSMIDDLE">      </td>
    <td>上载文件到当前目录：</td>
    <td><form name="fup" enctype="multipart/form-data" onsubmit="return fupsubmit()" action="/servlet/EditNetDisk" method="post">
      <script type="">
        function fupsubmit()
        {
          if(fup.userfile.value.length<=0)
          {
            alert('文件名无效');
            fup.userfile.focus();
            return false;
          }else
          if(fup.userfile.value.indexOf(".jsp")!=-1)
          {
            alert('不能上传JSP文件(.jsp).');
            fup.userfile.focus();
            return false;
          }
          return true;
        }
        </script>
        <input  class="in"  type="file"  name="userfile" size="30">
          <INPUT TYPE="hidden" name="action" value="upload">
            <INPUT TYPE="hidden" name="id" value="">
              <input type="hidden" name="url" value="<%=url%>">
                <input type="hidden" name="prefix" value="<%=prefix%>">
                  <input type="hidden" name="sens" value="0">
                    <input type=hidden name="nexturl" value="<%=nexturl%>">
                      <input type="submit"  name="upload"  class="in"  value="上载"></form>
    </td></tr>
    <tr  ><td >
      <img src="/tea/image/other/directory.gif" align="ABSMIDDLE">
</td>
<td >在当前目录创建新目录：</td>
<td class="huiditable"><form method="post" action="/servlet/EditNetDisk">
  &nbsp;&nbsp;
  <input type="text" name="foldername" class="in" size="30">
    <input type="hidden" name="rep" value="">
      <input type="hidden" name="action" value="mkdir">
        <input type="hidden" name="url" value="<%=url%>">
          <input type="hidden" name="prefix" value="<%=prefix%>">
            <input type="hidden" name="sens" value="0">
              <input type=hidden name="nexturl" value="<%=nexturl%>">
      <input type="submit"  name="newfolder"   class="in"  value="创建">
</form></td></tr>
<%}%>
<tr ><td >
            <img src="/tea/image/other/find.gif" align="ABSMIDDLE">
              </td>
                          <td >在当前目录查找文件：</td>
                          <td class="huiditable">
                            <form method="post">
                <input type="text" class="in" name="name" size="30">
                  <input type="hidden" name="url" value="<%=url%>">
                    <input type="hidden" name="prefix" value="<%=prefix%>">
                    <input type=hidden name="nexturl" value="<%=nexturl%>">
                <input type="submit"  name="find"   class="in"  value="查找">
              </form></td></tr>

</table>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

