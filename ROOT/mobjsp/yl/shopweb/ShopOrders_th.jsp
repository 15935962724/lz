<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.yl.shop.ShopExchanged"%>
<%@page import="tea.entity.yl.shop.ShopOrderData"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%

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
		response.sendRedirect("/mobjsp/yl/user/login_mobile.html?nexturl="+Http.enc(url));
		return;
	}
	Profile p1=lstp.get(0);
	if(p1.profile>0){
		h.member=p1.profile;
		//out.print("<script>alert('a:"+h.member+"');</script>");
		
	}
	
/* if(h.member<1){
	String param = request.getQueryString();
	String url = request.getRequestURI();
	if(param != null)
		url = url + "?" + param;
	response.sendRedirect("/mobjsp/yl/user/login_wx.jsp?nexturl="+url);
	return;
} */
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


//???????????????

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

String[] TAB={"??????","????????????","?????????","?????????"};
String[] SQL={""," AND status=0"," AND (status =1 or (status=2 and exchangedstatus!=0))"," AND status=2 and exchangedstatus=0"};
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;
int count=ShopExchanged.count(sql.toString());

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,user-scalable=0">
	<title>????????????</title>

	<script src="/tea/mt.js" type="text/javascript"></script>
	<script src="/jsp/sup/sup.js" type="text/javascript"></script>
	<script src="/tea/new/js/jquery.min.js"></script>
	<script src="/tea/yl/mtDiag.js"></script>
	<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
</head>

<body>
<div class="body">

<form name="form1" action="?">
<input type="hidden" name="tab" value="<%=tab %>" />
	<%--<div class="order-sea">
<table  id="tableweb" cellspacing="0">
<tr>
  <td >?????????<input type="text" name="hname" id="hname" value="<%=hname %>" readonly/>
  <input id="hospitalsel" onclick="mt.show('/mobjsp/yl/shopwebnew/Selhospital.jsp',1,'????????????',500,500)" type="button" value="?????????"/>
  </td>
  </tr>
  <tr>
  <td >???????????????<input type="text"  name="orderId" value="<%=MT.f(orderId)%>"/></td>
<tr>
  <td>???????????????<input type="text" name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date" style="width:100px;"/>?????????
  <input type="text" name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date" style="width:100px;"/></td>
</tr>
<tr>
  <td style="text-align:center;"><input type="submit" class="button" value="??????"/></td>
</tr>

</table>
</div>--%>
	<div class="order-sea">
		<div class="order-sea-left fl-left">
			<p style="position:relative;">
				<span class="ft14 order-l-span">?????????</span>
				<input type="text" name="hname" class="right-box-data" id="hname" value="<%=hname %>" readonly style=""/>
				<input id="hospitalsel" class="btn btn-link" style="position:absolute;width:auto;right:-70px;color:#044694;border:none;background:none;top:0px;height:33px;" onclick="layer.open({type: 2,title: '????????????',shadeClose: true,area: ['98%', '580px'],closeBtn:1,content: '/jsp/yl/shopwebnew/Selhospital.jsp'});" type="button" value="?????????"/>
			</p>

			<p>
				<span class="ft14 order-l-span">???????????????</span>
				<input type="text" class="right-box-inp" name="orderId" value="<%=MT.f(orderId)%>"/>
			</p>
			<p>
				<span class="ft14 order-l-span">???????????????</span>
                    <span class="time">
                        <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                        <span style="">~</span>
                        <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    </span>
			</p>
		</div>
		<input type="submit" class="fl-right order-cxb ft14" value="??????">
	</div>
</form>
	<div class="order-lx">
		<%out.print("<ul>");
			for(int i=0;i<TAB.length;i++)
			{
				out.print("<li class='ft14 fl-left "+(i==tab?"on":"")+"'><a href='javascript:mt.tab("+i+")'>"+TAB[i]+"("+ShopExchanged.count(sql.toString()+SQL[i])+")</a></li>");
			}
			out.print("</ul>");
		%>
	</div>
<form name="form2" action="?" method="post">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="seid"/>
<input type="hidden" name="orderId"/>
<input type="hidden" name="id" value="<%=menuid %>"/>





<%
sql.append(SQL[tab]);

int sum=ShopExchanged.count(sql.toString());
if(sum<1)
{
  out.print("<ul style='text-align:center;width:100%;'>????????????!</ul>");
}else
{
	sql.append(" order by time desc");
    ArrayList list = ShopExchanged.find(sql.toString(),pos,size);
    for (int i = 0;i<list.size(); i++) {
		ShopExchanged se = (ShopExchanged) list.get(i);
		ShopProduct sp=ShopProduct.find(se.product_id);
		ShopPackage spage = new ShopPackage(0);
	    List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
		String pname = "";
		if(sp.isExist){
			pname=sp.getAnchor(h.language);
		}else{
			spage = ShopPackage.find(se.product_id);
			pname="[??????]"+MT.f(spage.getPackageName());
			spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
			String [] sarr = spage.getProduct_link_id().split("\\|");
			for(int m=1;m<sarr.length;m++){
			    spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
			}
		}
		
  %>
	<div class="order-list">
   <ul class="ft14">
  <li>
    <span class="list-spanr5 fl-left" >???????????????</span>
	  <span class="list-spanr fl-left"><%=se.orderId %></span>
  </li>
  <li>
  	<span class="list-spanr5 fl-left">???????????????</span>
	  <span class="list-spanr fl-left"><%=se.expressNo %></span>

  </li>
  <li>
    <span class="list-spanr5 fl-left">???????????????</span>
	  <span class="list-spanr fl-left"><%=se.exchanged_code %></span>

  </li>
  <li>
    
    <span  class="list-spanr5 fl-left">?????????????????????</span>
	  <span  class="list-spanr fl-left"><%=se.quantity %></span>
	  </li>
	   <li>
    <span class="list-spanr5 fl-left">?????????????????????</span>
    <span class="list-spanr fl-left">
		<%
			if(se.status==0){
				out.print("");
			}else if(se.status==1){
				out.print(se.quantity);
			}else if(se.status==2){
				out.print(se.exchangednum);
			}
		%>
	</span>
  </li>
	   <li>
		   <span class="list-spanr5 fl-left">???????????????</span>
		   <span class="list-spanr fl-left"><%=MT.f(se.time,1)%></span>
	   </li>
  <li style="text-align:right;color:#999999;">
    
   <%-- <span  ><%=MT.f(se.time,1)%></span>--%>
    <%
    	/*if(se.status==2&&se.exchangedstatus==0){
    		out.print("<span nowrap align='right' style='color:#999999;'><input type='button' onclick=mt.act('yesexchange',0,'"+se.orderId+"') value='??????????????????'></span>");
    	}*/
    %>
  </li>
  </ul>

			<p class="order-btnp">



				<%

					if(se.status==2&&se.exchangedstatus==0){
						/*out.print("<span nowrap align='right' style='color:#999999;'><input type='button' onclick=mt.act('yesexchange',0,'"+se.orderId+"') value='??????????????????'></span>");*/
						out.println("<a  class='btn' onclick=mt.act('yesexchange',0,'"+se.orderId+"'); >??????????????????</a>");
					}


				%>
			</p>

  

</div>
	<%}
		if(sum>5)out.print("<div id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,5)+"</div>");
		}%>
</form>
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
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,oid){
	form2.act.value=a;
	form2.seid.value=id;
	if(a=='view'){
		mt.show("/jsp/yl/shop/ShopExchangedDetail.jsp?seid="+id,1,"???????????????",410,300);
		return;
	}else if(a=="finish"){
		mt.show("??????????????????",2,"form2.submit()");
	}else if(a=='yesexchange'){
		  form2.action="/ShopExchangeds.do";
		  form2.target="_ajax";
		  form2.act.value=a;
		  form2.orderId.value=oid;
		  form2.submit();
	  }
	
}
mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};


</script>
<script>
mt.fit();
</script>
</body>
</html>
