<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="tea.entity.util.*" %>
<%@ page import="tea.entity.util.*" %>
<%@ page import="java.io.*" %>
<%
File fpic = new File(application.getRealPath("/res/1.jpg"));
File extralarge = new File(application.getRealPath("/res/2.jpg"));
File extralargedir = extralarge.getParentFile();
if(!extralargedir.exists())
{
  extralargedir.mkdirs();
}

BufferedImage bi = ImageIO.read(fpic);
//File f = File.createTempFile("edn",".tmp");
//ImageIO.write(bi,"JPEG",f);
//bi = null;
//bi = ImageIO.read(fpic);
ZoomOut zo = new ZoomOut();
if(!extralarge.isFile())
{
  bi = zo.imageZoomOut(bi,4211,4211);
  ImageIO.write(bi,"JPEG",extralarge);
}
%>
<html>
<head>
</head>
<body bgcolor="#ffffff">
<form action="">




</form>
</body>
</html>
