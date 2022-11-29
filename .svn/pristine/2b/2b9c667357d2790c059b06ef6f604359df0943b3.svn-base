<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%><%

Http h=new Http(request,response);
if(h.member < 1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int smoke=h.getInt("smoke");
Smoke t=Smoke.find(smoke);
if(t.smoke<1)
{
  t.matter=1;
  t.type=h.getInt("type");
}
int tab=h.getInt("tab",t.type);

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body >
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="smoke" value="<%=smoke%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
</form>

<form name="form2" action="/Smokes.do?repository=smoke" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="if(mt.check(this)){mt.show(null,0);up.complete();}return false;">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="smoke" value="<%=smoke%>"/>
<input type="hidden" name="type" value="<%=tab%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<%
out.print("<div class='switch'>");
for(int i=1;i<Smoke.SMOKE_TYPE.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+Smoke.SMOKE_TYPE[i]+"</a>");
}
out.print("</div>");
%>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>姓名</td>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="姓名"/></td>
  </tr>
  <tr>
    <td>身份证号</td>
    <td><input name="idcard" value="<%=MT.f(t.idcard)%>"/> 请填写您真实发有效的身份证号</td>
  </tr>
  <tr>
    <td>地址</td>
    <td><input name="address" value="<%=MT.f(t.address)%>" size="50"/></td>
  </tr>
  <tr>
    <td>手机号</td>
    <td><input name="mobile" value="<%=MT.f(t.mobile)%>" alt="手机号"/> 请填写您有效手机号，以便能及时联系到您</td>
  </tr>
  <tr>
    <td>内容</td>
    <td><textarea name="content" cols="50" rows="5" alt="内容"><%=MT.f(t.content)%></textarea><span id="info">还能输入</span><b id="count">500</b>字</td>
  </tr>
<%
if(tab==1)
{
%>
<%
}else if(tab==2)
{%>
  <tr>
    <td>上传图片</td>
    <td><input type="hidden" name="attch" value="<%=t.attch%>" /><input readonly class="file0" alt="图片" /><input type="button" id="_attach" class="file1" value="上传..."/> 可以涉及海报、照片、创意图画、动态图画等多种形式，作品格式为JPG、GIF、PNG，数据文件10M以内</td>
  </tr>
<%
}else if(tab==3)
{%>
  <tr>
    <td>上传视频</td>
    <td><input type="hidden" name="attch" value="<%=t.attch%>" /><input readonly class="file0" alt="视频" /><input type="button" id="_attach" class="file1" value="上传..."/> 视频格式为MPEG、AVI、MOV、MP4、FLV等,数据文件大小在300M以内</td>
  </tr>
<%
}%>
  <tr>
    <td>题材</td>
    <td><%=h.radios(Smoke.MATTER_TYPE[tab],"matter",t.matter)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="location=form2.nexturl.value;"/>
</form>

<script>
mt.focus();
var au=$$('_attach');
if(au)
{
  var up=new Upload(au,{buttonAction:-100,fileTypes:"<%=tab==2?"*.jpg;*.gif;*.png":"*.wmv;*.avi;*.dat;*.asf;*.mpeg;*.mpg;*.flv;*.mp4;*.3gp;*.mov;*.divx;*.dv;*.vob;*.mkv;*.qt;*.cpk;"%>"});
  up.uploadSuccess=function(file,d,responseReceived)
  {
    var t=this.but.previousSibling.previousSibling;
    eval('d='+d.substring(d.indexOf('\n')+1));
    t.value=d.attch;
  };
  up.complete=function()
  {
    var file=up.getFile();
    if(file)
    {
      up.start();
      $$('dialog_content').innerHTML="文件：" +file.name+"<br/>总计：" + mt.f(file.size/1024,2)+' KB';
      $$('dialog_footer').innerHTML="<img src='/tea/mt/progress.gif'/>";
      return;
    }
    $$('dialog_content').innerHTML="数据提交中,请稍等...";
    form2.submit();
  };
  <%
  if(t.attch>0)out.print("up.fileQueued("+Attch.find(t.attch)+");");
  %>
}
fc=form2.content;
fc.onpropertychange=fc.oninput=function()
{
  var len=500-this.value.length;
  $$('info').innerHTML=len<0?"已经超过":"还能输入";
  var c=$$('count');
  c.innerHTML=Math.abs(len);
  c.style.color=len<0?"red":"";
};
fc.oninput();
</script>
</body>
</html>
