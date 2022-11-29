<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
	if(h.member<1){
		String param = request.getQueryString();
		String url = request.getRequestURI();
		if(param != null)
			url = url + "?" + param;
		response.sendRedirect("" +
				"/mobjsp/yl/user/login_mobile.html?nexturl="+Http.enc(url));
		return;
	}
System.out.println(h.member);

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&id="+menu);

 sql.append(" AND member="+h.member);
par.append("&member="+h.member);
sql.append(" AND applyUnit=0");
//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospital like "+Database.cite("%"+hname+"%"));
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
String[] SQL={""," AND (status = 0 or status=1)  "," AND status = 2 "," AND status = 3 "," AND status= 4 "," AND status = 5 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");

int size=5;

%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
<title>发票管理</title>
</head>
<body style=''>

<div class="body">
	<div class="invoice">
		<input type="button" onclick="location.href='/mobjsp/yl/shopweb/AskInvoice.jsp'" value="申请发票" class="invoice-btn ft16">
	</div>
	<div class="order-sea">
		<form name="form1" action="?">
			<input type="hidden" name="id" value="<%=menu%>"/>
			<input type="hidden" name="tab" value="<%=tab%>"/>
			<div class="order-sea-left fl-left">
				<p style="position:relative;">
					<span class="ft14 order-l-span">医院：</span>
					<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style=""/>
					<input id="hospitalsel" class="btn btn-link" style="position:absolute;width:auto;right:-70px;color:#044694;border:none;background:none;top:0px;height:33px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,area: ['95%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
				</p>

				<p>
					<span class="ft14 order-l-span">开票单位：</span>
					<select name='puid' style=""  class="right-box-yy">
						<option value=''>请选择</option>
						<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
						<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
						<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
					</select>
				</p>
				<p>
					<span class="ft14 order-l-span">索票时间：</span>
					<span class="time">
                        <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                        <span style="">~</span>
                        <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    </span>
				</p>
			</div>
			<input type="submit" class="fl-right order-cxb order-cxb2 ft14" value="查询">

		</form>

	</div>
	<div class="order-lx">
		<%out.print("<ul>");
			for(int i=0;i<TAB.length;i++)
			{
				out.print("<li class='ft14 fl-left "+(i==tab?"on":"")+"'><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+Invoice.count(sql.toString()+SQL[i])+")</a></li>");
			}
			out.print("</ul>");
		%>
	</div>




		<%
			sql.append(SQL[tab]);
			System.out.println(sql.toString());
			int sum=Invoice.count(sql.toString());
			if(sum<1)
			{
				out.print("<div class='order-list'><p class='text-c'>暂无记录!</p></div>");
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
	<div class="order-list">
		<p class="order-line1 ft14">
			<span class="fl-left order-tit"><%=MT.f(invoice.getHospital()) %></span>
			<span class="fl-right order-zt"><%=statuscontent %></span>
		</p>
		<ul class="ft14">
			<li>
				<span class="list-spanr3 fl-left">发票号：</span>
				<span class="list-spanr fl-left"><%=MT.f(invoice.getInvoiceno()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">厂商：</span>
				<span class="list-spanr fl-left"><%= ProcurementUnit.findName(invoice.getPuid()) %></span></li>
			<li>
				<span class="list-spanr3 fl-left">开票单位：</span>
				<span class="list-spanr fl-left" ><%= ProcurementUnit.findName(invoice.getPuid()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">索票时间：</span>
				<span class="list-spanr fl-left"><%=MT.f(invoice.getCreatedate(),1) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">申请开票数量：</span>
				<span class="list-spanr fl-left"><%=invoice.getNum() %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">申请开票金额：</span>
				<span class="list-spanr fl-left"><%=invoice.getAmount() %></span>
			</li>
		</ul>
		<p class="order-btnp">
			<a class="btn" href="javascript:mt.act('data','<%=invoice.getId()%>');">查看</a>&nbsp;&nbsp;
			<%
				if(invoice.getStatus()==3){
			%>
			<a class="btn" href="javascript:mt.show('<%=MT.f(invoice.getReason()) %>')">查看拒绝原因</a>
			<%
				}
				if(invoice.getStatus()==2){
			%>
			<a class="btn" href="javascript:mt.act('back','<%=invoice.getId() %>')">申请退票</a>
			<%
				}
			%>
		</p>
	</div>

		<%
				}
				if(sum>5)out.print("<div id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,5)+"</div>");
			}%>



</div>


<script>
mt.act=function(a,invoiceid)
{
  
  if(a=='data')
  {
	  
	  //window.open("InvoiceDatas.jsp?invoiceid="+invoiceid);
	  //location.href="/mobjsp/yl/shopweb/InvoiceDatas.jsp?invoiceid="+invoiceid+"&nexturl=/jsp/yl/shopwebnew/ListInvoice.jsp"+location.search;
	  location.href="/mobjsp/yl/shopwebnew/InvoiceDatas_wx.jsp?invoiceid="+invoiceid+"&nexturl=/jsp/yl/shopwebnew/ListInvoice.jsp";

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
					        	//location.href="/jsp/yl/shopwebnew/InvoiceBack.jsp?invoiceid="+invoiceid+"&nexturl=/jsp/yl/shopwebnew/ListInvoice.jsp"+location.search;
								location.href="/mobjsp/yl/shopwebnew/InvoiceBack_wx.jsp?invoiceid="+invoiceid+"&nexturl=/mobjsp/yl/shopweb/ListInvoice.jsp"+location.search;
					        }
					    });
	  

  }
};
mt.receive=function(v,n,h){
	document.getElementById("hname").value=v;
	};
mt.fit();
</script>
</body>
</html>
