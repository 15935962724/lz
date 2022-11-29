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

Plant t=null;
String subject=null,content=null;
if(n.getType()==1)
{
  t=new Plant(0);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);

  t=Plant.find(h.node);
}


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——植物</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Plants.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">保护区：</td>
    <td><input name="reserve" value="<%=MT.f(t.reserve)%>"/></td>
  </tr>
  <tr>
    <td class="th">拉丁名：</td>
    <td><input name="species0" value="<%=MT.f(t.species[0])%>"/></td>
  </tr>
  <tr>
    <td class="th">中文名：</td>
    <td><input name="species1" value="<%=MT.f(t.species[1])%>"/></td>
  </tr>
  <tr>
    <td class="th">科名(英)：</td>
    <td><input name="family0" value="<%=MT.f(t.family[0])%>"/></td>
  </tr>
  <tr>
    <td class="th">科名(中)：</td>
    <td><input name="family1" value="<%=MT.f(t.family[1])%>"/></td>
  </tr>
  <tr>
    <td class="th">属名：</td>
    <td><input name="genus" value="<%=MT.f(t.genus)%>"/></td>
  </tr>
  <tr>
    <td class="th">种名作者：</td>
    <td><input name="speciesauthor" value="<%=MT.f(t.speciesauthor)%>"/></td>
  </tr>
  <tr>
    <td class="th">种下名称：</td>
    <td><input name="mutation" value="<%=MT.f(t.mutation)%>"/></td>
  </tr>
  <tr>
    <td class="th">种下名称作者：</td>
    <td><input name="mutationauthor" value="<%=MT.f(t.mutationauthor)%>"/></td>
  </tr>
  <tr>
    <td class="th">分布：</td>
    <td><input name="areas" value="<%=MT.f(t.areas)%>"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
