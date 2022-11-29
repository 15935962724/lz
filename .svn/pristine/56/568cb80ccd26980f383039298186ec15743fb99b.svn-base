<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%--
request.setCharacterEncoding("UTF-8");
    response.setContentType("application/x-download");//设置为下载application/x-download

   //String filedownload=request.getParameter("uri");
   String filedownload=request.getParameter("uri");
   System.out.println(filedownload);
    String filedisplay = request.getParameter("name");
    String filenamedisplay = URLEncoder.encode(filedisplay,"UTF-8");


    response.addHeader("Content-Disposition","attachment;filename=" + filenamedisplay);

  try
{

URL u=new URL(filedownload);
URLConnection urlconn=u.openConnection();
 BufferedReader br=new BufferedReader(new InputStreamReader(urlconn.getInputStream()));

OutputStream os = response.getOutputStream();
InputStream fis = urlconn.getInputStream();

byte[] b = new byte[1024];
int i = 0;

while ( (i = fis.read(b)) > 0 )
{
os.write(b, 0, i);
}

fis.close();
os.flush();
os.close();

}
catch ( Exception e )
{ e.printStackTrace();
}

    finally
    {
    out.clear();
out = pageContext.pushBody();
    }
--%>
