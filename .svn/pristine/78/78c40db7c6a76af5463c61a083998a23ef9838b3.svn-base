<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.*" %>
<%

TeaSession teasession =new TeaSession(request);
//byte by[]=teasession.getBytesParameter("file");
String name=teasession.getParameter("filename");

//if(by.length!=-1)
//{
//System.out.println(by.length+":"+name);
//}
System.out.println(":"+name);
%>

<OBJECT ID="Uploader" title="AlamyUpload your images using this ActiveX control" WIDTH="580" HEIGHT="400" CLASSID="CLSID:3E0D93BD-ABC6-4723-A70F-2A57D33C0186" CODEBASE="/tea/applet/alamy_uploader.cab#Version=0,0,0,3">
  <param name="LogLevel" value="none">
    <param name="UploadURL" value="http://127.0.0.1/jsp/bpicture/saler/Saler_price.jsp">
      <param name="SkinURL" value="http://www.alamy.com/upload-skin.xml?v4">
        <param name="PassthruParamValues" value="name=Alamy Uploader,MediaRef=OL275920,UserID={055CC9AE-6B0C-476D-8F34-ECAF88316065},showHTML=false">
              <param name="MaxFileSize" value="26214kb"/>
              <param name="FileFilter" value="jpg,jpeg"/>
              <param name="FileFilterDesc" value="JPEG (*.JPG)"/>
              <param name="MinImageSize" value="47mb">
</OBJECT>
