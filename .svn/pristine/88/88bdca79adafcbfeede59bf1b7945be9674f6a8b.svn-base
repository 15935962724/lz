<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&id="+menu);

 sql.append(" AND member="+h.member);
par.append("&member="+h.member);
sql.append(" AND applyUnit=0");
//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	//sql.append(" and hospital like "+Database.cite("%"+hname+"%"));
	sql.append(" and hospital = "+Database.cite(hname));
	par.append("&hname="+h.enc(hname));
}

int puid = h.getInt("puid",-1);
if(puid!=-1){
	sql.append(" AND puid = "+puid);
	  par.append("&puid="+puid);
}

Date time0=h.getDate("time0");
if(time0!=null)
{
	sql.append(" AND createdate>="+DbAdapter.cite(time0));
	par.append("&time0="+time0);
}
Date time1=h.getDate("time1");
if(time1!=null)
{
	sql.append(" and createdate<"+DbAdapter.cite(time1));
	par.append("&time1="+time1);
}


String[] TAB={"全部","未完成开票","已完成开票","审核不通过","退票申请","已退票"};
String[] SQL={""," AND (status = 0 or status=1) "," AND status = 2 "," AND status = 3 "," AND status= 4 "," AND status = 5 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");

int size=20;

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
	.con-left .bd:nth-child(2) li:nth-child(3){
		font-weight: bold;
	}
	.con-left-list .tit-on1{color:#044694;}

</style>

</head>
<body style='min-height:800px'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<div class="con-right-box" style="">
			<form name="form1" action="?">
			<input type="hidden" name="id" value="<%=menu%>"/>
			<input type="hidden" name="tab" value="<%=tab%>"/>
			<div class="right-line1">
				<p style="margin-bottom:10px;">
					<span>医　　院：</span>
					<span style="width:335px;display: inline-block">
						<input type="text" class="right-box-data" name="hname" id="hname" value="<%=hname %>" readonly style="width:252px;"/>
						<input id="hospitalsel" class="right-search" style="border: 1px solid #dadada;float: none;margin: 0px;height: 32px;background: #ececec;color: #333;
						line-height: 31px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,offset:'100px',area: ['60%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
					</span>
					<span class="right-box-tit" style="margin-left:17px;">开票单位：</span>
					<select name='puid' style="width:342px;"  class="right-box-yy">
						<option value=''>请选择</option>
						<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
						<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
						<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
					</select>
				</p>
				<p>
					<span>索票时间：</span>
					<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
					<span style="padding:0 8px">至</span>
					<input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
				</p>

			</div>
			<input type="submit" class="right-search" value="查询" style="">
			</form>
		</div>
		<div class="right-list">
			<%out.print("<ul class='right-list-zt'>");
				for(int i=0;i<TAB.length;i++)
				{
					out.print("<li><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+Invoice.count(sql.toString()+SQL[i])+")</a></li>");
				}
				out.print("<input type=\"button\" onclick=\"location.href='/jsp/yl/shopwebnew/AskInvoice.jsp'\" value=\"申请开票\" class=\"right-fp-inp\"></ul>");
			%>

			<table class="right-tab" border="1" cellspacing="0">
				<tr>
					<th class="td2">序号</th>
					<th class="td3">发票号</th>
					<th class="td4">医院</th>
					<th class="td5">索要发票时间</th>
					<th class="td6">申请开票数量</th>
					<th class="td7">申请开票金额</th>
					<th class="td8">状态</th>
					<th class="td8">开票单位</th>
					<th class="td9">操作</th>
				</tr>
				<%
					sql.append(SQL[tab]);
					int sum=Invoice.count(sql.toString());
					System.out.println(sql.toString());
					if(sum<1)
					{
						out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
					}else
					{
						List<Invoice> lstinvoice=Invoice.find(sql.toString()+" order by createdate desc ", pos, size);
						for(int i=0;i<lstinvoice.size();i++)
						{
							Invoice invoice=lstinvoice.get(i);
							String statuscontent="";
							if(invoice.getStatus()==0||invoice.getStatus()==1){
								statuscontent="未开具";
							}else if(invoice.getStatus()==2){
								statuscontent="已开具";
							}else if(invoice.getStatus()==3){
								statuscontent="审核不通过";
							}else if(invoice.getStatus()==4){
								statuscontent="退票申请中";
							}else if(invoice.getStatus()==5){
								statuscontent="已退票";
							}
				%>
				<tr>

					<td><%=(pos+i+1) %></td>
					<td><%=MT.f(invoice.getInvoiceno()) %></td>
					<td><%=MT.f(invoice.getHospital()) %></td>
					<td><%=MT.f(invoice.getCreatedate(),1) %></td>
					<td><%=invoice.getNum() %></td>
					<td><%=invoice.getAmount() %></td>
					<td><%=statuscontent %></td>
					<td><%= ProcurementUnit.findName(invoice.getPuid()) %></td>
					<td><a href="javascript:mt.act('data','<%=invoice.getId()%>');">查看</a>&nbsp;&nbsp;
						<%
							if(invoice.getStatus()==3){
						%>
						<a href="javascript:mt.show('<%=MT.f(invoice.getReason()) %>')">查看拒绝原因</a>
						<%
							}
							if(invoice.getStatus()==2){
						%>
						<a href="javascript:mt.act('back',<%=invoice.getId() %>)">申请退票</a>
						<%
							}
						%>
					</td>
				</tr>
				<%
						}
						if(sum>20)out.print("<tr class='fenye'><td colspan='11' id='ggpage' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
					}%>
			</table>
			<div class='center text-c pd20'><button class="btn btn-primary btn-blue" type="button" onclick="dcorder()">导出</button></div>
		</div>
	</div>
</div>
<form action="/Invoices.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_invoice_web" type="hidden" />
	<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>

<script>
mt.act=function(a,invoiceid)
{
  
  if(a=='data')
  {
	  
	  //window.open("InvoiceDatas.jsp?invoiceid="+invoiceid);
	  location.href="/jsp/yl/shopwebnew/InvoiceDatas.jsp?invoiceid="+invoiceid+"&nexturl=/jsp/yl/shopwebnew/ListInvoice.jsp"+location.search;

  }else if(a=='back'){
	  //InvoiceBack.jsp
	  mt.send("/Invoices.do?act=iscanback&invoiceid="+invoiceid,function(d)
				{
		 
					        if(d=='1')
					        {
					        	mt.show("该发票已申请回款匹配，不能申请退票！");
					        	return false;
					        }else{
					        	///jsp/yl/shopwebnew/InvoiceBack.jsp
					        	location.href="/jsp/yl/shopwebnew/InvoiceBack.jsp?invoiceid="+invoiceid+"&nexturl=/jsp/yl/shopwebnew/ListInvoice.jsp"+location.search;
					        }
					    });
	  

  }
};
mt.receive=function(v,n,h){
	document.getElementById("hname").value=v;
	};
mt.fit();
function dcorder() {
	form3.submit();
}
</script>
</body>
</html>
