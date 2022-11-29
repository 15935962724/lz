<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
String nexturl = h.get("nexturl");
int advisoryId=h.getInt("advisoryId");
ShopAdvisory t=ShopAdvisory.find(advisoryId);

String uname = MT.f(Profile.find(t.getMember()).member);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>咨询回复</h1>

<form name="form1" action="/ShopAdvisorys.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="advisoryId" value="<%=advisoryId%>"/>
<input type="hidden" name="act" value="reply"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='5' class='bornone'>&nbsp;</td></tr>
</thead>
  <tr>
    <td width='60' style='text-align:right'>商品</td>
    <td class='bornone'><%=ShopProduct.find(t.getProduct_id()).getAnchor(h.language)%></td>
  </tr>
  <tr>
    <td style='text-align:right'>用户</td>
    <td class='bornone'><%=uname%></td>
  </tr>
  <tr>
    <td style='text-align:right'>咨询内容</td>
    <td class='bornone'><textarea name="depict" cols="50" rows="5"><%=MT.f(t.getDepict())%></textarea><span id="info">还能输入</span><b id="count">200</b>字</td>
  </tr>
  <tr>
    <td style='text-align:right'>回复内容</td>
    <td class='bornone'><textarea name="replycont" cols="50" rows="5"><%=MT.f(t.getReplycont())%></textarea><span id="info2">还能输入</span><b id="count2">200</b>字</td>
  </tr>
</table>
</div><div class="center mt15">
    <button class="btn btn-primary" type="button" onclick="submitZx()">提交</button>
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button></div>
</form>

<script>
form1.replycont.focus();


fc=form1.depict;
fc.onpropertychange=fc.oninput=function()
{
  var len=200-this.value.length;
  $$('info').innerHTML=len<0?"已经超过":"还能输入";
  var c=$$('count');
  c.innerHTML=Math.abs(len);
  c.style.color=len<0?"red":"";
};
fc.oninput();

fc2=form1.replycont;
fc2.onpropertychange=fc2.oninput=function()
{
  var len=200-this.value.length;
  $$('info2').innerHTML=len<0?"已经超过":"还能输入";
  var c=$$('count2');
  c.innerHTML=Math.abs(len);
  c.style.color=len<0?"red":"";
};
fc2.oninput();

function submitZx(){
	var len = form1.depict.value.length;
	var len2 = form1.replycont.value.length;
	if(len>200||len2>200)
		mt.show("最多只能输入200字！！！");
	else
		form1.submit();
}

</script>

</body>
</html>
