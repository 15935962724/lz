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

sql.append(" AND status = 1");
par.append("&status=1");
//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospitalid in (select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}


String[] TAB={"已匹配发票","未申请","已申请"};
String[] SQL={""," AND chargestatus = 0 "," AND chargestatus <> 0 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>

<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

 <link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>

<script src="cssjs/jquery.min.js"></script>
<script type="text/javascript" src="cssjs/swiper-3.4.0.jquery.min.js" ></script>
<link rel="stylesheet" href="cssjs/swiper-3.2.7.min.css" />

<style>
.mt_data td,.mt_data th{padding:3px}

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
<title>申请服务费</title>
</head>
<body style='min-height:300px'>
<header class="header">申请服务费</header>
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
  out.print("<a href='javascript:mt.tab("+i+")' class='swiper-slide "+(i==tab?"current":"")+"'>"+TAB[i]+"（"+BackInvoice.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>

		</div>
	</div>
	<!-- swiper2 -->
	<div class="swiper-container swiper2">
		<div class="swiper-wrapper">
<div class="results" style="margin-bottom: 70px;">			
<form name="form2" action="/Charges.do" method="post" target="_ajax">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="hospital"/>
<div class="results">

<%
int sum=BackInvoice.count(sql.toString());
	if(tab==1&&sum>0){
%>
  <div><input type="checkbox" id="all"/>全选</div>
  <%
	}
  %>
  
<%
sql.append(SQL[tab]);


if(sum<1)
{
  out.print("<div style='text-align:center;width:100%;'>暂无记录!</div>");
}else
{
  List<BackInvoice> lst=BackInvoice.find(sql.toString()+" order by createdate desc ",pos,20);
  for(int i=0;i<lst.size();i++)
  {
	  BackInvoice t=lst.get(i);
	  int hospitalid=t.getHospitalid();//医院
	  ShopHospital hospital=ShopHospital.find(hospitalid);//医院
	  String[] invoiceidarr=t.getInvoiceid().split(",");//匹配发票号
	  String invoicestr="";//发票号
	  for(int k=0;k<invoiceidarr.length;k++){
		  int in=Integer.parseInt(invoiceidarr[k]);
		  Invoice invoice=Invoice.find(in);
		  if(k==invoiceidarr.length-1){
			  invoicestr+=invoice.getInvoiceno();
		  }else{
			  invoicestr+=invoice.getInvoiceno()+",";
		  }
		  
	  }
	  String replystr="";//回款编号
	  String[] replyidarr=t.getReplyid().split(",");//回款id
	  for(int j=0;j<replyidarr.length;j++){
		  int re=Integer.parseInt(replyidarr[j]);
		  ReplyMoney reply=ReplyMoney.find(re);
	      if(j==replyidarr.length-1){
	    	  replystr+=reply.getCode();
	      }else{
	    	  replystr+=reply.getCode()+",";
	      }
	  }
%>
<ul>
<%
	if(tab==1){
%>
	<span class="check"><input type="checkbox" name="issigns" value="<%=t.getId() %>"/><input type="hidden" name="hid" value="<%=hospital.getId() %>"/></span>
<%
	}
%>	
	<li><span><%=hospital.getName() %></span></li>
	<li><span>回款编号：<%=replystr %></span></li>
	<li><span>匹配发票号：<%=invoicestr %></span></li>
	
	<li>
		<span>匹配金额：<%=t.getMatchamount() %></span>
		<span>挂款金额：<%=t.getHangamount() %></span>
	</li>
	<li>
		<span  class="statuscon"><%=BackInvoice.STATUS[t.getStatus()] %></span>
		<span class="list-but"><a href="javascript:mt.act('data',<%=t.getId() %>)">查看</a></span>
	</li>
	
	
</ul>

<%	    	  
	      
	  
  }
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
}%>

</div>
<%
	if(tab==1){
%>
<div class='center mt15 btnbottom'>
		<button class="btn btn-primary" disabled="disabled" type="button" id="getinvoice" onclick="fnconfirm()" >申请服务费</button>
	</div>
<%
	}
%>
</form>
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
form2.nexturl.value=location.pathname+location.search;
function fnconfirm(){
	form2.act.value="askcharge";
	var i=0;
	var a=0;
	var h='';
	var hid=0;
	$("input[name='issigns']:checked").each(function(){
		
		i+=1;
		
		if(i==1){
			h=$(this).parent().parent().find("li:first").children().html();//医院
			hid=$(this).next().val();//医院id
		}
		
		var	h2=$(this).parent().parent().find("li:first").children().html();
		
		
		if(h!=h2){
			mt.show("请选择同一所医院申请服务费！");
			a=1;
			return false;
		} 
		
	});
	if(a==0){
		mt.show("是否确定提交申请服务费？",2);
		mt.ok=function(){
			form2.nexturl.value="/mobjsp/yl/shopwebnew/ListCharge_wx.jsp";
			form2.hospital.value=hid;
			
			form2.submit();
		}
	}
	
}
//全选操作

$("#all").click(function(){  
	
	
	if($(this).prop("checked")==true){
		
		$("input[name='issigns']").each(function(){
			  if($(this).prop("checked")==false){
				  $(this).click();
			  }
			  
		})
	}else{
		$("input[name='issigns']").each(function(){
			  
			if($(this).prop("checked")==true){
				  $(this).click();
			  }
		})
	}
	var len = $("input[name='issigns']:checkbox:checked").length;
	//控制申请服务费按钮
	if(len==0){
		$('#getinvoice').attr('disabled',"true");
		
	}else{
		$('#getinvoice').removeAttr("disabled"); 
		
	}
	
	
	
});

	
	//单选操作
	$("input[name='issigns']").click(function(){  
		
		
		
		var len = $("input[name='issigns']:checked").length; 
		//控制申请服务费按钮
		if(len==0){
			$('#getinvoice').attr('disabled',"true");
			
		}else{
			$('#getinvoice').removeAttr("disabled"); 
		}
		var alllen=document.getElementsByName("issigns").length;
		//控制全选
		if(len<alllen){
			$("#all").prop("checked", false);  
		}
		if(len==alllen){
			$("#all").prop("checked", true);  
		}
		
		

	});

	mt.act=function(a,rid)
	{
	  
	  if(a=='data')
	  {
		  //window.open("BackInvoiceDatas.jsp");
		  //parent.location="/html/folder/17110004-1.htm?backid="+rid+"&nexturl="+location.pathname+location.search;
          location.href="/mobjsp/yl/shopwebnew/BackInvoiceDatas_wx.jsp?backid="+rid+"&nexturl="+location.pathname+location.search;
	  }
	};
	mt.receive=function(v,n,h){
		document.getElementById("hname").value=v;
		};
	mt.fit();
</script>
</body>
</html>
