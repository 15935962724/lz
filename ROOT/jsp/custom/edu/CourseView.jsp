<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="net.mietian.convert.*"%><%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)return;

Node n=Node.find(h.getInt("course"));
if(CoursePlan.count(" AND member="+h.member+" AND node="+n._nNode+" AND ispay=2 AND deleted=0")<1)
{
  out.print("<script>alert('由于您还未参与过我方的培训，不能浏览相关课件！');history.back();</script>");
  return;
}

String act=h.get("act");
int video=h.getInt("video");
int paper=h.getInt("paper");


out.print("<span class='title'>"+n.getAnchor(h.language)+"</span>");
%>



<%
if(video>0)//视频
{
  String str=n.getVoice(h.language);
  String[] arr=str.split("[|]");
  Attch t=Attch.find(video);

%>
<script>
mt.embed("/tea/image/flv/CuPlayer.swf",600,400,"CuPlayerFile=<%=t.path2%>&CuPlayerImage=<%=t.path3%>&CuPlayerLogo=/res/Home/structure/logo_60.png&CuPlayerShowImage=true&CuPlayerWidth=600&CuPlayerHeight=400&CuPlayerAutoPlay=false&CuPlayerAutoRepeat=false&CuPlayerShowControl=true&CuPlayerAutoHideControl=false&CuPlayerAutoHideTime=6&CuPlayerVolume=80&CuPlayerGetNext=false");
</script>
<div class="out">
<div class="next" onmousedown="ISL_GoDown()" onmouseup="ISL_StopDown()" onmouseout="ISL_StopDown()"></div>
<div id="ISL_Cont">
<div class="width0">
	<ul id="List1" class="videoLi">
	<%
	//out.print("<ul>");
	for(int i = 1;i < arr.length;i++)
	{
	  Attch a = Attch.find(Integer.parseInt(arr[i]));
	  int j = a.name.lastIndexOf('.');
	  out.print("<li class='"+(video==a.attch?"cur":"")+"'><a href='?course="+n._nNode+"&video=" + a.attch + "' id='pic'><img src='" + a.path3 + "' /></a><a href='?course="+n._nNode+"&video=" + a.attch + "' class='playBtn'></a><span id='time'>" + Video.f(a.length) + "</span><a href='?course="+n._nNode+"&video=" + a.attch + "' id='name'>" + a.name.substring(0,j) + "</a></li>");
	}
	%>

	<%
	}else if(paper>0)//文档
	{
	  String str=n.getFile(h.language);
	  String[] arr=str.split("[|]");
	  Attch t=Attch.find(paper);
	%>
	<script>edn.paper("<%=t.path2%>",3162111);</script>
	<ul>
	<%
	for(int i = 1;i < arr.length;i++)
	{
	  Attch a = Attch.find(Integer.parseInt(arr[i]));
	  int j = a.name.lastIndexOf('.');
	  out.print("<li class='"+(paper==a.attch?"cur":"")+"'><!--<a href='?course="+n._nNode+"&paper=" + a.attch + "' id='pic'><img src='" + a.path3 + "' /></a><span id='page'>" + a.length + "</span>--><a href='?course="+n._nNode+"&paper=" + a.attch + "' id='name'><img src='/tea/image/netdisk/" + a.name.substring(j + 1) + ".gif' />&nbsp;" + a.name.substring(0,j) + "</a>　 <span id='size'>" + Course.f(new File(Http.REAL_PATH + a.path).length()) + "</span></li>");
	}
	%>


<%
}
%>

