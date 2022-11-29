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
Materia t=Materia.find(node);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——中华本草</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Materias.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">本名：</td>
    <td><input name="name" value="<%=MT.f(t.name)%>"/></td>
  </tr>
  <tr>
    <td class="th">采收加工：</td>
    <td><textarea name="harvesting" cols="50" rows="5"><%=MT.f(t.harvesting)%></textarea></td>
  </tr>
  <tr>
    <td class="th">参考文献：</td>
    <td><textarea name="reference" cols="50" rows="5"><%=MT.f(t.reference)%></textarea></td>
  </tr>
  <tr>
    <td class="th">出处：</td>
    <td><input name="source" value="<%=MT.f(t.source)%>"/></td>
  </tr>
  <tr>
    <td class="th">分类：</td>
    <td><select name="type"><%=h.options(Materia.MATERIA_TYPE,t.type)%></select></td>
  </tr>
  <tr>
    <td class="th">粉末特征：</td>
    <td><textarea name="characteristic" cols="50" rows="5"><%=MT.f(t.characteristic)%></textarea></td>
  </tr>
  <tr>
    <td class="th">附方：</td>
    <td><textarea name="prescript" cols="50" rows="5"><%=MT.f(t.prescript)%></textarea></td>
  </tr>
  <tr>
    <td class="th">附注：</td>
    <td><textarea name="note" cols="50" rows="5"><%=MT.f(t.note)%></textarea></td>
  </tr>
  <tr>
    <td class="th">功能与主治：</td>
    <td><textarea name="functions" cols="50" rows="5"><%=MT.f(t.functions)%></textarea></td>
  </tr>
  <tr>
    <td class="th">化学成分：</td>
    <td><textarea name="composition" cols="50" rows="5"><%=MT.f(t.composition)%></textarea></td>
  </tr>
  <tr>
    <td class="th">集解：</td>
    <td><textarea name="recipes" cols="50" rows="5"><%=MT.f(t.recipes)%></textarea></td>
  </tr>
  <tr>
    <td class="th">禁忌：</td>
    <td><textarea name="taboo" cols="50" rows="5"><%=MT.f(t.taboo)%></textarea></td>
  </tr>
  <tr>
    <td class="th">拉丁名：</td>
    <td><input name="latin" value="<%=MT.f(t.latin)%>"/></td>
  </tr>
  <tr>
    <td class="th">来源：</td>
    <td><textarea name="quarry" cols="50" rows="5"><%=MT.f(t.quarry)%></textarea></td>
  </tr>
  <tr>
    <td class="th">理化鉴别：</td>
    <td><textarea name="identify" cols="50" rows="5"><%=MT.f(t.identify)%></textarea></td>
  </tr>
  <tr>
    <td class="th">炮制：</td>
    <td><textarea name="processing" cols="50" rows="5"><%=MT.f(t.processing)%></textarea></td>
  </tr>
  <tr>
    <td class="th">品质标志：</td>
    <td><textarea name="quality" cols="50" rows="5"><%=MT.f(t.quality)%></textarea></td>
  </tr>
  <tr>
    <td class="th">品种考证：</td>
    <td><textarea name="textual" cols="50" rows="5"><%=MT.f(t.textual)%></textarea></td>
  </tr>
  <tr>
    <td class="th">商品规格：</td>
    <td><textarea name="specification" cols="50" rows="5"><%=MT.f(t.specification)%></textarea></td>
  </tr>
  <tr>
    <td class="th">使用注意：</td>
    <td><textarea name="precaution" cols="50" rows="5"><%=MT.f(t.precaution)%></textarea></td>
  </tr>
  <tr>
    <td class="th">释名：</td>
    <td><textarea name="shiming" cols="50" rows="5"><%=MT.f(t.shiming)%></textarea></td>
  </tr>
  <tr>
    <td class="th">显微鉴别：</td>
    <td><textarea name="microscopic" cols="50" rows="5"><%=MT.f(t.microscopic)%></textarea></td>
  </tr>
  <tr>
    <td class="th">现代临床研究：</td>
    <td><textarea name="clinical" cols="50" rows="5"><%=MT.f(t.clinical)%></textarea></td>
  </tr>
  <tr>
    <td class="th">性味：</td>
    <td><textarea name="flavour" cols="50" rows="5"><%=MT.f(t.flavour)%></textarea></td>
  </tr>
  <tr>
    <td class="th">药材及产销：</td>
    <td><textarea name="medicinal" cols="50" rows="5"><%=MT.f(t.medicinal)%></textarea></td>
  </tr>
  <tr>
    <td class="th">药材鉴别：</td>
    <td><textarea name="identification" cols="50" rows="5"><%=MT.f(t.identification)%></textarea></td>
  </tr>
  <tr>
    <td class="th">药理：</td>
    <td><textarea name="pharmacology" cols="50" rows="5"><%=MT.f(t.pharmacology)%></textarea></td>
  </tr>
  <tr>
    <td class="th">药论：</td>
    <td><textarea name="theory" cols="50" rows="5"><%=MT.f(t.theory)%></textarea></td>
  </tr>
  <tr>
    <td class="th">异名：</td>
    <td><input name="synonym" value="<%=MT.f(t.synonym)%>"/></td>
  </tr>
  <tr>
    <td class="th">饮片性状：</td>
    <td><textarea name="feature" cols="50" rows="5"><%=MT.f(t.feature)%></textarea></td>
  </tr>
  <tr>
    <td class="th">应用与配伍：</td>
    <td><textarea name="compatibility" cols="50" rows="5"><%=MT.f(t.compatibility)%></textarea></td>
  </tr>
  <tr>
    <td class="th">用法用量：</td>
    <td><textarea name="dosage" cols="50" rows="5"><%=MT.f(t.dosage)%></textarea></td>
  </tr>
  <tr>
    <td class="th">原生长形态：</td>
    <td><textarea name="morphology" cols="50" rows="5"><%=MT.f(t.morphology)%></textarea></td>
  </tr>
  <tr>
    <td class="th">制法：</td>
    <td><textarea name="method" cols="50" rows="5"><%=MT.f(t.method)%></textarea></td>
  </tr>
  <tr>
    <td class="th">制剂：</td>
    <td><textarea name="preparation" cols="50" rows="5"><%=MT.f(t.preparation)%></textarea></td>
  </tr>
  <tr>
    <td class="th">中文科名：</td>
    <td><input name="family1" value="<%=MT.f(t.family1)%>"/></td>
  </tr>
  <tr>
    <td class="th">中文种名：</td>
    <td><input name="species1" value="<%=MT.f(t.species1)%>"/></td>
  </tr>
  <tr>
    <td class="th">药性：</td>
    <td><textarea name="potency" cols="50" rows="5"><%=MT.f(t.potency)%></textarea></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
