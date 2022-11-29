<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int price=h.getInt("price");
ShopPrice t=ShopPrice.find(price);



%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>价格区域管理</h1>

<form name="form1" action="/ShopPrices.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="price" value="<%=price%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>区域</td>
    <td>
<%
String[] arr=t.area.split("[|]");
for(int i=1;i<arr.length;i++)
{
  if(i>1)out.print("-");
  out.print("<input name='area' value='"+arr[i]+"' mask='int' size='5' />");
}
for(int i=arr.length;i<13;i++)
{
  out.print("-<input name='area' value='' mask='int' size='5' />");
}
%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus(form1);</script>

</body>
</html>
