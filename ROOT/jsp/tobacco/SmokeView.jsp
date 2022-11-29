<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.util.*"%><%@page import="tea.entity.stat.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%><%

Http h=new Http(request,response);
if(h.member < 1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int smoke=h.getInt("smoke");
Smoke t=Smoke.find(smoke);


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看</h1>
<div id="head6"><img height="6" src="about:blank"></div>



<form name="form2" action="/Smokes.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="smoke" value="<%=smoke%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>



<table id="tablecenter" cellspacing="0">
  <tr>
    <td>编号</td>
    <td><%=MT.f(t.code)%></td>
  </tr>
  <tr>
    <td>姓名</td>
    <td><%=MT.f(t.name)%></td>
  </tr>
  <tr>
    <td nowrap>身份证号</td>
    <td><%=MT.f(t.idcard)%></td>
  </tr>
  <tr>
    <td>地址</td>
    <td><%=MT.f(t.address)%></td>
  </tr>
  <tr>
    <td>手机号</td>
    <td><%=t.getMobile()%>
      <%
      try
      {
        Tel tel=Tel.find(Integer.parseInt(t.mobile.substring(0,7)));
        out.print("("+tel.address+")");
      }catch(Throwable ex)
      {}
      %>
      </td>
  </tr>
  <tr>
    <td>内容</td>
    <td><%=MT.f(t.content).replaceAll("\r\n","<br/>")%></td>
  </tr>
<%
if(t.type==1)
{
}else
{
  Attch a=Attch.find(t.attch);
  if(t.type==2)
  out.print("<tr><td>图片</td><td><img src='"+("gif".equals(a.type)?a.path:a.path4)+"' />");
  else
  out.print("<tr><td>视频</td><td><script>mt.embed('/tea/image/flv/ckplayer.swf',320,240,'f=%2FPlayers.do%3Fact%3Dquality%26quality%3D%5B%24pat%5D%26attch%3D"+a.attch+"&i="+a.path4+"&a=2&s=1&x=%2FPlayers.do%3Fact%3Dconf%26quality%3Dtrue&p=1&my_url='+encodeURIComponent(location.href));</script>");
  out.print("<a href='/Attchs.do?act=down&attch="+MT.enc(a.attch)+"'>下载</a>");
}
out.print("<tr><td>题材</td><td>"+Smoke.MATTER_TYPE[t.type][t.matter]);
if(t.smember>0)
{
%>
  <tr>
    <td>处理人</td>
    <td><%=Profile.find(t.smember).getMember()%></td>
  </tr>
  <tr>
    <td nowrap>处理人时间</td>
    <td><%=MT.f(t.stime,1)%></td>
  </tr>
<%
}%>
  <tr>
    <td>赞</td>
    <td><%=t.positive%></td>
  </tr>
  <tr>
    <td>踩</td>
    <td><%=t.derogatory%></td>
  </tr>
  <tr>
    <td>IP地址</td>
    <td><%=t.ip+" ("+Ip.findByIp(t.ip)+")"%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="location=form2.nexturl.value;"/>
</form>

</body>
</html>
