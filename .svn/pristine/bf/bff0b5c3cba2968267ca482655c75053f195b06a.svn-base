<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="java.io.*"%><%@page import="net.mietian.convert.*"%><%

Http h=new Http(request);



String path=h.get("path");//转换后的文件
String act=h.get("act");

if("upload".equals(act))//返回上传后的路径
{
  out.print(h.get("file"));
  System.out.println("上传完成。");
  return;
}else if("progress".equals(act))//返回转换进度
{
  Video v=(Video)session.getAttribute(path);
  if(v==null)
    out.print("clearInterval(inter);mt.show('<input size=35 value="+path+">',1,'转换成功');mt.ok=function(){location.reload();}");
  else
    out.print("mt.progress("+v.progress+",100,'总："+v.getDuration()+"　已转："+v.getTime()+"　大小："+v.size+"K');");
  return;
}else
if("POST".equals(request.getMethod()))//执行转换
{
  String video=application.getRealPath(h.get("video"));//源文件
  try
  {
    Video v=new Video(video);
    v.width=h.getInt("w");
    v.height=h.getInt("h");
    v.qscale=h.getInt("qscale");
    session.setAttribute(path,v);
    for(int j = 0;j < 20;j++)
    out.print("// 显示进度条  \n");
    out.print("<script>parent.f_conv();</script>");
    out.flush();

    System.out.println("开始转换F："+video);
    System.out.println("开始转换T："+path);
    boolean rs=v.start(application.getRealPath(path));
    if(!rs)
    {
      System.out.println(v.error);
      Filex.write("err_flv.txt",v.error);
      out.print("<script>parent.clearInterval(parent.inter);parent.mt.show('视频转换失败！');</script>");
      return;
    }
    //    String pic="";
    //    if(h.getBool("pic"))
    //    {
    //      pic="/res/"+h.community+"/"+new SimpleDateFormat("yyMM").format(new Date())+"/"+lo+".jpg";
    //      v.pic(20,application.getRealPath(pic));
    //    }
  }finally
  {
    System.out.println("转换完成！");
    session.removeAttribute(path);
    new File(video).delete();
  }
  return;
}


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_submit()
{
  if(!up.getFile()){mt.show('“视频”不能为空!');return false;}
  if(!mt.check(form1))return false;
  mt.show('<input size=35 value='+form1.path.value+'>',2,'视频路径');
  mt.ok=function(){up.start();$('dialog_header').innerHTML='正在上传中...';$('dialog_footer').innerHTML='<img src=/tea/mt/progress.gif >';return false;}
  return false;
}

var inter;
function f_conv()
{
  $('dialog_header').innerHTML='正在转换中...';
  inter=setInterval(function()//转换进度
  {
    mt.send(form1.action+'&act=progress&path='+form1.path.value,function(js){eval(js);});
  },1000);
}
</script>
</head>
<body>
<h1>视频格式转换</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="<%=request.getRequestURI()%>?community=<%=h.community%>&repository=tmp" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return f_submit()">
<input type="hidden" name="path" value="<%="/res/"+h.community+"/media/"+System.currentTimeMillis()%>.flv"/>
<input type="hidden" name="video"/>

<table id="tablecenter">
  <tr>
    <td nowrap="nowrap">上传视频</td>
    <td nowrap="nowrap" style="width:300"><div class="file" id="file"></div><input id="but_up" type="button" style='font-family:宋体' value="浏览..."/></td>
    <td>支持的视频格式：asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv,rm,rmvb</td>
  </tr>
  <tr>
    <td>画面质量</td>
    <td>
      <select name="qscale">
      <%
      for(int i=0;i<101;i+=5)
      {
        out.print("<option value="+i);
        if(10==i)out.print(" selected");
        out.print(">"+i);
      }
      %>
      </select></td>
    <td>越小质量越好</td>
  </tr>
  <tr>
    <td>画面大小</td>
    <td><input name="w" value="400" size="8" mask="int" alt="宽"/> x <input name="h" value="300" size="8" mask="int" alt="高"/></td>
    <td>转换后的画面大小</td>
  </tr>
  <!--
  <tr>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="pic" id="pic"><label for="pic">截图</label></td>
  </tr>
  -->
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<table id="tablecenter" style="display:none">
<tr><td>FLV视频:</td><td><input id="rflv" size="60"/></td></tr>
<tr><td>视频截图:</td><td><input id="rpic" size="60"/></td></tr>
</table>

<script>
var up=new Upload($('but_up'),
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
  if(total)return;
  mt.progress(c,file.size,'总大小：'+mt.f(file.size/1024,0)+'K　已完成：'+mt.f(c/1024,0)+'K');
};
up.uploadSuccess=function(file,serverData,responseReceived)
{
  form1.video.value=serverData;//上传后路径
  form1.submit();//开始转换
};
</script>

</body>
</html>
