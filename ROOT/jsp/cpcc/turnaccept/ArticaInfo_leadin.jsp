<%@page contentType="text/html;charset=UTF-8" %>




<html>
<head>
<link href="/res/cpcc/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>填写授权作品详细资料</title>
<style>
#notpass{width:100%;font-size:16px;text-align:center;color:#ff0000;font-weight:bold;line-height:40px;}
</style>
</head>
<body id="bodynone">

<div id="jspbefore" style="display:none"></div>

<div id="tablebgnone">
  <form action="" method="post" enctype="multipart/form-data" name="form1" id="form1">
<div style="text-align:center;margin-top:20px;margin-bottom:20px;font-size:18px;font-weight:bold;">导入授权作品详细资料</div>

<h2>上传文件</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenterup">
<tr>
<td>
Excel文件：<input type="file" name="file">　　　　<input type="button" value="预览"><input type="button" value="导入"><input type="button" value="返回"></td>
</tr>
</table>

<div><h2>导入预览</h2>
  <iframe src="about:blank" name="CR_ImportPreview" width=90% height=400px frameborder="1" > </iframe>
</div>
<div stle="margin-top:10px;">注：第一行和第一列不被导入！</div>

  </form>
</div>



</body>
</html>


