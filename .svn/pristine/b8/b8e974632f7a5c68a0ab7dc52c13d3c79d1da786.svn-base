<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int modelId=h.getInt("modelId");
int category=h.getInt("category");
ShopProductModel t=ShopProductModel.find(modelId);


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>

<form name="form1" action="/ShopProductModels.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="modelId" value="<%=modelId%>"/>
<input type="hidden" name="category" value="<%=category%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>规格/型号</td>
    <td><input name="model" value="<%=MT.f(t.getModel())%>"/></td>
  </tr>
</table>

<br/>
    <button class="btn btn-primary" type="submit">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="history.back();">返回</button>
</form>

<script>
form1.model.focus();
</script>

</body>
</html>
