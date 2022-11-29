<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %>
<%@include file="/jsp/Header.jsp"%>
<%!
public String getDir(String path,String url)throws java.io.IOException
{
  //String path=file.getCanonicalPath();
  StringBuffer sb=new StringBuffer("/");
  StringBuffer sb2=new StringBuffer("/<a href=\""+url+"\">"+r.getString(teasession._nLanguage, "Root")+"</a>/");
  java.util.StringTokenizer tokenizer=new java.util.StringTokenizer(path,"/");
  while(tokenizer.hasMoreTokens())
  {
    String label=tokenizer.nextToken();
    sb.append(java.net.URLEncoder.encode(label,"UTF-8")).append("/");
    sb2.append(new tea.html.Anchor(url+"?url="+sb.toString(),label)+"/");
  }
  return(sb2.toString());
}
String contextPath="";
%>
<%
Http h=new Http(request);
r.add("/tea/resource/NetDisk");

String prefix="/res/"+teasession._strCommunity+"/media";

String url=h.get("url","/");


int id=h.getInt("id");



%><html>
<head>
<title><%=r.getString(teasession._nLanguage, "1168501132109")%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script type="text/javascript" src="/jsp/include/fancyupload/mootools.js"></script>
<script type="text/javascript" src="/jsp/include/fancyupload/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="/jsp/include/fancyupload/Swiff.Uploader.js"></script>
</head>
<body>
<!--流媒体文件管理-->
<h1><%=r.getString(teasession._nLanguage, "1168501132109")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<br>

<script>
function f_submit()
{
  if(swf.size==0){mt.show('“视频”不能为空!');return false;}
  if(!mt.check(form1))return false;
  swf.start();
  return false;
}
var inter;
function f_progress()
{
  mt.send(form1.action+'?act=progress&community='+encodeURIComponent(form1.community.value)+'&url='+encodeURIComponent(form1.url.value)+'&path='+form1.path.value,function(js){eval(js);});
}
</script>




<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Path")+":"+getDir(url,request.getRequestURI())%></td>
  </tr>
</table>

<form name="form1" action="/servlet/EditMms" method="POST" target="_ajax" onsubmit="return f_submit()">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?community="+teasession._strCommunity%>"/>
<input type="hidden" name="url" value="<%=url%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="prefix" value="<%=prefix%>"/>
<input type="hidden" name="pid" value="<%=System.currentTimeMillis()%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="name"/>
<input type="hidden" name="path" size="60"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>文件:</td>
    <td><input id="but_up" type="button" value="浏览视频"/></td>
  </tr>
  <tr>
    <td>选项:</td>
    <td>
      <!--<input type="checkbox" name="decompression" value="0" id="decompression"><label for="decompression">自动解压(ZIP或RAR)</label>-->
    <input type="checkbox" name="flv" value="0" id="flv" onclick="$('t_flv').style.display=checked?'':'none'"><label for="flv" title="仅支持：asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv，rm，rmvb">转换为FLV文件</label>
    </td>
  </tr>
  <tbody id="t_flv" style="display:none">
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
  </tbody>
</table>
<input type="submit" value="提交"/>
<input type="button" value="返回" onclick="history.back();"/>
</form>


<script>
var progress;
var swf = new Swiff.Uploader({
  url: form1.action+'?act=upload&repository=media'+encodeURIComponent(form1.url.value),
  verbose: true,
  queued: false,
  multiple: false,
  target: $('but_up'),
  instantStart: false,
  typeFilter:{'视频文件(*.asx, *.asf, *.mpg, *.wmv, *.3gp, *.mp4, *.mov, *.avi, *.flv, *.rm, *.rmvb)': '*.asx; *.asf; *.mpg; *.wmv; *.3gp; *.mp4; *.mov; *.avi; *.flv; *.rm; *.rmvb'},
  appendCookieData: true,
  onQueue:function()
  {
    if(swf.percentLoaded==0)return;
    if(!progress)
    {
      mt.show("视频上传中...","<div style='border:1px solid #999999;text-align:left'><div id='progress' style='background-color:#0000FF;'></div></div>");
      progress=$('progress');
    }
    progress.style.width=swf.percentLoaded+"%";
  },
  onFileComplete:function(file)
  {
    var path=file.response.text;
    if(!path)
    {
      mt.show("上传超时...");
      return;
    }
    form1.path.value=path;
    form1.submit();
    if(form1.flv.checked)inter=setInterval(f_progress,1000);
  }
});
</script>

<div id="head6"><img height="6" src="about:blank" alt=""></div>
</body>
</html>
