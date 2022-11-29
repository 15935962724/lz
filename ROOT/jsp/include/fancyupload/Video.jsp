<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="java.io.*"%><%@page import="net.mietian.convert.*"%><%

Http h=new Http(request);


if("POST".equals(request.getMethod()))
{
  out.print("<script>parent.mt.show('上传成功!<br/>视频转换中...',0);</script>");
  out.flush();
  String video=application.getRealPath(h.get("video"));
  try
  {
    Video v=new Video(video);
    v.width=h.getInt("w");
    v.height=h.getInt("h");
    v.qscale=h.getInt("qscale");
    long lo=System.currentTimeMillis();
    String flv="/res/"+h.community+"/media/"+lo+".flv";
    boolean rs=v.start(application.getRealPath(flv));
    if(!rs)
    {
      System.out.println(v.error);
      out.print("<script>parent.mt.show('视频转换失败!');</script>");
      return;
    }
    String pic="";
    if(h.getBool("pic"))
    {
      pic="/res/"+h.community+"/"+new SimpleDateFormat("yyMM").format(new Date())+"/"+lo+".jpg";
      v.pic(20,application.getRealPath(pic));
    }
    out.print("<script>parent.document.getElementsByTagName('TABLE')[1].style.display=''; parent.$('rflv').value='"+flv+"'; parent.$('rpic').value='"+pic+"'; parent.mt.show('视频转换成功!');</script>");
  }finally
  {
    new File(video).delete();
  }
  return;
}


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js1111" type="text/javascript"></script>
<script src="/tea/mt.js111111111" type="text/javascript"></script>
<script type="text/javascript" src="/jsp/include/fancyupload/mootools.js"></script>
<script type="text/javascript" src="/jsp/include/fancyupload/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="/jsp/include/fancyupload/Swiff.Uploader.js"></script>
</head>
<body>
<h1>视频格式转换</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" method="post" enctype="multipart/form-data" name="form1" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="repository" value="media"/>

<table id="tablecenter">
  <tr>
    <td>上传视频</td>
    <td><input type="file" name="video" alt="视频"/>
    <input id="but_up" type="button" value="浏览视频"/>
<script>
var swf = new Swiff.Uploader({
  url: 'script.jsp',
  verbose: true,
  queued: false,
  multiple: false,
  target: $('but_up'),
  instantStart: true,
  //typeFilter:{'视频文件(*.asx, *.asf, *.mpg, *.wmv, *.3gp, *.mp4, *.mov, *.avi, *.flv, *.rm, *.rmvb)': '*.asx; *.asf; *.mpg; *.wmv; *.3gp; *.mp4; *.mov; *.avi; *.flv; *.rm; *.rmvb'},
  //fileSizeMax: 1024,
  appendCookieData: true,
  onQueue: function linkUpdate()
  {
    //link.innerHTML=swf.percentLoaded + '% 大小：' +Swiff.Uploader.formatUnit(this.size, 'b');
  },
  onFileComplete: function(file)
  {
    alert(file.response.text);
    file.remove();
    this.setEnabled(true);
  }
});
</script>
</td>
      <td>仅支持：asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv，rm，rmvb
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
  <tr>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="pic" id="pic"><label for="pic">截图</label></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<table id="tablecenter" style="display:none">
<tr><td>FLV视频:</td><td><input id="rflv" size="60"/></td></tr>
<tr><td>视频截图:</td><td><input id="rpic" size="60"/></td></tr>
</table>

</body>
</html>
