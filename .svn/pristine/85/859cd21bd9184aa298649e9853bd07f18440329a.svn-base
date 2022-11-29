<%@page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<title>设置字体和样式</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css"> <!-- body { background-color: #dde5fd; border: none; margin: 0px; padding: 0px; }
td{FONT-SIZE: 9pt; FONT-FAMILY: Tahoma;}
-->
</style>
<script id="clientEventHandlersJS" language="javascript">
var editor=opener.FreeTextBox1_editor;
if(window.dialogArguments)
{
  editor=dialogArguments.FreeTextBox1_editor.document;
}
function Button1_onclick()
{
  editor.focus();
  editor.document.execCommand('SelectAll','',null);
  editor.document.execCommand("FontName", false, Text1.value);
  fs(editor.document);
  editor.document.execCommand("FontSize", false, Text3.value);
  window.close();
}
function WinOnload()
{
  var obj=chatwordsFrame.document;
  obj.open();
  obj.write('<html><head><style type=\'text/css\'> body{margin: 0px; padding: 0px 0px 2px 5px; FONT-SIZE: 9pt; FONT-FAMILY: Tahoma;}p { margin-top:0px;margin-bottom:0px;FONT-SIZE: 9pt; FONT-FAMILY: Tahoma;}</style></head><body>EDN商务通</body></html>');
  obj.close();
  if((navigator.appVersion.indexOf('MSIE 5.5')>-1) || (navigator.appVersion.indexOf('MSIE 6')>-1))
  {
    obj.body.contentEditable = true;
  }else
  {
    obj.designMode = 'On';
  }
  Text1.value=Select1.value=fontobj.fontname;
  if(!fontobj.isbold && !fontobj.isitalic)
  {
    Text2.value=Select2.value='常规';
  }
  else if(fontobj.isbold && !fontobj.isitalic)
  {
    Text2.value=Select2.value='粗体';
  }
  else if(!fontobj.isbold && fontobj.isitalic)
  {
    Text2.value=Select2.value='斜体';
  }
  else if(fontobj.isbold && fontobj.isitalic)
  {
    Text2.value=Select2.value='粗斜体';
  }
  Text3.value=Select3.value=fontobj.fontsize;
  Checkbox1.checked=fontobj.isstrikethrough;
  Checkbox2.checked=fontobj.isunderline;
  var obj=chatwordsFrame.document;
  obj.execCommand('SelectAll','',null);
  obj.execCommand('fontname','',fontobj.fontname);
  if(fontobj.isbold!=obj.queryCommandState('bold'))obj.execCommand('bold','',null);
  if(fontobj.isitalic!=obj.queryCommandState('Italic'))obj.execCommand('Italic','',null);
  obj.execCommand('FontSize','',ConvertFontsize(fontobj.fontsize));

  if(fontobj.isstrikethrough!=obj.queryCommandState('strikethrough'))obj.execCommand('strikethrough','',null);
  if(fontobj.isunderline!=obj.queryCommandState('underline'))obj.execCommand('underline','',null);
}

function Submit2_onclick() {
	window.close();
}
function FontNameChange(fontname)
{
	Text1.value=fontname;
	chatwordsFrame.document.execCommand('SelectAll','',null);
	chatwordsFrame.document.execCommand('FontName','',fontname);
}
function FontStyleChange(fontname)
{
  Text2.value=fontname;
  var obj=chatwordsFrame.document;
  obj.execCommand('SelectAll','',null);
  fs(obj);
}
function fs(obj)
{
  switch(Text2.value)
  {
    case '常规':
    if(obj.queryCommandState('bold'))obj.execCommand('bold','',null);
    if(obj.queryCommandState('Italic'))obj.execCommand('Italic','',null);
    break;
    case '粗体':
    if(!obj.queryCommandState('bold'))obj.execCommand('bold','',null);
    if(obj.queryCommandState('Italic'))obj.execCommand('Italic','',null);
    break;
    case '斜体':
    if(obj.queryCommandState('bold'))obj.execCommand('bold','',null);
    if(!obj.queryCommandState('Italic'))obj.execCommand('Italic','',null);
    break;
    case '粗斜体':
    if(!obj.queryCommandState('bold'))obj.execCommand('bold','',null);
    if(!obj.queryCommandState('Italic'))obj.execCommand('Italic','',null);
    break;
  }
}
function FontSizeChange(fontname)
{
	Text3.value=fontname;
	chatwordsFrame.document.execCommand('SelectAll','',null);
	chatwordsFrame.document.execCommand('FontSize','',fontname);
}
function Checkbox1Click()
{
  var obj=chatwordsFrame.document;
  //if(obj.queryCommandState('StrikeThrough'))obj.execCommand('StrikeThrough','',null);
  //if(Checkbox1.checked)
  {
    obj.execCommand('SelectAll','',null);
    obj.execCommand('StrikeThrough','',null);
  }
}
function Checkbox2Click()
{
  var obj=chatwordsFrame.document;
  if(obj.queryCommandState('underline'))chatwordsFrame.document.execCommand('underline','',null);
  if(Checkbox2.checked)
  {
    obj.execCommand('SelectAll','',null);
    obj.execCommand('underline','',null);
  }
}
//-->
</script>
</head>
<body onload="WinOnload()">
<table border="0" align="center" cellpadding="0" cellspacing="0" ID="Table1">
  <tr>
    <td height="25" width="5">&nbsp;</td>
    <td width="130" style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">字体(<font style="TEXT-DECORATION: underline">F</font>)</td>
    <td width="15" style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
    <td width="60" style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">字形(<font style="TEXT-DECORATION: underline">Y</font>)</td>
    <td width="15" style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
    <td width="50" style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">大小(<font style="TEXT-DECORATION: underline">S</font>)</td>
    <td width="15" style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
    <td width="35" style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
  </tr>
  <tr>
    <td height="20">&nbsp;</td>
    <td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><input type="text" style="FONT-SIZE:9pt;WIDTH:130px;FONT-FAMILY:Tahoma" name="Text1" ID="Text1"
      readonly></td>
      <td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
      <td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><input type="text" style="FONT-SIZE:9pt;WIDTH:60px;FONT-FAMILY:Tahoma" name="Text2" ID="Text2"></td>
        <td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
        <td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><input type="text" style="FONT-SIZE:9pt;WIDTH:50px;FONT-FAMILY:Tahoma" name="Text3" ID="Text3"></td>
          <td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
          <td width="35" style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><input type="button" name="Submit2" value="确定" ID="Submit" onclick="return Button1_onclick()"
            style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"></td>
  </tr>
  <tr>
    <td height="25">&nbsp;</td>
    <td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><select name="Select1" size="7" style="FONT-SIZE:9pt;WIDTH:130px;FONT-FAMILY:Tahoma" ID="Select1"
    onchange="FontNameChange(this.value)">
    <option value="宋体">宋体</option>
    <option value="华文彩云">华文彩云</option>
    <option value="华文新魏">华文新魏</option>
    <option value="华文细黑">华文细黑</option>
    <option value="华文行楷">华文行楷</option>
    <option value="幼圆">幼圆</option>
    <option value="方正姚体">方正姚体</option>
    <option value="方正舒体">方正舒体</option>
    <option value="楷体_GB2312">楷体_GB2312</option>
    <option value="隶书">隶书</option>
    <option value="黑体">黑体</option>
    <option value="Arial">Arial</option>
    <option value="MS Mincho">MS Mincho</option>
    <option value="PMingLiU">PMingLiU</option>
    <option value="Tahoma">Tahoma</option>
    <option value="Verdana">Verdana</option>
</select></td>
<td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
<td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><select name="Select2" size="7" style="FONT-SIZE:9pt;WIDTH:60px;FONT-FAMILY:Tahoma" ID="Select2"
onchange="FontStyleChange(this[this.selectedIndex].value)">
<option value="常规">常规</option>
<option value="粗体">粗体</option>
<option value="斜体">斜体</option>
<option value="粗斜体">粗斜体</option>
</select></td>
<td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
<td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><select name="select3" size="7" style="FONT-SIZE:9pt;WIDTH:50px;FONT-FAMILY:Tahoma" ID="Select3"
onchange="FontSizeChange(value)">
<option value="1">8</option>
<option value="2">10</option>
<option value="3">12</option>
<option value="4">14</option>
<option value="5">18</option>
<option value="6">24</option>
<option value="7">36</option>
</select></td>
<td style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">&nbsp;</td>
<td valign="top" style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><input type="button" name="Submit3" value="取消" ID="Submit2" style="MARGIN-TOP:5px;FONT-SIZE:9pt;FONT-FAMILY:Tahoma"
  language="javascript" onclick="return Submit2_onclick()"></td>
  </tr>
  <tr>
    <td height="35" align="center">&nbsp;</td>
    <td height="35" valign="top"><fieldset><legend>效果</legend><p style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px">
      <input type="checkbox" name="checkbox" value="checkbox" ID="Checkbox1" onclick="Checkbox1Click()">删除线</p>
      <p style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px">
        <input type="checkbox" name="checkbox" value="checkbox" ID="Checkbox2" onclick="Checkbox2Click()">下划线</p>
</fieldset>
</td>
<td height="35" align="center">&nbsp;</td>
<td height="35" colspan="5" valign="top"><fieldset style="WIDTH: 168px; HEIGHT: 60px"><legend>示例</legend><iframe id="chatwordsFrame" name="chatwordsFrame" style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; WIDTH: 160px; BORDER-TOP-STYLE: none; PADDING-TOP: 0px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 65px; BORDER-BOTTOM-STYLE: none;"
  src="im.aspx" frameborder="1" hspace="1" height="65" width="160" scrolling="no"></iframe>
</fieldset>
</td>
  </tr>
</table>
</body>
</html>
