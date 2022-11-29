<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int wxred=h.getInt("wxred");
WxRed t=WxRed.find(wxred);



%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1><%=t.wxred<1?"添加":"编辑"%>红包</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/WxReds.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxred" value="<%=wxred%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>城市</td>
    <td><script>_cb=true;mt.city('city1','city2',null,"<%=t.city%>")</script></td>
  </tr>
  <tr>
    <td>每天上限</td>
    <td><input name="limit" value="<%=MT.f(t.limit)%>" mask="int" size="5"/>元</td>
  </tr>
  <tr>
    <td>共充值</td>
    <td><input name="total" value="<%=MT.f(t.total)%>" mask="int" size="8"/>元</td>
  </tr>
  <tr>
    <td>警界线</td>
    <td><input name="pline" value="<%=MT.f(t.pline)%>" mask="int" size="8"/>元，不足此值时，发送提醒。</td>
  </tr>
  <tr>
    <td>选项</td>
    <td><input type="checkbox" name="hidden" <%=t.hidden?" checked ":""%>>隐藏</td>
  </tr>
</table>


<h2>中奖概率</h2>
<table id="tablecenter" cellspacing="0">
<%
for(int i=1;i<WxRed.PROBABILITY.length;i++)
{
%>
  <tr>
    <td><%=WxRed.PROBABILITY[i]%>元</td>
    <td><input type="number" name="probability<%=i%>" value="<%=MT.f(t.probability[i])%>" min="0" max="100" mask="float"/>%</td>
  </tr>
<%
}%>
  <tr>
    <td>总概率</td>
    <td><input type="number" name="pro" min="0" max="100"/>%</td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
form1.city1.options[0].text="全国";

var pro=0;
for(var i=1;i<7;i++)
{
  var t=form1['probability'+i];
  if(t)pro+=parseFloat(t.value||'0');
}
form1.pro.value=pro;
for(var i=1;i<7;i++)
{
  var t=form1['probability'+i];
  t.pec=parseFloat(t.value||'0')*100/pro;
}
form1.pro.onchange=function()
{
  pro=parseInt(form1.pro.value);
  for(var i=1;i<7;i++)
  {
    var t=form1['probability'+i];
    t.value=t.pec*pro/100;
  }
};
</script>
</body>
</html>
