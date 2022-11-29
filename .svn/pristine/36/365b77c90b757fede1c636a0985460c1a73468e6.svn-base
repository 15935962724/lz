<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="tea.entity.member.*"%><%@page import="net.mietian.convert.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.tobacco.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%><%

Http h=new Http(request,response);
if(h.member < 1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

Community c=Community.find(h.community);
String domain=c.getWebName();
//domain="www.redcome.com";

String cookie="BAIDUID=BCD5EE6205390D9B55A75684BA3D6320:FG=1; BDUSS=d0UlQwemZXckJQUS1PNX50TjJzb1ZVSnNkVnR1TDVlN0Y0SUltVjF-MEl-OGxUQVFBQUFBJCQAAAAAAAAAAAEAAAC4RIIAaXdsawAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAhyolMIcqJTYz";

String par="&domain="+domain+"&s=2014/05/14&e="+MT.f(new Date()).replace('-','/');
if("POST".equals(request.getMethod()))//导出
{
  String act=h.get("act");
  response.setHeader("Content-Disposition","attachment; filename="+act+".csv");
  byte[] by=(byte[])Http.open("http://share.baidu.com/analysis/share"+act+"?down=1"+par,cookie);
  OutputStream os=response.getOutputStream();
  os.write(by);
  os.close();
  return;
}

String data=(String)Http.open("http://share.baidu.com/analysis/general?type=all&domain="+domain,cookie);
if(data.contains("location.href="))
{
  out.print("登陆状态失效！");
  return;
}

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
mt.len=function(a,b)
{
  return a.substring(0,b)+(a.length>b?'...':'');
};
mt.act=function(a)
{
  form2.act.value=a;
  form2.submit();
};
</script>
</head>
<body>
<h1>分享统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>



<h2>概述</h2>
<form name="form2" action="?" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=h.get("id")%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td>分享量</td>
  <td>产生分享的页面数</td>
  <td>回流量</td>
  <td>分享回流比</td>
</tr>
<script>
var h="",d=<%=data%>.data;
var tr=['today','yestoday','thistime','top','average'],th=['今日','昨日','昨日此时','历史峰值','每日平均'],td=["share","page","back"];
for(var i=0;i<tr.length;i++)
{
  var r=d[tr[i]];
  h+="<tr><td>"+th[i];
  for(var j=0;j<td.length;j++)
  {
    h+="<td>"+r[td[j]];
  }
  h+="<td>"+mt.f(r.back*100/r.share,2)+"%";
}
document.write(h);
</script>
</table>

<table id="tablecenter" cellspacing="0">
<tr>
  <td>
<script>
function open_flash_chart_data()
{
  var COLOR=["FFA333","009149","0058C6"],TAB=["分享量","产生分享的页面数","回流量"];
  var d=[<%=Http.open("http://share.baidu.com/analysis/sharedata?"+par,cookie)%>.data,<%=Http.open("http://share.baidu.com/analysis/sharepage?"+par,cookie)%>.data,<%=Http.open("http://share.baidu.com/analysis/backdata?"+par,cookie)%>.data];
  var h="",v="",max=0;
  for(var i=0;i<d.length;i++)
  {
    if(i>0)v+=",";
    v+="{'type':'line','values':[";
    var sum=0;
    for(var j=0;j<d[i].length;j++)
    {
      if(j>0)v+=",";
      max=Math.max(max,d[i][j].value);
      v+=d[i][j].value;
      sum+=d[i][j].value;
      if(i!=0)continue;
      if(j>0)h+=",";
      h+="'"+d[i][j].label+"'";
    }
    v+="],'text':'"+TAB[i]+"("+sum+")','colour':'"+COLOR[i]+"'}";
  }
  return ("{'elements':["+v+"],'x_axis':{'labels':{'labels':["+h+"]},'colour':'#000000','grid-colour':'#E4E4E4'},'y_axis':{'max':"+max+",'steps':"+max/10+",'colour':'#000000','grid-colour':'#E4E4E4'},'bg_colour':'#FFFFFF','tooltip':{'stroke':1}}").replace(/'/g,'"');
}
function save_image()
{
  mt.post("/Imgs.do?act=chart",$$('chart').get_img_binary());
}
mt.embed('/tea/mt/chart.swf','100%',300);
</script>
</table>
<input type="button" value="导出" onclick="save_image()"/>

<h2>分享页面数据</h2>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>url链接</td>
  <td>分享量</td>
  <td>回流量</td>
  <td>分享回流比</td>
  <td>关联度最高的页面</td>
</tr>
<script>
var h="",d=<%=Http.open("http://share.baidu.com/analysis/sharehotdata?limit=10"+par,cookie)%>.data;
var td=["url","share","back",null,"page"];
for(var i=0;i<d.length;i++)
{
  var r=d[i];
  h+="<tr>";
  for(var j=0;j<td.length;j++)
  {
    h+="<td>";
    if(j==0||j==4)h+="<a href="+r[td[j]]+">"+mt.len(r[td[j]],36)+"</a>";
    else if(j==3)h+=mt.f(r.back*100/r.share,2)+"%";
    else h+=r[td[j]];
  }
}
document.write(h);
</script>
</table>
<input type="button" value="导出" onclick="mt.act('hotdata')"/>

<h2>分享媒体数据</h2>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>媒体名称</td>
  <td>分享量</td>
  <td>回流量</td>
  <td>分享回流比</td>
  <td>此媒体分享量最高的页面</td>
</tr>
<script>
var T=[];
T['mshare']='一键分享';
T['qzone']='QQ空间';
T['tsina']='新浪微博';
T['baidu']='百度搜藏';
T['renren']='人人网';
T['tqq']='腾讯微博';
T['bdxc']='百度相册';
T['kaixin001']='开心网';
T['tqf']='腾讯朋友';
T['tieba']='百度贴吧';
T['douban']='豆瓣网';
T['tsohu']='搜狐微博';
T['bdhome']='百度新首页';
T['sqq']='QQ好友';
T['thx']='和讯微博';
T['qq']='QQ收藏';
T['taobao']='我的淘宝';
T['hi']='百度空间';
T['bdysc']='百度云收藏';
T['sohu']='搜狐白社会';
T['t163']='网易微博';
T['qy']='奇艺奇谈';
T['meilishuo']='美丽说';
T['mogujie']='蘑菇街';
T['diandian']='点点网';
T['huaban']='花瓣';
T['leho']='爱乐活';
T['share189']='手机快传';
T['duitang']='堆糖';
T['hx']='和讯';
T['tfh']='凤凰微博';
T['fx']='飞信';
T['youdao']='有道云笔记';
T['sdo']='麦库记事';
T['qingbiji']='轻笔记';
T['ifeng']='凤凰快博';
T['people']='人民微博';
T['xinhua']='新华微博';
T['ff']='饭否';
T['mail']='邮件分享';
T['kanshou']='搜狐随身看';
T['isohu']='我的搜狐';
T['yaolan']='摇篮空间';
T['wealink']='若邻网';
T['xg']='鲜果';
T['ty']='天涯社区';
T['fbook']='Facebook';
T['twi']='Twitter';
T['deli']='delicious';
T['s51']='51游戏社区';
T['s139']='139说客';
T['linkedin']='linkedin';
T['copy']='复制网址';
T['print']='打印';
T['ibaidu']='百度个人中心';
T['weixin']='微信';
T['iguba']='股吧';
var h="",d=<%=Http.open("http://share.baidu.com/analysis/sharesiteurl?limit=10"+par,cookie)%>.data;
var td=["name","share","back",null,"url"];
for(var i=0;i<d.length;i++)
{
  var r=d[i];
  h+="<tr>";
  for(var j=0;j<td.length;j++)
  {
    h+="<td>";
    if(j==0)h+=T[r.name];
    else if(j==3)h+=mt.f(r.back*100/r.share,2)+"%";
    else if(j==4)h+="<a href="+r.url+">"+mt.len(r.url,36)+"</a>";
    else h+=r[td[j]];
  }
}
document.write(h);
</script>
</table>
<input type="button" value="导出" onclick="mt.act('siteurl')"/>
</form>



</body>
</html>
