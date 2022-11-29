<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int lang=h.getInt("lang");
int brand=h.getInt("brand");
ShopBrand t=ShopBrand.find(brand);


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<form name="form1" action="/ShopBrands.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="brand" value="<%=brand%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="lang" value="<%=lang%>"/>
<input type="hidden" name="repository" value="brand/<%=t.brand/10000%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<div class="radiusBox">
<table cellspacing="0" class='newTable' id='tdbor'>
<thead>
<tr><td colspan='2'>品牌的创建与编辑</td></tr>
</thead>
<tr>
    <td>品牌名称</td>
    <td class='bornone'><input name="name" value="<%=MT.f(t.name[lang])%>" size="40" alt="名称"/></td>
  </tr>
  <tr>
    <td>Logo</td>
    <td class='bornone'><input type="file" name="logo"/><%if(t.logo!=null)out.print(" <a href='###' onclick=mt.img('"+t.logo+"')>查看</a>");%></td>
   <!-- <input type="file" name="smallimg"/> -->
  </tr>
  <tr>
    <td>简介</td>
    <td class='bornone'><textarea name="content" cols="50" rows="5"><%=MT.f(t.content[lang])%></textarea></td>
  </tr>
</table>
</div>
<div class='mt15'>
<button class="btn btn-primary" type="submit">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- <button class="btn btn-default" type="button" onclick="history.back();">返回</button> -->
<button class="btn btn-default" type="button" onclick="window.history.back();">返回</button>
</div>
</form>

<script>form1.name.focus();</script>

</body>
</html>
