<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int node=h.getInt("node");
Node n=Node.find(node);

Specimen t=null;
String subject=null,content=null;
if(n.getType()==1)
{
  t=new Specimen(0);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);

  t=Specimen.find(h.node);
}


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——标本</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Specimens.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">保存单位及其标本馆：</td>
    <td><input name="unit" value="<%=MT.f(t.unit)%>"/></td>
  </tr>
  <tr>
    <td class="th">标本馆代码：</td>
    <td><input name="bbgdm" value="<%=MT.f(t.bbgdm)%>"/></td>
  </tr>
  <tr>
    <td class="th">种名(中)：</td>
    <td><input name="species1" value="<%=MT.f(t.species[1])%>"/></td>
  </tr>
  <tr>
    <td class="th">纲：</td>
    <td><input name="class1" value="<%=MT.f(t.class1)%>"/></td>
  </tr>
  <tr>
    <td class="th">目：</td>
    <td><input name="order0" value="<%=MT.f(t.order0)%>"/></td>
  </tr>
  <tr>
    <td class="th">科：</td>
    <td><input name="family" value="<%=MT.f(t.family)%>"/></td>
  </tr>
  <tr>
    <td class="th">属：</td>
    <td><input name="genus" value="<%=MT.f(t.genus)%>"/></td>
  </tr>
  <tr>
    <td class="th">种名(英)：</td>
    <td><input name="species0" value="<%=MT.f(t.species[0])%>"/></td>
  </tr>
  <tr>
    <td class="th">种下名称：</td>
    <td><input name="mutation" value="<%=MT.f(t.mutation)%>"/></td>
  </tr>
</table>

<h2>采集信息</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">标本号：</td>
    <td><input name="snumber" value="<%=MT.f(t.snumber)%>"/></td>
  </tr>
  <tr>
    <td class="th">采集人：</td>
    <td><input name="cperson" value="<%=MT.f(t.cperson)%>"/></td>
  </tr>
  <tr>
    <td class="th">采集时间：</td>
    <td><input name="ctime" value="<%=MT.f(t.ctime)%>" onclick="mt.date(this)" class="date"/></td>
  </tr>
  <tr>
    <td class="th">采集号：</td>
    <td><input name="cnumber" value="<%=MT.f(t.cnumber)%>"/></td>
  </tr>
  <tr>
    <td class="th">采集地（保护区小地名）：</td>
    <td><input name="csite" value="<%=MT.f(t.csite)%>"/></td>
  </tr>

  <tr>
    <td class="th">reserve：</td>
    <td><input name="reserve" value="<%=MT.f(t.reserve)%>"/></td>
  </tr>
  <tr>
    <td class="th">保护区名称：</td>
    <td><input name="rname" value="<%=MT.f(t.rname)%>"/></td>
  </tr>
  <tr>
    <td class="th">保护区代码：</td>
    <td><input name="rcode" value="<%=MT.f(t.rcode)%>"/></td>
  </tr>
  <tr>
    <td class="th">国家：</td>
    <td><input name="country" value="<%=MT.f(t.country)%>"/></td>
  </tr>
  <tr>
    <td class="th">省：</td>
    <td><input name="province" value="<%=MT.f(t.province)%>"/></td>
  </tr>
  <tr>
    <td class="th">经度：</td>
    <td><input name="longitude" value="<%=MT.f(t.longitude)%>"/></td>
  </tr>
  <tr>
    <td class="th">纬度：</td>
    <td><input name="latitude" value="<%=MT.f(t.latitude)%>"/></td>
  </tr>
  <tr>
    <td class="th">海拔：</td>
    <td><input name="elevation" value="<%=MT.f(t.elevation)%>"/></td>
  </tr>
</table>

<h2>扩展信息</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">植被类型：</td>
    <td><input name="vegetation" value="<%=MT.f(t.vegetation)%>"/></td>
  </tr>
  <tr>
    <td class="th">生境：</td>
    <td><textarea name="environment" cols="50" rows="5"><%=MT.f(t.environment)%></textarea></td>
  </tr>
  <tr>
    <td class="th">寄主：</td>
    <td><input name="host" value="<%=MT.f(t.host)%>"/></td>
  </tr>
  <tr>
    <td class="th">性别：</td>
    <td><input name="sexual" value="<%=MT.f(t.sexual)%>"/></td>
  </tr>
  <tr>
    <td class="th">年龄：</td>
    <td><input name="old" value="<%=MT.f(t.old)%>"/></td>
  </tr>
</table>

<h2>共享信息</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">标本属性：</td>
    <td><input name="property" value="<%=MT.f(t.property)%>"/></td>
  </tr>
  <tr>
    <td class="th">标本状态：</td>
    <td><select name="status"><%=h.options(Specimen.SPECIMEN_TYPE,t.status)%></td>
  </tr>
  <tr>
    <td class="th">保藏方式：</td>
    <td><input name="preserve" value="<%=MT.f(t.preserve)%>"/></td>
  </tr>
  <tr>
    <td class="th">实物状态：</td>
    <td><input name="conlive" value="<%=MT.f(t.conlive)%>"/></td>
  </tr>
  <tr>
    <td class="th">共享方式：</td>
    <td><input name="share" value="<%=MT.f(t.share)%>"/></td>
  </tr>
  <tr>
    <td class="th">获取途径：</td>
    <td><input name="getway" value="<%=MT.f(t.getway)%>"/></td>
  </tr>
  <tr>
    <td class="th">描述：</td>
    <td><textarea name="discribe" cols="50" rows="5"><%=MT.f(t.discribe)%></textarea></td>
  </tr>
  <tr>
    <td class="th">用户名称：</td>
    <td><input name="uuser" value="<%=MT.f(t.uuser)%>"/></td>
  </tr>
  <tr>
    <td class="th">用户ID：</td>
    <td><input name="uid" value="<%=MT.f(t.uid)%>"/></td>
  </tr>
  <tr>
    <td class="th">物种类型：</td>
    <td><select name="speciestype"><%=h.options(Specimen.SPECIES_TYPE,t.speciestype)%></select></td>
  </tr>
  <tr>
    <td class="th">标本入库时间：</td>
    <td><input name="enterdbdate" value="<%=MT.f(t.enterdbdate)%>" onclick="mt.date(this)" class="date"/></td>
  </tr>
  <tr>
    <td class="th">资源一级分类：</td>
    <td><input name="firstlevel" value="<%=MT.f(t.firstlevel)%>"/></td>
  </tr>
  <tr>
    <td class="th">资源二级分类：</td>
    <td><input name="secondlevel" value="<%=MT.f(t.secondlevel)%>"/></td>
  </tr>
  <tr>
    <td class="th">资源归类码：</td>
    <td><input name="zyglm" value="<%=MT.f(t.zyglm)%>"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
