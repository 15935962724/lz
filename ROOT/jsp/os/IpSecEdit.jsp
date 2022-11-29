<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.os.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加——IP全安策略</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/IpSecs.do" method="post" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="act" value="add"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">源IP地址：</td>
    <td><textarea name="srcaddr" cols="30" rows="3" alt="IP"></textarea>每行一个！</td>
  </tr>
  <tr>
    <td class="th">目标IP地址：</td>
    <td><select name="dstaddr" onchange="form1.dstaddr6.style.display=value==6?'':'none'"><%=h.options(IpSec.SERVER_NAME,0)%></select><input name="dstaddr6" style="display:none"/></td>
  </tr>
  <tr>
    <td class="th">协议：</td>
    <td><select name="protocol" onchange="mt.htb(this,value!=2&&value!=3)"><%=h.options(IpSec.PROTOCOL_TYPE,0)%></select></td>
  </tr>
  <tbody style="display:none">
  <tr>
    <td class="th">源端口：</td>
    <td><input name="srcport" mask="int">不填为任意端口</td>
  </tr>
  <tr>
    <td class="th">目标端口：</td>
    <td><input name="dstport" mask="int">不填为任意端口</td>
  </tr>
  </tbody>
  <tr>
    <td class="th">选项：</td>
    <td><input type="checkbox" name="mirrored" id="mirrored"><label for="mirrored">镜像，与源地址和目标地址正好相反的数据包相匹配</label></td>
  </tr>
  <tr>
    <td class="th">描述：</td>
    <td><textarea name="description" cols="30" rows="3"></textarea></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<script>
//mt.focus();
</script>
</body>
</html>
