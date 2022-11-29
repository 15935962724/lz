<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.db.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.util.*" %>
<%@page import="java.math.BigDecimal" %>
<%
TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

String member = teasession.getParameter("member");
if(member == null){
  member = teasession._rv._strR;
}

StringBuffer sql = new StringBuffer(" and  node in(select node where member="+DbAdapter.cite(member)+") and picsalestype=1");

String sdate = teasession.getParameter("sdate");
String edate = teasession.getParameter("edate");

if(sdate!=null&&edate!=null){
if(sdate.length()>0&&edate.length()>0){
  sql.append(" and picsalesdate >="+DbAdapter.cite(sdate)+" and picsalesdate <='" + edate+" 23:59:59'");
}
}

if(sdate!=null&&edate==null){
if(sdate.length()>0&&edate.length()==0){
  sql.append(" and picsalesdate >="+DbAdapter.cite(sdate));
}
}

if(sdate==null&&edate!=null){
if(edate.length()>0&&sdate.length()==0){
  sql.append(" and picsalesdate <='" + edate+" 23:59:59'");
}
}

BigDecimal salePic = Bimage.countSumMoney(sql.toString());
if(salePic==null){
  salePic = new BigDecimal("0.00");
}
int countSalePic = Bimage.countOrfer(sql.toString());

 BigDecimal averagePic=new BigDecimal("0.00");
if(countSalePic!=0){
 averagePic =salePic.divide(new BigDecimal(countSalePic), 2, BigDecimal.ROUND_UP);
}
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title>销售统计</title>
    <style>
  #table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:6px;}
  </style>
  </head>

<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;销售统计</div>
<h1>销售统计</h1>
<form action="?">
<input type="hidden" name="id" value="<%=teasession.getParameter("id")%>"/>
<table border="0" cellpadding="0" cellspacing="2" id="table005" >
<tr>
  <td nowrap="nowrap" width="100">开始时间</td>
  <td width="15%"><input id="sdate" type="text" size="28" name="sdate" value="<%if(sdate!=null)out.print(sdate);%>" readonly="readonly" /><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(sdate);" /></td>
  <td nowrap="nowrap" width="100">结束时间</td>
  <td><input id="edate" type="text" size="28" name="edate" value="<%if(edate!=null)out.print(edate);%>" readonly="readonly"/><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(edate);" />
    <input type="submit" value="查询"/>　<%if(teasession.getParameter("forword")!=null){%><input type="button" value="返回" onclick="history.go(-1);"/><%}%></td>
</tr>
  <tr>
  <td nowrap="nowrap" colspan="4">供应商&nbsp;&nbsp;<b><%=tea.entity.member.Profile.find(member).getFirstName(teasession._nLanguage)%></b>&nbsp;&nbsp;的销售统计</td>
  </tr>
  <tr>
  <td nowrap="nowrap">销售额</td>
  <td colspan="3"><%=salePic%></td>
  </tr>
  <tr>
  <td nowrap="nowrap">销售数量</td>
  <td colspan="3"><%=countSalePic%></td>
  </tr>
  <tr>
  <td nowrap="nowrap">均价</td>
  <td colspan="3"><%=averagePic%></td>
  </tr>

</table>
</form>
<br/>
<a href="#" onclick="infoShow();">显示图片销售信息</a>
<div id="picInfo" style="display:none;">
<table border="0" cellpadding="0" cellspacing="2" id="table005" >
<tr>
<td nowrap="nowrap" width="100">图片编号</td><td nowrap="nowrap" width="100">销售日期</td><td nowrap="nowrap" width="100">销售额</td><td nowrap="nowrap">小样图</td>
</tr>
<%

Enumeration e = Bimage.findByCommunity(teasession._strCommunity,sql.toString(),0,10);
while(e.hasMoreElements()){
int id = ((Integer)e.nextElement()).intValue();
Bimage b = Bimage.find(id);

String picpath = "/res/"+teasession._strCommunity+"/picture/small/"+b.getNode()+".jpg";
%>
<tr>
  <td><%=b.getNode()%></td><td><%=b.getPicsalesdateToString()%></td><td><%=b.getPicprice()%></td><td><img alt="" src="<%=picpath%>" /></td>
</tr>
<%}%>
</table>
</div>
</div>
<script type="">
function infoShow(){
if(document.getElementById('picInfo').style.display==''){
  document.getElementById('picInfo').style.display='none';
}else{
  document.getElementById('picInfo').style.display='';
}
}
</script>
 <%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>
