<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int lmspay=h.getInt("lmspay");
LmsPay t=LmsPay.find(lmspay);

StringBuilder sb=new StringBuilder();
sb.append(" AND lmsmembercourse IN(0");

String[] arr=h.getValues("lmsmembercourses");
if(arr!=null)
{
  for(int i=0;i<arr.length;i++)
    sb.append(",").append(arr[i]);
}else
{
  ArrayList al=LmsMemberCourse.find(" AND lmc.lmspay=0"+h.key,0,Integer.MAX_VALUE);
  for(int i=0;i<al.size();i++)
  {
    LmsMemberCourse lmc=(LmsMemberCourse)al.get(i);
    sb.append(",").append(lmc.lmsmembercourse);
  }
}
h.key=sb.append(")").toString();

int quantity=LmsMemberCourse.count(h.key);
if(quantity<1)
{
  out.print("<script>alert('没有待交费的学员！');history.back();</script>");
  return;
}

float price=LmsMemberCourse.sum(h.key);

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>缴费</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/LmsPays.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmspay" value="<%//=lmspay%>"/>
<input type="hidden" name="act" value="add"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="quantity" value="<%=quantity%>"/>
<input type="hidden" name="price" value="<%=price%>"/>
<input type="hidden" name="key" value="<%=MT.enc(h.key)%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <th>总金额：</th>
    <td><%=MT.f(price)%>元</td>
  </tr>
  <tr>
    <th>学员数：</th>
    <td><%=quantity%>人</td>
  </tr>
  <tr>
    <th>支付方式：</th>
    <td><%=h.radios(LmsPay.PAYMENT_TYPE,"payment",t.payment)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
form2.payment[0].disabled=true;
form2.payment[1].checked=true;
</script>
</body>
</html>
