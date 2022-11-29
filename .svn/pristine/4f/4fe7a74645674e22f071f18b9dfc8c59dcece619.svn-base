<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);

String community = h.get("community","");
if(community.equals("")){
community = h.getCook("community", "Home");
}
h.setCook("community", community, Integer.MAX_VALUE);


    String openid=h.getCook("openid",null);
	if(openid==null){
		response.sendRedirect("/PhoneProjectReport.do?act=openid&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()+"&r="+Math.random()));
		return;
	}
	
	List<Profile> lstp= Profile.find1(" and openid="+DbAdapter.cite(openid), 0, 1);
	if(lstp.size()==0){
		String param = request.getQueryString();
		String url = request.getRequestURI();
		if(param != null)
			url = url + "?" + param;
		response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
		return;
	}
	Profile p1=lstp.get(0);
	if(p1.profile>0){
		h.member=p1.profile;
		session.setAttribute("member",h.member);
		//out.print("<script>alert('a:"+h.member+"');</script>");
		
	}
	
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

sql.append(" AND member="+h.member);
par.append("&member="+h.member);
//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospital like "+Database.cite("%"+hname+"%"));
	par.append("&hname="+h.enc(hname));
}


String[] TAB={"全部","未完成开票","已完成开票","审核不通过","退票申请","已退票"};
String[] SQL={""," AND status = 0 "," AND status = 2 "," AND status = 3 "," AND status= 4 "," AND status = 5 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");

int size=20;

%><!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
 
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css">

<script src="cssjs/jquery.min.js"></script>
<script type="text/javascript" src="cssjs/swiper-3.4.0.jquery.min.js" ></script>
<link rel="stylesheet" href="cssjs/swiper-3.2.7.min.css" />
<style>
.mt_data td,.mt_data th{padding:3px}
.results ul li .statuscon{float:right;}
input[type=text]::-ms-clear{

                display: none;

                 

            }

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

                font-color: #004779;

                 

            } 
</style>
<title>发票管理</title>
</head>
<body style='min-height:300px'>
<header class="header">发票管理</header>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="query">
<table id="tableweb" cellspacing="0">
<tr>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="mt.show('/mobjsp/yl/shopwebnew/Selhospital.jsp',1,'选择医院',500,500)" type="button" value="请选择"/>  
  </td>
  
  
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>
<style>
 
	.swiper1 {
		width: 100%;
	}
 
	.swiper1 .swiper-slide {
		text-align: center;
		font-size: 14px;
		height: 50px;
		display: -webkit-box;
		display: -ms-flexbox;
		display: -webkit-flex;
		display: flex;
		-webkit-box-pack: center;
		-ms-flex-pack: center;
		-webkit-justify-content: center;
		justify-content: center;
		-webkit-box-align: center;
		-ms-flex-align: center;
		-webkit-align-items: center;
		align-items: center;
		cursor: pointer;
	}
	.swiper2 {
		width: 100%;
	}
	.swiper2 .swiper-slide {
		height: calc(100vh - 50px);
		background-color: #ccc;
		color: #fff;
		text-align: center;
		box-sizing: border-box !important;
		overflow-x: hidden !important;
	}
</style>
<div class="container">
	<div class="swiper-container swiper1">
<%out.print("<div class='swiper-wrapper'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='swiper-slide " +(i==tab?"current":"")+"'>"+TAB[i]+"（"+Invoice.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
		</div>
	</div>
	<!-- swiper2 -->
	<div class="swiper-container swiper2">
		<div class="swiper-wrapper">
<div class="resultlist">

<!-- <tr id="tableonetr">
  
  <td class="td2">序号</td>
  <td class="td3">发票号</td>
  <td class="td4">医院</td>
  <td class="td5">索要发票时间</td>
  <td class="td6">申请开票数量</td>
  <td class="td7">申请开票金额</td>
  <td class="td8">状态</td>
  <td class="td9">操作</td>
  
</tr> -->
<%
sql.append(SQL[tab]);

int sum=Invoice.count(sql.toString());
if(sum<1)
{
  out.print("<ul style='text-align:center;width:100%;'>暂无记录!</ul>");
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






<ul>
	
	
	<li>
		<span class="invono"><h3><%=MT.f(invoice.getInvoiceno()) %></h3></span>
		<span class="invostatus"><%=statuscontent %></span>
		<span class="invodate"><%=MT.f(invoice.getCreatedate(),1) %></span>
	</li>
	<li>
		<span><%=MT.f(invoice.getHospital()) %></span>
	</li>
	<li>
		<span>申请开票数量：<%=invoice.getNum() %></span>&nbsp;&nbsp;
		<span>申请开票金额：<%=invoice.getAmount() %></span>
		
	</li>
	<li>
		<span class="list-but"><a href="javascript:mt.act('data',<%=invoice.getId() %>)">查看</a></span>&nbsp;&nbsp;
	<%
		if(invoice.getStatus()==3){
	%>
	<span class="list-but"><a href="javascript:mt.show('<%=MT.f(invoice.getReason()) %>')">查看拒绝原因</a></span>
	<%		
		}
		if(invoice.getStatus()==2){
	%>
	<span class="list-but"><a href="javascript:mt.act('back',<%=invoice.getId() %>)">申请退票</a></span>
	<%		
		}
	%>
	
	</li>
	
	
</ul>
<%
  }
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
}%>

</div>

	</div>

</div>
<script>
	$(function() {
		function setCurrentSlide(ele, index) {
			$(".swiper1 .swiper-slide").removeClass("selected");
			ele.addClass("selected");
			//swiper1.initialSlide=index;
		}

		var swiper1 = new Swiper('.swiper1', {
//					设置slider容器能够同时显示的slides数量(carousel模式)。
//					可以设置为number或者 'auto'则自动根据slides的宽度来设定数量。
//					loop模式下如果设置为'auto'还需要设置另外一个参数loopedSlides。
			slidesPerView: 2.5,
			paginationClickable: true,//此参数设置为true时，点击分页器的指示点分页器会控制Swiper切换。
			spaceBetween: 10,//slide之间的距离（单位px）。
			freeMode: true,//默认为false，普通模式：slide滑动时只滑动一格，并自动贴合wrapper，设置为true则变为free模式，slide会根据惯性滑动且不会贴合。
			loop: false,//是否可循环
			onTab: function(swiper) {
				var n = swiper1.clickedIndex;
			}
		});
		swiper1.slides.each(function(index, val) {
			var ele = $(this);
			ele.on("click", function() {
				setCurrentSlide(ele, index);
				swiper2.slideTo(index, 500, false);
				//mySwiper.initialSlide=index;
			});
		});

		var swiper2 = new Swiper('.swiper2', {
			//freeModeSticky  设置为true 滑动会自动贴合  
			direction: 'horizontal',//Slides的滑动方向，可设置水平(horizontal)或垂直(vertical)。
			loop: false,
//					effect : 'fade',//淡入
			//effect : 'cube',//方块
			//effect : 'coverflow',//3D流
//					effect : 'flip',//3D翻转
			autoHeight: true,//自动高度。设置为true时，wrapper和container会随着当前slide的高度而发生变化。
			onSlideChangeEnd: function(swiper) {  //回调函数，swiper从一个slide过渡到另一个slide结束时执行。
				var n = swiper.activeIndex;
				setCurrentSlide($(".swiper1 .swiper-slide").eq(n), n);
				swiper1.slideTo(n, 500, false);
			}
		});
	});
</script>

 

<script>
mt.act=function(a,invoiceid)
{
  
  if(a=='data')
  {
	  //window.open("InvoiceDatas.jsp?invoiceid="+invoiceid);
	  //parent.location="/html/folder/17100799-1.htm?invoiceid="+invoiceid+"&nexturl="+location.pathname+location.search;
	  location.href="/mobjsp/yl/shopwebnew/InvoiceDatas_wx.jsp?invoiceid="+invoiceid+"&nexturl="+location.pathname+location.search;
  }else if(a=='back'){
	  //InvoiceBack.jsp
	  //parent.location="/html/folder/17100800-1.htm?invoiceid="+invoiceid+"&nexturl="+location.pathname+location.search;
	  location.href="/mobjsp/yl/shopwebnew/InvoiceBack_wx.jsp?invoiceid="+invoiceid+"&nexturl="+location.pathname+location.search;
  }
};
mt.receive=function(v,n,h){
	document.getElementById("hname").value=v;
	};
mt.fit();
</script>
</body>
</html>
