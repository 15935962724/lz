<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.convert.*"%>
<%@page import="com.jacob.com.*"%><%

Http h=new Http(request,response);
//TeaSession ts=new TeaSession(request);
//if(ts._rv==null)
//{
//  out.print("<script>top.location='/servlet/StartLogin'</script>");
//  return;
//}
if(h.community==null)h.setCook("community",h.community="Home",-1);

Dispatch skin=Paper.getSkin(h.community);

Conf co=Conf.find(h.community);


%><!DOCTYPE html><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>样式设置</h1>

<form name="form1" action="/Papers.do?repository=paper/skin" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act" value="skin"/>
<input type="hidden" name="nexturl"/>
<h2>图片</h2>
<table id="tablecenter">
<%
String[] TOOLBARIMAGE={"","LOGO","拖曳页面","选择文本","缩放1","缩放2","缩放3","适合宽度","适合页面","前一页","下一页","查询","旋转","打印","新窗口打开","帮助","更多","背景图","返回","向前","全屏","退出全屏"};
for(int i=1;i<TOOLBARIMAGE.length;i++)
{
  if((i-1)%3==0)out.print("<tr>");
  out.print("<td>"+TOOLBARIMAGE[i]+"<td><img src='/res/"+h.community+"/paper/skin/"+i+".png' /> <input type='file' name='f"+i+"' />");
}
%>
</table>

<h2>颜色</h2>
<table id="tablecenter">
  <tr>
    <td>文档</td>
    <td><input name="DocBgrColor" value="<%=co.get("DocBgrColor")%>" usemap="<%=Paper.c(Dispatch.get(skin,"DocBgrColor").getInt())%>"/></td>
    <td>选中文字</td>
    <td><input name="TextHighlightColor" value="<%=co.get("TextHighlightColor")%>" usemap="<%=Paper.c(Dispatch.get(skin,"TextHighlightColor").getInt())%>"/></td>
  </tr>
  <tr>
    <td colspan="4"><h2>默认时</h2></td>
  </tr>
  <tr>
    <td>背景色</td>
    <td><input name="OverButColor" value="<%=co.get("OverButColor")%>" usemap="<%=Paper.c(Dispatch.get(skin,"OverButColor").getInt())%>"/></td>
    <td>边框</td>
    <td><input name="OverRectColor" value="<%=co.get("OverRectColor")%>" usemap="<%=Paper.c(Dispatch.get(skin,"OverRectColor").getInt())%>"/></td>
  </tr>
  <tr>
    <td colspan="4"><h2>按下时</h2></td>
  </tr>
  <tr>
    <td>背景色</td>
    <td><input name="DownButColor" value="<%=co.get("DownButColor")%>" usemap="<%=Paper.c(Dispatch.get(skin,"DownButColor").getInt())%>"/></td>
    <td>边框</td>
    <td><input name="DownRectColor" value="<%=co.get("DownRectColor")%>" usemap="<%=Paper.c(Dispatch.get(skin,"DownRectColor").getInt())%>"/></td>
  </tr>
  <tr>
    <td colspan="4"><h2>链接</h2></td>
  </tr>
  <tr>
    <td>Logo链接</td>
    <td><input name="LogoURL" value="<%=co.get("LogoURL")%>" usemap="<%=Dispatch.get(skin,"LogoURL")%>"/></td>
    <td>帮助链接</td>
    <td><input name="HelpButtonURL" value="<%=co.get("HelpButtonURL")%>" usemap="<%=Dispatch.get(skin,"HelpButtonURL")%>"/></td>
  </tr>
</table>


<br/>
<input class="but2" type="submit" value="提　交"/> <input class="but2" type="button" value="重　置" onclick="mt.reset()"/>
</form>

<script>
form1.nexturl.value=location.pathname+location.search;
mt.reset=function()
{
  var arr=form1.elements;
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i].getAttribute('usemap');
    if(arr[i].type=='text')
    arr[i].value=t;
  }
};
</script>
</body>
</html>
