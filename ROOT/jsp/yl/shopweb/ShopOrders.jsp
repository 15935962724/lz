<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
Profile profile=Profile.find(h.member);
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

/*sql.append(" AND member="+h.member);
par.append("&member="+h.member);*/

    if(profile.membertype==2){//服务商
        sql.append(" AND member="+h.member);
        par.append("&member="+h.member);
    }else if(profile.membertype==0){//签收人
        sql.append(" AND order_id in (select order_id from shoporderdispatch where a_consignees="+DbAdapter.cite(profile.member)+")");
    }else {
		sql.append(" AND member="+h.member);
		par.append("&member="+h.member);
	}


sql.append(" AND status!=6");
par.append("&status!=6");
//按医院查询

sql.append(" AND so.orderType = 0  ");

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and order_id in (select order_id from shoporderdispatch where a_hospital like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}
String orderId=h.get("orderId","");
if(orderId.length()>0)
{
  sql.append(" AND order_Id LIKE "+Database.cite("%"+orderId+"%"));
  par.append("&orderId="+h.enc(orderId));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND createDate>"+DbAdapter.cite(time0));
  par.append("&createDate="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND createDate<"+DbAdapter.cite(time1));
  par.append("&createDate="+MT.f(time1));
}

int puid = h.getInt("puid",-1);
if(puid!=-1){
	sql.append(" AND puid = "+puid);
	  par.append("&puid="+puid);
}


String[] TAB={"全部订单","待付款","待发货","待收货","已完成","已取消","已退货"};
String[] SQL={"  "," AND status=0"," AND (status=1 or status=2 or status=-1 or status=-2 or status=-3 or status=-4 or status=-5)"," AND status=3"," AND status=4"," AND status=5"," AND status = 7"};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(1){
		font-weight: bold;
	}
	.con-left-list .tit-on1{color:#044694;}

</style>
</head>
<body style='min-height:800px;'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<form name="form1" action="?">
		<input type="hidden" name="id" value="<%=menu%>"/>
		<input type="hidden" name="tab" value="<%=tab%>"/>
		<div class="con-right-box">
			<div class="right-line1">
				<p>
					<span>医　　院：</span>
					<span style="width:335px;display: inline-block">
						<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style="width:252px;"/>
						<input id="hospitalsel" class="right-search" style="border: 1px solid #dadada;float: none;margin: 0px;height: 32px;background: #ececec;color: #333;
						line-height: 31px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,offset:'100px',area: ['60%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
					</span>

					<span class="right-box-tit">订单编号：</span>
					<input type="text" class="right-box-inp" name="orderId" value="<%=MT.f(orderId)%>"/>
				</p>
				<p>
					<span>订单时间：</span>
					<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
					<span style="padding:0 8px">至</span>
					<input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
					<span class="right-box-tit" style="margin-left:19px;">开票单位：</span>
					<select name='puid' style="width:342px;"  class="right-box-yy">
						<option value=''>请选择</option>
						<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
						<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
						<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
					</select>
				</p>
			</div>
			<input type="submit" class="right-search" value="查询">
		</div>
		</form>
		<div class="right-list">
				<%out.print("<ul class='right-list-zt'>");
					for(int i=0;i<TAB.length;i++)
					{
					  out.print("<li><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+ShopOrder.count(sql.toString()+SQL[i])+")</a></li>");
					}
					out.print("</ul>");
				%>
			<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
			<input type="hidden" name="orderId"/>
			<input type="hidden" name="status"/>
			<input type="hidden" name="cancelReason"/>
			<input type="hidden" name="tab" value="<%=tab%>"/>
			<input type="hidden" name="nexturl"/>
			<input type="hidden" name="act"/>
			<table class="right-tab" border="1" cellspacing="0">
				<tr>

					<th>序号</th>
					<th>订单编号</th>
					<!-- <td>用户</td> -->
					<th>医院</th>
					<th>数量</th>
					<th>已开票数量</th>
					<th>未开票数量</th>
					<th>下单时间</th>
					<th>开票单位</th>
					<%if(tab==0){%><th>状态</th><%}%>
					<th>操作</th>
				</tr>
				<%
					sql.append(SQL[tab]);

					int sum=ShopOrder.count(sql.toString());
					if(sum<1)
					{
						out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
					}else
					{
						//sql.append(" order by createDate desc");
						Iterator it=ShopOrder.find(sql.toString()+" order by createDate desc ",pos,20).iterator();
						for(int i=1+pos;it.hasNext();i++)
						{
							ShopOrder t=(ShopOrder)it.next();

							ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(t.getOrderId());

							String querySql = " AND order_id="+DbAdapter.cite(t.getOrderId());
							List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
							ShopOrderData odata=null;
							if(sodList.size()>0){

								//Filex.logs("yt.txt",t.getOrderId());
								odata=sodList.get(0);
							}





							String uname = MT.f(Profile.find(t.getMember()).member);
							int status = t.getStatus();
							String statusContent = "";
							if(status==0)
								statusContent = "待付款";
							else if(status==1||status==2||status==-1||status==-2||status==-3||status==-4||status==-5)
								statusContent = "待发货";
							else if(status==3)
								statusContent = "待收货";
							else if(status==4)
								statusContent = "已完成";
							else if(status==5)
								statusContent = "已取消";
							else if(status==7)
								statusContent = "已退货";
				%>
				<tr>
					<td><%=i%></td>
					<td class="orderId"><%=t.getOrderId()%></td>
					<%-- <td><%=uname%></td> --%>
					<td><%=MT.f(sod.getA_hospital()) %></td>
					<td>
						<%
							if(sodList.size()>0){
								out.print(odata.getQuantity());
							}
						%>

					</td>
					<td><%=t.getIsinvoicenum() %></td>
					<td><%=odata.getQuantity()-t.getIsinvoicenum() %></td>
					<td><%=MT.f(t.getCreateDate(),1)%></td>
					<td><%= ProcurementUnit.findName(t.getPuid()) %></td>
					<%if(tab==0){%><td><%=statusContent%></td><%}%>
					<td>
						<%
							/* if(Profile.find(h.member).membertype!=2){
                                if(status>0){
                                    if(t.getInvoiceStatus()==0){
                                    out.println("<a href=\"javascript:mt.act('getfp','"+t.getOrderId()+"');\">索要发票</a>");
                                    }
                                }
                            }else{
                               if(t.getInvoiceStatus()==0){
                                out.println("<a href=\"javascript:mt.act('getfp','"+t.getOrderId()+"');\">索要发票</a>");
                                 }
                            } */
							//2017.1.12加 小屈说有一票PO1611020010的订单用户下单后，订单状态是已完成的了，这时他办理了退货，但是在用户的个人中心还能看到“索要发票”。（yt改为已退换货的订单不能再索要发票了）
							List<ShopExchanged> exchangelst=ShopExchanged.find(" and order_id="+Database.cite(t.getOrderId()), 0, Integer.MAX_VALUE);
							if(exchangelst.size()==0){
								if(status!=5&&t.getInvoiceStatus()==0){
									if(Profile.find(h.member).membertype!=2){
										if(status>0){
											//out.println("<a href=\"javascript:mt.act('getfp','"+MT.enc(t.getOrderId())+"');\">索要发票</a>");
										}
									}else{
										//out.println("<a href=\"javascript:mt.act('getfp','"+MT.enc(t.getOrderId())+"');\">索要发票</a>");
									}
								}
							}
   	 /*
    	if(status==0){
			int count = ShopOrderData.count(" AND order_id = "+Database.cite(t.getOrderId())+" AND sp.state <> 0");
			if(count==0){
	    		out.println("<a href=\"javascript:mt.act('payment','"+MT.enc(t.getOrderId())+"');\">付款</a>");
			}
    	}
    	*/
							out.println("<a href=\"javascript:mt.act('data','"+MT.enc(t.getOrderId())+"');\">查看</a>");

							if(status==0)
								out.println("<a href=\"javascript:mt.act('status','"+t.getOrderId()+"',5,'取消订单');\" >取消订单</a>");
							if(status==3){
    		/*
    		暂时放开-2016-02-15*/
    		/*
    		服务商不能确认收货 2017-5-15日，小屈通知改回来
    		*/
								Profile m=Profile.find(h.member);
								if(m.membertype!=1) //签收人也可以打印
									out.println("<a href=\"javascript:mt.act('printOrder','"+t.getOrderId()+"');\">打印发货单</a>");
								//if(m.membertype != 2) //服务器，不允许确认收货，只能通过签收人微信扫码
								//out.println("<a href=\"javascript:mt.act('status','"+t.getOrderId()+"',4,'确认收货');\">确认收货</a>");
								if(ShopHospital.find(sod.getA_hospital_id()).getIssign()==0){//20天未签收设置 否 （可以在出库状态下申请退货）
									out.println("<a href=\"javascript:mt.act('refund','" + MT.enc(t.getOrderId()) + "');\">申请退货</a>");
								}
							}
							//if(status==4||status==5)
							//	out.println("|<a href=\"javascript:mt.act('status','"+t.getOrderId()+"',6,'删除订单');\">删除</a>");
							if(status==4){
								ShopExchanged ex=ShopExchanged.findByOrderId(t.getOrderId());
								if(ex.id>0&&profile.membertype==2){
									out.println("<a href=\"javascript:mt.act('refund','"+MT.enc(t.getOrderId())+"');\">查看退货</a>");

								}else{
								    if(profile.membertype==2) {
										out.println("<a href=\"javascript:mt.act('refund','" + MT.enc(t.getOrderId()) + "');\">申请退货</a>");
									}

								}
								Profile m=Profile.find(h.member);
								if(m.membertype==2||m.membertype==0){
									out.println("<a href=\"javascript:mt.act('printOrder','"+t.getOrderId()+"');\">打印发货单</a>");
								}
							}

						%>

					</td>
				</tr>
				<%}
					if(sum>20)out.print("<tr><td colspan='10' id='ggpage' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
				}%>
			</table>

			<%
				Profile pro = Profile.find(h.member);
				if(pro.getMembertype() == 2){
					sql.append(" AND isLzCategory=1");
			%>
			<div class='center text-c pd20'><button class="btn btn-primary btn-blue" type="button" onclick="dcorder()">导出</button></div>
			<%} %>
			</form>
			<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
				<input name="act" value="exp_sh" type="hidden" />
				<input name="exflag" value="0" type="hidden"/>
				<input type='hidden' name='category' value="14102669">
				<input type='hidden' name="sql" value="<%= sql.toString() %>" />
			</form>
		</div>
	</div>
</div>


<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,orderId,status,statusContent)
{
  form2.act.value=a;
  form2.orderId.value=orderId;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='status')
  {
	  form2.status.value=status;
	  if(status==5){
          layer.prompt({title: '取消订单原因', formType: 2}, function (pass, index) {
              if(pass==""){
                  layer.alert("“取消订单原因”不能为空！");
			  }else{
                  form2.cancelReason.value=t.value;
                  form2.submit();
			  }
              layer.close(index);
          });

	  }else{
	  	mt.show('你确定要"'+statusContent+'"吗？',2,'form2.submit()');
	  }
  }else if(a=='data')
  {
	  //window.open("ShopOrderDatas.jsp?orderId="+orderId);
	  location.href="/jsp/yl/shopweb/ShopOrderDatas.jsp?orderId="+orderId;

  }else if(a=='payment')
  {
	  //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
	  window.open("/html/folder/14110391-1.htm?orderId="+orderId);
  }else if(a=='refund')
  {
	  //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
	  location.href="/jsp/yl/shopweb/ShopOrderDatasRefund.jsp?orderId="+orderId;
  }else if(a=='getfp'){
	  //parent.location="/jsp/yl/shopweb/ShopGetFp.jsp?orderId="+orderId;
      parent.location="/html/folder/14113269-1.htm?orderId="+orderId;
  }else if(a=='printOrder'){
	  /* form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt.jsp");
	  form2.target='_self';form2.method='get';form2.submit(); */
	 // parent.location="/jsp/yl/shop/ShopOrderDatasReceipt.jsp";
	 location.href="/jsp/yl/shop/ShopOrderDatasReceipt.jsp?orderId="+orderId;
  }
};
function dcorder(){
	form3.submit();
}
mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};
mt.fit();
</script>
</body>
</html>
