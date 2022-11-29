<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.custom.papc.*"%><%

Http h=new Http(request,response);

int papcapp=h.getInt("papcapp");
PapcApp t=PapcApp.find(papcapp);

if("POST".equals(request.getMethod()))
{
  String act=h.get("act");
  String nexturl=h.get("nexturl");
  if("del".equals(act))
  {
    t.delete();
  }else if("edit".equals(act))
  {
    t.member=h.getInt("member");
    t.name=h.get("name");
    t.email=h.get("email");
    t.tel=h.get("tel");
    t.position=h.getInt("position");
    t.country=h.getInt("country");
    t.address=h.get("address");
    t.org=h.get("org");
    t.project=h.get("project");
    t.leader=h.get("leader");
    t.purpost=h.get("purpost");
    t.content=h.get("content");
    t.commitment=h.get("commitment");
    t.ip=h.get("ip");
    t.time=h.getDate("time");
    t.set();
  }
  out.print("<script>parent.mt.show('数据操作成功！',1,'"+nexturl+"');</script>");
  return;
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="papcapp" value="<%=papcapp%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>member</td>
    <td><input name="member" value="<%=MT.f(t.member)%>"/></td>
  </tr>
  <tr>
    <td>申请人</td>
    <td><input name="name" value="<%=MT.f(t.name)%>"/></td>
  </tr>
  <tr>
    <td>电子邮件</td>
    <td><input name="email" value="<%=MT.f(t.email)%>"/></td>
  </tr>
  <tr>
    <td>电话</td>
    <td><input name="tel" value="<%=MT.f(t.tel)%>"/></td>
  </tr>
  <tr>
    <td>身份</td>
    <td><%=h.radios(PapcApp.POSITION_TYPE,"position",t.position)%></td>
  </tr>
  <tr>
    <td>国家</td>
    <td><input name="country" value="<%=MT.f(t.country)%>"/></td>
  </tr>
  <tr>
    <td>地址</td>
    <td><input name="address" value="<%=MT.f(t.address)%>"/></td>
  </tr>
  <tr>
    <td>单位</td>
    <td><input name="org" value="<%=MT.f(t.org)%>"/></td>
  </tr>
  <tr>
    <td>项目或课题名称及来源</td>
    <td><textarea name="project" cols="50" rows="5"><%=MT.f(t.project)%></textarea></td>
  </tr>
  <tr>
    <td>课题负责人</td>
    <td><textarea name="leader" cols="50" rows="5"><%=MT.f(t.leader)%></textarea></td>
  </tr>
  <tr>
    <td>数据应用说明</td>
    <td><textarea name="purpost" cols="50" rows="5"><%=MT.f(t.purpost)%></textarea></td>
  </tr>
  <tr>
    <td>所需数据内容描述（地区、类群或馆别）</td>
    <td><textarea name="content" cols="50" rows="5"><%=MT.f(t.content)%></textarea></td>
  </tr>
  <tr>
    <td>承诺</td>
    <td><textarea name="commitment" cols="50" rows="5"><%=MT.f(t.commitment)%></textarea></td>
  </tr>
  <tr>
    <td>IP地址</td>
    <td><input name="ip" value="<%=MT.f(t.ip)%>"/></td>
  </tr>
  <tr>
    <td>申请时间</td>
    <td><%=h.selects("time",t.time)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
