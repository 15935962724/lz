<%@page import="tea.entity.Seq"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.Attch"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="com.jspsmart.upload.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
String ext = "jpg";
String name = "";
int imgsize = 0 ;
String savepath = "/res/tobacco/smoke/1407/";
try{
String realPath = this.getServletConfig().getServletContext().getRealPath("/"); 
String filePath = realPath+savepath;
/* (new java.io.File (filePath)).mkdirs(); //文件夹不存在则创建文件夹  */
//实例化上传组件

SmartUpload upload = new SmartUpload();

//初始化上传组件

upload.initialize(config,request,response);
//开始上传

upload.upload();
if(upload.getFiles().getFile(0).getFileName().indexOf(".")!=-1){
	ext = upload.getFiles().getFile(0).getFileExt();         //取得上传文件的扩展名
}
imgsize = upload.getFiles().getFile(0).getSize();
name = System.currentTimeMillis()+upload.getFiles().getFile(0).getSize()+""; //取得自定义的图片名
//3.保存上传的文件
upload.getFiles().getFile(0).saveAs(savepath+name+"."+ext);

}catch(Exception e){
	out.print("");
}
Attch a = new Attch(Seq.get());
a.node = 14050050;
a.name = name+"."+ext;
a.path = savepath+name+"."+ext;
a.type = ext;
a.length = imgsize;
a.community = "tobacco";
a.set();
//System.out.println(a.attch);
//out.print(savepath+name+"."+ext);
out.print(a.attch+"||"+savepath+name+"."+ext);
%>
</body>
</html>