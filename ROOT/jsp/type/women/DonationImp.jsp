<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.women.*"%><%

Http h=new Http(request,response);

String act=h.get("donation");

%><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>捐赠信息导入</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="/Donations.do?community=<%=h.community%>&repository=donation" enctype="multipart/form-data" method="post" target="_ajax" onsubmit="return mt.check(this)&&mt.show('文件上传中。。。',0)">
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="act" value="imp<%=act%>"/>

<%
if("don".equals(act))
{
%>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>捐赠信息表：<td><input type="file" name="file" alt="捐赠信息表"/></td>
  </tr>
</table>
<%
}else if("par".equals(act))
{
%>

<table id="tablecenter" cellspacing="0">
<tr>
  <td>落实信息表：<td><input type="file" name="file" alt="落实信息表"/></td>
</tr>
<tr>
  <td width="200">落实照片：<td><input type="button" id="browse" value="浏览照片"/>
    <table id="tablecenter" cellspacing="0">
    <tr><th></th><th>文件名</th><th>大小</th><th>操作</th>
    <tbody id="plist">
    </tbody>
    </table></td>
</tr>
</table>

<script>
var plist=$('plist');
var up=new Upload($('browse'),{resize:800});
up.fileQueued=function(f)
{
  var tr=document.createElement("TR"),td=document.createElement("TD");
  td.innerHTML='';
  tr.appendChild(td);
  td=document.createElement("TD");
  td.innerHTML="<img src='/tea/image/netdisk/"+f.type.substring(1).toLowerCase()+".gif' align='top'><input type='hidden' name='name' value='"+f.name.substring(0,f.name.length-4).toLowerCase()+"'/>"+f.name;
  tr.appendChild(td);
  td=document.createElement("TD");
  td.innerHTML=mt.f(f.size/1024,2)+' KB';
  tr.appendChild(td);
  td=document.createElement("TD");
  td.innerHTML="<a href='###' onclick=up.fileCancel(this,'"+f.id+"')><img src='/tea/image/public/delete.gif'></a>";
  tr.appendChild(td);
  plist.appendChild(tr);
}
up.fileDialogComplete=function()
{
  t=plist.childNodes;
  for(var i=0;i<t.length;i++)t[i].firstChild.innerHTML=i+1;
}
up.fileCancel=function(a,id)
{
  this.cancel(id);
  while(a.tagName!='TR')a=a.parentNode;
  plist.removeChild(a);
  up.fileDialogComplete();
}
up.uploadResizeStart=function(f)
{
  var s=this.getStats(),i=s.successful_uploads,j=i+s.files_queued;
  mt.progress(i,j,"总数：" + j + "　目前：" + i++ + "　文件：" + f.name);
}
up.complete=function()
{
  mt.show("数据导入成功！",1,form1.nexturl.value);
}
</script>

<%
}
%>

<input type="submit" value="导入"/> <input type="button" value="返回" onclick="history.back();"/>

</form>



</body>
</html>
