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
if(t==null||t.getTime()==null||t.getType()!=2||t.isHidden()){
	//out.print("活动已结束");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=2").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=2&type=2");
	return;
}

//查看当前微活动，是否设置奖项
List<WxActivityPrize> actyPrizeList = WxActivityPrize.find(" AND activityId="+t.getId(), 0, Integer.MAX_VALUE);
if(actyPrizeList==null||actyPrizeList.size()<1){
	//out.print("活动已结束");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=2").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=2&type=2");
	return;
}

Date nowDate = new Date();
long nowTimes = nowDate.getTime();
if(nowTimes<t.getStarttime().getTime()){
	//out.print("未开始");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=1&type=2").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=1&type=2");
	return;
}else if(nowTimes>t.getStoptime().getTime()){
	//out.print("已结束");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=2").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=2&type=2");
	return;
}

int totalOfPerson = WxActivityMem.count(" AND activityId="+t.getId()+" AND member="+h.member);
if(totalOfPerson>=t.getTotalOfPerson()){//如果当前用户抽奖次数达到微活动 每人参与的总次数，不能再次抽奖
	//out.print("亲，您本次活动的机会用完了，看看其他的活动吧。");//out.print("亲，您今日的机会用完了，明天再来吧。");
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=3&type=2&nochance=1").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=3&type=2&nochance=1");
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
	request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=3&type=2&nochance=1").forward(request, response);
	//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=3&type=2&nochance=1");
	return;
}

//今天还有几次参与机会
int residualNum = t.getNumOfDay()-numOfDay;
//System.out.print("t.getNumOfDay()="+t.getNumOfDay()+",numOfDay="+numOfDay);
/* WxGetGift gg = new WxGetGift(t.getId(),h.member);
WxActivityPrize p = gg.findPrizeByActivityId(); */

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<title>幸运水果机</title>
<link href="/tea/weixin/css/activity-style.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
<script src="/tea/weixin/js/alert.js" type="text/javascript"></script>
<script src="/tea/weixin/js/jQueryRotate.2.2.js" type="text/javascript"></script>
<script src="/tea/weixin/js/jquery.easing.min.js" type="text/javascript"></script>
</head>

<body data-role="page" class="activity-scratch-card-winning">

	<div class="main">
		<%-- <div class="cover">
		<%
		if(t.getAttch()>0){
			out.print("<img src='"+Attch.find(t.getAttch()).path+"'>");
		}
		%>
		</div> --%>
		<div class="content title">
			<div class="boxcontent boxyellow">
				<div class="Detail">
					<p>
						<%=MT.f(t.getName()) %>
					</p>
				</div>
			</div>
		</div>
		<div class="tigerslot ui-content">
			<div class="machine">
                <div class="strip left">
                    <div class="box" style="background-position: 0px 0px;"></div>
                    <div class="cover"></div>
                </div>
                <div class="strip middle">
                    <div class="box" style="background-position: 0px 0px;"></div>
                    <div class="cover"></div>
                </div>
                <div class="strip right">
                    <div class="box" style="background-position: 0px 0px;"></div>
                    <div class="cover"></div>
                </div>
                <div class="gamebutton"></div>
            	<div class="light l0 on"></div><div class="light l1 on"></div><div class="light l2 on"></div><div class="light l3 on"></div><div class="light l4 on"></div><div class="light l5 on"></div><div class="light l6 on"></div><div class="light l7 on"></div><div class="light l8 on"></div><div class="light l9"></div><div class="light l10 on"></div><div class="light l11 on"></div><div class="light l12 on"></div><div class="light l13 on"></div><div class="light l14 on"></div><div class="light l15 on"></div><div class="light l16 on"></div><div class="light l17 on"></div><div class="light l18 on"></div><div class="light l19 on"></div><div class="light l20 on"></div><div class="light l0 on"></div><div class="light l1"></div><div class="light l2 on"></div><div class="light l3"></div><div class="light l4 on"></div><div class="light l5"></div><div class="light l6 on"></div><div class="light l7"></div><div class="light l8 on"></div><div class="light l9"></div><div class="light l10 on"></div><div class="light l11"></div><div class="light l12 on"></div><div class="light l13"></div><div class="light l14 on"></div><div class="light l15"></div><div class="light l16 on"></div><div class="light l17"></div><div class="light l18 on"></div><div class="light l19"></div><div class="light l20 on"></div>

	    	</div>

		</div>

		<%-- <div class="content">
			<div id="zjl" style="display:none;" class="boxcontent boxwhite">
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
							<input type="hidden" id="jxint" value="0"/>
							<input name="" id="winActivityMemId" value="" type="hidden"/>
							<input name="" class="px" id="tel" mask="int" value="" type="text" placeholder="用户请输入您的手机号"/>
						</p>
						<p>
							<p>
								<input class="pxbtn" name="提 交" id="save-btn" type="button" value="用户提交">
							</p>
					</div>
				</div>
			</div>
		</div> --%>
		<div class="content">
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
(function () {
	  var lastTime = 0;
	  var vendors = ['ms', 'moz', 'webkit', 'o'];
	  for (var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
	      window.requestAnimationFrame = window[vendors[x] + 'RequestAnimationFrame'];
	      window.cancelAnimationFrame = window[vendors[x] + 'CancelAnimationFrame']
	                                 || window[vendors[x] + 'CancelRequestAnimationFrame'];
	  }

	  if (!window.requestAnimationFrame)
	      window.requestAnimationFrame = function (callback, element) {
	          var currTime = new Date().getTime();
	          var timeToCall = Math.max(0, 16 - (currTime - lastTime));
	          var id = window.setTimeout(function () { callback(currTime + timeToCall); },
	            timeToCall);
	          lastTime = currTime + timeToCall;
	          return id;
	      };

	  if (!window.cancelAnimationFrame)
	      window.cancelAnimationFrame = function (id) {
	          clearTimeout(id);
	      };
	}());

	(function () {
	  window.GameTimer = function (fn, timeout) {
	      this.__fn = fn;
	      this.__timeout = timeout;
	      this.__running = false;
	      this.__lastTime = Date.now();
	      this.__stopcallback = null;
	  };

	  window.GameTimer.prototype.__runer = function () {
	      if (Date.now() - this.__lastTime >= this.__timeout) {
	          this.__lastTime = Date.now();
	          this.__fn.call(this);
	      }
	      if (this.__running) {
	          window.requestAnimationFrame(this.__runer.bind(this));
	      }
	      else {
	          if (typeof this.__stopcallback === 'function') {
	              window.setTimeout(this.__stopcallback,100);
	          }
	      }
	  };

	  window.GameTimer.prototype.start = function () {
	      this.__running = true;
	      this.__runer();
	  };
	  window.GameTimer.prototype.stop = function (callback) {
	      this.__running = false;
	      this.__stopcallback = callback;
	  };

	})();
	var lhjjx = [
	{ left:8, middle:8,right:8},//1等级
	{ left:2, middle:2,right:2},//2等级
	{ left:6, middle:6,right:6},//3等级
	{ left:1, middle:1,right:1},//4等级
	{ left:4, middle:4,right:4},//5等级
	{ left:3, middle:3,right:3}//6等级
	];
	$(function () {

	  var toLeftIndex = 0;
	  var toMiddleIndex = 0;
	  var toRightIndex = 0;
	  var itemPositions = [
	      0, //苹果
	      100,//芒果
	      200,//布林
	      300,//香蕉
	      400,//草莓
	      500,//梨
	      600,//桔子
	      700,//青苹果
	      800//樱桃
	  ];

	  var jxint = 0;

	  //游戏开始
	  var gameStart = function () {
	      lightFlicker.stop();
	      lightRandom.stop();
	      lightCycle.start();

	      sendx("/WxActivitys.do?act=fruitMachine&wxActivity=<%=t.getId()%>",
				function(data)
				{
		    		eval("v="+data);

		    		var abnormalUrl = v.abnormalUrl;
					if(abnormalUrl!=null){
						location.href=abnormalUrl;
						return;
					}

		    		if(v.id>0){//有奖
		    			//游戏开始，指定用户的结果，从左到右，水果编码，从0开始。
		    			var jxint = parseInt(v.seq);
		    		    $('#jxint').val(jxint);
		    		    boxCycle.start(lhjjx[jxint-1]);
		    		}else{//没奖 start
						var needsjint = true;
	    		    	while(needsjint){
	    		    		var vv1 = Math.round(Math.random() * 8);
	    		            var vv2 = Math.round(Math.random() * 8);
	    		            var vv3 = Math.round(Math.random() * 8);
	    		            if(vv1 == vv2 && vv2 == vv3){
	    		            	needsjint = true;
	    		            }else{
	    		            	needsjint = false;
	    		            	boxCycle.start({ left:vv1, middle:vv2,right:vv3});
	    		            }
	    		    	}
					}//没奖 end
				}
	      );



	  };

	  //游戏结束
	  var gameOver = function (resultData) {
	      lightFlicker.start();
	      lightRandom.stop();
	      lightCycle.stop();
	      $('.machine .gamebutton').removeClass('disabled');

	  };



	  var $machine = $('.machine');
	  var $slotBox = $('.tigerslot .box');
	  var light_html = '';
	  for (var i = 0; i < 21; i++) {
	      light_html += '<div class="light l'+ i +'"></div>';
	  }
	  var $lights = $(light_html).appendTo($machine);



	  var $gameButton = $('.machine .gamebutton').click(function () {
	      var $this = $(this);
	      if (!$this.hasClass('disabled')) {
	          $this.addClass('disabled');
	          $this.toggleClass(function (index, classname) {
	              if (classname.indexOf('stop') > -1) {
	                  boxCycle.stop(function (resultData) {
	                      gameOver(resultData);
	                      //$this.removeClass('disabled');
	                  });
	              } else {
	                  gameStart();
	                  window.setTimeout(function () {
	                      $this.removeClass('disabled');
	                  },1500);
	              }
	              return 'stop';
	          });
	      }
	  });


	  var lightCycle = new function () {
	      var currIndex = 0, maxIndex = $lights.length - 1;
	      $('.l0').addClass('on');
	      var tmr = new GameTimer(function () {
	          $lights.each(function(){
	              var $this = $(this);
	              if($this.hasClass('on')){
	                  currIndex++;
	                  if (currIndex > maxIndex) {
	                      currIndex = 0;
	                  }
	                  $this.removeClass('on');
	                  $('.l' + currIndex).addClass('on');
	                  return false;
	              }
	          });
	      }, 100);
	      this.start = function () {
	          tmr.start();
	      };
	      this.stop = function () {
	          tmr.stop();
	      };
	  };
	  var lightRandom = new function () {
	      var tmr = new GameTimer(function () {
	          $lights.each(function () {
	              var r = Math.random() * 1000;
	              if (r < 400) {
	                  $(this).addClass('on');
	              } else {
	                  $(this).removeClass('on');
	              }
	          });
	      }, 100);
	      this.start = function () {
	          tmr.start();
	      };
	      this.stop = function () {
	          tmr.stop();
	      };
	  };

	  var lightFlicker = new function () {
	      $lights.each(function (index) {
	          if ((index >> 1) == index / 2) {
	              $(this).addClass('on');
	          } else {
	              $(this).removeClass('on');
	          }
	      });
	      var tmr = new GameTimer(function () {
	          $lights.toggleClass('on');
	      }, 100);
	      this.start = function () {
	          tmr.start();
	      };
	      this.stop = function () {
	          tmr.stop();
	      };
	  };


	  var boxCycle = new function () {

	      var speed_left = 0, speed_middle = 0, speed_right = 0, maxSpeed = 25;
	      var running = false, toStop = false, toStopCount = 50;
	      var boxPos_left = 0, boxPos_middle = 0, boxPos_right = 0;

	      var resultData;

	      var $box = $('.tigerslot .box'), $box_left = $('.tigerslot .strip.left .box'), $box_middle = $('.tigerslot .strip.middle .box'), $box_right = $('.tigerslot .strip.right .box');

	      var fn_stop_callback = null;

	      var tmr = new GameTimer(function () {
	          if (toStop) {
	              toStopCount--;

	              if (toStopCount < 0) {
	                  speed_right = 0;
	                  boxPos_right = -itemPositions[toRightIndex];
	              }else if (toStopCount < 25) {
	            	  speed_middle = 0;
	                  boxPos_middle = -itemPositions[toMiddleIndex];
	                  boxPos_right += speed_right;
	              }else{
	            	  speed_left = 0;
	                  boxPos_left = -itemPositions[toLeftIndex];
	                  boxPos_middle += speed_middle;
	                  boxPos_right += speed_right;
	              }
	          } else {
	              speed_left += 1;
	              speed_middle += 1;
	              speed_right += 1;
	              if (speed_left > maxSpeed) {
	                  speed_left = maxSpeed;
	              }
	              if (speed_middle > maxSpeed) {
	                  speed_middle = maxSpeed;
	              }
	              if (speed_right > maxSpeed) {
	                  speed_right = maxSpeed;
	              }
	              boxPos_left += speed_left;
	              boxPos_middle += speed_middle;
	              boxPos_right += speed_right;
	          }

	          $box_left.css('background-position', '0 ' + boxPos_left + 'px')
	          $box_middle.css('background-position', '0 ' + boxPos_middle + 'px')
	          $box_right.css('background-position', '0 ' + boxPos_right + 'px')

	          if (speed_left <= 0 && speed_middle <= 0 && speed_right <= 0) {
	              tmr.stop();
	              tellcjok();
	          }

	      }, 33);

	      this.start = function (data) {
	          toLeftIndex = data.left; toMiddleIndex = data.middle; toRightIndex = data.right;
	          running = true; toStop = false;
	          resultData = data;
	          tmr.start();
	      };

	      this.stop = function (fn) {
	          fn_stop_callback = fn;
	          toStop = true;
	          toStopCount = 50;
	      };


	      this.reset = function () {
	          $box_left.css('background-position', '0 ' + itemPositions[0] + 'px');
	          $box_middle.css('background-position', '0 ' + itemPositions[0] + 'px');
	          $box_right.css('background-position', '0 ' + itemPositions[0] + 'px');
	      };
	      this.reset();
	  };


	  //初始给点欢乐
	  lightFlicker.start();
	  window.setTimeout(function () {
	      lightFlicker.stop();
	  }, 2000);

	});

	function tellcjok(){
		//游戏开始，指定用户的结果，从左到右，水果编码，从0开始。
	    var jxint = parseInt($('#jxint').val());
	    if(jxint && jxint>0){//有奖
	    	$("#theAward").html(v.name);//奖项
	    	$("#winActivityMemId").val(v.winActivityMemId);
			setPrizeMem();
	    }else{
	    	tusi("很遗憾，您没有中奖");
			setTimeout(function(){
				location.reload(true);
			},1888);
		}

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
