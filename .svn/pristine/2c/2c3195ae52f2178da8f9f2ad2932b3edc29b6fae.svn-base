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
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
<title>回款管理</title>
</head>
<body style=''>

<div class="body">
	<form name="form1" action="?">
		<input type="hidden" name="id" value="<%=menu%>"/>
		<input type="hidden" name="tab" value="<%=tab%>"/>
		<div class="order-sea">
			<div class="order-sea-left fl-left">
				<p style="position:relative;">
					<span class="ft14 order-l-span">回款单位：</span>
					<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style=""/>
					<input id="hospitalsel" class="btn btn-link" style="position:absolute;width:auto;right:-70px;color:#044694;border:none;background:none;top:0px;height:33px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,area: ['98%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
				</p>
				<p>
					<span class="ft14 order-l-span">收款单位：</span>
					<select name='puid' style=""  class="right-box-yy">
						<option value=''>请选择</option>
						<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
						<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
						<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
					</select>
				</p>
			</div>
			<input type="submit" class="fl-right order-cxb order-cxb3 ft14" value="查询" style="margin-top:57px;">
		</div>

	</form>
	<div class="order-lx order-lx3">

		<%out.print("<ul class='right-list-zt'>");
			for(int i=0;i<TAB.length;i++)
			{
				out.print("<li class='ft14 fl-left "+(i==tab?"on":"")+"'><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+BackInvoice.count(sql.toString()+SQL[i])+")</a></li>");
			}
			out.print("</ul>");
		%>
	</div>
	<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax">

		<input type="hidden" name="tab" value="<%=tab%>"/>
		<input type="hidden" name="nexturl"/>
		<input type="hidden" name="act"/>
		<input type="hidden" name="backid"/>


				<%
					sql.append(SQL[tab]);

					int sum=BackInvoice.count(sql.toString());
					if(sum<1)
					{
						out.print("<div class=\"order-list\"><p class='text-c'>暂无记录!</p></div>");
					}else
					{
						List<BackInvoice> lst=BackInvoice.find(sql.toString()+" order by createdate desc ",pos,5);
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

				%>
				<div class="order-list">
					<p class="order-line1 ft14">
						<span class="fl-left order-tit"><%=hospital.getName() %></span>
						<span class="fl-right order-zt"><%=BackInvoice.STATUS[t.getStatus()] %></span>
					</p>
					<ul class="ft14">
						<li>
							<span class="fl-left list-spanr5">回款编号：</span>
							<span class="fl-left list-spanr"><%=reply.getCode() %></span>
						</li>
						<li>
							<span class="fl-left list-spanr5">开票单位：</span>
							<span class="fl-left list-spanr"><%= ProcurementUnit.findName(t.getPuid()) %></span>
						</li>
						<li>
							<span class="fl-left list-spanr5">匹配发票号：</span>
							<span class="fl-left list-spanr"><%=invoicestr %></span>
						</li>
						<li>
							<span class="fl-left list-spanr5">匹配金额：</span>
							<span class="fl-left list-spanr"><%=ShopHospital.getDecimal((double)t.getMatchamount()) %></span>
						</li>
						<li>
							<span class="fl-left list-spanr5">挂款金额：</span>
							<span class="fl-left list-spanr"><%=ShopHospital.getDecimal((double)t.getHangamount()) %></span>
						</li>
					</ul>
					<p class="order-btnp">
						<input type="button" class="fl-right" onclick="mt.act('data','<%=t.getId() %>')"  value="查看">
					</p>
				</div>
				<%
							}
						}
						if(sum>5)out.print("<div id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,5)+"</div>");
					}%>

	</form>
</div>

<div id="Content">

	<div class="con-right">


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
	  parent.location="/mobjsp/yl/shopweb/BackInvoiceDatas.jsp?backid="+rid+"&nexturl=/mobjsp/yl/shopweb/ListBackInvoice.jsp"+location.search;

  }
};



	mt.fit();
</script>
</body>
</html>
