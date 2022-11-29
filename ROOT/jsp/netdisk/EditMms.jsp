<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="java.io.*" %>
<%@include file="/jsp/Header.jsp"%>
<%!
java.util.Vector vector=new java.util.Vector();
public void find(java.io.File file,final String filter)
{
    java.io.File path[] = file.listFiles(new FilenameFilter()
    {
        public boolean accept(java.io.File dir, String name)
        {
          return new java.io.File(dir,name).isDirectory()||name.indexOf(filter)!=-1;
        }
    });
    for(int i = 0; i < path.length; i++)
    {
      if(!path[i].isDirectory()||path[i].getName().indexOf(filter)!=-1)
      vector.addElement(path[i]);
      if(path[i].isDirectory())
        find(path[i],filter);
    }
}
public String getDir(String path,String url)throws java.io.IOException
{
  //String path=file.getCanonicalPath();
  StringBuffer sb=new StringBuffer("/");
  StringBuffer sb2=new StringBuffer("<a href=\""+url+"\">"+r.getString(teasession._nLanguage, "Root")+"</a>");
  java.util.StringTokenizer tokenizer=new java.util.StringTokenizer(path,"/");
  while(tokenizer.hasMoreTokens())
  {
    String label=tokenizer.nextToken();
    sb.append(Http.enc(label)).append("/");
    sb2.append(" >> ").append(new tea.html.Anchor(url+"?url="+sb.toString(),label));
  }
  return sb2.toString();
}
String contextPath="";
%>
<%
Http h=new Http(request);
r.add("/tea/resource/NetDisk");

contextPath=request.getContextPath();
String prefix="/res/"+teasession._strCommunity+"/media";

String url=h.get("url","/");
int pos=h.getInt("pos");
String name=h.get("name");
boolean find=name!=null;

int id=h.getInt("id");

int F_LEN=application.getRealPath(prefix).length();

StringBuffer par=new StringBuffer();
par.append("?id="+id);
par.append("&url="+Http.enc(url));
if(name!=null&&name.length()>0)
{
  par.append("&name="+Http.enc(name));
}
par.append("&pos=");

%><html>
<head>
<title><%=r.getString(teasession._nLanguage, "1168501132109")%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<!--流媒体文件管理-->
<h1><%=r.getString(teasession._nLanguage, "1168501132109")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<br>

<script>
function f_act(a,b)
{
  var c=b.substring(b.lastIndexOf('/')+1);
  form1.act.value=a;
  form1.file.value=b;
  switch(a)
  {
    case 'mkdir':
    mt.show("文件夹名称:<input id='mt_name' >",2,"创建新目录");
    break;
    case 'rename':
    mt.show("新名称:<input id='mt_name' value='"+c+"' >",2,"更改名称");
    break;
    case 'delete':
    mt.show("确定要删除“"+c+"”吗？",2);
    break;
    case 'search':
    mt.show("名称:<input id='mt_name' value='"+c+"' >",2,"搜索文件");
  }
  mt.ok=function()
  {
    var tmp=$('mt_name');
    if(tmp)
    {
      if(tmp.value==""){alert('名称不能为空');return false;}
      form1.name.value=tmp.value;
    }
    if(a=='search')
    {
      form1.action="?";
      form1.target="_self";
      form1.method="get";
    }
    form1.submit();
  }
}
</script>

<form name="form1" action="/servlet/EditMms" method="POST" target="_ajax">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?community="+teasession._strCommunity%>"/>
<input type="hidden" name="url" value="<%=url%>"/>
<input type="hidden" name="file"/>
<input type="hidden" name="act"/>
<input type="hidden" name="name"/>
</form>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="text-align:center">
<tr>
  <td onmouseover="bgColor='#BCD1E9'" onMouseOut="bgColor=''"><a href="?id=<%=id%>&url=<%=url.substring(0,url.lastIndexOf('/',url.length()-2)+1)%>"><img src="/tea/image/netdisk/up_big.gif"/><br/>向上</a></td>
  <td onmouseover="bgColor='#BCD1E9'" onMouseOut="bgColor=''"><a href="javascript:;" onclick="location.reload()"><img src="/tea/image/netdisk/refresh_big.gif"/><br/>刷新</a></td>
  <td onmouseover="bgColor='#BCD1E9'" onMouseOut="bgColor=''"><a href="javascript:f_act('mkdir','')"><img src="/tea/image/netdisk/new_folder.gif"/><br/>新目录</a></td>
  <td onmouseover="bgColor='#BCD1E9'" onMouseOut="bgColor=''"><a href="/jsp/netdisk/UploadMms.jsp?url=<%=h.enc(url)%>"><img src="/tea/image/netdisk/upload_big.gif"/><br/>上传</a></td>
  <td onmouseover="bgColor='#BCD1E9'" onMouseOut="bgColor=''"><a href="javascript:f_act('search','')"><img src="/tea/image/netdisk/search.gif"/><br/>搜索</a></td>
</tr>
</table>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Path")+":"+getDir(url,request.getRequestURI())%></td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td> 　<%=r.getString(teasession._nLanguage, "MmsFileName")%>&nbsp;&nbsp;</td>
    <%if(find){%>
    <td align=center class="huiditable"><%=r.getString(teasession._nLanguage, "Path")%></td>
    <%}%>
    <td align=center class="huiditable">MMS</td>
    <td align=center class="huiditable"><%=r.getString(teasession._nLanguage, "Size")%></td>
    <td align=center class="huiditable"><%=r.getString(teasession._nLanguage, "Time")%> </td>
    <td align="center" class="huiditable"><%//=r.getString(teasession._nLanguage, "Operation")%></td>
  </tr>
  <%
java.io.File files[];
if(find)
{
  vector.clear();
  find(new java.io.File(application.getRealPath(prefix+url)),name);
  files=new java.io.File[vector.size()];
  for(int index=0;index<vector.size();index++)
  files[index]=(java.io.File)vector.get(index);
}else
files=new java.io.File(application.getRealPath(prefix+url)).listFiles();

if(files==null||files.length<1)
out.print("<tr><td colspan=5 align=center>该文件夹为空。");
else
{

//把文件夹排在前面
for(int i=0,j=0;i<files.length;i++)
{
  if(files[i].isFile())continue;
  File f=files[j];
  files[j]=files[i];
  files[i]=f;
  j++;
}
for(int index=pos;index<files.length&&index<pos+15;index++)
{
  String strpath=files[index].getParent().substring(F_LEN).replaceAll("\\\\","/");
  String fname=files[index].getName();
  url=strpath+"/";

  out.print("<tr onmouseover=bgColor='#BCD1E9' onMouseOut=bgColor='' ><td>");

  String ico=null;
  boolean dir=false;
  if(files[index].isDirectory())
  {
    dir=true;
    String str;
    if(find)
    str=(strpath+"/");
    else
    str=(url+fname+"/");
    out.print("<a href=\""+request.getRequestURI()+"?url="+java.net.URLEncoder.encode(str,"UTF-8")+"\" ><img src=/tea/image/netdisk/.gif  align=ABSMIDDLE border=0>"+fname+"</a>");
  }else
  {
    int location =fname.lastIndexOf(".");
    if(location !=-1)
    {
      ico=fname.substring(location +1).toLowerCase();
    } else
    ico="default";
    out.print("<img src=/tea/image/netdisk/"+ico+".gif onerror=\"if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/netdisk/default.gif';\" align=ABSMIDDLE border=0>"+fname+"</a>");
  }
    %>
    </td>
    <%if(find){%>
    <td  class="huiditable"><%=getDir(strpath,request.getRequestURI())%> </td>
    <%}%>
    <td  class="huiditable"><%if(!dir)out.print("mms://"+request.getServerName()+"/"+teasession._strCommunity+url+fname);%></Td>
    <td align="right" class="huiditable"><%if(!dir)out.print(((int)((files[index].length()/1024f)*100)/100f)+"KB");%></td>
    <td align="center" class="huiditable"><%=MT.f(new java.util.Date(files[index].lastModified()),true)%></td>
    <td align="center" class="huiditable">
      <img src="/tea/image/other/renommer.gif" onclick="f_act('rename','<%=url+fname%>')"/>
      <img src="/tea/image/other/supprimer.gif" onClick="f_act('delete','<%=url+fname%>')"/>
      <a href="/jsp/netdisk/NetDiskDownload.jsp?community=<%=teasession._strCommunity%>&prefix=<%=h.enc(prefix)%>&url=<%=h.enc(url)%>&name=<%=h.enc(fname)%>"><img src="/tea/image/other/download.gif"/></a>
    </td>
  </tr>
<%}
out.println("<tr><td colspan=5 align=center>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,files.length,15));
}%>
</table>


<div id="head6"><img height="6" src="about:blank" alt=""></div>
</body>
</html>
