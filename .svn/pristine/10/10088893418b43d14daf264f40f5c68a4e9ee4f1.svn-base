<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.db.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
StringBuffer sql=new StringBuffer(" and member="+DbAdapter.cite(teasession._rv.toString())+" and passpage=1 ");
String sear = request.getParameter("txtSearch");
if(sear!=null&&sear.length()>0)
{
  sql.append(" and node like ").append(DbAdapter.cite("%"+sear+"%")).append(" or node in(select node from picture where name like ").append(DbAdapter.cite("%"+sear+"%")+")");
  param.append("&txtSearch=").append(sear);
}
int pos = 0;
if (request.getParameter("pos") != null&&request.getParameter("pos").length()>0) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
int pageSize = 5;
if (request.getParameter("npgs") != null) {
  pageSize = Integer.parseInt(request.getParameter("npgs"));
}
int count = 0;
count = Baudit.count(teasession._strCommunity,sql.toString());

int countwc = 0;
countwc = Baudit.count(teasession._strCommunity,sql.toString()+" and  property!=0");
%>
<html>
<!-- Stock photography -->
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>净收入</title>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

<style>
.bg8{background:#F0F0F0;font-size:12px;width:95%;}
.bg8 td,.bg8 th{padding:2px 15px;line-height:150%;}
.padleft{line-height:150%;}
#table001{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;width:95%;margin-top:10px;padding:2px;}
#table001 td{line-height:180%;}
.bg7 td{padding:2;}
</style>
</head>

<div id="wai">

<body>

<h1>净收入</h1>

<table width="95%" border="0" cellspacing="0" cellpadding="0" class="bg8">
	<tr>
		<td bgcolor="#F0F0F0" class="padleft">&nbsp;请输入日期范围:</td>
		<td align=right class="padright">
			<table border="0" cellspacing="0" cellpadding="3">
				<tr><form name="DateRange" method="post" action="net-revenue.asp" onSubmit="return CheckDate()">
				    <input type="hidden" name="DR">
					<td>自</td>
					<td><input id="sdate" type="text" value="" name="StartDate" size="10" style="width:75"><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(sdate);" /></td>
					<td>至</td>
					<td><input id="edate" type="text" value="" name="EndDate" size="10"  style="width:75"><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(edate);" /></td>
					<td><select name="Ordering" size="1">
								<option value="1" >日期清除</option>
								<option value="2" >发票的日期</option>
								<option value="3" selected>支付日期</option>
						</select></td>
					<td class="button"><input type="submit" name="DateRangeGo" value="GO" class="button"></td>
				</form>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- if already submitted with Go button (or download button?)-->


<table width="95%" border="0" cellspacing="0" cellpadding="3" style="margin:10px 0;" id="table001">
	<tr valign="top">
		<td class="padleft">净营收总结期间显示（你可以导入到电子表格，例如 MicrosoftExcel中） 。只需选择您需要的信息从右边的列表中，点击'下载' 。</td>
		<td align="right" class="padright">
			<table width="365" border="1" cellspacing="0" cellpadding="0" class="bg7">
				<form name="Exal" action="?">
				<tr>
					<td><input type="checkbox" value="1" name="DateCleared" checked></td>
					<td>日期清除</td>
					<td><input type="checkbox" value="1" name="AgencyRef" checked></td>
					<td nowrap>局裁判&nbsp;</td>
					<td><input type="checkbox" value="1" name="Region" checked></td>
					<td>地址</td>
				</tr>
				<tr>
					<td><input type="checkbox" value="1" name="DateOfInvoice" checked></td>
					<td>发票的日期</td>
					<td><input type="checkbox" value="1" name="Pseudonym" checked></td>
					<td>摄影师</td>
					<td><input type="checkbox" value="1" name="TotalSale" checked></td>
					<td>共计销售</td>
				</tr>
				<tr>
					<td><input type="checkbox" value="1" name="DatePaid" checked></td>
					<td>支付日期</td>
					<td><input type="checkbox" value="1" name="LicenceType" checked></td>
					<td>许可证类型</td>
					<td><input type="checkbox" value="1" name="TotalDeduction" checked></td>
					<td nowrap>共计扣除</td>
				</tr>
				<tr>
					<td><input type="checkbox" value="1" name="AlamyRef" checked></td>
					<td nowrap>B-picture管理</td>
					<td><input type="checkbox" value="1" name="LicenceDetail" checked></td>
					<td>许可证详细</td>
					<td><input type="checkbox" value="1" name="NetDue" checked></td>
					<td>预计净收入</td>
				</tr>
				<tr>
					<td colspan="6" align="right" class="button"><input type="button" name="Download" value="Download" class="button"></td>
				</tr>
				</form>
			</table>
		</td>
	</tr>
</table>
<%@ include file="/jsp/include/Canlendar4.jsp" %>
</body>

<!-- Stock photography -->
</html>
