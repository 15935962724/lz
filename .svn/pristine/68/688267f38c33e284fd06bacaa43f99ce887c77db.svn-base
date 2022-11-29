<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%!
String community;
class DirFilter implements java.io.FilenameFilter
{
  private java.util.regex.Pattern pattern;
  public DirFilter(String regex)
  {
    pattern = java.util.regex.Pattern.compile(regex);
  }
  public boolean accept(java.io.File dir, String name)
  {
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
public String getDir(String path,boolean isDir)throws java.io.IOException
{
  StringBuffer sb=new StringBuffer("/");
  StringBuffer sb2=new StringBuffer("/<a href=\"?url=/\">"+r.getString(teasession._nLanguage, "Root")+"</a>");
  java.util.StringTokenizer tokenizer=new java.util.StringTokenizer(path,"/");
  while(tokenizer.hasMoreTokens())
  {
    String label=tokenizer.nextToken();
    if(!isDir&&!tokenizer.hasMoreTokens())
    {
      sb.append(label);
    }else
    {
      sb.append(label+"/");
    }
    sb2.append("/").append(new tea.html.Anchor("?url="+java.net.URLEncoder.encode(sb.toString(),"UTF-8"),label));
  }
  return(sb2.toString());
}
String contextPath="";
%>
<%
request.setCharacterEncoding("UTF-8");


community=teasession._strCommunity;

if(!Safety.find(teasession._rv.toString(),community,1).isExists()&&!Safety.find(teasession._rv.toString(),community,2).isExists()&&!Safety.find(teasession._rv.toString(),community,3).isExists()&&!License.getInstance().getWebMaster().equals(teasession._rv._strR))
{
  response.sendError(403);
  return;
}

r.add("/tea/resource/NetDisk");
boolean find=request.getParameter("find")!=null;
contextPath=request.getContextPath();
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>


<!--LINK href="/tea/CssJs/21shiji.css" REL="stylesheet" TYPE="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/CssJs/21shiji.js"></SCRIPT>
<LINK href="/tea/CssJs/21shiji1.css" REL="stylesheet" TYPE="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/CssJs/21shiji.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"-->
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditNetDisk")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td ><%
    String url=request.getParameter("url");

    if(url==null)
    url="/";

    out.print(r.getString(teasession._nLanguage, "Path")+":"+getDir(url,true));

%>
    </td>
    <td align="right" ><a href="javascript:location.reload()"><img src="/tea/image/other/refresh.gif" alt="" border="0"></a>
      <a href="/jsp/netdisk/NetDiskHelp.jsp"  target="_blank"><img src="/tea/image/other/help.gif" alt="" border="0"></a></td>
  </tr>
</table>

           <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr ID=tableonetr>
                <td> 　<%=r.getString(teasession._nLanguage, "FileName")%>&nbsp;&nbsp;</td>
                <%if(find){%>
                <td align=center class="huiditable"><%=r.getString(teasession._nLanguage, "Path")%></td>
                <%}%>
                <td align=center class="huiditable"><%=r.getString(teasession._nLanguage, "Size")%></td>
                <td align=center class="huiditable"><%=r.getString(teasession._nLanguage, "Time")%> </td>
                <td align="center" class="huiditable"><%=r.getString(teasession._nLanguage, "Operation")%></td>
              </tr>
              <%
java.io.File files[];
if(find)
{
  vector.clear();
  String name=request.getParameter("name");
  if(name.length()==0||name.equals("*"))
  name=".*";
else
{
  //name=new String(name.getBytes("ISO-8859-1"), tea.ui.TeaServlet.CHARSET[teasession._nLanguage]);
}
find(new java.io.File(getServletContext().getRealPath("/res/"+node.getCommunity()+"/netdisk"+url)),name);
files=new java.io.File[vector.size()];
for(int index=0;index<vector.size();index++)
files[index]=(java.io.File)vector.get(index);
}else
files=new java.io.File(getServletContext().getRealPath("/res/"+node.getCommunity()+"/netdisk"+url)).listFiles();

java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
for(int index=0;files!=null&&index<files.length;index++)
{
  String strpath=files[index].getAbsolutePath().substring(application.getRealPath("/res/"+node.getCommunity()+"/netdisk"+url).length()).replaceAll("\\\\","/");
  String name=files[index].getName();
%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td>
    <%
    String ico=null;
    boolean dir=false;
    if(files[index].isDirectory())
    {
      dir=true;
      String str;
      if(find)
      str=(strpath+"/");
      else
      str=(url+name+"/");
      out.print("<a href=/jsp/netdisk/EditNetDisk.jsp?community="+community+"&url="+java.net.URLEncoder.encode(str,"UTF-8")+" ><img src=/tea/image/other/directory.gif  align=ABSMIDDLE border=0>"+name+"</a>");
    }else
    {
      int location =name.lastIndexOf(".");
      if(location !=-1)
      {
        ico=name.substring(location +1).toLowerCase();
      } else
      ico="defaut";
      if(tea.entity.util.Safety.find(teasession._rv.toString(),community,1).isExists())
      {
        out.print("<a href=\"/res/"+community+"/netdisk"+url+name+"\">");
      }
      out.print("<img src=/tea/image/other/"+ico+".gif onerror=\"if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';\"  align=ABSMIDDLE border=0>"+name+"</a>");
    }
    %>
    </td>
    <%
    if(find)
    {
      out.print("<td>"+getDir(strpath,dir)+"</td>");
    }
    %>
    <td align="right" ><%if(!dir)out.print(((int)((files[index].length()/1024f)*100)/100f)+"KB");%>　</td>
    <td align="center" ><%=sdf.format(new java.util.Date(files[index].lastModified()))%>　</td>
    <td align="center"  width="120px">
                    <%--&nbsp;<a href="index.php?id=&action=copier&sens=0&ordre=&rep=&fic=odbcconf.log"><img src="/tea/image/other/copier.gif" alt="复制" width="20" height="20" border="0"></a>
      <a href="index.php?id=&action=deplacer&ordre=&sens=0&rep=&fic=odbcconf.log"><img src="/tea/image/other/deplacer.gif" alt="移动" width="20" height="20" border="0"></a>
   --%>
                    <%tea.entity.util.Safety safety2=tea.entity.util.Safety.find(teasession._rv.toString(),community,3);
   if(safety2.isExists()){%>
   <form action="/servlet/EditNetDisk" method="POST" name="formrename<%=index%>" STYLE="width:30px;float:left;padding:0px; margin:0px">
   <input type="hidden" name="url" value="<%=url%>"/>
   <input type="hidden" name="community" value="<%=community%>"/>
   <input type="hidden" name="name" value="<%=name%>"/>
   <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?community="+community%>"/>
   <input type="hidden" name="newname" value=""/>
   <input type="image" src="/tea/image/other/renommer.gif" onClick="var newname=window.prompt('<%=r.getString(teasession._nLanguage, "InputNewName")%>:','<%=name%>');if(newname!=null){formrename<%=index%>.newname.value=newname; }else{ return false;}">
   </form>
   <form action="/servlet/EditNetDisk" method="POST" name="formdelete<%=index%>"  STYLE="width:30px;float:left;padding:0px; margin:0px">
   <input type="hidden" name="url" value="<%=url%>"/>
   <input type="hidden" name="community" value="<%=community%>"/>
   <input type="hidden" name="name" value="<%=name%>"/>
   <input type="hidden" name="delete" value="ON"/>
   <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?community="+community%>"/>
   <input type="image" src="/tea/image/other/supprimer.gif" onClick="return(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));" >
   </form>
   <%   }%>
   <%--            <img src="/tea/image/other/pixel.gif" width="20" height="20">--%>
     <%  if(tea.entity.util.Safety.find(teasession._rv.toString(),community,1).isExists()){%>

     <form action="/jsp/netdisk/NetDiskDownload.jsp" method="POST" name="formdown<%=index%>"  STYLE="padding:0px; margin:0px;width:30px;float:left">
     <input type="hidden" name="url" value="<%=url%>"/>
     <input type="hidden" name="community" value="<%=community%>"/>
     <input type="hidden" name="name" value="<%=name%>"/>
     <input type="image" src="/tea/image/other/download.gif">
     </form>
                <%}%></td>
              </tr>
              <%}%>
</table>
	       <p>
               <%
tea.entity.util.Safety safety3=tea.entity.util.Safety.find(teasession._rv.toString(),community,2);
if(safety3.isExists())
{
%>
                      </p>
	       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><img src="/tea/image/other/upload.gif" align="ABSMIDDLE" alt="">      </td>
    <td><%=r.getString(teasession._nLanguage, "UpFile")%>：</td>
    <td><form enctype="multipart/form-data" action="/servlet/EditNetDisk" method="post">
        <input type="hidden" name="community" value="<%=community%>"/>
        <input  class="in"  type="file"  name="userfile" size="30">
          <INPUT TYPE="hidden" name="action" value="upload">
            <INPUT TYPE="hidden" name="id" value="">
              <input type="hidden" name="url" value="<%=url%>">
                <input type="hidden" name="ordre" value="">
                  <input type="checkbox" name="decompression" value="0">自动解压(ZIP或RAR)
                    <input type="submit"  name="upload"  value="<%=r.getString(teasession._nLanguage, "Up")%>"></form>
    </td></tr>
          <tr  ><td >
            <img src="/tea/image/other/directory.gif" align="ABSMIDDLE" alt="">
              </td>
            <td ><%=r.getString(teasession._nLanguage, "MkDir")%>：</td>
            <td ><form method="post" action="/servlet/EditNetDisk">
              &nbsp;&nbsp;
<input type="text" name="foldername" class="in" size="30">
        <input type="hidden" name="rep" value=""><input type="hidden" name="action" value="mkdir"><input type="hidden" name="url" value="<%=url%>"><input type="hidden" name="ordre" value=""><input type="hidden" name="sens" value="0">
        <input type="submit"  name="newfolder"  value="<%=r.getString(teasession._nLanguage, "New")%>">
</form>
</td>
 </tr>
           <tr>
             <td>
               <img src="/tea/image/other/find.gif" align="ABSMIDDLE" alt="">
              </td>
             <td >
               <%=r.getString(teasession._nLanguage, "FindFile")%>：
             </td>
             <td >
              <form method="post">
                &nbsp;&nbsp;
                <input type="text" class="in" name="name" size="30">
                  <input type="hidden" name="url" value="<%=url%>">
                <input type="submit"  name="find"  value="<%=r.getString(teasession._nLanguage, "Find")%>">
               </form>
             </td>
           </tr>
</table>
<%}%>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
