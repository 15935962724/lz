<%@page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="java.net.*"%><%@page import="java.util.regex.*" %><%
final String CHARSET="GBK";

request.setCharacterEncoding(CHARSET);

String url = request.getParameter("url");
//String qs = request.getQueryString();
//if(qs!=null)
//{
//  String gbk = new String(qs.getBytes("ISO-8859-1"), CHARSET);
//  if (!qs.equals(gbk))
//  {
//    qs = gbk;
//  }
//  url+="?"+qs;
//}

String sn = request.getServerName();
String ip = request.getRemoteAddr();

//response.setHeader("Content-Encoding", "gzip");

URL u=new URL(url);
String host=u.getHost();
HttpURLConnection conn = (HttpURLConnection)u.openConnection();
HttpURLConnection.setFollowRedirects(false);
//添加响应头/////////////
Enumeration e=request.getHeaderNames();
if(!e.hasMoreElements())
{
  return;
}

while(e.hasMoreElements())
{
  String name=(String)e.nextElement();
  String value=request.getHeader(name);
  if(name.equals("host"))
  {
    value=host;
  }else if(name.equals("referer"))
  {
    value=value.replaceFirst(sn,host);
  }else if(name.equals("cookie")||name.equals("accept-encoding"))//
  {
    continue;
  }
  conn.setRequestProperty(name,value);
}


String c=(String)session.getAttribute("Cookie");//
if(c!=null)
{
  conn.setRequestProperty("Cookie",c);
}

//System.out.println("Cookie:"+c);

//conn.setRequestProperty("RemoteAddr",ip);

if("POST".equals(request.getMethod()))
{
  conn.setRequestMethod("POST");
  conn.setDoOutput(true);

  String ct=request.getContentType();//multipart/form-data; boundary=---------------------------7d82ce2f1570538
  if(ct.startsWith("multipart/form-data"))
  {
    ///System.out.println(ct);
    InputStream is=request.getInputStream();
    OutputStream os=conn.getOutputStream();
    int v=0;
    StringBuffer sb=new StringBuffer();
    while((v=is.read())!=-1)
    {
      os.write(v);
      sb.append((char)v);
    }
    os.close();
    String str=new String(sb.toString().getBytes("ISO-8859-1"),CHARSET);
    System.out.println(str);
  }else
  {
    PrintWriter pw = new PrintWriter(conn.getOutputStream());
    boolean b=false;
    e=request.getParameterNames();
    StringBuffer par=new StringBuffer();
    while(e.hasMoreElements())
    {
      String name=(String)e.nextElement();
      String value[]=request.getParameterValues(name);
      for(int i=0;i<value.length;i++)
      {
        if(b)
        par.append("&");
        else
        b=true;
        par.append(name).append("=").append(URLEncoder.encode(value[i],CHARSET));
      }
    }
    pw.write(par.toString());

    //
    //if(url.equals("http://127.0.0.1/login.asp?action=chk"))
    {
      //System.out.println(par.toString());
    }
    pw.close();
  }
}

//System.out.println(u.toString());
int code=conn.getResponseCode();
if(code==301||code==302)
{
  String newurl=conn.getHeaderField("location");
  newurl=request.getRequestURI()+"?url="+encode(newurl);
  response.sendRedirect(newurl);
  return;
}
response.setStatus(code);

boolean texttype=false;
String ct=conn.getContentType();
if(ct!=null&&!ct.startsWith("image"))
{
	texttype=true;
	//System.out.println(u.toString()+"\t"+ct);
}else
{

}
response.setContentType(ct);

//返回响应头/////////////
Iterator it=conn.getHeaderFields().keySet().iterator();
while(it.hasNext())
{
  String name=(String)it.next();
  if(name!=null)//&&!name.equals("ETag")&&!name.equals("Last-Modified"))//&&!name.equals("Set-Cookie")&&!name.equals("Connection"))//&&(name.equals("X-Powered-By")||name.equals("Content-Length")||name.equals("X-AspNet-Version")||name.equals("Set-Cookie")||name.equals("Date")||name.equals("Server")||name.equals("Content-Type")||name.equals("Cache-Control") ))
  {
    String value=conn.getHeaderField(name);
    if(name.equals("Set-Cookie"))
    {
      System.out.println("c:"+value+"\tURL:"+url);
      //  if(c!=null)
      //  {
      //    String s[]=sc.split("; ");
      //    for(int i=0;i<s.length;i++)
      //    {
      //      int j=s[i].indexOf("=");
      //      String name=s[i].substring(0,j);
      //      j=c.indexOf(name+"=");
      //      if(j!=-1)
      //      {
      //        int j_2=c.indexOf("; ",j)+2;
      //        if(j_2==1)j_2=c.length();
      //        c=c.substring(0,j)+c.substring(j_2);
      //      }
      //      c=c+"; "+s[i];
      //    }
      //  }else
      {
        c=value;
      }
      session.setAttribute("Cookie",c);//
      if(session.isNew())
      {
        application.setAttribute(ip,c);
      }
    }else
    {
      response.setHeader(name,value);
    }
  }
  //if(url.equals("/"))
  //System.out.println("返回:"+name+":"+conn.getHeaderField(name));
}

//String cd=conn.getHeaderField("Content-Disposition");
//if(cd!=null)
//  response.setHeader("Content-Disposition",cd);

InputStream is;
try
{
  is=conn.getInputStream();
}catch(IOException ex)
{
  is=conn.getErrorStream();
}

out.clear();
OutputStream os =response.getOutputStream();
int len=conn.getContentLength();
if(len==-1||len>102400)
{
  len=8192;
}

byte by[]=new byte[len];
while((len=is.read(by))>0)
{
  if(texttype)
  {
    String str=new String(by,0,len,CHARSET);
    for(int i=0;i<PS.length;i++)
    {
      StringBuilder sb=new StringBuilder();
      int end=0;
      Matcher m =PS[i].matcher(str);
      while(m.find())
      {
        int gc=m.groupCount();
        if(m.group(gc)!=null)
        {
          sb.append(str.substring(end,m.start(gc))).append("?url=").append(abs(url,m.group(gc)));
          end=m.end(gc);
        }
      }
      sb.append(str.substring(end));
      str=sb.toString();
    }
    os.write(str.getBytes(CHARSET));
  }else
  {
    os.write(by,0,len);
    os.flush();
  }
}

is.close();
os.close();

if(true)
return;
%>

<%!
static Pattern PS[]=new Pattern[2];
static
{
  PS[0]=Pattern.compile("((href)|(src))=([\"']?)([^>]+)\\4",Pattern.CASE_INSENSITIVE);
  PS[1]=Pattern.compile(":url\\(([^)]+)\\)",Pattern.CASE_INSENSITIVE);
}
public String abs(String url,String u)
{
  if(u.indexOf("://")==-1)
  {
    if(u.charAt(0)=='/')
    {
      url=url.substring(0,url.indexOf('/',10));
    }else if(url.charAt(url.length()-1)!='/')
    {
      url=url.substring(0,url.lastIndexOf('/'));
    }
    u=url+u;
  }
  return u;
}
public String encode(String url)
{
  return URLEncoder.encode(url);
}
%>
