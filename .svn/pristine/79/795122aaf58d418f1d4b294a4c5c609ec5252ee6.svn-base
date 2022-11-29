<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%><%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.nba.PointGift"%><%@page import="tea.entity.weixin.*"%>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/xhtml/nbayao/folder/15020427-1.htm?nexturl="+request.getRequestURI()+ "?" + request.getQueryString());
  return;
}
WxActivity t=WxActivity.find(h.getInt("wxActivity"));
if(t==null||t.getTime()==null||t.getType()!=4||t.isHidden()){
	//out.print("活动已结束");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=4").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=2&type=4");
	return;
}

//查看当前微活动，是否设置奖项
List<WxActivityPrize> actyPrizeList = WxActivityPrize.find(" AND activityId="+t.getId(), 0, Integer.MAX_VALUE);
if(actyPrizeList==null||actyPrizeList.size()<1){
	//out.print("活动已结束");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=4").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=2&type=4");
	return;
}

Date nowDate = new Date();
long nowTimes = nowDate.getTime();
if(nowTimes<t.getStarttime().getTime()){
	//out.print("未开始");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=1&type=4").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=1&type=4");
	return;
}else if(nowTimes>t.getStoptime().getTime()){
	//out.print("已结束");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=4").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=2&type=4");
	return;
}

int totalOfPerson = WxActivityMem.count(" AND activityId="+t.getId()+" AND member="+h.member);
if(totalOfPerson>=t.getTotalOfPerson()){//如果当前用户抽奖次数达到微活动 每人参与的总次数，不能再次抽奖
	//out.print("亲，您本次活动的机会用完了，看看其他的活动吧。");//out.print("亲，您今日的机会用完了，明天再来吧。");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=3&type=4&nochance=1").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=3&type=4&nochance=1");
	return;
}

SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
String nowTime = df.format(nowDate);

Calendar calendar = Calendar.getInstance();
calendar.setTime(nowDate);
calendar.add(Calendar.DAY_OF_MONTH, 1);
String afterDayTime = df.format(calendar.getTime());

int numOfDay = WxActivityMem.count(" AND activityId="+t.getId()+" AND member="+h.member+" AND time>'"+nowTime+"' and time<'"+afterDayTime+"'");
if(numOfDay>=t.getNumOfDay()){//如果当前用户今日抽奖次数达到微活动 每人每天可参与次数，不能再次抽奖
	//out.print("亲，您今日的机会用完了，明天再来吧。");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=3&type=4&nochance=1").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=3&type=4&nochance=1");
	return;
}

//今天还有几次参与机会
int residualNum = t.getNumOfDay()-numOfDay;
//System.out.print("t.getNumOfDay()="+t.getNumOfDay()+",numOfDay="+numOfDay);
/* WxGetGift gg = new WxGetGift(t.getId(),h.member);
WxActivityPrize p = gg.findPrizeByActivityId(); */
%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<!-- uc强制竖屏 -->
<meta name="screen-orientation" content="portrait">
<!-- QQ强制竖屏 -->
<meta name="x5-orientation" content="portrait">
<title>砸金蛋</title>
<link href="/tea/weixin/css/activity-style.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
<script src="/tea/weixin/js/alert.js" type="text/javascript"></script>
<script src="/tea/weixin/js/jQueryRotate.2.2.js" type="text/javascript"></script>
<script src="/tea/weixin/js/jquery.easing.min.js" type="text/javascript"></script>
<style>
body{-webkit-text-size-adjust:none}
.egg{width:100%;max-width:640plix;}
.eggList{list-style:none;width:100%;overflow:hidden;/*display:-webkit-box*/}
.eggList li{}
.eggList .curr{background-position:center center !important;width:33% !important;}
.eggList .curr sup{background-size:140% auto !important;width:100% !important;left:0px !important;background-position:top center !important;}
.hammer{z-index:1000 !important;left:25%;background-size:80%;}
.upbox_cens{width:100%;-webkit-box-sizing:border-box;}

.title .Detail{padding:10px 15px;}
.title .Detail p{font-weight:bold;color:#000;}


    .egg{height:400px; margin:0 auto 20px auto;padding-top:0}
.egg li{z-index:999;-webkit-tap-highlight-color:rgba(0,0,0,0);}
.eggList{padding-top:105px;position:relative;display:-webkit-box;}
.eggList li{/*float:left;*/background:url(/tea/weixin/image/egg_1.png) no-repeat bottom;height:137px;cursor:pointer;position:relative;/*margin-left:35px;*/width:33%;margin:0px;list-style:none;background-size:75% auto !important; background-position:center center;
        }
.eggList li span{position:absolute; width:30px; height:60px; left:68px; top:64px; color:#ff0; font-size:42px; font-weight:bold}
.eggList li.curr{background:url(/tea/weixin/image/egg_2.png) no-repeat bottom;cursor:default;z-index:300;}
.eggList li.curr sup{position:absolute;background:url(/tea/weixin/image/img-4.png) no-repeat;width:232px; height:181px;top:-36px;left:-34px;z-index:800;}
.hammer{background:url(/tea/weixin/image/img-6.png) no-repeat;width:74px;height:87px;position:absolute; /*text-indent:-9999px*/;z-index:150;left:43%;top:20px;}
.resultTip{position:absolute; background:#ffc ;width:148px;padding:6px;z-index:5000;top:200px; left:10px; color:#f60; text-align:center;overflow:hidden;display:none;width:auto; padding:5px 10px;}
.resultTip b{font-size:14px;line-height:24px;}


</style>
</head>

<body data-role="page" class="activity-scratch-card-winning">

	<div class="main">
		<div class="content title">
			<div class="boxcontent boxyellow">
				<div class="Detail">
					<p>
						<%=MT.f(t.getName()) %>
					</p>
				</div>
			</div>
		</div>
		<div class="egg">
			<ul class="eggList">
				<p class="hammer" id="hammer" title='锤子'></p>
				<p class="resultTip" id="resultTip"><b id="result"></b></p>
				<li><sup></sup></li>
				<li><sup></sup></li>
				<li><sup></sup></li>
			</ul>
		</div>
		<div class="content">
			<%-- <div id="zjl" style="display:none" class="boxcontent boxwhite">
				<div class="box">
					<div class="title-red" style="color: #444444;">
						<span class="red"><%=h.username %></span>
						<span>
							恭喜你
						</span>
					</div>
					<div class="Detail">
						<p>
							你中了：
							<span class="red" id ="theAward"></span>
						</p>
						<p class="red"></p>
						<p>
							<input name="" id="winActivityMemId" value="" type="hidden"/>
							<input name="" class="px" id="tel" mask="int" value="" type="text" placeholder="用户请输入您的手机号"/>
						</p>
						<p>
							<p>
								<input class="pxbtn" name="提 交" id="save-btn" type="button" value="用户提交">
							</p>
					</div>
				</div>
			</div> --%>

			<div class="boxcontent boxyellow">
				<div class="box">
					<div class="title-green"><span>奖项设置：</span></div>
					<div class="Detail">
					<%
					for(WxActivityPrize prize:actyPrizeList){
						PointGift pg = PointGift.find(prize.getPgId());
						out.print("<p>"+prize.getName()+"："+MT.f(pg.getgName()));
						if(t.isShowNum())
							out.print("。奖品数量："+prize.getNum()+"</p>");
					}
					%>
					</div>
				</div>
			</div>
			<div class="boxcontent boxyellow">
				<div class="box">
					<div class="title-green">活动说明：</div>
					<div class="Detail">
						<p class="red">您今天还有<%=residualNum%>次参与机会</p>
						<p><%=MT.f(t.getInfo()) %></p>
					</div>
				</div>
			</div>

		</div>

		<div id="zjl" style="display: none;position: fixed;width: 100%; bottom: 0px;z-index:9999;">
			<div class="Pop-upbox" id="usermsg" >
		        <div class="upbox_top">
		            <h1>恭喜中奖：</h1>
		            <a href=""><div class="close" style="display: none;"></div></a>
		        </div>
		        <div class="upbox_cens">
			        <div> 恭喜获得奖品:<span class="red" id ="theAward"></span>。 请留下你的手机号码作为领奖依据。<br/> </div>
			     	<div style="margin-top: 5px;">
						<input type="hidden" id="jxint" value="0"/>
						<input name="" id="winActivityMemId" value="" type="hidden"/>
						手机号：<input id="tel" mask="int" type="tel" class="sinput" placeholder="用户请输入您的手机号"/>
			     	</div>

		        </div>
		        <div class="upbox_cen">
		            <div id="save-btn" class="button_1"><span>确认信息</span></div>
		        </div>
			</div>
		</div>

	</div>

<script type="text/javascript">
	var isSmash = false;

	$(".eggList li").click(function() {
		//$(this).children("span").hide();
		if(!isSmash)
			eggClick($(this));
	});

	/*$(".eggList li").hover(function() {
		var posL = $(this).position().left + $(this).width()+10;
		$("#hammer").show().css('left', posL);
		$("#hammer").show().css('top', $(this).position().top);

	});*/

	function eggClick(obj) {
		isSmash = true;
		var _this = obj;
		if(_this.hasClass("curr")){
			alert("蛋都碎了，别砸了！刷新再来.");
			return false;
		}
		//_this.unbind('click');

		sendx("/WxActivitys.do?act=smashEggs&wxActivity=<%=t.getId()%>",
			function(data)
			{
				eval("v="+data);
                var width = $(".eggList li").css("width");
                //alert(width);
				$(".hammer").css({"top":_this.position().top,"left":_this.position().left+width});
				$(".hammer").animate(
					{
						"top":_this.position().top-20,
						"left":_this.position().left+50
					},0,function(){
						_this.addClass("curr"); //蛋碎效果
						_this.find("sup").show(); //金花四溅
						//$(".hammer").hide();
						$('.resultTip').css({display:'block',top:'100px',left:_this.position().left-0,opacity:0}).animate({top: '50px',opacity:1},300,function(){
							if(v.id>0){//有奖
								/* $("#winActivityMemId").val(v.winActivityMemId);
								$("#result").html("恭喜，您中得"+v.name);//奖项
								setPrizeMem(); */
								$("#result").html("恭喜，您中得"+v.name);//奖项
								$("#theAward").html(v.name);
								$("#winActivityMemId").val(v.winActivityMemId);
								setPrizeMem();
							}else{
								$("#result").html("很遗憾,您没能中奖!");
								setTimeout(function(){
									location.reload(true);
								},1888);

								/* tusi("很遗憾，您没有中奖");
								 setTimeout(function(){
									location.reload(true);
								},1888); */
							}
						});
					}
				);
			}
		);
	}

	//保存中奖者信息
	function setPrizeMem(){
		//$("#zjl").fadeIn();
		$("#zjl").slideToggle(500);
		$("#outercont").slideUp(500);
		//$("#outercont").slideUp(500);
	}

	$("#save-btn").bind("click", function() {
		var btn = $(this);
		var tel = $("#tel").val();
		if (tel == '') {
			alert("请输入手机号");
			return;
		}

		sendx("/WxActivitys.do?act=savePrizeMem&wxActivity=<%=t.getId()%>&winActivityMemId="+$("#winActivityMemId").val()+"&tel="+tel,
			function(data)
			{
				tusi('提交成功.');
				setTimeout(function(){
					location.reload(true);
				},1888);
			}
		);

	});
</script>

</body>
</html>
