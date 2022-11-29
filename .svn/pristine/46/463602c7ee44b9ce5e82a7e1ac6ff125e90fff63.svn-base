<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

int course=h.getInt("course");
Node n=Node.find(course);
Course t=Course.find(course,h.language);

%>

<form name="form2" action="/Courses.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=course%>"/>
<input type="hidden" name="act" value="planadd2"/>
<input type="hidden" name="nexturl" value="/html/Home/folder/26-1.htm"/>
<div class="cplans">
<div class="pxjltop">在线报名</div>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>培训名称</td>
  <td>培训时间</td>
  <td>培训费用</td>
  <td>支付方式</td>
</tr>
<tr>
  <td><%=n.getAnchor(h.language)%></td>
  <td><%=MT.f(n.getStartTime(),1)%></td>
  <td><%=MT.f(t.price)%></td>
  <td><select name="payment" alt="支付方式"><%=h.options(CoursePlan.PAYMENT_TYPE,0)%></select></td>
</tr>
</table>

<table id="account" cellspacing="0" style="display:none">
<tr>
  <td>开户行：</td>
  <td>中国建设银行</td>
</tr>
<tr>
  <td>开户名：</td>
  <td>中国儿童中心</td>
</tr>
<tr>
  <td>账　号：</td>
  <td>000000000</td>
</tr>
</table>

<br/>
<div class="funBtn"><input type="submit" value="确认报名"/> <input type="button" value="返回" onclick="history.back();"/></div>
</div>
</form>

<script>
form2.payment.onchange=function()
{
  $$('account').style.display=this.value=='2'?'':'none';
};

</script>
