<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

/*
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
*/



 

//System.out.println(Profile.sdf3.format(cal.getTime()));

int psid = 0;
try{
	psid=Integer.parseInt(teasession.getParameter("psid"));
}catch(NumberFormatException   e)   
{   
    out.println("<script>alert('您的操作不正确,系统禁止这样操作.');history.go(-2);</script>");
} 
PerformStreak psobj = PerformStreak.find(psid); 

//如果网上订票结束，则不能定座
if(!psobj.isTiems())
{   
	out.print("<script>");
	out.print("alert('网上预订票已经结束!');");
	out.print("history.go(-2);");
	out.print("</script>");
}

//演出名称
Node nobj1= Node.find(psobj.getNode());
//演出场馆
Node nobj2 = Node.find(psobj.getVenues());

Seat sobj = Seat.find(psobj.getVenues());

  //列数
  int row = sobj.getRow();
  int linage=sobj.getLinage();

if(row==0)
{
  row = 10;
}
if(linage == 0)
{
  linage = 10;
}

tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>

<title>在线选座</title>
</head>

<body id="bodynone2" >
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<!-- 禁止另存为 -->
<noscript><iframe src="*.htm"></iframe></noscript>

<div class="bodyFramework">
<script>
//15分钟刷新页面
window.history.forward(1);

 //控制右键
function stop(){
return false;
}
document.oncontextmenu=stop;
//控制选择文本
var omitformtags=["input", "textarea", "select"]

omitformtags=omitformtags.join("|")

function disableselect(e){
if (omitformtags.indexOf(e.target.tagName.toLowerCase())==-1)
return false
}

function reEnable(){
return true
}

if (typeof document.onselectstart!="undefined")
document.onselectstart=new Function ("return false")
else{
document.onmousedown=disableselect
document.onmouseup=reEnable
}




var a = 0;
var pr = 0;
var np = "/";
       function myImgs(igd,url,Region,Linagenumber,Seatnumber,Price)
       {

            var imgs= document.getElementById("myimg" + igd);//.style.backgroundColor = "red";
			if(imgs.x!="1")//选中以后
			{
				if(a>4)
	      		{
	      			alert('自助选座最多只能选择5个座位!');
	      			return false;
	      		}
	      		//票的信息
	      		var venues= form1.Venues.value;//场馆名称

			    imgs.x="1";
				imgs.src ='/tea/image/piao/SELECTED.jpg';
				////添加一行
		        var newTr1 = testTbl.insertRow();

		        //添加两列
		        var newTd1 = newTr1.insertCell();

		        //设置列内容和属性
		        a++;
		        newTd1.innerHTML= '第'+a+'张票<br>位置:<b>'+venues+Region+Linagenumber+'排 '+Seatnumber+'号</b><br>价格:<b>'+Price+'元</b>';

		        pr =parseInt(pr)+parseInt(Price);
		        np=np+igd+"/";
			}else
			{
				imgs.x="0";
				imgs.src =url;
				testTbl.deleteRow();
				a--;
				pr = parseInt(pr)-parseInt(Price);
				np = form1.numbers.value.replace("/"+igd,"");
			}
          form1.numbers.value=np;
          form1.price.value= pr;
          document.getElementById('show').innerHTML = '数量：'+a+'张<br>总价:'+pr+'元<br><a href=# onclick=f_submit();><img src=/res/REDCOME/0909/09099966.gif></a>';
       }

    	function f_submit()
    	{
    		//判断是否选中

		//判断时间超时问题 清楚选定的座位
		 sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=OnlineReservations_f_submit&numbers="+form1.numbers.value+"&psid="+form1.psid.value,
		  function(data)
		  {

		    if(data.trim()!=null && data.trim().length>0 )
		    {
		    	alert(data.trim());
		    	window.open('/jsp/type/perform/OnlineReservations.jsp?psid='+form1.psid.value+'&community='+form1.community.value,'_self');
		    }else
		    {
		    	form1.action="/servlet/EditPerformOrders";
    		    form1.submit();
		    }
		  }
		  );

    	}
    	//显示层
    	function f_ver(url)
    	{
    		document.getElementById('showurl').innerHTML ="<img src = "+url+" width=50>";
    	}
 		function f_out()
 		{
 			document.getElementById('showurl').style.display='none';
 		}
</script>
<SCRIPT language=JavaScript>

var pltsPop=null;
var pltsoffsetX = 10;
var pltsoffsetY = 15;
var pltsPopbg="#ffffee";
var pltsPopfg="#111111";
var pltsTitle="";
document.write('<div id=pltsTipLayer style="display: none;position: absolute; z-index:10001"></div>');
function pltsinits()
{
    document.onmouseover= plts;
    document.onmousemove = moveToMouseLoc;
}
function plts()
{
   var o=event.srcElement;
    if(o.alt!=null && o.alt!=""){o.dypop=o.alt;o.alt=""};
    if(o.title!=null && o.title!=""){o.dypop=o.title;o.title=""};
    pltsPop=o.dypop;
    if(pltsPop!=null&&pltsPop!=""&&typeof(pltsPop)!="undefined")
    {
		pltsTipLayer.style.left=-1000;
		pltsTipLayer.style.display='';
		var Msg=pltsPop.replace(/\n/g,"<br>");
		Msg=Msg.replace(/\0x13/g,"<br>");
		var re=/\{(.[^\{]*)\}/ig;
		if(!re.test(Msg))pltsTitle="";
		else{
		  re=/\{(.[^\{]*)\}(.*)/ig;
			pltsTitle=Msg.replace(re,"$1")+"&nbsp;";
		  re=/\{(.[^\{]*)\}/ig;
		  Msg=Msg.replace(re,"");
		  Msg=Msg.replace("<br>","");}
		  var attr=(document.location.toString().toLowerCase().indexOf("list.asp")>0?"nowrap":"");
			   var content =
			  '<table  id=toolTipTalbe border=0><tr><td width="100%"><table class=selet_bg cellspacing="0" cellpadding="0" style="width:100%" style="font size:9pt;">'+
			  '<tr id=pltsPoptop><th height=12 valign=bottom class=header><p id=topleft align=left>'+pltsTitle+'</p><p id=topright align=right style="display:none">'+pltsTitle+'?§J</font></th></tr>'+
			  '<tr><td "+attr+" class=f_one style="padding-left:10px;padding-right:10px;padding-top: 4px;padding-bottom:4px;line-height:135%">'+Msg+'</td></tr>'+
			  '<tr id=pltsPopbot style="display:none"><th height=12 valign=bottom class=header><p id=botleft align=left>'+pltsTitle+'</p><p id=botright align=right style="display:none">'+pltsTitle+'</font></th></tr>'+
			  '</table></td></tr></table>';
			   pltsTipLayer.innerHTML=content;
			   toolTipTalbe.style.width=Math.min(pltsTipLayer.clientWidth,document.body.clientWidth/2.2);
			   moveToMouseLoc();
			   return true;
    }
    else
    {
        pltsTipLayer.innerHTML='';
        pltsTipLayer.style.display='none';
       return true;
    }
}

function moveToMouseLoc()
{
	if(pltsTipLayer.innerHTML=='')return true;
	var MouseX=event.x;
	var MouseY=event.y;
	//window.status=event.y;
	var popHeight=pltsTipLayer.clientHeight;
	var popWidth=pltsTipLayer.clientWidth;
	if(MouseY+pltsoffsetY+popHeight>document.body.clientHeight)
	{
		  popTopAdjust=-popHeight-pltsoffsetY*1.5;
		  pltsPoptop.style.display="none";
		  pltsPopbot.style.display="";
	}
	 else
	{
		  popTopAdjust=0;
		  pltsPoptop.style.display="";
		  pltsPopbot.style.display="none";
	}
	if(MouseX+pltsoffsetX+popWidth>document.body.clientWidth)
	{
		popLeftAdjust=-popWidth-pltsoffsetX*2;
		topleft.style.display="none";
		botleft.style.display="none";
		topright.style.display="";
		botright.style.display="";
	}
	else
	{
		popLeftAdjust=0;
		topleft.style.display="";
		botleft.style.display="";
		topright.style.display="none";
		botright.style.display="none";
	}
	pltsTipLayer.style.left=MouseX+pltsoffsetX+document.body.scrollLeft+popLeftAdjust;
	pltsTipLayer.style.top=MouseY+pltsoffsetY+document.body.scrollTop+popTopAdjust;
	return true;
}
pltsinits();
</SCRIPT>
<form name="form1" action="/jsp/type/perform/PerformOrders1.jsp" method="post">

<input type="hidden" name="act" value="OnlineReservations">
<input type="hidden" name="numbers" value="/">
<input type="hidden" name="price" value="">
<input type="hidden" name="Venues" value="<%=nobj2.getSubject(teasession._nLanguage) %>">
<input type="hidden" name="psid" value="<%=psid %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
<div class="header">
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099950.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
    <td><img src="/res/REDCOME/0909/09099948.gif"></td>
    <td><img src="/res/REDCOME/0909/09099947.gif"></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" class="title">
  <tr>
    <td><img src="/res/REDCOME/0909/09099951.gif"></td>
    <td><img src="/res/REDCOME/0909/09099952.gif"></td>
    <td><img src="/res/REDCOME/0909/09099953.gif"></td>
    <td><img src="/res/REDCOME/0909/09099954.gif"></td>
    <td><img src="/res/REDCOME/0909/09099955.gif"></td>
  </tr>
</table>
<div class="PerInfo"><%=nobj1.getSubject(teasession._nLanguage) %>　演出时间：<%=psobj.getPftimeToString() %>　演出场馆：<%=nobj2.getSubject(teasession._nLanguage) %>
</div>
</div>
<span id ="showurl" >&nbsp;</span>
  <table border="0" cellpadding="0" cellspacing="0" class="Seatingall">
  <tr>
<td class="Seatingtdleft">
<div class="SeatingLeft">
  <div class="SeatingLeftCon">
	<div class="title"><img src="http://ntcc.redcome.com/res/REDCOME/0909/09099943.gif"></div>
<div class="Seats">
<input type="hidden" name="number_str" value="">
  <table border="0" cellpadding="0" cellspacing="0">

  <%

  for(int i=1;i<=linage*row;i++)
  {

    SeatEditor seobj = SeatEditor.find(i,psobj.getVenues());//显示场馆设置好的分布图
	// 视位图
	SeatPic spic = SeatPic.find(seobj.getPicid());
    PriceDistrict pdobj = PriceDistrict.find(i,psid);//分区价格显示图
    if(i%row==1){
      out.print("<tr>");

    }
//onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''
    out.print("<td  ");
    if(seobj.isExists())
    {
      out.print("   bgcolor=\"#CCCCCC\" ");
    }

    out.print(">");
    if(pdobj.isExist())
    {
    	 PriceSubarea psobj2 = PriceSubarea.find(pdobj.getPricesubareaid());
	     SeatPic spobj = SeatPic.find(psobj2.getPicturepath());


    	if(OrderDetails.isPitchon(psid,i))//显示已经销售
    	{
    		out.print("<img src=/tea/image/piao/LOCK.jpg style=cursor:pointer ");
    		out.print(" title= \"");
        	out.print("<img src='"+spic.getPicpath()+"'>&#10;");
        	out.print("楼层:"+seobj.getRegion()+"&#10;");
        	out.print("排号:"+seobj.getLinagenumber()+"&#10;");
        	out.print("座号:"+seobj.getSeatnumber()+"&#10;");
        	out.print("价格:"+psobj2.getPrice()+"元&#10;");
	    	out.print("状态:已经售完");
	    	out.print(" \" ");
    		out.print(">");
    	}else
    	{

	    	out.print("<img src = "+spobj.getPicpath());
	    	out.print(" title= \"");
	    	out.print("<img src='"+spic.getPicpath()+"'>&#10;");
	    	out.print("楼层:"+seobj.getRegion()+"&#10;");
	    	out.print("排号:"+seobj.getLinagenumber()+"&#10;");
	    	out.print("座号:"+seobj.getSeatnumber()+"&#10;");
	    	out.print("价格:"+psobj2.getPrice()+"元&#10;");
	    	out.print("状态:可以订票");
	    	out.print(" \" ");
	    	out.print(" id =myimg"+i+"  name=myimg"+i);
	    	out.print(" onclick=myImgs('"+i+"','"+spobj.getPicpath()+"','"+seobj.getRegion()+"','"+seobj.getLinagenumber()+"','"+seobj.getSeatnumber()+"','"+psobj2.getPrice()+"');  style=cursor:pointer");
	    	out.print(" >");
    	}
    }
    out.print("</td>");

    if(i%row==0){
      out.print("</tr>");

    }

  }



  %>
  </table>
  </div>
</form>
 <div class="Notes">
<ul>
		<%
		out.print("<li><img src=/tea/image/piao/LOCK.jpg>&nbsp;<span>已经售出的座位</span></li>");
		Enumeration e = PriceSubarea.find(teasession._strCommunity," and psid ="+psid,0,20);
		while(e.hasMoreElements())
		{
			int prsid = ((Integer)e.nextElement()).intValue();
			PriceSubarea prsobj = PriceSubarea.find(prsid);
			SeatPic spobj = SeatPic.find(prsobj.getPicturepath());

			out.print("<li>");
			out.print("<img src="+spobj.getPicpath()+">&nbsp;");
			out.print("<span>"+prsobj.getSubareaname());
			out.print(prsobj.getPrice()+"元</span>");
			out.print("</li>");
		}
		out.print("<li><img src=/tea/image/piao/SELECTED.jpg>&nbsp;<span>选择的座位</span></li>");

		 %>

</ul>
</div>
</div>
</div>
</td>
<td class="Seatingtdright">
<div class="Seatingright">
	<div class="Tickets">
    <div class="TicketsCon">
    <div class="title">选座信息：</div>
<table id="testTbl" ellpadding="0" cellspacing="0" border="0">
</table>
<span id="show"></span>
</div>
<div class="Ticketsbottom"></div>
</div>
<div class="Indicate">注：在已选择的座位上单击可取消选择；<br>
自助选座最多可选5个座位
请尽快选座订购，以免您需要的座位被其他人抢先订购；
预定15分钟后如不付款，系统会自动清空您的座位信息。	</div>
    </div>
     </td></tr></table>
    </div>
        </div>

     <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
