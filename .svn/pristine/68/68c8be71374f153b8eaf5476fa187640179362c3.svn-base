<%@page contentType="text/html;charset=utf-8" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String type=teasession.getParameter("type");

if(request.getMethod().equals("POST"))
{
  byte by[]=teasession.getBytesParameter("uploadfile");
  if(by!=null)
  {
    out.print("<script>");
    if("word".equals(type))
    {
      java.io.ByteArrayInputStream bis=new java.io.ByteArrayInputStream(by);
      String content;
      try
      {
        org.apache.poi.hwpf.extractor.WordExtractor extractor = new  org.apache.poi.hwpf.extractor.WordExtractor(bis);
        content = extractor.getText();

        out.print("parent.insetIMG(\""+content.replaceAll("\"","&quot;").replaceAll("\r\n","<br/>").replaceAll("</","&lt;/")+"\");");
      }catch(java.io.IOException e)
      {
        out.print("alert('文件无效,不是Word文件.');");
      }
    }else
    {
      java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyMM");
      String year = sdf.format(new java.util.Date());
      String path = "/res/" + teasession._strCommunity + "/u/" + year + "/";
      java.io.File f = new java.io.File(getServletContext().getRealPath(path));
      if (!f.exists())
      {
        f.mkdirs();
      }
      java.io.File file=java.io.File.createTempFile(year,".gif",f);
      java.io.FileOutputStream fos=new java.io.FileOutputStream(file);
      fos.write(by);
      fos.close();

      out.print("parent.insetIMG('"+path+file.getName()+"');");

    }
    out.print("</script>");
  }
//  return;
}


%>








<html>
  <head>
      <style type="text/css">
      body {
      margin-left: 0px;
      margin-top: 0px;
      margin-right: 0px;
      margin-bottom: 0px;
      }
      </style>
      </head>
      <body >

      <form action="?" method=post name=myform enctype="multipart/form-data">
      <input type=file name=uploadfile >
<%
if(type!=null)
{
  out.print("<input type=hidden name=type value="+type+" >");
}
%>
      </form>

      </body>
</html>

