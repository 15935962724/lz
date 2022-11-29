<%@page contentType="text/html;charset=UTF-8"%>
<%!
static final String POSTFIX ="_en.properties";
class Filter implements java.io.FilenameFilter
{
  public Filter()
  {
  }
  public boolean accept(java.io.File dir,String name)
  {
    return new java.io.File(dir.getAbsolutePath()+dir.separator+name).isDirectory()|| name.endsWith(POSTFIX);
  }
}
public void findFile(java.io.File path,java.io.Writer out,int layer)throws java.io.IOException
{//application.getRealPath("/WEB-INF/classes/tea/")
  java.io.File files[]=path.listFiles(new Filter());
  /*new java.io.FilenameFilter()
  {
    public boolean accept(java.io.File dir, String name);
    {
      return    name.endsWith("_en.properties");
    }
  }
  );*/
  for(int index=0;index<files.length;index++)
  {
    for(int i=0;i<layer;i++)
    {
        out.write("│ &nbsp;");
      }
      out.write("├─");
    if(files[index].isDirectory())
    {
      out.write(files[index].getName()+"<BR/>");
      findFile(files[index],out,++layer);
      --layer;
    }else
    {
      int len=files[index].getName().length()-POSTFIX.length();
      out.write("<A href=/jsp/util/EditResource.jsp?path="+files[index].getAbsolutePath().substring(0,files[index].getAbsolutePath().length()-POSTFIX.length())+">"+files[index].getName().substring(0,len)+"</a><BR/>");
      //out.print(files[index].getCanonicalPath().substring(0,len)+"<br/>");
      //out.print(files[index].getName()+"<br/>");
    }
  }
}
%>
<h3>EDN系统资源文件列表</h3>
<%
findFile(new java.io.File(application.getRealPath("/WEB-INF/classes/tea/")),out,0);
%>

