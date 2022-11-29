<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

sql.append(" AND member="+h.member);
par.append("&member="+h.member);

//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospitalid in (select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}

int puid = h.getInt("puid",-1);
if(puid!=-1){
	sql.append(" AND puid = "+puid);
	  par.append("&puid="+puid);
}

String[] TAB={"全部","待审核","已完成","审核不通过"};
String[] SQL={""," AND status = 0 "," AND status = 1 "," AND status = 2 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(4){
		font-weight: bold;
	}

.mt_data td,.mt_data th{padding:3px}

input[type=text]::-ms-clear{
	display: none;
}
	.con-left-list .tit-on1{color:#044694;}

input::-webkit-search-cancel-button{
	display: none;
}  
input.t {
	border:1px solid #fff;
	background:#fff;            
	padding-left:5px; 
	height:30px; 
	line-height:30px ;
	font-size:12px;
	color: #004779;
}
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(4){
		font-weight: bold;
	}
</style>

</head>
<body style='min-height:800px'>

<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<div class="con-right-box con-right-box2">
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
	<div class="right-line1">
		<p>
			<span>回款单位：</span>
			<span style="width:335px;display: inline-block">
				<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style="width:252px;"/>
				<input id="hospitalsel" class="right-search" style="float:none;margin:0px;height:33px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,area: ['60%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
			</span>
			<span class="right-box-tit">开票单位：</span>
			<select name='puid' style="width:342px;"  class="right-box-yy">
				<option value=''>请选择</option>
				<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
				<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
				<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
			</select>
		</p>

	</div>
	<input type="submit" class="right-search right-search2" value="查询">
</form>
		</div>
		<div class="right-list">
<%out.print("<ul class='right-list-zt'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<li><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+BackInvoice.count(sql.toString()+SQL[i])+")</a></li>");
}
out.print("</ul>");
%>
		</div>
<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="backid"/>
<div class="results">
<table class="right-tab" border="1" cellspacing="0" style='table-layout: fixed;'>
<tr id="tableonetr">
  <th class="td2" style='width:50px;'>序号</th>
  <th class="td3" style='width:110px;'>回款编号</th>
  <th class="td4">类型</th>
  <th class="td4">回款单位</th>
  
  <th class="td6">回款金额</th>
  <th class="td7">匹配金额</th>
  <th class="td7">挂款金额</th>
  <th class="td7" style='word-wrap: break-word;width:120px;'>匹配发票号</th>
  <th class="td8">状态</th>
  <th class="td8">开票单位</th>
  <th class="td9">操作</th>
  
</tr>
<%
sql.append(SQL[tab]);

int sum=BackInvoice.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
  List<BackInvoice> lst=BackInvoice.find(sql.toString()+" order by createdate desc ",pos,20);
  for(int i=0;i<lst.size();i++)
  {
	  BackInvoice t=lst.get(i);
	  int hospitalid=t.getHospitalid();//医院
	  ShopHospital hospital=ShopHospital.find(hospitalid);//医院
	  String[] invoiceidarr=t.getInvoiceid().split(",");//匹配发票号
	  String invoicestr="";
	  for(int k=0;k<invoiceidarr.length;k++){
		  if(invoiceidarr[k].length()>0){
			  int in=Integer.parseInt(invoiceidarr[k]);
			  Invoice invoice=Invoice.find(in);
			  if(k==invoiceidarr.length-1){
				  invoicestr+=invoice.getInvoiceno();
			  }else{
				  invoicestr+=invoice.getInvoiceno()+",";
			  }
		  }
		  
		  
	  }
	  
	  String[] replyidarr=t.getReplyid().split(",");//回款id
	  for(int j=0;j<replyidarr.length;j++){
		  int re=Integer.parseInt(replyidarr[j]);
		  ReplyMoney reply=ReplyMoney.find(re);
	      if(j==0){
%>
<tr>
	<td rowspan="<%=replyidarr.length %>"><%=(i+1) %></td>
	<td><%=reply.getCode() %></td>
	<td nowrap=""><%=ReplyMoney.typeARR[reply.getType()] %></td>
	<td rowspan="<%=replyidarr.length %>"><%=hospital.getName() %></td>
	<td><%=ShopHospital.getDecimal((double)reply.getReplyPrice()) %></td>
	
	<td rowspan="<%=replyidarr.length %>"><%=ShopHospital.getDecimal((double)t.getMatchamount()) %></td>
	<td rowspan="<%=replyidarr.length %>"><%=ShopHospital.getDecimal((double)t.getHangamount()) %></td>
	<td style='word-wrap: break-word;' rowspan="<%=replyidarr.length %>"><%=invoicestr %></td>
	<td rowspan="<%=replyidarr.length %>"><%=BackInvoice.STATUS[t.getStatus()] %></td>
	<td rowspan="<%=replyidarr.length %>"><%= ProcurementUnit.findName(t.getPuid()) %></td>
	<td nowrap="" rowspan="<%=replyidarr.length %>"><a href="javascript:mt.act('data','<%=t.getId() %>')">查看</a>&nbsp;&nbsp;</td>
	
</tr>
<%
	      }else{
%>
<tr>
	<td><%=reply.getCode() %></td>
	<td><%=ReplyMoney.typeARR[reply.getType()] %></td>
	<td><%=reply.getReplyPrice() %></td>
</tr>
<%	    	  
	      }
	  }
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right' id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>


</form>
	</div>
</div>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,rid)
{
  form2.act.value=a;
  form2.backid.value=rid;
  if(a=='data')
  {
	  //window.open("BackInvoiceDatas.jsp");
	  location.href="/jsp/yl/shopwebnew/BackInvoiceDatas.jsp?backid="+rid+location.search;

  }
};



	mt.fit();
</script>
</body>
</html>
