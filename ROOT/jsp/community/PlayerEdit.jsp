<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%

Http h=new Http(request,response);
if(h.member < 1)
{
  out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
  return;
}


int player=Community.find(h.community).id;//h.getInt("player");
Player t=Player.find(player);

String[] arr=t.pm_logo.split(",");

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>播放器设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Players.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="player" value="<%=player%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>


<table id="tablecenter" cellspacing="0">
  <tr>
    <th>Logo</th>
    <td><input type="file" name="logo"/><%=t.logo<1?"":Attch.f(t.logo)%></td>
  </tr>
  <tr style="display:none">
    <th>缓冲时显示的LOGO</th>
    <td><input type="file" name="buffer"/><%=t.buffer<1?"":Attch.f(t.buffer)%></td>
  </tr>
  <tr>
    <th>Logo位置</th>
    <td>水平<select name="pm_logo0"><%=h.options(Player.ALIGN_TYPE,Integer.parseInt(arr[0]))%></select><input name="pm_logo2" value="<%=arr[2]%>" size="5" mask="tel"/>　垂直<select name="pm_logo1"><%=h.options(Player.ALIGN_TYPE,Integer.parseInt(arr[1]))%></select><input name="pm_logo3" value="<%=arr[3]%>" size="5" mask="tel"/></td>
  </tr>
</table>

<h2>前置广告</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <th>状态</th>
    <td><%=h.radios(Player.FRONT_TYPE,"fronttype",t.fronttype)%></td>
  </tr>
  <tr>
    <th>播放顺序</th>
    <td><%=h.radios(Player.FRONT_ORDER,"frontorder",t.frontorder)%></td>
  </tr>
</table>

<div id="front" style="display:none">
<table id="tablecenter" cellspacing="0">
  <tr id=tableonetr>
  	<td>序号</td>
    <td>广告(SWF、视频、图片)</td>
    <td>链接</td>
    <td>时间(秒)</td>
    <td>操作</td>
  </tr>
<%
String[] front0=(t.front0+"||||| ").split("[|]"),front1=(t.front1+"||||| ").split("[|]"),front2=(t.front2+"||||| ").split("[|]");
for(int i=1;i<front0.length-1;i++)
{
  int attch=front0[i].length()<1?0:Integer.parseInt(front0[i]);
  out.print("<tr style=display:"+(i>1&&attch<1?"none":"")+">");
  out.print("<td>"+i);
  out.print("<td><input type='hidden' name='front0' value='"+front0[i]+"' /><input type='file' name='front0_"+(i-1)+"' value='"+front0[i]+"' "+(attch<1?"alt":"alt_del")+"='广告' />"+(attch<1?"":Attch.f(attch))+"</td>");
  out.print("<td><input name='front1' value='"+front1[i]+"' size='30' /></td>");
  out.print("<td><input name='front2' value='"+front2[i]+"' size='5' alt='时间' mask='int' /></td>");
  out.print("<td>"+(i==1?"<a href=### onclick=mt.add(this)>添加</a>":"<a href=### onclick=mt.del(this)>删除</a>"));
}
%>
</table>
</div>

<h2>暂停广告</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <th>状态</th>
    <td><%=h.radios(Player.PAUSE_TYPE,"pausetype",t.pausetype)%></td>
  </tr>
</table>
<div id="pause" style="display:none">
<table id="tablecenter" cellspacing="0">
  <tr id=tableonetr>
  	<td>序号</td>
    <td>广告(SWF、图片)</td>
    <td>链接</td>
    <td>操作</td>
  </tr>
<%
String[] pause0=(t.pause0+"||||| ").split("[|]"),pause1=(t.pause1+"||||| ").split("[|]");
for(int i=1;i<pause0.length-1;i++)
{
  int attch=pause0[i].length()<1?0:Integer.parseInt(pause0[i]);
  out.print("<tr style=display:"+(i>1&&attch<1?"none":"")+">");
  out.print("<td>"+i);
  out.print("<td><input type='hidden' name='pause0' value='"+pause0[i]+"' /><input type='file' name='pause0_"+(i-1)+"' value='"+pause0[i]+"' "+(attch<1?"alt":"alt_del")+"='广告' />"+(attch<1?"":Attch.f(attch))+"</td>");
  out.print("<td><input name='pause1' value='"+pause1[i]+"' size='30' /></td>");
  out.print("<td>"+(i==1?"<a href=### onclick=mt.add(this)>添加</a>":"<a href=### onclick=mt.del(this)>删除</a>"));
}
%>
</table>
</div>

<h2>滚动广告</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <th>状态</th>
    <td><%=h.radios(Player.MARQUEE_TYPE,"marqueetype",t.marqueetype)%></td>
  </tr>
  <tr id="marquee" style="display:none">
    <th>内容</th>
    <td><textarea name="marquee" cols="50" rows="3"><%=MT.f(t.marquee)%></textarea><a href="javascript:mt.view()">预览</a></td>
  </tr>
</table>
<div style="background-color:#000000" id="view"></div>


<h2>分享</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <th>UUID</th>
    <td><input name="share_uuid" value="<%=MT.f(t.share_uuid)%>" size="40"><a href="http://www.bshare.cn/register" target="_blank">注册</a></td>
  </tr>
</table>
<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();


var arr=[form1.fronttype,form1.pausetype,form1.marqueetype];
for(var i=0;i<arr.length;i++)
{
  for(var j=0;j<arr[i].length;j++)
  {
    arr[i][j].onclick=function()
    {
      $$(this.name.substring(0,this.name.length-4)).style.display=this.value=='0'?'none':'';
    };
  }
  arr[i][[<%=t.fronttype%>,<%=t.pausetype%>,<%=t.marqueetype%>][i]].onclick();
}

mt.add=function(a)
{
  a=mt.ftr(a);
  while(a=a.nextSibling)
  {
    if(a.style.display=='none')
    {
      a.style.display="";
      break;
    }
  }
};
mt.del=function(a)
{
  a=mt.ftr(a);
  a.parentNode.removeChild(a);
};
mt.view=function()
{
  $$('view').innerHTML=form1.marquee.value;
};
</script>
</body>
</html>
