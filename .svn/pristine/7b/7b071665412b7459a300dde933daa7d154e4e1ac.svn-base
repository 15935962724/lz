<%@page import="tea.entity.nba.PointGift"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int type = h.getInt("type");
String activityUrl = "";
if(type==1){//刮刮卡
	activityUrl = "WxScratchCard.jsp";
}else if(type==2){//幸运水果机
	activityUrl = "WxFruitMachine.jsp";
}else if(type==3){//幸运大转盘
	activityUrl = "WxTurntable.jsp";
}else if(type==4){//砸金蛋
	activityUrl = "WxSmashEggs.jsp";
}

WxActivity t=WxActivity.find(h.getInt("wxActivity"));

String url = "http://"+request.getHeader("Host");
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div class="alert-info" align="left">
<P><SPAN class=bold>说明：</SPAN><%=WxActivity.TYPEARR[type]%>是一种游戏促销模式。&nbsp;&nbsp;<FONT color=red>（如需使用链接，请复制下方地址）</FONT></P>
<P><SPAN class=bold>当前地址：</SPAN><%=url%>/jsp/weixin/<%=activityUrl%>?wxActivity=<%=t.getId()>0?t.getId():"" %></P>
</div>

<form name="form1" action="/WxActivitys.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxActivity" value="<%=t.getId()%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td width="10%"><span style="color:red;">*</span><%=WxActivity.TYPEARR[type]%>名称</td>
    <td><input name="name" value="<%=MT.f(t.getName())%>" alt="<%=WxActivity.TYPEARR[type]%>名称"/></td>
  </tr>
  <tr>
    <td><span style="color:red;">*</span>活动关键字</td>
    <td><input name="keyword" value="<%=MT.f(t.getKeyword())%>" alt="活动关键字"/></td>
  </tr>
  <tr>
    <td><span style="color:red;">*</span>活动开始时间</td>
    <td><input name="starttime" value="<%=MT.f(t.getStarttime(),1)%>" alt="活动开始时间" readonly="readonly" onclick="mt.date(this,true)" class="date"/></td>
  </tr>
  <tr>
    <td><span style="color:red;">*</span>活动结束时间 </td>
    <td><input name="stoptime" value="<%=MT.f(t.getStoptime(),1)%>" alt="活动结束时间 " readonly="readonly" onclick="mt.date(this,true)" class="date"/></td>
  </tr>
  <tr>
    <td>活动展示图片</td>
    <td width="50px"><input name="attch" type="file" />
    	<%
        if(t.getAttch()!=0){
        	if(t.getAttch()!=0)out.print(" <a href='###' onclick=mt.img('"+Attch.find(t.getAttch()).path+"')>查看</a>");
        	out.print("<input type='hidden' name='attch.attch' value='"+t.getAttch()+"' />");
        }
        %></td>
  </tr>
  <tr>
    <td>活动简述</td>
    <td>
    	<textarea name="info" cols="60" rows="5"><%=MT.f(t.getInfo())%></textarea>
    	<div class='chus'><span id="info">还能输入</span><b id="count">200</b>字</div>
    </td>
  </tr>
  <tr>
    <td></td>
    <td>
      <input name="hidden" type="checkbox" value="1" id="hidden_1" <%if(t.isHidden())out.print(" checked ");%>/><label for="hidden_1">隐蔽/显示</label>
    </td>
  </tr>
  
</table>

<h3 style="text-align: center;">奖项设置</h3>

<table id="tablecenter" cellspacing="0">
  <tbody id="prizeTbody">
  <tr>
  	<td></td>
  	<td><span style="color:red;">*</span>奖项名称</td>
  	<td><span style="color:red;">*</span>奖品</td>
  	<td><span style="color:red;">*</span>奖品数量</td>
  	<td><span style="color:red;">*</span>中奖概率</td>
  	<td>操作</td>
  </tr>
  <%
  ArrayList<WxActivityPrize> wxacPrizeList = WxActivityPrize.find(" AND activityId="+t.getId()+" order by sequence,id asc",0,Integer.MAX_VALUE);
  if(wxacPrizeList==null||wxacPrizeList.size()<1)wxacPrizeList.add(new WxActivityPrize(0));
  for(int i=0;i<wxacPrizeList.size();i++){
	  out.print("<tr id='ptr_"+(i+1)+"' name='ptr'>");
	  WxActivityPrize prize = wxacPrizeList.get(i);
	  PointGift pg = PointGift.find(prize.getPgId());
	  out.print("<td>奖项"+(i+1)+"</td>");
	  out.print("<td><input type='hidden' name='prize_id' class='prize_id' value='"+prize.getId()+"' /><input name='prize_name' alt='奖项名称' value='"+MT.f(prize.getName())+"' /></td>");
	  out.print("<td>");
	  out.print("<input type='type' name='prize_pgName' alt='奖品' value='"+MT.f(pg.getgName())+"' />");
	  out.print("<input type='hidden' name='prize_pgId' mask='int' value='"+MT.f(pg.getId())+"' />");
	  out.print("&nbsp;&nbsp;<input class='btn btn-primary btn-xs' type='button' value='选择奖品' onclick=\"showPrizes(this)\" />");
	  out.print("</td>");
	  out.print("<td><input name='prize_num' alt='奖品数量' mask='int' value='"+MT.f(prize.getNum())+"' /></td>");
	  out.print("<td><input name='prize_probability' alt='中奖概率' mask='float' value='"+MT.f(prize.getProbability()*100)+"' />%</td>");
	  out.print("<td><a href='###' onClick=\"mt.act('del',this)\">删除</a></td>");
	  out.print("</tr>");
  }
  %>
  <!-- <tr>
  	<td colspan="5"><input type="button" value="添加奖项" onclick="mt.add();"/></td>
  </tr> -->
  </tbody>
  <tbody>
  	<tr>
  		<td align="left" colspan="6">
  			<input type="button" value="添加奖项" onclick="mt.act('add');"/>
  			<%
			if(type==3)
			{
			%>
			<span style="color:red;">奖项最多为六个</span>
			<%
			}
			%>
  		</td>
  	</tr>
  </tbody>
</table>

<h3 style="text-align: center;">其他设置</h3>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td width="10%">是否显示奖品数量</td>
    <td><input name="showNum" type="checkbox" value="1" <%if(t.isShowNum())out.print(" checked ");%> /><label for="hidden_1">取消选择后在活动页面中将不会显示奖品数量 </label></td>
  </tr>
  <tr>
    <td><span style="color:red;">*</span>每人参与的总次数</td>
    <td><input name="totalOfPerson" value="<%=MT.f(t.getTotalOfPerson())%>" mask="int" alt="每人参与的总次数"/></td>
  </tr>
   <tr>
    <td><span style="color:red;">*</span>每人每天可参与次数</td>
    <td><input name="numOfDay" value="<%=MT.f(t.getNumOfDay())%>" mask="int" alt="每人每天可参与次数"/></td>
  </tr>
   <tr>
    <td><span style="color:red;">*</span>每天最多出奖数量</td>
    <td><input name="maxNumOfDay" value="<%=MT.f(t.getMaxNumOfDay())%>" mask="int" alt="每天最多出奖数量"/><label for="maxNumOfDay">0为不限制出奖数</label></td>
  </tr>
  
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
<script type="text/javascript">
var prizeTbody = document.getElementById("prizeTbody");
var prizeTrArr=prizeTbody.getElementsByTagName("TR");//document.getElementById("clone_tab")
var TEMP=prizeTrArr[prizeTrArr.length-1].cloneNode(true);//document.getElementById("clone_tbody").firstChild.cloneNode(true);
//alert(TEMP.innerHTML);
//var prizeTit = TEMP.firstChild.innerHTML.substring(0,TEMP.firstChild.innerHTML.length-1);
//alert(prizeTit);
mt.act=function(a,t){
	if(a=="add"){
		  if(<%=type==3%>){
			  var prizeCount = prizeTrArr.length-1;
			  if(prizeCount>=6){
				  mt.show("奖项最多为六个");
				  return;
			  }
		  }
		  
		  var b=TEMP.cloneNode(true);
		  var index = prizeTrArr.length;
		  //var newPrizeTit = prizeTit+index;
		  //var ptrIdVal = b.getAttribute("id").substring(0,b.getAttribute("id").length-1)+index;
		  var newPtrIdStr = "ptr_"+index;
		  b.setAttribute("id",newPtrIdStr);
		  b.firstChild.innerHTML="奖项"+index;//newPrizeTit;
		  
		  prizeTbody.appendChild(b);
		  
		  //alert(newPtrIdStr);
		  $("#"+newPtrIdStr+" input[name='prize_id']").val("0");
		  $("#"+newPtrIdStr+" input[name='prize_name']").val("");
		  $("#"+newPtrIdStr+" input[name='prize_num']").val("");
		  $("#"+newPtrIdStr+" input[name='prize_probability']").val("");
		  $("#"+newPtrIdStr+" input[name='prize_pgName']").val("");
		  $("#"+newPtrIdStr+" input[name='prize_pgId']").val("");
	}else if(a=="del"){
		var index = prizeTrArr.length-1; 
		if(index!=1){
			var prizeId = $(t).parent().parent().find(".prize_id").val();
			//alert(prizeId);
		    mt.show('确认删除？',2);
			mt.ok=function()
			{
				if(prizeId>0){
					mt.send("/WxActivityPrizes.do?act=del&wxActivityPrize="+prizeId, function(data) {
						if(data==""){
							mt.show("删除成功！");
							while(t.tagName!='TR')t=t.parentNode;
						    var c=t.parentNode;
						    c.removeChild(t);
						}else{
							mt.show(data);
						}
					});
				}else{
					while(t.tagName!='TR')t=t.parentNode;
				    var c=t.parentNode;
				    c.removeChild(t);
				}
			};
		}else{
			mt.show('奖项数量不能为零！');
		}
	}
};

/* function ToFixed(t){
	if(t.value){
		var v = parseFloat(t.value);
		v = v.toFixed(4);
		t.value = v;
	}
		
} */

var fc=form1.info;
fc.onpropertychange=fc.oninput=function()
{
  var len=200-this.value.length;
  $$('info').innerHTML=len<0?"已经超过":"还能输入";
  var c=$$('count');
  c.innerHTML=Math.abs(len);
  c.style.color=len<0?"red":"";
};
fc.oninput();

var ptrIdStr = 0;
function showPrizes(t){
	while(t.tagName!='TR')t=t.parentNode;
	ptrIdStr = t.getAttribute("id");
	var pgId = $("#"+ptrIdStr+" input[name='prize_pgId']").val();
	//alert(pgId);
	var str = "(0,";
	if($("#prizeTbody tr[name='ptr']").length>0){
		$("#prizeTbody input[name='prize_pgId']").each(function(){
			if(pgId!=this.value){
				str += ","+ this.value ;
			}
			
		});
	}
	str+=")";
	str = str.replace(",", "");
	//alert(str);
	mt.show("/jsp/nba/PointGiftSel.jsp?str="+str,2,"查询商品",800,400);
}

mt.setPrize=function(prizeId,prizeName){
	//alert(prizeId+prizeName);
	$("#"+ptrIdStr+" input[name='prize_pgId']").val(prizeId);
	$("#"+ptrIdStr+" input[name='prize_pgName']").val(prizeName);
};

</script>
</body>
</html>
