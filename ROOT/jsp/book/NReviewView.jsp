<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int review=h.getInt("review");
NReview t=NReview.find(review);

Node n=Node.find(t.node);



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看——评价管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/NReviews.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="review" value="<%=review%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">商品：</td>
    <td><%=n.getSubject(h.language)%></td>
  </tr>
  <tr>
    <td class="th">评价者：</td>
    <td><%=Profile.find(t.member).getMember()%></td>
  </tr>
  <tr>
    <td class="th">评分：</td>
    <td><div class='star' style='background-position:<%=t.score*13-65%>px;'></div></td>
  </tr>
  <tr>
    <td class="th">评价：</td>
    <td><%=MT.f(t.content)%></td>
  </tr>
 
  <tr>
    <td class="th">时间：</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>

</script>
</body>
</html>
