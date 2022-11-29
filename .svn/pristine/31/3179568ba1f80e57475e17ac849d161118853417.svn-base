<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@page import="java.util.*"%><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int adword = Integer.parseInt(teasession.getParameter("adword"));

Adword obj = Adword.find(adword);

java.util.Date stop=obj.getStoptime();
if(stop==null)
{
	Calendar c=Calendar.getInstance(); 
	c.set(c.YEAR,2010);
	stop=c.getTime();
}

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.budget.focus();">

为广告命名 > 目标客户 > 制作广告 > 选择关键字 > <b>定价</b> > 审核与保存
<div id="head6"><img height="6" src="about:blank"></div>
<br>


<form name="form1" action="/servlet/EditAdword" onsubmit="return submitFloat(this.budget,'无效预算')&&submitFloat(this.bid,'无效出算');">
<input type=hidden name=community value=<%=teasession._strCommunity%> >
<input type=hidden name=adword value=<%=adword%> >
<input type=hidden name=act value=editadwordpricing >
<input type=hidden name=nexturl value="/jsp/adword/EditAdwordConfirm.jsp">

<h2>您希望的平均每天最高费用是多少？</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>控制您的费用。总体而言，在达到每日预算限额时，您的广告就会在当天停止展示。（预算控制着您广告的展示频率，而非其排名。）您可以随时提高或降低预算。:</td>
</tr>
<tr>
  <td>输入您的每日预算： ¥<input name=budget value="<%if(obj.getBudget()!=null)out.print(obj.getBudget());%>" ></td>
</tr>
</table>


<h2>每次用户点击您的广告时，您最高愿意支付多少费用？</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>通过设置广告的最高每次点击费用(CPC)，您可以影响其排名。最高每次点击费用就是用户每次点击您的广告时您愿意支付的最高费用。您可以随时更改最高每次点击费用。</td>
</tr>
<tr>
  <td>默认每次点击费用出价：¥<input name=bid value="<%if(obj.getBid()!=null)out.print(obj.getBid());%>" >（最低金额：¥0.08）</td>
</tr>
</table>

<h2>截止日期</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>过了此日期，广告自动暂停</td>
</tr>
<tr>
  <td>截止日期：<%=new tea.htmlx.TimeSelection("stoptime", stop)%></td>
</tr>
</table>

<h2>要记住三件事：</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>您可以随时改变每次点击费用和预算，或者完全暂停您的帐户。</td>
</tr>
<tr>
  <td>您的预算控制着您的费用。如果您的每日预算是 $5 美元，且每个月按 30 天计算，那么您每月支付的费用决不会超过 $150 美元。</td>
</tr>
<tr>
  <td>选择更具体的关键字来降低费用，例如，用红玫瑰代替花。具体的关键字更有可能带来销售机会。</td>
</tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="form1.nexturl.value='/jsp/adword/EditAdwordKeywords.jsp'" >
<input type="submit" value="<%=r.getString(teasession._nLanguage,"继续")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

