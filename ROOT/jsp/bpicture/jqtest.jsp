<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>测试上传图片</title>
<script language="javascript">
 function   getFileSize   (fileName)   {
      if   (document.layers)   {
          if   (navigator.javaEnabled())   {
              var   file   =   new   java.io.File(fileName);
              if   (location.protocol.toLowerCase()   !=   'file:')
                  netscape.security.PrivilegeManager.enablePrivilege(
                  'UniversalFileRead'
                  );
              return   file.length();
          }
          else   return   -1;
      }
      else   if   (document.all)   {
          window.oldOnError   =   window.onerror;
          window.onerror   =   function   (err)   {
              if   (err.indexOf('utomation')   !=   -1)   {
                  alert('file   access   not   possible');
                  return   true;
              }
              else
                  return   false;
          };
          var   fso   =   new   ActiveXObject('Scripting.FileSystemObject');
          var   file   =   fso.GetFile(fileName);
          window.onerror   =   window.oldOnError;
          return   file.Size;
      }
  }

</script>
</head>
<body>
<form name="form" action="">

<input type="file" name="fileName" id="fileName" size="40">
<INPUT   TYPE="button"   VALUE="check   file   size" ONCLICK="alert(getFileSize(this.form.fileName.value))">
</form>

</body>
</html>

