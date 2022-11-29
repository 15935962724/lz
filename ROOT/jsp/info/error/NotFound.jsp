<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="tea.ui.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");


String community = (String) session.getAttribute("tea.Community");
String sn=request.getServerName();
String uri=(String)request.getAttribute("javax.servlet.error.request_uri");
String referer=request.getHeader("referer");

if(uri.startsWith("/res/")&&(sn.equals("127.0.0.1")||sn.indexOf(".")==-1)&&!uri.endsWith("/cssjs/editortoolbar.js"))
{
  if(community==null)
  {
    community=uri.substring(5,uri.indexOf('/',5));
  }
  int port=80;
  Enumeration e=DNS.findByCommunity(community,0);
  if(e.hasMoreElements())
  {
    String dn=(String)e.nextElement();
    if(!sn.equals(dn))
    {

      if(dn.equals("www.mzb.com.cn"))
      {
        port=8080;
      }
      System.out.println("404: http://"+dn+":"+port+uri);
      try
      {
        InputStream is=new java.net.URL("http://"+dn+":"+port+uri).openStream();
        File f=new File(application.getRealPath(java.net.URLDecoder.decode(uri,"UTF-8")));
        f.getParentFile().mkdirs();
        FileOutputStream os=new FileOutputStream(f);
        int i;
        byte by[]=new byte[1024*8];
        while((i=is.read(by))!=-1)
        {
          os.write(by,0,i);
        }
        os.close();
        is.close();
      }catch(IOException ex)
      {}
      response.sendRedirect("http://"+dn+":"+port+uri);
      return;
    }
  }
}

int i=uri.lastIndexOf('.')+1;
String ext=i==0?"/":uri.substring(i,i+2);
if(referer!=null&&!ext.equals("/")&&!ext.equals("js")&&!ext.equals("ht"))
{
  return;
}

StringBuffer sb=request.getRequestURL();
String  index=sb.substring(0,sb.length()-request.getRequestURI().length()).toString();
%><html>
<head>
  <link href="/tea/community.css" rel="stylesheet" type="text/css">
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
    <script type="text/javascript">
  	 function hback(){
  		 if(window.history.length==1){
  			 window.location.href='<%=index%>';
  		 }else{
  			window.history.back();
  		 }
  	 }
  </script>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>提示信息</title>
</HEAD>
<body>

<table border="0" cellpadding="0" cellspacing="0" style="width:550px;height:118px;background-image:url(/jsp/info/error/bg.jpg);background-repeat: no-repeat;background-position: left top;">
<TR><TD align="center" valign="middle">
<h1>提示信息</h1><p> <u>该页不存在，单击<A href="javascript:hback();" >这里</A>返回。</u></p></TD>
    </TR>
  </table></body>
</html>
