<%@page import="util.Config"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@ page import="tea.entity.yl.shop.*" %>
<%@ page import="tea.entity.member.Profile" %>
<%

	Http h=new Http(request,response);
	if(h.member<1)
	{
		response.sendRedirect("/servlet/StartLogin?node="+h.node);
		return;
	}

	String act=h.get("act","");
	StringBuffer sql=new StringBuffer(),par=new StringBuffer();

	sql.append(" AND member="+h.member);
	par.append("?member="+h.member);

	int menuid=h.getInt("id");
	int seid=h.getInt("seid");
	if(request.getMethod().equals("POST")){
		if("finish".equals(act)){
			ShopExchanged.find(seid).set("status","1");
		}
	}
	int tab=h.getInt("tab");
	par.append("&tab="+tab);


//按医院查询

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
		sql.append(" AND time>="+DbAdapter.cite(time0));
		par.append("&time0="+time0);
	}
	Date time1=h.getDate("time1");
	if(time1!=null)
	{
		sql.append(" and time<"+DbAdapter.cite(time1));
		par.append("&time1="+time1);
	}

	int puid = h.getInt("puid",-1);
	if(puid!=-1){
		sql.append(" AND puid = "+puid);
		par.append("&puid="+puid);
	}

	String[] TAB={"全部","待退货","已完成","待确认","已拒绝"};
	String[] SQL={""," AND status=0"," AND (status =1 or (status=2 and exchangedstatus!=0))"," AND status=2 and exchangedstatus=0"," AND status=3 "};
	int pos=h.getInt("pos");
	par.append("&pos=");
	int size=5;
	int count=ShopExchanged.count(sql.toString());

%>
<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>-->
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
    <title>我的退货</title>

</head>
<body style=''>

	<div class="body">
		<form name="form1" action="?">
			<input type="hidden" name="tab" value="<%=tab%>"/>
			<div class="order-sea">
				<div class="order-sea-left fl-left">
					<p style="position:relative;">
						<span class="ft14 order-l-span">医院：</span>
						<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style=""/>
						<input id="hospitalsel" class="btn btn-link" style="position:absolute;width:auto;right:-70px;color:#044694;border:none;background:none;top:0px;height:33px;" onclick="layer.open({type: 2,title: '选择医院',shadeClose: true,area: ['98%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="请选择"/>
					</p>
					<p>
						<span class="ft14 order-l-span">厂商：</span>
						<select name='puid' style=""  class="right-box-yy">
							<option value=''>请选择</option>
							<option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
							<option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
							<option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
						</select>
					</p>
					<p>
						<span class="ft14 order-l-span">订单号：</span>
						<input type="text" class="right-box-inp" name="orderId" value="<%=MT.f(orderId)%>" style=""/>
					</p>
					<p>
						<span class="ft14 order-l-span">下单时间：</span>
						<span class="time">
                        <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                        <span style="">~</span>
                        <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    </span>
					</p>
				</div>
				<input type="submit" class="fl-right order-cxb  ft14" value="查询">
			</div>
		</form>

		<form name="form2" action="?" method="post">
			<input type="hidden" name="nexturl"/>
			<input type="hidden" name="act"/>
			<input type="hidden" name="seid"/>
			<input type="hidden" name="orderId"/>
			<input type="hidden" name="id" value="<%=menuid %>"/>
			<div class="order-lx "><%--order-lx order-lx2 改为  order-lx 原先的class 手机端不显示已拒绝Tab--%>
			<%
				out.print("<ul class='right-list-zt'>");
				for(int i=0;i<TAB.length;i++)
				{
					out.print("<li class='ft14 fl-left "+(i==tab?"on":"")+"'><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+ShopExchanged.count(sql.toString()+SQL[i])+")</a></li>");
				}
				out.print("</ul>");
			%>
			</div>

					<%
						sql.append(SQL[tab]);

						int sum=ShopExchanged.count(sql.toString());
						if(sum<1)
						{
							out.print("<div class=\"order-list\"><p class='text-c'>暂无记录!</p></div>");
						}else
						{
							sql.append(" order by time desc");
							ArrayList list = ShopExchanged.find(sql.toString(),pos,size);
							for (int i = 0;i<list.size(); i++) {
								ShopExchanged se = (ShopExchanged) list.get(i);
								ShopProduct sp=ShopProduct.find(se.product_id);
								ProcurementUnit pu = ProcurementUnit.find(sp.puid);
								ShopPackage spage = new ShopPackage(0);
								List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
								ShopOrder so = ShopOrder.findByOrderId(se.orderId);
								ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
								String pname = "";
								if(sp.isExist){
									pname=sp.getAnchor(h.language);
								}else{
									spage = ShopPackage.find(se.product_id);
									pname="[套装]"+MT.f(spage.getPackageName());
									spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
									String [] sarr = spage.getProduct_link_id().split("\\|");
									for(int m=1;m<sarr.length;m++){
										spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
									}
								}

					%>
					<div class="order-list">
						<p class="order-line1 ft14">
							<span class="fl-left order-tit"><%=MT.f(sod.getA_hospital())%></span>
							<span class="fl-right order-zt">
								<%if(se.status==0){out.print("待退货");}
									else if(se.status==1 || (se.status==2 && se.exchangedstatus != 0)){out.print("已完成");}
									else if(se.status==2 && se.exchangedstatus == 0){out.print("待确认");}
									else if(se.status==3){
									out.print("已拒绝");
								}
								%>

							</span>
						</p>
						<ul class="ft14">
							<li>
								<span class="list-spanr3 fl-left">订单编号：</span>
								<span class="list-spanr fl-left"><%=se.orderId %></span>
							</li>
							<li>
								<span class="list-spanr3 fl-left">开票单位：</span>
								<span class="list-spanr fl-left"><%=MT.f(pu.getName()) %></span></li>

							<li>
								<span class="list-spanr3 fl-left">快递单号：</span>
								<span class="list-spanr fl-left"><%=MT.f(se.expressNo) %></span>
							</li>
							<li>
								<span class="list-spanr3 fl-left">商品名称：</span>
								<span class="list-spanr fl-left">
									<%
										if(sp.isExist){
											out.print(pname);
										}else{
											out.println(pname);
											for(int n=0;n<spagePList.size();n++){
												ShopProduct s1 = spagePList.get(n);
												out.println(s1.getAnchor(h.language));
											}
										}
									%>
								</span>
							</li>
							<li>
								<span class="list-spanr3 fl-left">退单类型：</span>
								<span class="list-spanr fl-left"><%=se.type==1?"退货":"换货" %></span>
							</li>
							<%
								if(se.status==0){
									out.println("<li><span class=\"list-spanr3 fl-left\">请求退货量：</span><span class=\"list-spanr fl-left\">"+se.quantity+"</span></li>");
									out.println("<li><span class=\"list-spanr3 fl-left\">实际退货量：</span><span class=\"list-spanr fl-left\"></span></li>");
								}else if(se.status==1){
			 /*  List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id="+Database.cite(se.orderId), 0, 1);
			  ShopOrderData t=new ShopOrderData(0);
			  t=lstorderdata.get(0); */
									out.println("<li><span class=\"list-spanr3 fl-left\">请求退货量：</span><span class=\"list-spanr fl-left\">"+se.quantity+"</span></li>");
									out.println("<li><span class=\"list-spanr3 fl-left\">实际退货量：</span><span class=\"list-spanr fl-left\">"+se.quantity+"</span></li>");
								}else if(se.status==2){
									out.println("<li><span class=\"list-spanr3 fl-left\">请求退货量：</span><span class=\"list-spanr fl-left\">"+se.quantity+"</span></li>");

									out.println("<li><span class=\"list-spanr3 fl-left\">实际退货量：</span><span class=\"list-spanr fl-left\">"+se.exchangednum+"</span></li>");


								}else if(se.status==3){
									out.println("<li><span class=\"list-spanr3 fl-left\">请求退货量：</span><span class=\"list-spanr fl-left\">"+se.quantity+"</span></li>");
								}
							%>

							<li>
								<span class="list-spanr3 fl-left">提交时间：</span>
								<span class="list-spanr fl-left"><%=MT.f(se.time) %></span>
							</li>

						</ul>

						<%
							if(tab==3){
								out.print("<p class=\"order-btnp\"><input type='button' onclick=mt.act('yesexchange',0,'"+se.orderId+"') value='确认退货数量'></p>");
							}
							if(tab==4){
								out.print("<p class=\"order-btnp\"><input type='button' onclick=mt.act('submit_dele','"+se.id+"','"+se.orderId+"') value='取消退货'></p>");
							}
						%>
					</div>
					<%
							}
							if(sum>size)
								out.print("<div id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size)+"</div>");
						}%>

			</div>
		</form>
	</div>


<script>
    sup.hquery();
</script>


<script>
    form2.nexturl.value=location.pathname+location.search;
    mt.act=function(a,id,oid){
        form2.act.value=a;
        form2.seid.value=id;
        if(a=='view'){
            layer.open({type: 2,title: '退货单明细',shadeClose: true,area: ['500px', '400px'],closeBtn:1,content: "/jsp/yl/shop/ShopExchangedDetail.jsp?seid="+id});
            //mt.show("/jsp/yl/shop/ShopExchangedDetail.jsp?seid="+id,1,"退换单明细",410,300);
            return;
        }else if(a=="finish"){
            mt.show("确认完成吗？",2,"form2.submit()");
        }else if(a=='yesexchange'){
            form2.action="/ShopExchangeds.do";
            form2.target="_ajax";
            form2.act.value=a;
            form2.orderId.value=oid;
            form2.submit();
        }else if(a=='submit_dele'){
            form2.action="/ShopExchangeds.do";
            form2.target="_ajax";
            form2.act.value=a;
            form2.orderId.value=oid;
            form2.submit();
		}

    }

    setFreeze(document.getElementsByTagName('TABLE')[1],0,1);

</script>
<script>
    mt.receive=function(v,n,h){
        document.getElementById("hname").value=v;
    };
    mt.fit();
</script>
</body>
</html>
