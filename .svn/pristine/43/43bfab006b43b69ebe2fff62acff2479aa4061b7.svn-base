<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");


String community = (String) session.getAttribute("tea.Community");
String sn=request.getServerName();
String uri=(String)request.getAttribute("javax.servlet.error.request_uri");
String referer=request.getHeader("referer");
request.setCharacterEncoding("UTF-8");

if(uri.startsWith("/res/")&&(sn.startsWith("127.")||sn.indexOf(".")==-1)&&!uri.endsWith("/cssjs/editortoolbar.js"))
{
  if(community==null)community=uri.substring(5,uri.indexOf('/',5));
  String dn=Community.find(community).getWebName();
  if(dn!=null&&dn.length()>0&&!sn.equals(dn))
  {
    System.out.println("404 http://"+dn+uri);
    try
    {
      byte[] by=(byte[])Http.open("http://"+dn+uri,"community="+community);
      Filex.write(application.getRealPath(java.net.URLDecoder.decode(uri,"UTF-8")),by);
    }catch(ClassCastException ex)
    {}catch(Throwable ex)
    {
      ex.printStackTrace();
    }
    return;
  }
}

int i=uri.lastIndexOf('.')+1;
String ext=i==0?"/":uri.substring(i,i+2);
if(referer!=null&&!ext.equals("/")&&!ext.equals("js")&&!ext.equals("ht"))
{
  return;
}

%><html>
<head>
 <!--  <link href="/tea/community.css" rel="stylesheet" type="text/css">
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css"> -->
  <SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
 <script src="/tea/mt.js" type="text/javascript"></script>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>提示信息</title>
</HEAD>
<!-- <body>

<table border="0" cellpadding="0" cellspacing="0" style="width:550px;height:118px;background-image:url(/jsp/info/error/bg.jpg);background-repeat: no-repeat;background-position: left top;">
<TR><TD align="center" valign="middle">
<h1>提示信息</h1><p> <u>该页不存在，单击<A href="javascript:window.history.back();" >这里</A>返回。</u></p></TD>
    </TR>
  </table></body> -->

  <style>
body{margin:0 auto;/*width:714px;position:relative*/background:url(/res/Home/structure/14111170.jpg) no-repeat center center;}
.yl404 span a{font-size:12px;color:blue;position:absolute;top:55%;left:55%;}
</style>
<body><div class="yl404" style='min-height:356px;'>
<!-- <p>很抱歉，您查看的页面找不到了！</p>-->
<span><a href="/">返回首页</a></span>
</div><body>
<script>
mt.fit();
</script>
</html>
