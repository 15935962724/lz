<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
/* if(h.member<1){
	String param = request.getQueryString();
	String url = request.getRequestURI();
	if(param != null)
		url = url + "?" + param;
	response.sendRedirect("/mobjsp/yl/user/login_wx.jsp?nexturl="+url);
	return;
} */
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
    //out.print("<script>alert('"+openid+"');</script>");
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
    //Filex.logs("openid.txt", openid);
    //Filex.logs("openid.txt", openid);
    
	if(openid==null){
		response.sendRedirect("/PhoneProjectReport.do?act=openid&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()+"&r="+Math.random()));
		return;
	}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

sql.append(" AND member="+h.member+" and istzfws in (1,2) ");
par.append("&member="+h.member);
par.append("&istzfws= 1");

//???????????????

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospitalid in (select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}



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
<title>???????????????</title>
</head>
<body style='min-height:300px'>
<header class="header">???????????????</header>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>

<div class="query">
<table id="tableweb" cellspacing="0">
<tr>
  <td>?????????<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="mt.show('/mobjsp/yl/shopwebnew/Selhospital.jsp',1,'????????????',500,500)" type="button" value="?????????"/>  
  </td>
  
  
  <td><input type="submit" class="button" value="??????"/></td>
  
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

	<!-- swiper2 -->
	<div class="swiper-container swiper2">
		<div class="swiper-wrapper">
<div class="results" style="margin-bottom: 70px;">

<form name="form2" action="/Charges.do" method="post" target="_ajax">

<input type="hidden" name="nexturl"/>
<input type="hidden" name="chargeid" />
<input type="hidden" name="act"/>
<input type="hidden" name="hospital"/>
<div class="resultlist">


<%

int sum=Charge.count(sql.toString());
if(sum<1)
{
  out.print("<div style='text-align:center;width:100%;'>????????????!</div>");
}else
{
  List<Charge> lst=Charge.find(sql.toString()+" order by createdate desc ",pos,20);
  for(int i=0;i<lst.size();i++)
  {
	  Charge t=lst.get(i);
	  int hospitalid=t.getHospitalid();//??????
	  ShopHospital hospital=ShopHospital.find(hospitalid);//??????
	  
%>
<ul>

	
	<li>
		<span>??????????????????<%=t.getChargecode() %></span>
		<span><%=MT.f(t.getCreatedate(),1) %></span>
	</li>
	<li><span><%=MT.f(hospital.getName()) %></span></li>
	
	<li>
		<span class="statuscon"><%=Charge.STATUS[t.getStatus()] %></span>
		<span class="list-but"><a href="javascript:mt.act('data',<%=t.getId() %>)">??????</a></span>
		<span class="list-but"><a href="javascript:mt.act('dcdata',<%=t.getId() %>)">???????????????</a></span>
		
	</li>
	
	
</ul>

<%	    	  
	     
	  }
  
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
}%>

</div>

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
//					??????slider???????????????????????????slides??????(carousel??????)???
//					???????????????number?????? 'auto'???????????????slides???????????????????????????
//					loop????????????????????????'auto'?????????????????????????????????loopedSlides???
			slidesPerView: 2.5,
			paginationClickable: true,//??????????????????true???????????????????????????????????????????????????Swiper?????????
			spaceBetween: 10,//slide????????????????????????px??????
			freeMode: true,//?????????false??????????????????slide??????????????????????????????????????????wrapper????????????true?????????free?????????slide???????????????????????????????????????
			loop: false,//???????????????
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
			//freeModeSticky  ?????????true ?????????????????????  
			direction: 'horizontal',//Slides?????????????????????????????????(horizontal)?????????(vertical)???
			loop: false,
//					effect : 'fade',//??????
			//effect : 'cube',//??????
			//effect : 'coverflow',//3D???
//					effect : 'flip',//3D??????
			autoHeight: true,//????????????????????????true??????wrapper???container???????????????slide???????????????????????????
			onSlideChangeEnd: function(swiper) {  //???????????????swiper?????????slide??????????????????slide??????????????????
				var n = swiper.activeIndex;
				setCurrentSlide($(".swiper1 .swiper-slide").eq(n), n);
				swiper1.slideTo(n, 500, false);
			}
		});
	});
</script>


<script>

//????????????

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
	//???????????????????????????
	if(len==0){
		$('#getinvoice').attr('disabled',"true");
		
	}else{
		$('#getinvoice').removeAttr("disabled"); 
		
	}
	
	
	
});

	
	//????????????
	$("input[name='issigns']").click(function(){  
		
		
		
		var len = $("input[name='issigns']:checked").length; 
		//???????????????????????????
		if(len==0){
			$('#getinvoice').attr('disabled',"true");
			
		}else{
			$('#getinvoice').removeAttr("disabled"); 
		}
		var alllen=document.getElementsByName("issigns").length;
		//????????????
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
		  //window.open("ChargeDatas.jsp");
		  //parent.location="/html/folder/17110006-1.htm?chargeid="+rid+"&nexturl="+location.pathname+location.search;
		  location.href="/mobjsp/yl/shopwebnew/ChargeDatas_wx.jsp?chargeid="+rid+"&nexturl="+location.pathname+location.search;
	  }else if(a=='dcdata'){
		  form2.act.value=a;
		  form2.chargeid.value=rid;
		  form2.submit();
	  }
	};
	mt.receive=function(v,n,h){
		document.getElementById("hname").value=v;
		};
	mt.fit();
</script>
</body>
</html>
