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

Animal t=null;
String subject=null,content=null,picture=null;
if(n.getType()==1)
{
  t=new Animal(0);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);
  picture=n.getPicture(h.language);

  t=Animal.find(h.node);
}


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——动物</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Animals.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">种类：</td>
    <td><select name="type"><%=h.options(Animal.ANIMAL_TYPE,t.type)%></select></td>
  </tr>
  <tr>
    <td class="th">物种代码：</td>
    <td><input name="code" value="<%=MT.f(t.code)%>"/></td>
  </tr>
  <tr>
    <td class="th">物种名称：</td>
    <td><input name="subject" value="<%=MT.f(t.name)%>" alt="物种名称"/></td>
  </tr>
  <tr>
    <td class="th">拉丁名字：</td>
    <td><input name="latin" value="<%=MT.f(t.latin)%>"/></td>
  </tr>
  <tr>
    <td class="th">分布省份：</td>
    <td><input name="city" value="<%=MT.f(t.city)%>"/></td>
  </tr>
  <tr>
    <td class="th">保护区分布：</td>
    <td><textarea name="reserve" cols="50" rows="5"><%=MT.f(t.reserve)%></textarea></td>
  </tr>
  <tr>
    <td class="th">分布山脉：</td>
    <td><input name="range" value="<%=MT.f(t.range)%>" size="50"/></td>
  </tr>
  <tr>
    <td class="th">濒危因素：</td>
    <td><input name="endanger" value="<%=MT.f(t.endanger)%>" size="50"/></td>
  </tr>
  <tr>
    <td class="th">生长环境：</td>
    <td><input name="environment" value="<%=MT.f(t.environment)%>" size="50"/></td>
  </tr>
  <tr>
    <td class="th">特征：</td>
    <td><textarea name="feature" cols="50" rows="5"><%=MT.f(t.feature)%></textarea></td>
  </tr>
  <tr>
    <td class="th">属名：</td>
    <td><input name="genus" value="<%=MT.f(t.genus)%>"/></td>
  </tr>
  <tr>
    <td class="th">科名：</td>
    <td><input name="family" value="<%=MT.f(t.family)%>"/></td>
  </tr>
  <tr>
    <td class="th">目名：</td>
    <td><input name="order1" value="<%=MT.f(t.order1)%>"/></td>
  </tr>
  <tr>
    <td class="th">上传图片：</td>
    <td><input name="filename" type="file"/></td>
  </tr>
</table>

<h2>保护等级</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">中国动物CITES公约名录等级：</td>
    <td><input name="cites" value="<%=MT.f(t.cites)%>"/></td>
  </tr>
  <tr>
    <td class="th">世界自然保护联盟：</td>
    <td><input name="iucn" value="<%=MT.f(t.iucn)%>"/></td>
  </tr>
  <tr>
    <td class="th">保护级别：</td>
    <td><input name="alevel" value="<%=MT.f(t.alevel)%>"/></td>
  </tr>
  <tr>
    <td class="th">红色名录等级：</td>
    <td><input name="rlevel" value="<%=MT.f(t.rlevel)%>"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
