<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.order.OrderDedail"%>
<%@page import="tea.entity.member.SMSMessage"%>
<%@page import="tea.entity.Seq"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.order.Order"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
Http h=new Http(request);
String act=h.get("act");
System.out.print(request.getMethod());
if("POST".equals(request.getMethod())){
	if("sub".equals(act)){
		String mobile=h.get("phone", "");
		Boolean b= Profile.isMobile(h.community,mobile);
		if(!b){
			String member=String.valueOf(Seq.get());
			Profile.create(member,member,h.community,h.get("email"),request.getServerName());
			String content="欢迎使用中华服务网，您的用户名："+mobile+",密码为"+member;
			//SMSMessage.create(h.community, member, mobile, h.language, content);
			Profile p=Profile.find(member);
			p.setMobile(mobile);
			p.setMembertype(0);
		}
		Order o=new Order(0);
		Date submitTime=new Date();
		  o.setCode("SP"+Order.sdf.format(submitTime)+(new java.util.Random().nextInt(900)+100));
		  o.setSubmitTime(submitTime);
		  o.setCustomer(h.get("name",""));
		  o.setMobile(mobile);
		  o.setReserveTime(h.getDate("time"));
		  o.community=h.get("community");
		  o.setPersonNum(h.getInt("pesonnum"));
		  o.community=h.community;
		  o.set();
		  OrderDedail od=new OrderDedail(0);
		  od.setSaleOrderId(o.getId());
		  od.setSaleOrderCode(o.getCode());
		  od.node=h.getInt("node");
		  od.setGoodsTitle(Node.find(h.getInt("node")).getSubject(h.language));
		  od.set();
		  out.print("<script>mt.show('预约成功,请等待服务人员联系');</script>");
		  return;
	}
}
%>
<script src="/tea/mt.js"></script>
<form action="?" method="post" name="form1" target="_ajax">
<input type="hidden" name="node" value="<%=h.node%>">
<input type="hidden" name="act" value="sub">
<table class="tab">
<tr><td class="td1">电话：</td><td><input type="text" name="phone" class="text"></td></tr>
<tr><td class="td1">时间：</td><td><input type="text" name="time" class="text" onclick="mt.date(this,false,new Date())"></td></tr>
<tr><td class="td1">姓名：</td><td><input type="text" name="name" class="text"></td></tr>
<tr><td class="td1">人数：</td><td><input type="text" name="pesonnum" class="text"></td></tr>

</table>
<p class="p01"><input type="button" value="预约" class="button" onclick=checkmob()></p>
</form>
<script>
function checkmob(){
	var mob=form1.phone.value;
    var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
     if(mob.length==0)
	  {
	    mt.show("请填写手机号码。");
	    return;
	  }else if(!reg.test(mob))
	  {
		  mt.show("手机格式不正确。");
		  return;
	  }
     if(form1.time.value.length==0){
    	 mt.show("请选择时间");
    	 return;
     }
     if(form1.name.value.length==0){
    	 mt.show("请输入您的姓名");
    	 return;
     }
     if(form1.pesonnum.value.length==0){
    	 mt.show("请输入人数");
    	 return;
     }
     form1.submit();
}
</script>