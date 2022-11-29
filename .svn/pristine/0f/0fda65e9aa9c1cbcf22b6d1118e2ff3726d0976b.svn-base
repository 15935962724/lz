<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   
    <title>My JSP 'upload.jsp' starting page</title>
      
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>  
  <body>
<script type="text/javascript">
function sendpath(path){
parent.document.all.imgpath.value=path;
parent.document.all.radio1.checked=true;
parent.document.all.mysubmit.click();
//window.close();
return false;
}
</script>
<br><br>
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />

<%
    String src = "F:/fck/";
    fileBean.setObjectPath(src);
   
    fileBean.setSize(10000*1024);
   
    fileBean.setSuffix(".gif.jpg.png.jpge");
   
    fileBean.setSourceFile(request);
   
    String [] saSourceFile = fileBean.getSourceFile();
   
    String [] saObjectFile = fileBean.getObjectFileName();
   
    String [] saDescription = fileBean.getDescription();
   
    int iCount = fileBean.getCount();
   
    String sObjectPath = fileBean.getObjectPath();
   
    for(int i=0;i<iCount;i++) {
   
     out.println("<br>源始文件:");
   
     out.println(saSourceFile[i]);
   
     out.println("<br>目标文件:");
   %>
<script type="text/javascript">
sendpath("<%= sObjectPath+saObjectFile[i]%>");
</script>
<%
     out.println(sObjectPath+saObjectFile[i]);
   
     out.println("<br>上传说明:");
   
     out.println(saDescription[i]);
   
     out.println("<br>");
   
    }
%>


  </body>
</html>
