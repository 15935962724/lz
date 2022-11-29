<%@page import="tea.entity.node.*" %><%@page import="java.io.*" %><%request.setCharacterEncoding("UTF-8");

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
return;
}
  String name = request.getParameter("name");
  String community = request.getParameter("community");
  if(community==null)
  {
    community=Node.find(teasession._nNode).getCommunity();
  }
  String prefix=request.getParameter("prefix");
  if(prefix==null)
  prefix="/res/" + community + "/netdisk/";

  File file = new File(getServletContext().getRealPath(prefix+request.getParameter("url") + name));

  OutputStream out1=response.getOutputStream();
  response.setContentType("application/x-msdownload");

  if(file.isDirectory())
  {
    response.setHeader("Content-disposition", "attachment; filename="+java.net.URLEncoder.encode(file.getName(),"utf-8")+".zip");
    org.apache.tools.zip.ZipOutputStream zos =  new org.apache.tools.zip.ZipOutputStream(out1);
    tea.ui.netdisk.EditNetDisk.compress(zos,file,"");
    zos.close();
    return;
  }
  response.setHeader("Content-disposition", "attachment; filename="+java.net.URLEncoder.encode(file.getName(),"utf-8"));
/*
java.util.Enumeration enumer=request.getHeaderNames();
while(enumer.hasMoreElements())
{
  String na=(String)enumer.nextElement();
  System.out.println(request.getHeader(na));
}*/
  byte by[] = new byte[(int) file.length()];
  FileInputStream is = new FileInputStream(file);
  is.read(by);
  is.close();
  response.setContentLength(by.length);
  out1.write(by);
  out1.close();

if(true)
return;
%>
<%!
public void compress(java.util.zip.ZipOutputStream zos,File file,String context)throws IOException
{
    if(file.isFile())
    {
      byte by[] = new byte[(int) file.length()];
      FileInputStream is = new FileInputStream(file);
      is.read(by);
      is.close();

      java.util.zip.ZipEntry ze=new java.util.zip.ZipEntry(context+file.getName());
      zos.putNextEntry(ze);
      zos.write(by);
      zos.closeEntry();
    }else
    if(file.isDirectory())
    {
      File files[]=file.listFiles();
      if(files!=null)
      for(int index=0;index<files.length;index++)
      {
        compress(zos,files[index],context+"/"+file.getName()+"/");
      }
    }
}
%>

