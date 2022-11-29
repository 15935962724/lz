<%@page contentType="text/html;charset=utf-8"%><%

request.setCharacterEncoding("utf-8");

String input=request.getParameter("input");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script>
function fm_check(fm)
{
	fm.content.value =wEdit.document.body.innerHTML;
	return false;
}
function f_load()
{
  wEdit.document.body.innerHTML=parent.<%=input%>.value;
}
function save()
{
  parent.<%=input%>.value=wEdit.document.body.innerHTML;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body onload="f_load()">
<form name="fm_newtopic" target="ifm_form" method="post" action="?">
<div class="menu" onmousedown=bar_event(event) onmouseover="bar_event(event)" onmouseup="bar_event(event)" onmouseout="bar_event(event)">
  <img src="/tea/image/bbs_edit/undo.gif" alt="撤销">
  <img src="/tea/image/bbs_edit/redo.gif" alt="重做">
  <img src="/tea/image/bbs_edit/Cut.gif" alt="裁切">
  <img src="/tea/image/bbs_edit/Copy.gif" alt="复制">
  <img src="/tea/image/bbs_edit/Paste.gif" alt="粘贴">
  <img src="/tea/image/bbs_edit/gd.gif">
  <img src="/tea/image/bbs_edit/bold.gif" alt="粗体">
  <img src="/tea/image/bbs_edit/italic.gif" alt="斜体">
  <img src="/tea/image/bbs_edit/underline.gif" alt="下划线">
  <img src="/tea/image/bbs_edit/gd.gif">
  <img src="/tea/image/bbs_edit/justifyLeft.gif" alt="居左">
  <img src="/tea/image/bbs_edit/justifyCenter.gif" alt="居中">
  <img src="/tea/image/bbs_edit/justifyRight.gif" alt="居右">
  <img src="/tea/image/bbs_edit/gd.gif">
  <img src="/tea/image/bbs_edit/img.gif" alt="插入图片">
  <!--<img src="/tea/image/editor/file.gif" alt="插入Word文件内容"> -->
  <!--img src="/tea/image/bbs_edit/wmv.gif" alt="插入影片"-->
  <!--<img src="/tea/image/bbs_edit/v.gif" alt="插入新浪播客视频">-->
  <!--img src="/tea/image/bbs_edit/flash.gif" alt="插入Flash"-->
  <img src="/tea/image/bbs_edit/a.gif" alt="超链接">
  <img src="/tea/image/bbs_edit/face.gif" alt="表情">
  <img src="/tea/image/bbs_edit/table.gif" alt="表格">
  <img src="/tea/image/bbs_edit/gd.gif">
  <img src="/tea/image/bbs_edit/font.gif" alt="字体">
  <img src="/tea/image/bbs_edit/size.gif" alt="字体大小">
  <img src="/tea/image/bbs_edit/color.gif" alt="字体色彩">
  <img src="/tea/image/bbs_edit/InsertHorizontalRule.gif" alt="横线">
  <img src="/tea/image/bbs_edit/gd.gif">
  <img src="/tea/image/bbs_edit/insertunorderedlist.gif" alt="符号编号">
  <img src="/tea/image/bbs_edit/insertorderedlist.gif" alt="数字编号">
  <img src="/tea/image/bbs_edit/Outdent.gif" alt="减少缩进">
  <img src="/tea/image/bbs_edit/Indent.gif" alt="增加缩进">
</div>
<iframe id=wEdit name=wEdit src="wEdit.htm" frameborder=0 style="width:99%; BORDER-RIGHT: #ccc 1px solid;  BORDER-TOP: #ccc 1px solid; BORDER-LEFT: #ccc 1px solid; BORDER-BOTTOM: #ccc 1px solid; HEIGHT:240px" class="forum_input2"></iframe>

</form>
<iframe id="wEditorMenu" name="wEditorMenu" src="edit_menu.jsp" frameborder=0 style="BORDER-RIGHT: #7691ac 1px solid; BORDER-TOP: #7691ac 1px solid; DISPLAY: none; Z-INDEX: 101; LEFT: 300px; BORDER-LEFT: #7691ac 1px solid; WIDTH: 100px; BORDER-BOTTOM: #7691ac 1px solid; POSITION: absolute; TOP: 200px; HEIGHT: 200px"></iframe>

<script language="javascript" type="text/javascript" src="/jsp/include/bbs_edit/ubb.v1189736939.js"></script>
<script language="javascript" type="text/javascript" src="/jsp/include/bbs_edit/msgbox.v1189736933.js"></script>
</body>
</html>
