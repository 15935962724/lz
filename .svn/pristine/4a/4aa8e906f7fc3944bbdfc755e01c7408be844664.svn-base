<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="java.util.*" %><%@ page import="tea.db.DbAdapter" %><%@page import="java.io.*" %><%@ page import="javax.imageio.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.cluster.*" %><%

request.setCharacterEncoding("UTF-8");


Http h=new Http(request);

String path=h.get("NewFile");

String act=h.get("act");

//批量传图
if("upload".equals(act))
{
  File f=new File(application.getRealPath(path));
  if(h.getBool("watermark"))
  {
    Watermark.mark(h.community,f);
  }
  out.print(path);
  return;
}



//单张传图
if(path!=null)
{
  String type=h.get("type");
  String name=path.substring(path.lastIndexOf("/")+1);

//  String ex=name.substring(name.lastIndexOf('.')+1);
//  if("flash".equals(type)&&!ex.equals("swf"))//wma,wmv,asf,mp3,avi,wav,mpeg,midi,aiff,au
//  {
//    File f=new File(application.getRealPath(path));
//    path="/res/media/";
//    File dir=new File(application.getRealPath(path));
//    dir.mkdirs();
//    File d=new File(dir,name);
//    if(d.exists())
//    {
//      d=File.createTempFile(name.substring(0,name.length()-4),"."+ex,dir);
//      name=d.getName();
//    }
//    f.renameTo(d);
//    path+=name;
//  }

  if(h.getBool("watermark"))//添加水印
  {
    Watermark.mark(h.community,new File(application.getRealPath(path)));
  }
  out.println("<script type=\"text/javascript\">");
  out.println("window.parent.OnUploadCompleted(0,'"+path+"','"+name+"','');");
  out.println("</script>");
  return;
}




//生成缩略图 或 删除
String url=h.get("url");
if(url!=null)
{
  File f=new File(application.getRealPath(url));
  if("scale".equals(act))
  {
    File tmp=File.createTempFile("50_",".tbn");
    Img img=new Img(f);
    img.width=img.height=50;
    img.start(tmp);
    Filex.piped(new FileInputStream(tmp),response.getOutputStream());
    tmp.delete();
    //ImageIO.write(Img.scale(ImageIO.read(f),50,50,false),"JPEG",response.getOutputStream());
  }else if("del".equals(act)&&(f.lastModified()+600000L)>System.currentTimeMillis())//10分钟内
  f.delete();
  return;
}

%>
