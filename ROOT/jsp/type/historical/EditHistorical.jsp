<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="java.text.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


Node n=Node.find(h.node);
Historical t;

String subject=null,content=null,keywords=null,picture=null,video=null,vname="";
if(n.getType()==1)
{
  t=new Historical(0,h.language);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);
  picture=n.getPicture(h.language);
  video=n.getVoice(h.language);
  if(video!=null)
  {
    vname=video.substring(video.lastIndexOf('/')+1);
    vname="<a href='/Utils.do?act=down&url="+Http.enc(video)+"'><img src=/tea/image/netdisk/"+vname.substring(vname.lastIndexOf(".")+1)+".gif width=16 align=top> "+vname+"</a>";
  }

  t=Historical.find(h.node,h.language);
}



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——历史事件</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Historicals.do?repository=historical/large" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.submit(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td align="right">发生时间：</td>
    <td>
    <%
    out.print("<select name='year' onchange='mt.oday()'><option value='0'>--");
    for(int year=Calendar.getInstance().get(Calendar.YEAR);year>1948;year--)
    {
      out.print("<option value="+year+">"+year);
    }
    out.print("</select>年 ");
    out.print("<select name='month' onchange='mt.oday()'><option value='0'>--");
    for(int month=1;month<13;month++)
    {
      out.print("<option value="+month+">"+month);
    }
    out.print("</select>月 ");
    out.print("<select name='day' onchange='mt.oday()'><option value='0'>--");
    for(int day=1;day<32;day++)
    {
      out.print("<option value="+day+">"+day);
    }
    out.print("</select>日 ");
    out.print("<script>form1.year.value='"+t.year+"';form1.month.value='"+t.month+"';form1.day.value='"+t.day+"';</script>");
    %>
    </td>
  </tr>
  <tr id="tbody" style="display:none">
    <td align="right">相关事件：</td>
    <td id="oday">
  </tr>
  <tr>
    <td align="right">* 标题：</td>
    <td><input name="subject" value="<%=MT.f(subject)%>" size="50" alt="标题"/></td>
  </tr>
  <tr>
    <td align="right">内容：</td>
    <td>
      <textarea name="content" cols="60" rows="9"><%=MT.f(content)%></textarea>
      <br/><span id="tip">还可以输入<b>112</b>字</span>
    </td>
  </tr>
  <tr>
    <td align="right">照片：</td>
    <td>
      <script>mt.file('picture','<%=MT.f(picture)%>','','jpg;gif;png;bmp;');</script>
      <%
      if(picture!=null)
      out.print("<input type='checkbox' name='clear' id='clear' /><label for='clear'>清空</label>");
      %>
    </td>
  </tr>
  <tr>
    <td align="right">视频：</td>
    <td>
      <input type="hidden" name="video" value="<%=MT.f(video)%>"/><div class="file" id="file"><%=vname%></div><input id="_video" type="button" style='font-family:宋体' value="浏览..."/>
      <%
      if(video!=null)
      out.print("<input type='checkbox' name='clearv' id='clearv' /><label for='clearv'>清空</label>");
      %>
      　支持格式：*.asx;*.asf;*.mpg;*.wmv;*.3gp;*.mp4;*.mov;*.avi;*.flv;*.rm;*.rmvb
    </td>
  </tr>
  <tr>
    <td align="right">来源出处：</td>
    <td><textarea name="source" cols="50" rows="2"><%=MT.f(t.source)%></textarea></td>
  </tr>
  <tr>
    <td align="right">来源出处说明：</td>
    <td><textarea name="sourcedesc" cols="50" rows="4"><%=MT.f(t.sourcedesc)%></textarea></td>
  </tr>
</table>

<br/>
<input type="submit" name="but_submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();

mt.oday=function()
{
  var y=form1.year.value,m=form1.month.value,d=form1.day.value;
  $('tbody').style.display=y+m+d=='000'?'none':'';
  if(y+m+d=='000')return;
  //$('oday').innerHTML="<img src='/tea/image/public/load.gif'>";
  mt.send('/Historicals.do?act=oday&node=<%=h.node%>&year='+y+'&month='+m+'&day='+d,function(d){$('oday').innerHTML=d});
};

var t=form1.content;
t.oninput=t.onpropertychange=function()
{
  var j=0,a=this.value;
  for(var i=0;i<a.length;i++)
  {
    j+=a.charCodeAt(i)<256?1:2;
  }
  if(j%2!=0)j++;
  j=112-j/2;
  $('tip').innerHTML=j<0?"已经超过<b style='color:#CC0000'>"+(-j)+"</b>字":"还可以输入<b>"+j+"</b>字";
  this.form.but_submit.disabled=j<0;
};
t.oninput();

//上传
var up=new Upload($('_video'),
{
  fileTypes:'*.asx;*.asf;*.mpg;*.wmv;*.3gp;*.mp4;*.mov;*.avi;*.flv;*.rm;*.rmvb',
  fileTypesDescription:'所有支持的视频文件',
  fileSizeLimit:0,
  buttonAction:-100
});
up.fileQueued=function(file)
{
  $('file').innerHTML='<img src=/tea/image/netdisk/'+file.type.substring(1)+'.gif width=16 align=top> '+file.name;
};
up.uploadProgress=function(file,c,total)
{
  if(!total)return;
  mt.progress(c,file.size,'总大小：'+mt.f(file.size/1024,0)+'K　已完成：'+mt.f(c/1024,0)+'K');
};
up.uploadSuccess=function(file,h,responseReceived)
{
  form1.video.value=h.substring(h.indexOf("\n")+1);//上传后路径
};
up.complete=function()
{
   mt.submit();
};


mt.submit=function()
{
  mt.show(null,0);
  if(up.getFile())
  {
    up.start();
  }else
  {
    form1.submit();
  }
  return false;
};

</script>
</body>
</html>
