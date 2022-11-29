<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.trust.TrustProduct"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
    #cur{color: red}
    </style>
<%
Http h=new Http(request);
int pos=h.getInt("pos", 0);
int size=14;
StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
par.append("?pos=");

int field=h.getInt("field", 0);
if(field>0){
	sql.append(" and field="+field);
	par.append("&field="+field);
}
int distribution=h.getInt("distribution", 0);
if(distribution>0){
	sql.append(" and distribution="+distribution);
	par.append("&distribution="+distribution);
}
int investmentWay=h.getInt("investmentWay", 0);
if(investmentWay>0){
	sql.append(" and investmentWay="+investmentWay);
	par.append("&investmentWay="+investmentWay);
}
int incometype=h.getInt("incometype", 0);
String income=h.get("income", "");
if(income.length()>0){
	String temp[]=income.split("-");
	int income1=Integer.valueOf(temp[0]);
	int income2=Integer.valueOf(temp[1]);
	if(incometype==1){
		sql.append(" and (tp.income2>"+income1+" and tp.income1<"+income2+")");
	}else{
		sql.append(" and (tp.income2>="+income1+" and tp.income1<="+income2+")");
	}
	par.append("&income="+income);
	par.append("&incometype="+incometype);
}
String timeLimit=h.get("timeLimit", "");
if(timeLimit.length()>0){
	if(timeLimit.indexOf("-")==-1){
	   sql.append(" and timeLimit1="+timeLimit+" and timeLimit2=0");
	}else{
		String temp[]=timeLimit.split("-");
		int timeLimit1=Integer.valueOf(temp[0]);
		int timeLimit2=Integer.valueOf(temp[1]);
		sql.append(" and (tp.timeLimit2>"+timeLimit1+" and tp.timeLimit1<"+timeLimit2+")");
		
	}
	
	par.append("&timeLimit="+timeLimit);
}
sql.append(" AND n.hidden=0 AND n.finished=1 AND n.type=110");
int sum=TrustProduct.count(sql.toString());
%>
<form action="?" method="post" name="form1">
<input type="hidden" name="income" value="<%=income%>">
<input type="hidden" name="incometype" value="<%=incometype%>">
<input type="hidden" name="field" value="<%=field%>">
<input type="hidden" name="investmentWay" value="<%=investmentWay%>">
<input type="hidden" name="distribution" value="<%=distribution%>">
<input type="hidden" name="timeLimit" value="<%=timeLimit%>">
<div class="xtcp">
<table cellpadding="0" cellspacing="0" class="cp">
  <tr><td class="td1">预期年化收益 :</td>
  <td><a href="###" <%=income.equals("")?"id=cur":"" %> onclick="subincome('')">全部</a>
        <a href="###" <%=income.equals("0-8")?"id=cur":"" %> onclick="subincome('0-8','1')">8%以下</a>
        <a href="###" <%=income.equals("8-10")?"id=cur":"" %> onclick="subincome('8-10')">8-10%</a>
        <a href="###" <%=income.equals("10-12")?"id=cur":"" %> onclick="subincome('10-12')">10-12%</a>
        <a href="###" <%=income.equals("12-1000")?"id=cur":"" %> onclick="subincome('12-1000','1')">12以上</a>
   </td>
   <td rowspan="6" class="td2"><input type="button" class="button" onclick="resets()" value="重置"></td>
   </tr>
  <tr><td class="td1">投资期限 :</td><td>
        <a href="###" <%=timeLimit.equals("")?"id=cur":"" %> onclick="subtimeLimit('')">全部</a>
        <a href="###" <%=timeLimit.equals("0-12")?"id=cur":"" %> onclick="subtimeLimit('0-12')">12个月以下</a>
        <a href="###" <%=timeLimit.equals("12")?"id=cur":"" %> onclick="subtimeLimit('12')">12个月</a>
        <a href="###" <%=timeLimit.equals("12-18")?"id=cur":"" %> onclick="subtimeLimit('12-18')">12-18个月</a>
        <a href="###" <%=timeLimit.equals("18")?"id=cur":"" %> onclick="subtimeLimit('18')">18个月</a>
        <a href="###" <%=timeLimit.equals("18-24")?"id=cur":"" %> onclick="subtimeLimit('18-24')">18-24个月</a>
        <a href="###" <%=timeLimit.equals("24")?"id=cur":"" %> onclick="subtimeLimit('24')">24个月</a>
        <a href="###" <%=timeLimit.equals("24-1000")?"id=cur":"" %> onclick="subtimeLimit('24-1000')">24个月以上</a>
  </td></tr>
  <tr><td class="td1">资金投向 :</td><td>
  <a href="###" <%=field==0?"id=cur":"" %> onclick="subfield(0)">全部</a>
  <%
  for(int i=1;i<TrustProduct.FIELD.length;i++){%>
      
      <a href="###" <%=i==field?"id=cur":"" %> onclick="subfield(<%=i%>)"><%=TrustProduct.FIELD[i] %></a>
	 <%
  }
  %>
  </td></tr>
  <tr><td class="td1">收效分配 :</td><td>
  <a href="###" <%=distribution==0?"id=cur":"" %> onclick="subdistribution(0)">全部</a>
  <%
  for(int i=1;i<TrustProduct.DISTRIBUTION.length;i++){%>
      
      <a href="###" <%=i==distribution?"id=cur":"" %> onclick="subdistribution(<%=i%>)"><%=TrustProduct.DISTRIBUTION[i] %></a>
	 <%
  }
  %>
  </td></tr>
  <tr><td class="td1">投资方式 :</td><td>
  <a href="###" <%=investmentWay==0?"id=cur":"" %> onclick="subinvestmentWay(0)">全部</a>
  <%
  for(int i=1;i<TrustProduct.INVESTMENTWAY.length;i++){%>
      
      <a href="###" <%=i==investmentWay?"id=cur":"" %> onclick="subinvestmentWay(<%=i%>)"><%=TrustProduct.INVESTMENTWAY[i] %></a>
	 <%
  }
  %>
  </td></tr>
  <tr><td class="td1">发行机构 :</td></tr>
</table>
</div>
</form>
<script type="text/javascript">
function resets(){
	form1.income.value='';
	form1.field.value='';
	form1.investmentWay.value='';
	form1.distribution.value='';
	form1.timeLimit.value='';
	form1.submit();
}
var subincome=function(income,b){
	form1.incometype.value=b;
	form1.income.value=income;
	form1.submit();
}
var subtimeLimit=function(timeLimit){
	form1.timeLimit.value=timeLimit;
	form1.submit();
}
var subfield=function(field){
	form1.field.value=field;
	form1.submit();
}
var subinvestmentWay=function(investmentWay){
	form1.investmentWay.value=investmentWay;
	form1.submit();
}
var subdistribution=function(distribution){
	form1.distribution.value=distribution;
	form1.submit();
}

</script>
<div class="title">
<h1>信托产品</h1>
<span class="right">点击进入<a href="#" target="_blank">在线预约 >></a></span>
</div>

<table class="con" cellpadding="0" cellspacing="0">
  <tr>
    <th class="th1">产品名称</th>
    <th>发行机构</th>
    <th>发行时间</th>
    <th>产品期限</th>
    <th>投资规模</th>
    <th>投资门槛</th>
    <th>资金投向</th>
    <th>预期年化收益</th>
    <th>状态</th>
  </tr>
<%
if(sum==0){%>
<tr><td colspan="10">暂无记录！</td></tr>
<%	
}else{
	ArrayList list=TrustProduct.find(sql.toString(), pos, size);
	for(int i=0;i<list.size();i++)
	{ 
	  TrustProduct t=(TrustProduct)list.get(i);
      String url="/html/"+h.community+"/trustproduct/"+t.node+"-1.htm";

  %>
  
  
  <tr>
    <td class="td1"><a href="<%=url%>" target="_blank"><%=MT.f(t.name) %></a></td>
    <td><%=MT.f(t.companyName) %></td>
    <td><%=MT.f(t.releaseTime) %></td>
    <td><%=t.timeLimit2>0?t.timeLimit1+"月-"+t.timeLimit2+"月":t.timeLimit1+"月"%></td>
    <td><%=t.sizeOf %>万元</td>
    <td><%=t.threshold %>万元</td>
    <td><%=TrustProduct.FIELD[t.field] %></td>
    <td class="tebie"><%=t.income1+"%至"+t.income2+"%" %></td>
    <td class="td2"><%=TrustProduct.STATE[t.state] %></td>
    
  </tr>

  
   <%
	}
}
%>
</table>
<div class="fy">
	<%if(sum>size)out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size)); %>
</div>