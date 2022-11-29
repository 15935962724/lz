<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.io.*" %>
<%@ page import="tea.db.*"%>
<html>
<head>
<title>
LogoPageTest
</title>
</head>
<%
String cps = request.getParameter("page");
int cp = 1;
if(cps != null){
  cp = Integer.parseInt(cps);
}
Logo logo = new Logo();
ArrayList ar = logo.getAll(cp,10);
System.out.print(ar.size());
int[] r = logo.countTmp(10,10,cp);
%>
<body bgcolor="#ffffff">
<div>
<%
for(int i = 0; i < ar.size();i++){
Logo logo2 = (Logo)ar.get(i);
out.print((i+1) + "&nbsp;&nbsp;&nbsp;&nbsp;" + logo2.getLogotype() + "&nbsp;&nbsp;&nbsp;&nbsp;" + logo2.getLogoname() + "&nbsp;&nbsp;&nbsp;&nbsp;"
+ logo2.getLogoimage() + "&nbsp;&nbsp;&nbsp;&nbsp;" + logo2.getLogouse() + "&nbsp;&nbsp;&nbsp;&nbsp;"
+ logo2.getRegnum() + "&nbsp;&nbsp;&nbsp;&nbsp;<br><br>");
}

%>
</div>
<div style="">
<%logo.pageHTML(10,10,cp,response);%>
<%!
public byte[] getByteArray(Image image)
{
  int raw[] = new int[image.getWidth() * image.getHeight()];
  image.getRGB(raw, 0, image.getWidth(), 0, 0, image.getWidth(), image.getHeight());
  byte rawByte[] = new byte[image.getWidth() * image.getHeight() * 4];
  int n = 0;
  for(int i = 0; i < raw.length; i++)
  {
    // break up into channels
    int ARGB = raw[i];
int a = (ARGB & 0xff000000) >> 24; // alpha channel!
int r = (ARGB & 0xff0000) >> 16; // red channel!
int g = (ARGB & 0x0000ff00) >> 8; // green channel!
int b = ARGB & 0x000000ff; // blue channel !

rawByte[n] = (byte)b;
rawByte[n + 1] = (byte)g;
rawByte[n + 2] = (byte)r;
rawByte[n + 3] = (byte)a;

// you can see these codes
// from "http://forum.java.sun.com/thread.jspa?forumID=76&threadID=629677"
// put the color back together
//argb = ((a << 24) | (r << 16) | (g << 8) | b);

n += 4;
}

raw = null;
return rawByte;
}



%>


<%
File file=new   File( "c://a.jpg");
//long len=file.length();

//byte[] bt = file.
//FileOutputStream fis =   new   FileOutputStream(file);
// Image img = new Image(fis);
//DbAdapter db = new  DbAdapter();
//String sql = "insert into test (value) values("+db.cite(fis)+")";
//
//db.executeUpdate(sql);

//System.out.print(fis);


%>
</div>
</body>
</html>
