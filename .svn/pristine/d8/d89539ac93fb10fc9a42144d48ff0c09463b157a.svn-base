<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmsprice","");
int lmsprice=key.length()<1?0:Integer.parseInt(MT.dec(key));

int father=h.getInt("father");
LmsPrice t=LmsPrice.find(lmsprice<1?father:lmsprice);


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1><%=lmsprice<1?"添加":"编辑"%>收费标准</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsPrices.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsprice" value="<%=key%>"/>
<input type="hidden" name="father" value="<%=father%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <th><em>*</em>考试计划：</th>
    <td colspan="3"><%=t.lmsprice<1?"<select name='lmsplan' alt='考试计划'><option value=''>--"+LmsPlan.options(" AND father=0 AND status IN(2,4)",t.lmsplan)+"</select>":"<input type='hidden' name='lmsplan' value='"+t.lmsplan+"'>"+LmsPlan.find(t.lmsplan).name%></td>
  </tr>
<%
if(father>0||t.father>0)
{
%>
  <tr>
    <th><em>*</em>省：</th>
    <td><script>mt.city("city",null,null,"<%=t.city%>");form1.city.setAttribute('alt','省');</script></td>
  </tr>
<%
}%>
<!--
  <tr>
    <th>省助学发展机构</th>
    <td><input name="lmsorg" value="<%=MT.f(t.lmsorg)%>"/></td>
  </tr>
-->
  <tr>
    <th>实践考费：</th>
    <td><input name="price1" value="<%=MT.f(t.price[1])%>" mask="float" size="10"/></td>
    <th>机考费：</th>
    <td><input name="price2" value="<%=MT.f(t.price[2])%>" mask="float" size="10"/></td>
  </tr>
  <tr>
<!--
    <th>实践环节重考费</th>
    <td><input name="price3" value="<%=MT.f(t.price[3])%>" mask="float" size="10"/></td>
-->
    <th>培训费：</th>
    <td><input name="price4" value="<%=MT.f(t.price[4])%>" mask="float" size="10"/></td>
    <th>考试费：</th>
    <td><input name="price5" value="<%=MT.f(t.price[5])%>" mask="float" size="10"/></td>
  </tr>
  <tr>
    <th>项目管理费：</th>
    <td><input name="price6" value="<%=MT.f(t.price[6])%>" mask="float" size="10"/></td>
    <th>省级管理费：</th>
    <td><input name="price7" value="<%=MT.f(t.price[7])%>" mask="float" size="10"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
