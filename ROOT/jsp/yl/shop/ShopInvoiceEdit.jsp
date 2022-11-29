<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


int id=h.getInt("id");

ShopOrderDispatch t=ShopOrderDispatch.find(id);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body style="border: none;padding-top:15px;background:none">

<form name="form2" action="/ShopOrderDispatchs.do" enctype="multipart/form-data" method="post" onsubmit="return mt.check(this)">
<input type="hidden" name="dispatch" value="<%=id%>"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<input type="hidden" name="act" value="invoice_edit"/>

<table id="tablecenter" cellspacing="0">
  <tr><td>新的发票单号：</td><td><input name='n_invoiceNoNew' value="<%=MT.f(t.getN_invoiceNoNew())%>" size='30' alt='新的发票单号'/></td></tr>
</table>

<br/>
<input type="submit" value="提交" />
<input type="button" value="关闭" onclick="parent.mt.close()"/>
</form>


</body>
</html>
