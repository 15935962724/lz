<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int review=h.getInt("review");
Review t=Review.find(review);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>评价详细</h1>

<form name="form1" action="/Reviews.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="review" value="<%=review%>"/>
<input type="hidden" name="act" value="state"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="state" value=""/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>商品</td>
    <td><%=Product.find(t.product).getAnchor(h.language)%></td>
  </tr>
  <tr>
    <td>用户</td>
    <td><%=MT.f(t.member)%></td>
  </tr>
  <tr>
    <td>标题</td>
    <td><%=MT.f(t.title)%></td>
  </tr>
  <tr>
    <td>评分</td>
    <td><img src='/tea/image/score/<%=MT.f(t.score)%>.gif' /></td>
  </tr>
  <tr>
    <td>使用心得</td>
    <td><%=MT.f(t.content)%></td>
  </tr>
  <tr>
    <td>优点</td>
    <td><%=MT.f(t.advantages)%></td>
  </tr>
  <tr>
    <td>缺点</td>
    <td><%=MT.f(t.shortcomings)%></td>
  </tr>
  <tr>
    <td>顶 </td>
    <td><%=MT.f(t.good)%></td>
  </tr>
  <tr>
    <td>踩</td>
    <td><%=MT.f(t.poor)%></td>
  </tr>
  <tr>
    <td>状态</td>
    <td><%=MT.f(Review.STATE_TYPE,t.state)%></td>
  </tr>
  <tr>
    <td>时间</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
</table>

<br/>

<input type="submit" value="批准" onclick="form1.state.value=1" <%=t.state==1?" disabled":""%> />
<input type="submit" value="拒绝" onclick="form1.state.value=2" <%=t.state==2?" disabled":""%> />
<input type="button" value="返回" onclick="history.back();"/>
</form>

</body>
</html>
