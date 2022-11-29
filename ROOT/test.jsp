<%@page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form action="/servlet/LvyouSynchronous" target="_self" method="post" enctype=multipart/form-data >
接口名：<input type="text" name="type" value="" size="20"><br>
接口密码：<input type="text" name="xmlpassword" value="123456" size="20"><br>
上传内容：<textarea name="xmlcontent" cols=40 rows=10></textarea><br>
 用户头像：<input type="file" name="headpic"  size="40"><br>
<input type="submit" name="submit" value="提交" size="20">
</form> 
</body>