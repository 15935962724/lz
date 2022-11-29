<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
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
	int menuid=h.getInt("id");
	
	String nexturl = request.getRequestURI()+"?community="+h.community+"&id="+menuid;
	
	int pwuid = h.getInt("pwuid");
	PoWakeUpCall pwu = PoWakeUpCall.find(pwuid);
	
	//Resource res=new Resource().add("/tea/resource/Consultant");

%>

<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/script.js" type="text/javascript"></script>

<style>
#tablecenter td table td{border:0}
</style>


<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" method="post" action="/EditWakeUpCall.do" target="_ajax" onSubmit="return mt.check(this);">

<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="pwuid" value="<%=pwuid %>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="member">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">

	<tr >
		<td class="th">交易产品:</td>
		<td class="td01"><input name="product" type="text" value="<%=MT.f(pwu.getProduct()) %>" size="50" alt="交易产品"></td>
	</tr>
	<tr >
		<td class="th">叫醒价位:</td>
		<td class="td01"><input name="wakeupprice" type="text" value="<%= MT.f(pwu.getWakeupprice()) %>" size="50" alt="叫醒价位"></td>
	</tr>
	
	<tr >
		<td class="th">叫醒时间:</td>
		<td class="td01"><input name="wakeuptime" class="date" onClick="mt.date(this,true)" value="<%=MT.f(pwu.getWakeuptime(),1)%>" size="40" readonly alt="叫醒时间" style="background: #f9f9f9 url(/res/Home/structure/list10.png) right center no-repeat;"/></td>
	</tr>
	<tr >
		<td class="th" valign="top" style="line-height:30px">备注:</td>
		<td><textarea name="remark" rows="3" cols="90" style="border-top: 1px #999 solid;padding: 0px 6px;line-height: 30px;font-size: 14px;color: #bababa;border-left: 1px #999 solid;border-bottom: 1px #e5e5e5 solid;border-right: 1px #e5e5e5 solid;background: #f9f9f9;width:661px !important;"><%= MT.f(pwu.getRemark()) %></textarea></td>
	</tr>
	<tr>
    	<td style="width:100%;" colspan="2"><div style="width:100%;border-top:1px #ddd solid;height:1px;float:left;margin-top:4px">&nbsp;</div></td>
    </tr>
	<tr >
		<td class="th">姓名:</td>
		<td class="td01"><input name="name" type="text" value="<%=MT.f(pwu.getName()) %>" size="40" alt="姓名"></td>
	</tr>
	<tr >
		<td class="th">联系方式:</td>
		<td class="td01"><input name="contactway" type="text" value="<%= MT.f(pwu.getContactway()) %>" size="40" alt="联系方式"></td>
	</tr>
	
</table>
<div align="center" style="width:100%;height:43px;margin-top:45px;padding-bottom:76px;border-bottom:1px #ddd dashed;"><input type="submit" value="<%out.print(pwu.getId()>0?"编辑":"申请叫醒服务"); %>" style="font-size:16px;height:43px;width:276px;color:#fff;font-weight:bold;background: url(/res/Home/structure/bg11.gif) center no-repeat;border:none;cursor:pointer;"/></div>
</form>
</head>
<body>
<div class="sqjl">申请记录</div>
<form name="form2" action="/EditWakeUpCall.do" target="" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="sqjl_list">
<table border=0 cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>姓名</td>
  	<td>联系方式</td>
    <td>交易产品</td>
    <td>叫醒价位</td>
    <td>叫醒时间</td>
    
    <td>申请时间</td>
    <td>操作</td>
  </tr>
<%
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?id="+menuid);

sql.append(" AND member=" + h.member);
par.append("&member=" + h.member);

int pos=h.getInt("pos");
par.append("&pos=");

int sum=PoWakeUpCall.count(sql.toString());
if(sum<1){
  out.print("<tr><td colspan='10' align='center'>暂无记录！</td></tr>");
}else{
  sql.append(" order by applyTime desc");
  ArrayList<PoWakeUpCall> al = PoWakeUpCall.find(sql.toString(),pos,20);
  for(int i=0;i<al.size();i++){
	  PoWakeUpCall obj = al.get(i);
    %>
    <tr>
      <td><%=MT.f(obj.getName())%></td>
      <td><%=MT.f(obj.getContactway())%></td>
      <td><%=MT.f(obj.getProduct())%></td>
      <td><%=MT.f(obj.getWakeupprice())%></td>
      <td><%=MT.f(obj.getWakeuptime(),1)%></td>
      
      <td><%=MT.f(obj.getApplyTime(),1)%></td>
      <td>
      	 <a href="javascript:mt.act('edit',<%=obj.getId()%>)">编辑</a>
      	 <a href="javascript:mt.act('del',<%=obj.getId()%>)">删除</a>
      </td>
    </tr>
    <%
  }
  if(sum>20)out.print("<tr><td colspan='10' class='tdpage'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table>
</div>
</form>

<script type="text/javascript">
//form1.nexturl.value=location.pathname+location.search;
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
</script>
</body>
</html>