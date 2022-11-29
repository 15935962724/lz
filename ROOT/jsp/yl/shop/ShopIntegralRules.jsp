<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.yl.shop.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
/*
String act=h.get("act");
if("action".equals(act))
{
  out.print("oper");
  return;
}*/
StringBuffer sql=new StringBuffer(),par=new StringBuffer();


int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);
/*
String name = h.get("name");
if(!"".equals(name) && name != null){
	sql.append(" AND name like'%" + name + "%'");
	par.append("&name="+name);
}
*/
int pos=h.getInt("pos");
par.append("&pos=");

int sum=ShopIntegralRules.count(sql.toString());
String acts=h.get("acts","");

//ArrayList list = ShopIntegralRules.find("",0,Integer.MAX_VALUE);
//ShopIntegralRules sir = ShopIntegralRules.find(0);
//if(list.size()>0){
//	sir = (ShopIntegralRules)list.get(0);
//}
%>
<!DOCTYPE html>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>

</head>
<body>
<h1>我的积分</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<script>
sup.hquery();
</script>

<form name="form2" action="/ShopIntegralRules.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act" value="alledit"/>

<div class='radiusBox'>
<table id="" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='2'>积分规则如下：</td></tr>
</thead>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;width:150px'>项目赠送</td>
		<td>赠送积分</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>会员注册</td><!-- item 1 -->
		<%
			ShopIntegralRules sir = ShopIntegralRules.findByItem(1);
		%>
		<td><input type="text" name="integral1" value="<%=sir.getIntegral() %>" /></td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>会员资质审核通过</td><!-- item 2 -->
		<%
			sir = ShopIntegralRules.findByItem(2);
		%>
		<td><input type="text" name="integral2" value="<%=sir.getIntegral() %>" /></td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>购买粒子积分</td><!-- item 0 -->
		<%
			sir = ShopIntegralRules.findByItem(0);
		%>
		<td><input type="text" name="integral0" value="<%=sir.getIntegral() %>" /> 购买粒子订单金额：积分，如：2，标示2元赠送1积分</td>
	</tr>
	
	
</table>
</div>
<div class='mt15'><input type="submit" value="提交" class='btn btn-primary' /></div>
<br/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.id.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='';
    else if(a=='edit')
      form2.action='/jsp/yl/shop/ShopHospitalsEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
