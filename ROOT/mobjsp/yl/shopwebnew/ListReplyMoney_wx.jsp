<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
//out.print("<script>alert('"+h.getCook("openid", "")+"');</script>");
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
	//out.print("<script>alert('"+h.member+"');</script>");
/* if(h.member<1){
	String param = request.getQueryString();
	String url = request.getRequestURI();
	if(param != null)
		url = url + "?" + param;
	response.sendRedirect("/mobjsp/yl/user/login_wx.jsp?nexturl="+url);
	return;
}  */

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

Profile profile=Profile.find(h.member);
String hospitals=profile.hospitals;

String[] hospitalsarr=hospitals.split("[|]");
String hidstr="";
for(int i=1;i<hospitalsarr.length;i++){
	//out.print(hospitalsarr[i]+".");
	
	if(i==hospitalsarr.length-1){
		hidstr+=hospitalsarr[i];
	}else{
		hidstr+=hospitalsarr[i]+",";
	}
}
if(hospitals.length()>1){
	sql.append(" and hid in("+hidstr+")");
}else{
	sql.append(" and hid in(000)");
}

/* sql.append(" AND profile="+h.member);
par.append("&profile="+h.member); */

//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hid in (select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}


String[] TAB={"未匹配发票","待审核","已匹配发票","全部"};
String[] SQL={" AND statusmember = 1 "," AND statusmember = 2 "," AND statusmember = 3 "," AND statusmember > 0 "};

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
<title>回款管理</title>
</head>
<body >
<header class="header">回款管理</header>
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
  out.print("<a href='javascript:mt.tab("+i+")' class='swiper-slide "+(i==tab?"current":"")+"'>"+TAB[i]+"（"+ReplyMoney.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>

		</div>
	</div>
	<!-- swiper2 -->
	<div class="swiper-container swiper2">
		<div class="swiper-wrapper">
<div class="results" style="margin-bottom: 120px;">

<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="replyid"/>


  <%
   	if(tab==0){
  %>
  
  <div><input type="checkbox" id="all"/>全选</div>
  <%
   	}
  %>
  
  
<%
sql.append(SQL[tab]);

int sum=ReplyMoney.count(sql.toString());
if(sum<1)
{
  out.print("<div style='text-align:center;width:100%;'>暂无记录!</div>");
}else
{
  List<ReplyMoney> lst=ReplyMoney.find(sql.toString()+" order by time desc ",pos,20);
  for(int i=0;i<lst.size();i++)
  {
	  ReplyMoney t=lst.get(i);
	  ShopHospital hospital=ShopHospital.find(t.getHid());
	  
%>
<ul>
	<%
	    if(tab==0){
	%>
	
	<span class="check"><input type="checkbox" name="issigns" value="<%=t.getId() %>"/>
	<input type="hidden" value="<%=hospital.getId() %>"/></span>
	
	<%
	    }
	%>
	<li>
	<span><h3><%=MT.f(t.getCode()) %></h3></span>
	<span class="invostatus"><%=ReplyMoney.typeARR[t.getType()] %></span>
	<span><%=MT.f(t.getReplyTime()) %></span>
	</li>
	<li>
	<span><%=MT.f(hospital.getName()) %></span>
	</li>
	<li>
		<span>回款金额：<span class="hkamount"><%=ShopHospital.getDecimal((double)t.getReplyPrice()) %></span></span>
		<span><%=ReplyMoney.statusmemberARR[t.getStatusmember()] %></span>
	</li>
	
	<li><span class="list-but"><a href="javascript:mt.act('data',<%=t.getId() %>)">查看</a></span>&nbsp;&nbsp;</li>
	
</ul>
<%
  }
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
}%>




</form>


</div>

	</div>
	

</div>
<%
	if(tab==0){
%>
<div class='center mt15 btnbottom' style="height:90px">
<div id="tishi"></div>
		<button class="btn btn-primary" disabled="disabled" type="button" id="getinvoice" onclick="fnconfirm(<%=h.member %>)" >选择发票</button>
</div>
<%
	}
%>
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
mt.act=function(a,rid)
{
  form2.act.value=a;
  form2.replyid.value=rid;
  if(a=='data')
  {
	  //window.open("ReplyMoneyDatas.jsp");
	  //parent.location="/html/folder/17110007-1.htm?replyid="+rid+"&nexturl="+location.pathname+location.search;
      location.href="/mobjsp/yl/shopwebnew/ReplyMoneyDatas_wx.jsp?replyid="+rid+"&nexturl="+location.pathname+location.search;
  }
};


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
	//控制索要发票按钮
	if(len==0){
		$('#getinvoice').attr('disabled',"true");
		
	}else{
		$('#getinvoice').removeAttr("disabled"); 
		
	}
	
	gethk();
	
});
mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};
	
	//单选操作
	$("input[name='issigns']").click(function(){  
		
		
		
		var len = $("input[name='issigns']:checked").length; 
		//控制索要发票按钮
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
		
		gethk();

	});
	
	
	
	
	//输入开票金额
	
	function fnconfirm(member){
		
		
		var i=0;
		var hospital='';//医院名称
		var a=0;
		var hid=0;//医院id
		var amount=0;//回款金额
		
		$("input[name='issigns']:checked").each(function(){
			
			i+=1;
			
			if(i==1){
				hospital=$(this).parent().parent().find("li").eq(1).find("span:first").html();
				hid=$(this).next().val();
			}
			var hospital2=$(this).parent().parent().find("li").eq(1).find("span:first").html();
			
			if(hospital2!=hospital){
				
				mt.show("请选择同一医院选择发票！");
				a=1;
				return false;
				
			}
			//var hk=parseFloat($(this).parent().parent().find("td").eq(5).html());
			var hk=parseFloat($(this).parent().parent().find("li").eq(2).find(".hkamount").html());
			amount+=hk;
			
		});
		if(a==0){
			mt.send("/ReplyMoneys.do?act=searchbackinvoice&hid="+hid,function(d)
					{
			
						        if(d=='1')
						        {
						        	mt.show("现有该医院已提交的申请待审核，暂不能申请！");
						        	
						        }else{
						        	var ids='';//id
									var nums='';//开票数量
									var amounts='';//开票金额
									$("input[name='issigns']:checked").each(function(){
										ids+=$(this).val()+",";
										
									});
									
									//jsp/yl/shopwebnew/SelInvoice.jsp;
									//location.href='/html/folder/17100826-1.htm?ids='+ids+'&member='+member+'&hid='+hid+'&amount='+parseFloat(amount)+'&nexturl='+location.pathname+location.search;
									location.href='/mobjsp/yl/shopwebnew/SelInvoice_wx.jsp?ids='+ids+'&member='+member+'&hid='+hid+'&amount='+parseFloat(amount)+'&nexturl='+location.pathname+location.search;
								
						        }
						    });
			}
		
	}
	//选中的回款金额
	function gethk(){
		var amount=0;
		$("input[name='issigns']:checked").each(function(){
			//alert($(this).val());
			//var hk=parseFloat($(this).parent().parent().find("td").eq(5).html());
			var hk=parseFloat($(this).parent().parent().find("li").eq(2).find(".hkamount").html());
			
			amount+=hk;
			
		});
		$("#tishi").html("已选中的回款金额："+parseFloat(amount)+"元");
		mt.fit();
	}
	mt.receive=function(v,n,h){
		document.getElementById("hname").value=v;
		};
	mt.fit();
</script>
</body>
</html>
