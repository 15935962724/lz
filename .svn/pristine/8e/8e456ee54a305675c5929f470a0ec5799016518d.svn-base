<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.nba.PointGift"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/xhtml/nbayao/folder/15020427-1.htm?nexturl="+request.getRequestURI()+ "?" + request.getQueryString());
  return;
}
WxActivity t=WxActivity.find(h.getInt("wxActivity"));
if(t==null||t.getTime()==null||t.getType()!=1||t.isHidden()){
	//out.print("活动已结束");
	//status{"活动状态","未开始","已结束","进行中"}
	//type{"微活动类型","刮刮卡","幸运水果机","幸运大转盘","砸金蛋"}
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=1").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=2&type=1");
	return;
}

//查看当前微活动，是否设置奖项
List<WxActivityPrize> actyPrizeList = WxActivityPrize.find(" AND activityId="+t.getId(), 0, Integer.MAX_VALUE);
if(actyPrizeList==null||actyPrizeList.size()<1){
	//out.print("活动已结束");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=1").forward(request, response);
	return;
}

Date nowDate = new Date();
long nowTimes = nowDate.getTime();
if(nowTimes<t.getStarttime().getTime()){
	//out.print("未开始");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=1&type=1").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=1&type=1");
	return;
}else if(nowTimes>t.getStoptime().getTime()){
	//out.print("已结束");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=1").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=2&type=1");
	return;
}

int totalOfPerson = WxActivityMem.count(" AND activityId="+t.getId()+" AND member="+h.member);
if(totalOfPerson>=t.getTotalOfPerson()){//如果当前用户抽奖次数达到微活动 每人参与的总次数，不能再次抽奖
	//out.print("亲，您本次活动的机会用完了，看看其他的活动吧。");//out.print("亲，您今日的机会用完了，明天再来吧。");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=3&type=1&nochance=1").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=3&type=1&nochance=1");
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
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=3&type=1&nochance=1").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=3&type=1&nochance=1");
	return;
}

//今天还有几次参与机会
int residualNum = t.getNumOfDay()-numOfDay;
//System.out.print("t.getNumOfDay()="+t.getNumOfDay()+",numOfDay="+numOfDay);
/* WxGetGift gg = new WxGetGift(t.getId(),h.member);
WxActivityPrize p = gg.findPrizeByActivityId(); */

%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="format-detection" content="telephone=no">
		<title>刮刮卡</title>
		<link href="/tea/weixin/css/activity-style.css" rel="stylesheet" type="text/css">
		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/tea.js" type="text/javascript"></script>
		<script src="/tea/jquery.js" type="text/javascript"></script>
		<script src="/tea/weixin/js/wScratchPad.js" type="text/javascript"></script>
		<script src="/tea/weixin/js/alert.js" type="text/javascript"></script>
	</head>
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
			<div class="cover">
				<img src="/tea/weixin/image/activity-scratch-card-bannerbg.png">
				<div id="prize">
				</div>
				<div id="scratchpad">
				</div>
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
							<!-- <p>
								兑奖SN码：
								<span class="red" id="sncode">
									fa423sffd889fsdfad
								</span>
							</p> -->
							<p class="red"></p>
							<p>
								<input name="" id="winActivityMemId" value="" type="hidden"/>
								<input name="" class="px" id="tel" mask="int" value="" type="text" placeholder="用户请输入您的手机号"/>
							</p>
							<p>
								<p>
									<input class="pxbtn" name="提 交" id="save-btn" type="button" value="用户提交">
								</p>
								<!--
								<p>
									<input name="" class="px" id="parssword" type="password" autocomplete="off" value="" placeholder="商家输入兑奖密码">
								</p>
								<p>
									<input class="pxbtn" name="提 交" id="save-btnn" type="button" value="商家提交">
								</p>
							!-->
						</div>
					</div>
				</div> --%>
				<div class="boxcontent boxyellow">
					<div class="box">
						<div class="title-brown"><span>奖项设置：</span></div>
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
						<div class="title-brown">活动说明：</div>
						<div class="Detail">
							<p class="red">您今天还有<%=residualNum%>次参与机会</p>
							<p><%=MT.f(t.getInfo()) %></p>
						</div>
					</div>
				</div>

			</div>
			<div id="outercont" style="clear:both;">
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

			var zjl = false;
			var num = 0;
			var goon = true;
			var isScratch = false;
			$(function() {
				$("#scratchpad").wScratchPad({
					width: 150,
					height: 40,
					color: "#a9a9a7",
					scratchMove: function(e, percent){
						if(!isScratch){
							scratchCard();
						}
						if(percent > 50 && goon){
							if(zjl){
								setPrizeMem();
							}else{
								goon = false;
								tusi("很遗憾，您没有中奖");
								setTimeout(function(){
									location.reload(true);
								},1888);
							}
						}
					},
					scratchUp: function(e, percent){
						if(!isScratch){
							scratchCard();
						}

						if (zjl && percent > 50 && goon) {
							setPrizeMem();
						}
					}

				});

				//$("#prize").html("谢谢参与");
				//loadingObj.hide();
				//$(".loading-mask").remove();
			});

			// 刮卡
			function scratchCard(){
				isScratch = true;
				sendx("/WxActivitys.do?act=scratchCard&wxActivity=<%=t.getId()%>",
					function(data)
					{
						eval("v="+data);
						var abnormalUrl = v.abnormalUrl;
						if(abnormalUrl!=null){
							location.href=abnormalUrl;
							return;
						}
						//alert(v.name);
						var award = v.id>0?v.name:"谢谢参与";
						if(v.id>0){
							zjl = true;
							$("#winActivityMemId").val(v.winActivityMemId);

						}
						//alert(111);
						document.getElementById('prize').innerHTML = award;
						$("#theAward").html(award);
					}
				);

			}

			//保存中奖者信息
			function setPrizeMem(){
				//$("#zjl").fadeIn();
				goon = false;
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

				/* var submitData = {
					tid: 438,
					code: $("#sncode").text(),
					tel: tel,
					action: "setTel"
				};
				$.post('index.php?ac=acw', submitData,
				function(data) {
					if (data.success == true) {
						alert(data.msg);
						return
					} else {}
				},
				"json"); */
			});

			// 保存数据
			$("#save-btnn").bind("click", function() {
				//var btn = $(this);
				var submitData = {
					tid: 438,
					code: $("#sncode").text(),
					parssword: $("#parssword").val(),
					action: "setTel"
				};
				$.post('index.php?ac=acw', submitData,
				function(data) {
					if (data.success == true) {
						alert(data.msg);
						if (data.changed == true) {
							window.location.href = location.href;
						}
						return
					} else {}
				},
				"json");
			});
		</script>

	</body>

</html>
