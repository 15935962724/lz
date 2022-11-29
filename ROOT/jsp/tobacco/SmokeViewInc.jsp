<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%><%

Http h=new Http(request,response);

int smoke=h.getInt("smoke");
Smoke t=Smoke.find(smoke);
if(t.time==null)
{
  out.println("<script>alert('该页不存在！');location.replace='/'</script>");
  return;
}

StringBuilder sb=new StringBuilder();
sb.append("bdText:"+Attch.cite(t.content));

%>



<table id="tablecenter" cellspacing="0">
<%
if(t.attch>0)
{
  Attch a=Attch.find(t.attch);
  if(t.type==2)
  out.print("<tr><td style='display:none'>图片</td><td colspan='4'><img src='"+("gif".equals(a.type)?a.path:a.path4)+"' />");
  else
  //out.print("<tr><td style='display:none'>视频</td><td colspan='4'><script>mt.embed('/tea/image/flv/CuPlayer.swf',640,480,'CuPlayerFile="+path+"&CuPlayerWidth=640&CuPlayerHeight=480&CuPlayerAutoPlay=false&CuPlayerImage="+a.path4+"&CuPlayerLogo=&CuPlayerAutoHideTime=3');</script>");
  out.print("<tr><td style='display:none'>视频</td><td colspan='4'><script>mt.embed('/tea/image/flv/ckplayer.swf',640,480,'f=%2FPlayers.do%3Fact%3Dquality%26quality%3D%5B%24pat%5D%26attch%3D"+a.attch+"&i="+a.path4+"&a=2&s=1&x=%2FPlayers.do%3Fact%3Dconf%26quality%3Dtrue&p=1&e=3&my_url='+encodeURIComponent(location.href));</script>");
  sb.append(",bdPic:'http://"+request.getServerName()+a.path4+"'");
}
%>
  <tr class='nab'>
    <td width='120'>编号: <%=MT.f(t.code)%></td>
    <td colspan='3' style='white-space:nowrap;width:520px;'>作者: <%=MT.f(t.name)%></td>
  </tr>
<%
//if(t.type==1)
{
  out.print("<tr class='pb'><td colspan='4'>分类: "+Smoke.MATTER_TYPE[t.type][t.matter]+"</td></tr>");
}
%>
  <tr>
    <td style='display:none;'>简介: </td>
    <td colspan='4' class='textp' style="text-indent:0px !important;"><span style="height:auto;float:left;display:block;width:35px;">简介: </span><span style="width:600px;display:block;float:left;"><%=MT.f(t.content).replaceAll("\r\n","<br/>")%></span></td>
  </tr>
</table>
<div style="float:right;width:100%;height:45px;line-height:45px;text-align:right;"><a onclick="history.go(-1)" style="cursor:pointer;color:#000;">返回上一页</a></div>
<div class="share">
<a href="###" onclick="mt.act(this,<%=t.smoke%>,1)" id="positive"><%=t.positive%></a><a href="###" onclick="mt.act(this,<%=t.smoke%>,1)" id="derogatory"><%=t.derogatory%></a><span class="bdsharebuttonbox"><a class="bds_more" data-cmd="more" style='float:none;display:inline'>分享</a></span>
</div>
<script>
window._bd_share_config={common:{<%=sb.toString()%>},share:[]};
with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];

mt.act=function(a,i,b)
{
  //顶,踩
  var ids=cook.get(a.id,'|');
  var val=ids.indexOf('|'+i+'|')==-1?1:-1;
  ids=val==1?ids+i+'|':ids.replace('|'+i+'|','|');
  mt.send("/Smokes.do?act="+a.id+"&smoke="+i+"&value="+val,function(d){a.innerHTML=d;cook.set(a.id,ids);});
  mt.up(a,val,function(){});
};
</script>

