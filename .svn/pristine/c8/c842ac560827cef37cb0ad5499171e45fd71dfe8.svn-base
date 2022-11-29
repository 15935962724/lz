<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);

int lmspeople=h.getInt("lmspeople");
LmsPeople t=LmsPeople.find(lmspeople);

if("POST".equals(request.getMethod()))
{
  String act=h.get("act");
  String nexturl=h.get("nexturl");
  if("del".equals(act))
  {
    t.delete();
  }else if("edit".equals(act))
  {
    t.lmsorg=h.getInt("lmsorg");
    t.name=h.get("name");
    t.sex=h.get("sex");
    t.age=h.getInt("age");
    t.nation=h.get("nation");
    t.brithday=h.getDate("brithday");
    t.type=h.getInt("type");
    t.address=h.get("address");
    t.telphone=h.get("telphone");
    t.cellphone=h.get("cellphone");
    t.mail=h.get("mail");
    t.duty=h.get("duty");
    t.remark1=h.get("remark1");
    t.remark2=h.get("remark2");
    t.remark3=h.get("remark3");
    t.remark4=h.get("remark4");
    t.remark5=h.get("remark5");
    t.set();
  }
  out.print("<script>parent.mt.show('数据操作成功！',1,'"+nexturl+"');</script>");
  return;
}

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmspeople" value="<%=lmspeople%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>省助学发展机构</td>
    <td><input name="lmsorg" value="<%=MT.f(t.lmsorg)%>"/></td>
  </tr>
  <tr>
    <td>姓名</td>
    <td><input name="name" value="<%=MT.f(t.name)%>"/></td>
  </tr>
  <tr>
    <td>性别</td>
    <td><input name="sex" value="<%=MT.f(t.sex)%>"/></td>
  </tr>
  <tr>
    <td>年龄</td>
    <td><input name="age" value="<%=MT.f(t.age)%>"/></td>
  </tr>
  <tr>
    <td>民族</td>
    <td><input name="nation" value="<%=MT.f(t.nation)%>"/></td>
  </tr>
  <tr>
    <td>出生日期</td>
    <td><%=h.selects("brithday",t.brithday)%></td>
  </tr>
  <tr>
    <td>类型</td>
    <td><%=h.radios(LmsPeople.TYPE_TYPE,"type",t.type)%></td>
  </tr>
  <tr>
    <td>联系地址</td>
    <td><input name="address" value="<%=MT.f(t.address)%>"/></td>
  </tr>
  <tr>
    <td>办公电话</td>
    <td><input name="telphone" value="<%=MT.f(t.telphone)%>"/></td>
  </tr>
  <tr>
    <td>手机</td>
    <td><input name="cellphone" value="<%=MT.f(t.cellphone)%>"/></td>
  </tr>
  <tr>
    <td>Email</td>
    <td><input name="mail" value="<%=MT.f(t.mail)%>"/></td>
  </tr>
  <tr>
    <td>duty</td>
    <td><input name="duty" value="<%=MT.f(t.duty)%>"/></td>
  </tr>
  <tr>
    <td>remark1</td>
    <td><input name="remark1" value="<%=MT.f(t.remark[1])%>"/></td>
  </tr>
  <tr>
    <td>remark2</td>
    <td><input name="remark2" value="<%=MT.f(t.remark[2])%>"/></td>
  </tr>
  <tr>
    <td>remark3</td>
    <td><input name="remark3" value="<%=MT.f(t.remark[3])%>"/></td>
  </tr>
  <tr>
    <td>remark4</td>
    <td><input name="remark4" value="<%=MT.f(t.remark[4])%>"/></td>
  </tr>
  <tr>
    <td>remark5</td>
    <td><input name="remark5" value="<%=MT.f(t.remark[5])%>"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
