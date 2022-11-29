<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="tea.entity.*" %><% request.setCharacterEncoding("UTF-8");

base=application.getRealPath("/").length()-1;

Http h=new Http(request,response);

String act=h.get("act");
if("scan".equals(act))
{
  out.write("<script>mt=parent.mt;</script>");
  try
  {
    String[] fs=h.getValues("files");
    for(int i=0;i<fs.length;i++)
    {
      find(out,new File(fs[i]));
    }
    out.write("<script>mt.show('完成！');</script>");
  }catch(Throwable ex)
  {
    out.write("<script>mt.show('"+ex.toString()+"');</script>");
    ex.printStackTrace();
  }
  return;
}
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>可疑文件扫描</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="?" method="post" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="act" value="scan"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr"></tr>
<%
File[] fs=new File(application.getRealPath("/")).listFiles();
for(int i=0;i<fs.length;i++)
{
  if(fs[i].isFile())continue;
  out.print("<tr><td><input type='checkbox' name='files' value='"+fs[i]+"'>"+fs[i].getName());
}
%>
</table>
<input type="submit" value="提交"/>
</form>

<%!
long last=0,dir=0,file=0,err=0;
int base;
void find(Writer out,File f)throws IOException
{
  if(f.isDirectory())
  {
    dir++;
    File[] fs=f.listFiles();
    if(fs==null)
    {
      Filex.logs("Scan.txt",f.getPath()+" IS NULL  exists:"+f.exists()+"  canRead:"+f.canRead()+"  canWrite:"+f.canWrite()+"  isHidden:"+f.isHidden());
      return;
    }
    for(int i=0;i<fs.length;i++)
    {
      find(out,fs[i]);
    }
  }else
  {
    file++;
    if(System.currentTimeMillis()-last>1000)
    {
      last=System.currentTimeMillis();
      out.write("<script>mt.progress("+0+"," +100+",'文件夹："+dir+"　文件："+file+"<br/>扫描："+f.getPath().replace('\\','/')+"<br/>可疑："+err+"个');</script>");
      out.flush();
    }
    if(!f.canRead())return;
    if(scan(f))
    {
      err++;
      String path=f.getPath();
      File f2=new File(path.substring(0,base)+"/可疑文件"+path.substring(base));
      f2.getParentFile().mkdirs();
      f.renameTo(f2);
    }
  }
}
boolean scan(File f)throws IOException
{
  InputStreamReader is=new InputStreamReader(new FileInputStream(f));
  try
  {
    int i=0;
    char[] by=new char[8192];
    while((i=is.read(by))!= -1)
    {
      String str=new String(by,0,i);
      if(str.contains("java.io.")||str.contains("ProcessBuilder")||str.contains("Runtime"))
      {
        err++;
        Filex.logs("java_io.txt",f.getPath());
        return true;
      }
    }
  }finally
  {
    is.close();
  }
  return false;
}
%>
