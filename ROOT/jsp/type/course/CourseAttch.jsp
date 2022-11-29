<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%><%@page import="net.mietian.convert.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int node=h.getInt("node");
Node n=Node.find(node);

String nexturl=h.get("nexturl");
int tab=h.getInt("tab");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>上传课件——课程管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
</form>

<div class="switch">
<a href='javascript:mt.tab(0)' id='a_tab0'>视频</a>
<a href='javascript:mt.tab(1)' id='a_tab1'>文档</a>
</div>
<script>$("a_tab<%=tab%>").className="current";</script>

<%
if(tab==0)
{
%>
<form name="form2" action="/Courses.do" method="post" enctype="multipart/form-data" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="attch"/>
<h2>列表</h2>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>时长</td>
  <td>大小</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
String[] voice=MT.f(n.getVoice(h.language),"|").split("[|]");
for(int i=1;i<voice.length;i++)
{
  Attch a=Attch.find(Integer.parseInt(voice[i]));
  if(a.time==null)continue;
  out.print("<tr><td>"+i);
  out.print("<td>"+a.name);
  out.print("<td>"+Video.f(a.length));
  out.print("<td>"+MT.f(new File(application.getRealPath(a.path2)).length()/1024F)+" KB　"+a.width+"x"+a.height);
  out.print("<td>"+MT.f(a.time,1));
  out.print("<td><a href=javascript:mt.act('del',"+a.attch+")>删除</a>");
}
%>
</table>
</form>


<h2>上传</h2>
<form name="form3" action="/Courses.do" method="post" enctype="multipart/form-data" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="attch0"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="attch"/>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">视频：</td>
    <td><input readonly class="file0" size="30" alt="视频"/><input id="vfile" type="button" value="浏览..." class="file1"/></td>
    <td>支持的视频格式：asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv,rm,rmvb</td>
  </tr>
  <tr>
    <td class="th">画面质量：</td>
    <td><span id="qscale"></span><input type="hidden" name="qscale" value="80" size="5"/></td>
  </tr>
  <tr>
    <td class="th">画面大小：</td>
    <td><input name="width" value="400" size="8" mask="int" alt="宽"/> x <input name="height" value="300" size="8" mask="int" alt="高"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="location=form3.nexturl.value"/>
</form>
<script>
mt.slider(form3.qscale);

form3.action="/Attchs.do?repository=course&node=<%=node%>";
var up=new Upload($$('vfile'),{fileTypes:'*.asx;*.asf;*.mpg;*.wmv;*.3gp;*.mp4;*.mov;*.avi;*.flv;*.rm;*.rmvb',fileSizeLimit:0});
form3.action="/Courses.do";
up.uploadSuccess=function(f,d)
{
  eval('d='+d.substring(d.indexOf('\n')+1));
  form3.attch.value=d.attch;
  form3.submit();
};
form3.onsubmit=function()
{
  if(!mt.check(this))return false;
  mt.show(null,0);
  up.start();
  return false;
};
</script>
<%
}else if(tab==1)
{
%>
<form name="form2" action="/Courses.do" method="post" enctype="multipart/form-data" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="attch"/>
<h2>列表</h2>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>页数</td>
  <td>大小</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
String[] files=MT.f(n.getFile(h.language),"|").split("[|]");
for(int i=1;i<files.length;i++)
{
  Attch a=Attch.find(Integer.parseInt(files[i]));
  if(a.time==null)continue;
  out.print("<tr><td>"+i);
  out.print("<td>"+a.name);
  if(a.length>0)
  {
    out.print("<td>"+a.length);
    out.print("<td>"+MT.f(new File(application.getRealPath(a.path2)).length()/1024F)+" KB");
  }else
    out.print("<td>--<td>--");
  out.print("<td>"+MT.f(a.time,1));
  out.print("<td><a href=javascript:mt.act('del',"+a.attch+")>删除</a>");
}
%>
</table>
</form>


<h2>上传</h2>
<form name="form3" action="/Courses.do" method="post" enctype="multipart/form-data" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="attch1"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="attch"/>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">文档：</td>
    <td><input readonly class="file0" size="30" alt="文档"/><input id="vfile" type="button" value="浏览..." class="file1"/></td>
  </tr>
  <tr>
    <td class="th">支持的格式：</td>
    <td><img src="/tea/image/netdisk/doc.gif"/>doc,docx　<img src="/tea/image/netdisk/ppt.gif"/>ppt,pptx　<img src="/tea/image/netdisk/xls.gif"/>xls,xlsx　<img src="/tea/image/netdisk/rtf.gif"/>rtf　<img src="/tea/image/netdisk/pdf.gif"/>pdf</td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="location=form3.nexturl.value"/>
</form>
<script>
form3.action="/Attchs.do?repository=course&node=<%=node%>";
var up=new Upload($$('vfile'),{fileTypes:'*.doc;*.docx;*.ppt;*.pptx;*.xls;*.xlsx;*.rtf;*.pdf',fileSizeLimit:0});
form3.action="/Courses.do";
up.uploadSuccess=function(f,d)
{
  eval('d='+d.substring(d.indexOf('\n')+1));
  form3.attch.value=d.attch;
  form3.submit();
};
form3.onsubmit=function()
{
  if(!mt.check(this))return false;
  mt.show(null,0);
  up.start();
  return false;
};
</script>
<%
}%>
<script>
mt.tab=function(i)
{
  form1.tab.value=i;
  form1.submit();
};

form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,i)
{
  form2.act.value='attch'+a;
  form2.attch.value=i;
  mt.show('你确定要删除吗？',2,'form2.submit()');
};
</script>
</body>
</html>
