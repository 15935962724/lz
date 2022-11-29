<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.os.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
Firewall t=new Firewall();
t.name=h.get("namex","");
t.protocol=h.getInt("protocol");
t.port=h.getInt("port");
t.mode=h.getInt("mode");
t.scope=h.getInt("scope");
t.addresses=h.get("addresses","");
t.profile=h.getInt("profile");
t.program=h.get("program","");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加——防火强</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Firewalls.do" method="post" target="_ajax" onSubmit="this.port.disabled=this.type[1].checked;return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="oldprotocol" value="<%=t.protocol%>"/>
<input type="hidden" name="oldport" value="<%=t.port%>"/>
<input type="hidden" name="oldprogram" value="<%=t.program%>">

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">名称：</td>
    <td><input name="name" value="<%=MT.f(t.name)%>" size="30" alt="名称"></td>
  </tr>
  <tr>
    <td class="th">分类：</td>
    <td><input type="radio" name="type" value="1" onchange="ftype(value)" id="_type1"><label for="_type1">端口</label>　<input type="radio" name="type" value="2" onchange="ftype(value)" id="_type2"><label for="_type2">程序</label></td>
  </tr>
  <tbody id="_tbody1">
  <tr>
    <td class="th">协议：</td>
    <td><select name="protocol"><%=h.options(Firewall.PROTOCOL_TYPE,t.protocol)%></select></td>
  </tr>
  <tr>
    <td class="th">端口：</td>
    <td><input name="port" value="<%=MT.f(t.port)%>" alt="端口" mask="int"></td>
  </tr>
  </tbody>
  <tbody id="_tbody2">
  <tr>
    <td class="th">路径：</td>
    <td><input name="program" value="<%=t.program%>" alt="路径" size="30"></td>
  </tr>
  </tbody>
  <tr>
    <td class="th">状态：</td>
    <td><select name="mode"><%=h.options(Firewall.MODE_NAME,t.mode)%></select></td>
  </tr>
  <tr>
    <td class="th">端口范围：</td>
    <td><select name="scope" onchange="document.getElementById('scope2').style.display=value==2?'':'none'"><%=h.options(Firewall.SCOPE_NAME,t.scope)%></select></td>
  </tr>
  <tr id="scope2">
    <td class="th">自定义列表：</td>
    <td><textarea name="addresses" cols="30" rows="3"><%=t.addresses%></textarea>示例：192.168.114.201,192.168.114.201/255.255.255.0</td>
  </tr>
  <tr>
    <td class="th">端口范围：</td>
    <td><select name="profile"><%=h.options(Firewall.PROFILE_NAME,t.profile)%></select></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="history.back();"/>
</form>

<script>
function ftype(v)
{
  for(var i=1;i<3;i++)
  {
    $$('_tbody'+i).style.display=v==i?'':'none'
  }
}
form1.type[<%=t.program.length()<1?0:1%>].click();
form1.scope.onchange();
//mt.focus();
</script>
</body>
</html>
