<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@page import="java.util.Date"%>
<%@page import="tea.db.DbAdapter"%>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.pm.PoWakeUpCall"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.Attch"%>
<%
	Http h=new Http(request); 
	if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	}
	/*
	if(h.isIllegal())
	{
	  response.sendError(404,request.getRequestURI());
	  return;
	}
	*/
	StringBuffer sql=new StringBuffer(),par=new StringBuffer();
	
	int menuid=h.getInt("id");
	par.append("?id="+menuid);
	
	String product=h.get("product","");
	if(product.length()>0)
	{
	  sql.append(" AND product LIKE "+DbAdapter.cite("%"+product+"%"));
	  par.append("&product="+h.enc(product));
	}
	
	Double wakeupprice0=h.getDouble("wakeupprice0");
	if(wakeupprice0>0)
	{
	  sql.append(" AND wakeupprice>="+wakeupprice0);
	  par.append("&wakeupprice0="+wakeupprice0);
	}
	
	Double wakeupprice1=h.getDouble("wakeupprice1");
	if(wakeupprice1>0)
	{
	  sql.append(" AND wakeupprice<="+wakeupprice1);
	  par.append("&wakeupprice1="+wakeupprice1);
	}
	
	Date wakeuptime0=h.getDate("wakeuptime0");
	if(wakeuptime0!=null)
	{
	  sql.append(" AND wakeuptime>"+DbAdapter.cite(wakeuptime0));
	  par.append("&wakeuptime0="+MT.f(wakeuptime0));
	}

	Date wakeuptime1=h.getDate("wakeuptime1");
	if(wakeuptime1!=null)
	{
	  sql.append(" AND wakeuptime<"+DbAdapter.cite(wakeuptime1));
	  par.append("&wakeuptime1="+MT.f(wakeuptime1));
	}
	
	String name=h.get("name","");
	if(name.length()>0)
	{
	  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
	  par.append("&name="+h.enc(name));
	}
	
	String contactway=h.get("contactway","");
	if(contactway.length()>0)
	{
	  sql.append(" AND contactway LIKE "+DbAdapter.cite("%"+contactway+"%"));
	  par.append("&contactway="+h.enc(contactway));
	}
	
	Date applyTime0=h.getDate("applyTime0");
	if(applyTime0!=null)
	{
	  sql.append(" AND applyTime>"+DbAdapter.cite(applyTime0));
	  par.append("&applyTime0="+MT.f(applyTime0));
	}

	Date applyTime1=h.getDate("applyTime1");
	if(applyTime1!=null)
	{
	  sql.append(" AND applyTime<"+DbAdapter.cite(applyTime1));
	  par.append("&applyTime1="+MT.f(applyTime1));
	}
	
	int pos=h.getInt("pos");
	par.append("&pos=");
	
	int sum=PoWakeUpCall.count(sql.toString());
%>
<html>
<head>
<title>叫醒服务</title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/script.js" type="text/javascript"></script>
<style>
#tablecenter td table td{border:0}
</style>
</head>
<body>
<h1>叫醒服务</h1>
<div id="head6"><img height="6" src="about:blank"></div><!-- onSubmit="if(mt.check(this)){mt.show(null,0);mt.usubmit(this);}return false;" -->
<h2>查询</h2>
<form name="form1" action="?" >

<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">

    <tr >
		<td class="th">交易产品:</td>
		<td><input type="text" name="product" value="<%=product%>"></td>
		<td class="th">叫醒价位:</td>
		<td><input type="text" name="wakeupprice0" style="width:50px;" value="<%=wakeupprice0>0?wakeupprice0:""%>" onKeyUp="clearNoNum(this)">-<input type="text" name="wakeupprice1" style="width:50px;" value="<%=wakeupprice1>0?wakeupprice1:""%>" onKeyUp="clearNoNum(this)"></td>
		<td class="th">叫醒时间:</td>
		<td><input name="wakeuptime0" value="<%=MT.f(wakeuptime0)%>" onClick="mt.date(this)" class="date"/>-<input name="wakeuptime1" value="<%=MT.f(wakeuptime1)%>" onClick="mt.date(this)" class="date"/></td>
	</tr>
	<tr >
		<td class="th">姓名:</td>
		<td><input type="text" name="name" value="<%=name%>"></td>
		<td class="th">联系方式:</td>
		<td><input type="text" name="contactway" value="<%=contactway%>"></td>
		<td class="th">申请时间:</td>
		<td><input name="applyTime0" value="<%=MT.f(applyTime0)%>" onClick="mt.date(this)" class="date"/>-<input name="applyTime1" value="<%=MT.f(applyTime1)%>" onClick="mt.date(this)" class="date"/>　<input type="submit" value="查询"/></td>
	</tr>
	
</table>
</form>

<h2>申请记录</h2>
<form name="form2" action="/EditWakeUpCall.do" target="" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table border=0 cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
  	<td>序号</td>
  	<td>交易产品</td>
    <td>叫醒价位</td>
    <td>叫醒时间</td>
    <td>姓名</td>
    <td>联系方式</td>
    <td>申请时间</td>
  </tr>
<%
if(sum<1){
  out.print("<tr><td colspan='10' align='center'>暂无记录！</td></tr>");
}else{
  ArrayList<PoWakeUpCall> al = PoWakeUpCall.find(sql.toString(),pos,20);
  for(int i=0;i<al.size();i++){
	  PoWakeUpCall obj = al.get(i);
    %>
    <tr>
      <td><%=i+1%></td>
      <td><%=MT.f(obj.getProduct())%></td>
      <td><%=MT.f(obj.getWakeupprice())%></td>
      <td><%=MT.f(obj.getWakeuptime(),1)%></td>
      <td><%=MT.f(obj.getName())%></td>
      <td><%=MT.f(obj.getContactway())%></td>
      <td><%=MT.f(obj.getApplyTime(),1)%></td>
    </tr>
    <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table>

</form>

<script type="text/javascript">
form1.nexturl.value=location.pathname+location.search;
mt.act=function(a,t,b){
  	form1.act.value = a;
  	form1.pwuid.value = t;
  	if(a=='edit'){
  		form1.action="?";
    	form1.target=form1.method='';
    	form1.submit();
  	}else if(a == 'del'){
  		mt.show("确认删除？资料也会被删除。",2,"form1.submit()");
	}
};

function clearNoNum(obj)
{
 //先把非数字的都替换掉，除了数字和.
 obj.value = obj.value.replace(/[^\d.]/g,"");
 //必须保证第一个为数字而不是.
 obj.value = obj.value.replace(/^\./g,"");
 //保证只有出现一个.而没有多个.
 obj.value = obj.value.replace(/\.{2,}/g,".");
 //保证.只出现一次，而不能出现两次以上
 obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}
</script>
</body>
</html>