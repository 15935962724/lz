<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int lmsscore=h.getInt("lmsscore");
LmsScore t=LmsScore.find(lmsscore);

int tab=h.getInt("tab");
String nexturl=h.get("nexturl");


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/lms/lms.js" type="text/javascript"></script>
</head>
<body>
<h1>导入招生数据</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
</form>

<form name="form2" action="/LmsMembers.do?repository=imp/<%=h.member%>" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="path"/>

<%
String[] TAB={"元数据","照片"};
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(tab==i?"current":"")+"'>"+TAB[i]+"</a>");
}
out.print("</div>");

if(tab==0)
{
  StringBuilder sql=new StringBuilder(),par=new StringBuilder();
%>
<input type="hidden" name="act" value="imp"/>
<table id="tablecenter" cellspacing="0">
  <tr>
    <%=Lms.query(h,sql,par,true)%>
  </tr>
  <tr>
    <th><em>*</em>文件:</th>
    <td><input type="file" name="file" onchange="form2.path.value='';" alt="文件" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
        <a href="/Utils.do?act=down&url=/res/lms/template/14071391.xls">下载模板</a></td>
  </tr>
  <tr>
    <th>重复:</th>
    <td><%=h.radios(Lms.IMPORT_TYPE,"type",0)%></td>
  </tr>
</table>
<script>
/*
form2.action+="<%=par.toString()%>";

//换行
var a=$$('_agent');
var tr=$$('_tr');
tr.appendChild(a.previousSibling);
tr.appendChild(a);
//必填
var arr=[form2.lmsorg,form2.agent];
for(var i=0;i<arr.length;i++)
{
  if(!arr[i])continue;
  a=arr[i].parentNode.previousSibling;
  arr[i].setAttribute('alt',a.innerHTML.replace(':',''));
  a.innerHTML="<em>*</em>"+a.innerHTML;
}*/
</script>
<%
}else if(tab==1)
{
%>
<input type="hidden" name="act" value="photo"/>
<table id="tablecenter" cellspacing="0">
  <tr>
    <th><em>*</em>照片:</th>
    <td><input type="button" id="_file" value="浏览..."/> 文件格式为：jpg，大小不超过50k，不符合规格无法上传；照片宽高：144px×192px，详细要求可以查看《操作手册》</td>
  </tr>
  <tr>
    <th>重复:</th>
    <td><%=h.radios(Lms.IMPORT_TYPE,"type",0)%></td>
  </tr>
</table>

<div id="_div" style="display:none">
<h2>待上传</h2>
<table id="tablecenter" cellspacing="0">
  <tr id="tableonetr">
    <td>序号</td>
    <td>文件名</td>
    <td>大小</td>
    <td>操作</td>
  </tr>
  <tbody id="_tb"></tbody>
</table>
</div>
<script>
var up=new Upload($$('_file'),{fileTypes:"*.jpg",fileSizeLimit:"50k"});
up.fileQueued=function(f)
{
  var tr=document.createElement("TR");
  tr.id=f.id;
  for(var i=0;i<4;i++)
  {
    var td=document.createElement("TD");
    if(i==0)
      td.innerHTML=f.index+1;
    else if(i==1)
      td.innerHTML="<img src='/tea/image/ico/"+f.type.substring(1).toLowerCase()+".gif' >"+f.name;
    else if(i==2)
      td.innerHTML=mt.f(f.size/1024,2)+"k";
    else if(i==3)
      td.innerHTML="<a href='###' onclick=up.del(this)>删除</a>";
    tr.appendChild(td);
  }
  $$('_tb').appendChild(tr);
  $$('_div').style.display="";
};
var COUNT=[0,0];
up.uploadSuccess=function(f,d,responseReceived)
{
  d=d.substring(d.indexOf('\n')+1);
  eval("d="+d);
  a=$$(f.id);
  if(d.info)
  {
    a.childNodes[1].innerHTML+=" <font color='red'>"+d.info+"</font>";
    return;
  }
  a.parentNode.removeChild(a);
  COUNT[d.code]++;
};
up.uploadComplete=function(file)
{
  clearInterval(UP_INTER);
  file=this.getFile();
  if(file)
    this.start(file);
  else
  {
    mt.show("操作执行成功！<br/>新增："+COUNT[0]+"张　　替换："+COUNT[1]+"张");
    COUNT=[0,0];
  }
};
up.del=function(a)
{
  if(typeof(a)=='string')
    a=$$(a);
  else
  {
    a=a.parentNode.parentNode;
    this.cancel(a.id);
  }
  a.parentNode.removeChild(a);
};
form2.onsubmit=function()
{
  data=""; c1=0; c2=0;
  var f=up.getFile();
  if(!f)
    mt.show('“照片”不能为空！');
  else if(mt.check(this))
  {
    up.start();
    mt.show(null,0);
  }
  return false;
};
var arr=form2.type;
for(var i=0;i<arr.length;i++)
{
  arr[i].onclick=function()
  {
    up.set('postParams',{'type':this.value});
    //up.set('uploadURL',up.uploadURL=up.uploadURL.replace(/&(type)=[^&]+/g,'')+'&type='+this.value);
  };
}
</script>
<%
}
%>
<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
var arr=form2.type;
for(var i=0;i<arr.length;i++)
{
  arr[i].setAttribute("alt","重复");
}
</script>
</body>
</html>
