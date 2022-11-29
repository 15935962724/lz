<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="java.io.*"%><%@page import="tea.entity.doctor.*"%><%

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String name=h.get("name"),file=h.get("file"),repository=h.get("repository","structure");

%><!DOCTYPE html>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>图片上传</h1>



<form name="form1" action="/Structures.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&f_act(this.file.value)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="repository" value="<%=repository%>"/>
<input type="hidden" name="act" value="upload"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td nowrap="nowrap" align="right">文件名：</td>
    <td><input name="attchname" value="<%=MT.f(name)%>" /></td>
  </tr>
  <tr>
    <td nowrap="nowrap" align="right">新文件：</td>
    <td><input type="file" name="file" alt="新文件"/></td>
  </tr>
  <tr>
    <td colspan="2" id="info">指定上传后的文件名，如果存在则替换。</td>
  </tr>
<%
if(file!=null)out.print("<tr><td>结果：<td colspan='2'><input value=\""+file+"\" size='50' >");
%>
</table>
<input type="submit" value="提交" />
<input type="button" value="关闭" onclick="window.close();" />
</form>

<script>
function f_act(v)
{
  var n=form1.attchname.value;
  if(n!=''&&n.indexOf('.')==-1)form1.attchname.value+=v.substring(v.lastIndexOf('.'));
  mt.show(null,0);
}
if(window.FormData)
{
  $$('info').innerHTML+=" <font color='red'>支持拖拽、Ctrl+V上传哦！</font>";
};

document.write("<div id='ce' style='width:1px;height:1px;overflow123:hidden;position:fixed;left:-100px;' contenteditable='true'></div>");
var ce=$$('ce');
ce.focus();
var HTML=document.documentElement;
HTML.addEventListener('click',function(e)
{
  if(e.target.type!='text')ce.focus();
},false);
HTML.addEventListener('paste',function(e)
{
  var d=e.clipboardData;
  if(d&&d.items)//GG
  {
    if(d.items.length<1)return;
    var fr=new FileReader();
    fr.onload=function(e){send(this.result)};
    fr.readAsDataURL(d.items[0].getAsFile());//name:blob
  }else//IE,FF
  {
    setTimeout(function()
    {
      var t=ce.firstChild;
      if(t.tagName=='IMG')send(t.src);
      ce.innerHTML="";
    },0);
  }
},false);
//拖拽
HTML.addEventListener('dragover',function(e){e.preventDefault();},false);
HTML.addEventListener('drop',function(e)
{
  e.preventDefault();
  var fs=e.dataTransfer.files;
  send(fs[0]);
},false);

function send(file)
{
  f_act(file.name||'剪切板.jpg');
  var fd=new FormData(),arr=form1.elements;
  for(var i=0;i<arr.length;i++)
  {
    if(!arr[i].name)continue;
    if(arr[i].type=='file')
      fd.append(arr[i].name,file);
    else
      fd.append(arr[i].name,arr[i].value);
  }
  var xhr=new XMLHttpRequest();
  xhr.open("POST",form1.action,true);
  xhr.onreadystatechange=function()
  {
    if(xhr.readyState!=4)return;
    d=xhr.responseText;
    d=d.substring(d.indexOf('\n')+9,d.length-9);
    eval(d);
  };
  xhr.upload.onprogress=function(e)
  {
    mt.progress(e.loaded,e.total,'文件：'+(file.name||'剪切板.jpg')+'<br/>总计：'+mt.f(e.total/1024,2)+' KB　已传：'+mt.f(e.loaded/1024,2)+' KB');
  };
  xhr.send(fd);
}

//document.write("<embed id='QQMailFFPluginIns' type='application/x-tencent-qmail-webkit' hidden='true'>");
//var aa=$$('QQMailFFPluginIns');
//aa.OnCaptureFinished=function()
//{
//  alert('OnCaptureFinished');
//};
//aa.OnEvent=function()
//{
//  alert('OnEvent');
//};//ScreenSnap
//aa._mfOnClick();
</script>
</body>
</html>
