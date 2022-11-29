<%@page import="tea.entity.site.Community"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.AdminFunction"%>
<%@page import="tea.entity.yl.shop.ShopExchanged"%>
<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.yl.shop.ShopOrder"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page  import="tea.resource.Resource" %>
<%@page import="tea.entity.yl.shop.ShopAdvisory"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@ page import="util.Config" %>
<%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
if(h.member<1)
{
	response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
Resource r=new Resource("/tea/resource/fun");

Profile pf = Profile.find(h.member);
String pfname = pf.getLastName(h.language)+pf.getFirstName(h.language);
if(pfname==null||pfname.length()<1){
	pfname = MT.f(pf.member);
}
%>
<!doctype html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body id="desktopBody">
<div id="pl">
	<div class='desktopbox'>
		<div class="pfImg"></div>
		<div id='masters'>
			<span><%=pfname %></span>
			<br/>
			<%
			Community ct = Community.find(h.community);
			%>
			<span>欢迎进入<%= MT.f(ct.getName(h.language),50) %>管理系统！</span>
		</div>
	</div>
	<div style="<%= (h.community.equals("Home")?"":"display: none;") %>" id='desktopbot'>
		<div class="wait"><span class="waitImg"></span><span>待办事项</span></div>
		<div id='todo'>
			<ul>
				<%
			    AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);
			    String[] rolearr = aur.role.split("/");
			    for(int i=1;i<rolearr.length;i++){
			    	int role=Integer.parseInt(rolearr[i]);
				    AdminRole ar=AdminRole.find(role);
				    String functions = ar.getAdminfunction();
				    
				    int menu = 14103122;//系统管理-资质审核：已提交资质审核
				    if(functions.indexOf("|"+menu+":")!=-1){
				    	//订单中“未付款”和“未确认收货”的数量
				    	int opersum = 0;
				    	String handleStr = "（0）";
				    	List<ShopQualification> sqlist = ShopQualification.find(" AND p.deleted=0 AND status=1",0,Integer.MAX_VALUE);
				    	if(sqlist!=null&&sqlist.size()>0){
				    		opersum = sqlist.size();
				    		AdminFunction af=AdminFunction.find(menu);
				    		handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+"&state=1"+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+"&state=1"+" >办理</a>";
				    	}				    		
				    	out.print("<li>【资质审核】资质待审&nbsp;&nbsp;"+handleStr+"</li>");
				    }
				    menu = 14110912;//订单管理：确认发货
				    if(functions.indexOf("|"+menu+":")!=-1){
				    	//订单中“未付款”和“未确认收货”的数量
				    	int opersum = 0;
				    	String handleStr = "（0）";
				    	List<ShopOrder> solist = ShopOrder.find(" AND status=1",0,Integer.MAX_VALUE);
				    	if(solist!=null&&solist.size()>0){
				    		opersum = solist.size();
				    		AdminFunction af=AdminFunction.find(menu);
				    		handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+" >办理</a>";
				    	}				    		
				    	out.print("<li>【订单管理】确认发货&nbsp;&nbsp;"+handleStr+"</li>");
				    }
				    
				    menu = 14110911;//订单管理：未付款——确认发货
				    if(functions.indexOf("|"+menu+":")!=-1){
				    	//订单中“未付款”和“未确认收货”的数量
				    	int opersum = 0;
				    	String handleStr = "（0）";
				    	List<ShopOrder> solist = ShopOrder.find(" AND so.status=0 AND m.isvip=1 ",0,Integer.MAX_VALUE);
				    	if(solist!=null&&solist.size()>0){
				    		opersum = solist.size();
				    		AdminFunction af=AdminFunction.find(menu);
				    		handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+" >办理</a>";
				    	}				    		
				    	out.print("<li>【订单管理】未付款-确认发货&nbsp;&nbsp;"+handleStr+"</li>");
				    }
				    
				    /*
				    menu = 14110913;//订单管理：待出库（都显示）
				    if(functions.indexOf("|"+menu+":")!=-1){
				    	//订单中“未付款”和“未确认收货”的数量
				    	int opersum = 0;
				    	String handleStr = "（0）";
				    	List<ShopOrder> solist = ShopOrder.find(" AND status=2 AND isLzCategory !=1",0,Integer.MAX_VALUE);
				    	if(solist!=null&&solist.size()>0){
				    		opersum = solist.size();
				    		AdminFunction af=AdminFunction.find(menu);
				    		handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+" >办理</a>";
				    	}				    		
				    	out.print("<li>【订单管理】出库订单&nbsp;&nbsp;"+handleStr+"</li>");
				    }
				    */
				    menu = 14116166;//订单管理：待出库（上海：只显示订单为粒子的）
				    if(functions.indexOf("|"+menu+":")!=-1){
				    	//订单中“未付款”和“未确认收货”的数量
				    	int opersum = 0;
				    	String handleStr = "（0）";
				    	List<ShopOrder> solist = ShopOrder.find(" and puid=0 and (ishidden=0 or ishidden is null) AND so.status in (2,3,4,-1,-2,-3,-4,-5) AND isLzCategory=1 AND (select count(1) from  ShopOrderdata sd inner join shopproduct sp on sd.product_id = sp.product where  sd.order_id = so.order_id  and sp.puid = "+Config.getInt("xinke")+" ) > 0",0,Integer.MAX_VALUE);
				    	if(solist!=null&&solist.size()>0){
				    		opersum = solist.size();
				    		AdminFunction af=AdminFunction.find(menu);
				    		handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+" >办理</a>";
				    	}				    		
				    	out.print("<li>【订单管理】上海出库订单&nbsp;&nbsp;"+handleStr+"</li>");
				    }

					menu = 19092536;//订单管理：待出库（高科：只显示订单为粒子的）
					if(functions.indexOf("|"+menu+":")!=-1){
						//订单中“未付款”和“未确认收货”的数量
						int opersum = 0;
						String handleStr = "（0）";
						List<ShopOrder> solist = ShopOrder.find(" and puid=0 and (ishidden=0 or ishidden is null) AND so.status in (2,3,4,-1,-2,-3,-4,-5) AND isLzCategory=1 AND (select count(1) from  ShopOrderdata sd inner join shopproduct sp on sd.product_id = sp.product where  sd.order_id = so.order_id  and sp.puid = "+Config.getInt("gaoke")+" ) > 0",0,Integer.MAX_VALUE);
						//List<ShopOrder> solist = ShopOrder.find(" AND status=2 AND isLzCategory=1 AND puid = "+ Config.getInt("gaoke"),0,Integer.MAX_VALUE);
						if(solist!=null&&solist.size()>0){
							opersum = solist.size();
							AdminFunction af=AdminFunction.find(menu);
							handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+" >办理</a>";
						}
						out.print("<li>【订单管理】高科出库订单&nbsp;&nbsp;"+handleStr+"</li>");
					}

					menu = 19092538;//订单管理：待出库（君安：只显示订单为粒子的）
					if(functions.indexOf("|"+menu+":")!=-1){
						//订单中“未付款”和“未确认收货”的数量
						int opersum = 0;
						String handleStr = "（0）";
						List<ShopOrder> solist = ShopOrder.find(" and puid=0 and (ishidden=0 or ishidden is null) AND so.status in (2,3,4,-1,-2,-3,-4,-5) AND isLzCategory=1 AND (select count(1) from  ShopOrderdata sd inner join shopproduct sp on sd.product_id = sp.product where  sd.order_id = so.order_id  and sp.puid = "+Config.getInt("junan")+" ) > 0",0,Integer.MAX_VALUE);
						//List<ShopOrder> solist = ShopOrder.find(" AND status=2 AND isLzCategory=1 AND puid = "+ Config.getInt("junan"),0,Integer.MAX_VALUE);
						if(solist!=null&&solist.size()>0){
							opersum = solist.size();
							AdminFunction af=AdminFunction.find(menu);
							handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+" >办理</a>";
						}
						out.print("<li>【订单管理】君安出库订单&nbsp;&nbsp;"+handleStr+"</li>");
					}

				    menu = 15110709;//订单管理：已出库未签收（粒子）
				    if(functions.indexOf("|"+menu+":")!=-1){
				    	//订单中“未付款”和“未确认收货”的数量
				    	int opersum = 0;
				    	String handleStr = "（0）";
				    	List<ShopOrder> solist = ShopOrder.find(" AND status=3 AND isLzCategory=1",0,Integer.MAX_VALUE);
				    	if(solist!=null&&solist.size()>0){
				    		opersum = solist.size();
				    		AdminFunction af=AdminFunction.find(menu);
				    		handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+" >查看</a>";
				    	}				    		
				    	out.print("<li>【订单管理】已出库未签收（粒子）&nbsp;&nbsp;"+handleStr+"</li>");
				    }
				    
				    menu = 14113036;//发票管理：未开具发票
				    if(functions.indexOf("|"+menu+":")!=-1){
				    	//订单中“未付款”和“未确认收货”的数量
				    	int opersum = 0;
				    	String handleStr = "（0）";
				    	List<ShopOrder> solist = ShopOrder.find(" AND invoiceStatus in (1,2) ",0,Integer.MAX_VALUE);
				    	if(solist!=null&&solist.size()>0){
				    		opersum = solist.size();
				    		AdminFunction af=AdminFunction.find(menu);
				    		handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+"&tab=1"+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+"&tab=1"+" >办理</a>";
				    	}				    		
				    	out.print("<li>【发票管理】未开具发票&nbsp;&nbsp;"+handleStr+"</li>");
				    }
				    
				    menu = 14103130;//客户服务-团换货管理：退换货
				    if(functions.indexOf("|"+menu+":")!=-1){
				    	//订单中“未付款”和“未确认收货”的数量
				    	int opersum = 0;
				    	String handleStr = "（0）";
				    	List<ShopExchanged> selist = ShopExchanged.find(" AND status=0",0,Integer.MAX_VALUE);
				    	if(selist!=null&&selist.size()>0){
				    		opersum = selist.size();
				    		AdminFunction af=AdminFunction.find(menu);
				    		handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+"&tab=1"+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+"&tab=1"+" >办理</a>";
				    	}				    		
				    	out.print("<li>【退换货管理】退换货&nbsp;&nbsp;"+handleStr+"</li>");
				    }
				    menu = 14110134;//客户服务-咨询管理
				    if(functions.indexOf("|"+menu+":")!=-1){
				    	//未回复的咨询
				    	int opersum = 0;
				    	String handleStr = "（0）";
				    	List<ShopAdvisory> sadList = ShopAdvisory.find(" AND isdelete = 0 AND replyMember = 0 ",0,Integer.MAX_VALUE);
				    	
				    	if(sadList!=null&&sadList.size()>0){
				    		opersum = sadList.size();
				    		AdminFunction af=AdminFunction.find(menu);
				    		handleStr = "（<a href=/jsp/admin/right.jsp?id="+af.id+"&tab=1"+" >"+opersum+"</a>）&nbsp;<a href=/jsp/admin/right.jsp?id="+af.id+"&tab=1"+" >办理</a>";
				    	}				    		
				    	out.print("<li>【咨询管理】未回复&nbsp;&nbsp;"+handleStr+"</li>");
				    }
			    }
				%>
			</ul>
			<ul>
				<li>达到未开票粒数预警值的医院：
				<%
					List<Integer> lsthid=ShopHospital.findnoinvoicewarn();
					for(int i=0;i<lsthid.size();i++){
						ShopHospital hospital=ShopHospital.find(lsthid.get(i));
						out.print("<span style='color:red'><a href='/jsp/yl/shop/ShopHospitalsEdit.jsp?id="+hospital.getId()+"&nexturl=/jsp/admin/DefaultDesktop.jsp' >"+hospital.getName()+"</a>&nbsp;</span>");
					}
				%>
				</li>
				<li>达到未开票粒数报警值的医院：
				<%
					List<Integer> lsthid2=ShopHospital.findnoinvoicealarm();
					for(int i=0;i<lsthid2.size();i++){
						ShopHospital hospital=ShopHospital.find(lsthid2.get(i));
						out.print("<span style='color:red'><a href='/jsp/yl/shop/ShopHospitalsEdit.jsp?id="+hospital.getId()+"&nexturl=/jsp/admin/DefaultDesktop.jsp' >"+hospital.getName()+"</a>&nbsp;</span>");
					}
				%>
				</li>
				<li>达到未回款金额预警值的医院：
				<%
					List<Integer> lsthid3=ShopHospital.findnoreplywarn();
					for(int i=0;i<lsthid3.size();i++){
						ShopHospital hospital=ShopHospital.find(lsthid3.get(i));
						out.print("<span style='color:red'><a href='/jsp/yl/shop/ShopHospitalsEdit.jsp?id="+hospital.getId()+"&nexturl=/jsp/admin/DefaultDesktop.jsp' >"+hospital.getName()+"</a>&nbsp;</span>");
					}
				%>
				</li>
				<li>达到未回款金额报警值的医院：
				<%
					List<Integer> lsthid4=ShopHospital.findnoreplyalarm();
					for(int i=0;i<lsthid4.size();i++){
						ShopHospital hospital=ShopHospital.find(lsthid4.get(i));
						out.print("<span style='color:red'><a href='/jsp/yl/shop/ShopHospitalsEdit.jsp?id="+hospital.getId()+"&nexturl=/jsp/admin/DefaultDesktop.jsp' >"+hospital.getName()+"</a>&nbsp;</span>");
					}
				%>
				</li>
			</ul>
		</div>
	</div>
</div>
</body>
</html>



