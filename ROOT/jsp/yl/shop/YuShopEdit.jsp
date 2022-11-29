<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int sid=h.getInt("sid");
YuShop t=YuShop.find(sid);

if("POST".equals(request.getMethod()))
{
  String act=h.get("act");
  String nexturl=h.get("nexturl");
  if("del".equals(act))
  {
	int count = Product.count(" AND state <> 2 AND shopid = "+sid);
	if(count==0){
	   t.delete();
	}else{
		out.print("<script>parent.mt.show('该商家下有商品，不能删除！',1,'"+nexturl+"');</script>");
		  return;
	}
  }else if("edit".equals(act))
  {
    if(h.get("logo")!=null){
    	t.slogo=h.get("logo");
    }
    t.sname=h.get("name");
    t.address = h.get("address");
    t.contacts = h.get("contacts");
    t.phone = h.getInt("phone");
    t.scontext=h.get("content");
    t.set();
  }else if("alldel".equals(act))
  {
	String [] selche = h.getValues("selche");
	for(int i=0;i<selche.length;i++){
	YuShop yt=YuShop.find(Integer.parseInt(selche[i]));
		yt.delete();
	}
  }
  out.print("<script>parent.mt.show('数据操作成功！',1,'"+nexturl+"');</script>");
  return;
}

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>商家的创建与编辑</h1>

<form name="form1" action="/jsp/yl/shop/YuShopEdit.jsp" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="sid" value="<%=sid%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>名称</td>
    <td><input name="name" value="<%=MT.f(t.sname)%>" size="40" alt="名称"/></td>
  </tr>
  <tr>
    <td>电话</td>
    <td><input name="phone" value="<%=MT.f(t.phone)%>" size="40" alt="电话"/></td>
  </tr>
  <tr>
    <td>联系人</td>
    <td><input name="contacts" value="<%=MT.f(t.contacts)%>" size="40" alt="联系人"/></td>
  </tr>
  <tr>
    <td>地址</td>
    <td><input name="address" value="<%=MT.f(t.address)%>" size="40" alt="地址"/></td>
  </tr>
  <tr>
    <td>图片</td>
    <td><input type="file" name="logo" /><%if(t.slogo!=null)out.print(" <a href='###' onclick=mt.img('"+t.slogo+"')>查看</a>");%></td>
  </tr>
  <tr>
    <td>简介</td>
    <td><textarea name="content" cols="50" rows="5"><%=MT.f(t.scontext)%></textarea></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>form1.name.focus();</script>

</body>
</html>
