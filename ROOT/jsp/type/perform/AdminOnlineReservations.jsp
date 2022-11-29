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

if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
//System.out.println(Profile.sdf3.format(cal.getTime()));

int psid = Integer.parseInt(teasession.getParameter("psid"));
String nexturl = request.getRequestURI()+"?psid="+psid+request.getContextPath();

PerformStreak psobj = PerformStreak.find(psid);

//如果出票结束，则不能定座
if(!psobj.isAdminTiems())
{
	out.print("<script>");
	out.print("alert('出票时间已经结束,您不能出票了!');");
	out.print("history.go(-1);");
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

<body id="bodySpecial" onLoad="f_onload();">
<script>
function f_onload()
{
	f_perform();

}
function f_perform()// 选择演出 联动场次
	{
		sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=AdminOnlineReservat_f_perform&perform="+form2.perform.value+"&community="+form2.community.value+"&psid=<%=psid%>",
		  function(data)
		  {
		    document.getElementById("performstreakid").innerHTML=data.trim();
		    f_performstreak();
		  }
		  );

	}
function f_performstreak()//选择场次 动态显示场次信息
{
	sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=AdminOnlineReservat_f_performstreak&performstreak="+form2.performstreak.value+"&community="+form2.community.value,
		  function(data)
		  {
		     form2.psid.value = form2.performstreak.value;
		    document.getElementById("showxx").innerHTML=data.trim();
		  }
		  );

}
//刷新提交
function f_submit2()
{
if(form2.performstreak.value==0)
{
	alert("请选择场次!");
	return false;
}
	form2.submit();
}
//选择演出信息
function f_perform2()
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:405px;';
  var url = '/jsp/type/perform/inquiryPerform.jsp';
  var rs = window.showModalDialog(url,self,y);
  if(rs>0)
  {
    form2.perform.value=rs;
  }
}
</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<div class="TicketSearch">
<form  name="form2" action="?" methed ="get">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
<input type="hidden" name="psid" value="<%=psid %>">
<script src="/jsp/type/perform/eme.js" type="text/javascript"></script>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td>
　　当前操作：<select name="perform" id="select" onChange="f_perform();">
		<%
		Enumeration pfen = Node.find(" and type = 55 and hidden = 0 and community = "+DbAdapter.cite(teasession._strCommunity),0,Integer.MAX_VALUE);
		while(pfen.hasMoreElements())
		{
			int nid = ((Integer)pfen.nextElement()).intValue();
			Node nobj = Node.find(nid);
			out.print("<option value= "+nid);
			if(psobj.getNode()==nid)
			{
				out.print(" selected ");
			}
			out.print(">"+nobj.getSubject(teasession._nLanguage));
			out.print("</option>");
		}
		%>
      </select>&nbsp;<img src="/tea/image/other/img-globe.gif" title="点击选择演出信息" style="cursor:pointer" onClick="f_perform2();">

</td>
<td>
场次：<span id="performstreakid">
<select name="performstreak" id="select">
      </select>
 <span>
 　

</td>
<td><span id ="showxx">&nbsp;</span></td>
<td class="td02"><a href=# onClick="f_submit2();">
<img src="/tea/image/public/reload.gif"> 刷新</a>
　　</td>
</table>
</form>
</div>
<div id="load" >
<img src="/tea/image/public/load.gif" align="top">正在加载...
</div>
<div class="bodyFramework">
<script>
//15分钟刷新页面

var a = 0;
var pr = 0;
var np = "/";
//var pr2 = 0;//价格
       function myImgs(igd,url,Region,Linagenumber,Seatnumber,Price,price_id)
       {

            var imgs= document.getElementById("myimg" + igd);//.style.backgroundColor = "red";
          //
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

		        //设置列内容和属性 s
		        a++;
		        newTd1.innerHTML= '第'+a+'张票<br>位置:<b>'+venues+Region+Linagenumber+'排 '+Seatnumber+'号</b><br>价格:<b><span id =p'+price_id+"#"+igd+'>'+Price+'</span>元</b>';

		///////******************************////////////////////
		var vote_s = form1.vote.value;
		var vote_1 = vote_s.split(",")[2];//票价的id号
		var vote_2 = vote_s.split(",")[3];//票价的价格
		//查找票价
		//alert(vote_s);
		for(var i = 1;i<vote_1.split("/").length;i++)
		{
			var vote_1_1 = vote_1.split("/")[i];//id
			var vote_2_2 = vote_2.split("/")[i];//价格

			if(price_id==vote_1_1)
			{
			    Price = vote_2_2;
				document.all('p'+vote_1_1+"#"+igd).innerHTML = Price;
				 document.getElementById("showzj").innerText =parseInt(document.getElementById("showzj").innerText)+parseInt(Price);
				 pr = document.getElementById("showzj").innerText;
			}
		}

		        //获取价格


		         // alert(pr+"---"+Price);
		         np=np+igd+"/"; //座位的id
		        //获取票种的价格的id

		        document.getElementById("price_id").value= document.getElementById("price_id").value+price_id+"/";//座位的票的区域id


			}else //取消座位
			{

				imgs.x="0";
				imgs.src =url;
				testTbl.deleteRow();
		     	a--;
				 //获取价格

				///////******************************////////////////////
				var vote_s = form1.vote.value;
				var vote_1 = vote_s.split(",")[2];//票价的id号
				var vote_2 = vote_s.split(",")[3];//票价的价格
				//查找票价

				for(var i = 1;i<vote_1.split("/").length;i++)
				{
					var vote_1_1 = vote_1.split("/")[i];//id
					var vote_2_2 = vote_2.split("/")[i];//价格
					//alert("price_id==vote_1_1:"+price_id==vote_1_1+"--"+price_id+":"+vote_1_1);
					var aa = price_id;
					var bb = vote_1_1;

					if(aa==bb)
					{
					    Price = vote_2_2;
						document.getElementById("showzj").innerText =parseInt(document.getElementById("showzj").innerText)-parseInt(Price);
						 pr = document.getElementById("showzj").innerText;
					}
				}

				np = form1.numbers.value.replace("/"+igd,"");
				//获取票种的价格的id
				form1.price_id.value= form1.price_id.value.replace("/"+price_id,"");//座位的票的区域id
			}

          form1.numbers.value=np;
          form1.price.value= pr;
         // alert(pr);


       //   alert(document.getElementById("showsl").innerText);

          document.getElementById("showsl").innerText=a;
          document.getElementById("showzj").innerText=pr;//总价格
          document.getElementById('show').style.display='';
          //document.getElementById('show').innerHTML = '数量：'+a+'张<br>总价:'+pr+'元<br><a href=# onclick=f_submit();><img src=/res/REDCOME/0909/09099966.gif></a>';
       }
//确认出票
	function f_submit()
	{

		//判断选择座位
		 sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=OnlineReservations_f_submit&numbers="+form1.numbers.value+"&psid="+form1.psid.value,
				  function(data)
				  {
				    if(data.trim()!=null && data.trim().length>0 )
				    {
				    	alert(data.trim());
				    	window.open('/jsp/type/perform/AdminOnlineReservations.jsp?psid='+form1.psid.value+'&community='+form1.community.value,'_self');
				    }else
				    {

						 if(confirm('确认出票?'))
					     {
						        var printApplet = document.getElementById("printApplet");
						       var n = form1.numbers.value;
						       var v = form1.vote.value;
						       var p = form1.psid.value;
						       var ip =form1.ip.value;
						       var sp = '?act=AdminOnlineReservations&numbers='+n+'&vote='+v+'&psid='+p;
						       openNewDiv('newDiv');

						       printApplet.openPrintApplet(ip,sp);
						       f_close('newDiv');

						}
						window.open(form1.nexturl.value,window.name);

				    }
				  }//判断订票时间 和 不选择座位点击
				  );


	}
	//打印预览/jsp/type/perform/PrintPreview.jsp
	function f_PrintPreview()
	{



		//判断选择座位
		 sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=OnlineReservations_f_submit&numbers="+form1.numbers.value+"&psid="+form1.psid.value,
				  function(data)
				  {
				    if(data.trim()!=null && data.trim().length>0 )
				    {
				    	alert(data.trim());
				    	window.open('/jsp/type/perform/AdminOnlineReservations.jsp?psid='+form1.psid.value+'&community='+form1.community.value,'_self');
				    }else
				    {

					       var n = form1.numbers.value;
					       var v = form1.vote.value;
					       var p = form1.psid.value;

						var vc = "edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:850px;dialogHeight:750px";
						var rs= window.showModalDialog('/jsp/type/perform/PrintPreview.jsp?numbers='+n+'&vote='+v+'&psid='+p,self,vc);
						if(rs>0)
						{
							window.open(form1.nexturl.value,window.name);
						}

				    }
				  }//判断订票时间 和 不选择座位点击
				  );


	}

//选择票种
function f_vote()
{
    //alert(document.getElementById('p5').value);
    var pr3 = 0;//价格

	var numbers_1 =form1.numbers.value;//座位ID
	var price_id_1 = form1.price_id.value;//票的id

	//查找票价
	 //alert(price_id_1);
	for(var j = 1;j<price_id_1.split("/").length-1;j++)
	{
		 var vote_s = form1.vote.value;
	    var vote_1 = vote_s.split(",")[2];//票价的id号
	    var vote_2 = vote_s.split(",")[3];//票价的价格
		for(var i = 1;i<vote_1.split("/").length;i++)
		{
			//var vote_1_1 = vote_1.split("/")[i];//id

			var numbers_1_1 =numbers_1.split("/")[j];
			var price_id_1_1 = price_id_1.split("/")[j];

			if(document.all('p'+price_id_1_1+"#"+numbers_1_1)!=null)
			{	//alert('p'+price_id_1_1+"#"+numbers_1_1+":"+document.all('p'+price_id_1_1+"#"+numbers_1_1).innerHTML);
			     var vote_1_1 = vote_1.split("/")[i];//id
			     var vote_2_2 =  vote_2.split("/")[i];//价格


				if(vote_1_1==price_id_1_1)
				{
					document.all('p'+price_id_1_1+"#"+numbers_1_1).innerHTML = vote_2_2;
					pr3 =parseInt(pr3)+parseInt(vote_2_2);
					break;
				}
			}
		}

	}
	//计算的总价格
	document.getElementById("showzj").innerText= pr3;
}
//会员卡出票
function f_member()
{
	//判断选择座位
	 sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=OnlineReservations_f_submit&numbers="+form1.numbers.value+"&psid="+form1.psid.value,
			  function(data)
			  {
			    if(data.trim()!=null && data.trim().length>0 )
			    {
			    	alert(data.trim());
			    	window.open('/jsp/type/perform/AdminOnlineReservations.jsp?psid='+form1.psid.value+'&community='+form1.community.value,'_self');
			    }else
			    {
					    	var vc = "edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px";
					    	sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=f_member&numbers="+form1.numbers.value+"&psid="+form1.psid.value+"&community="+form1.community.value,
					    		  function(data)
					    		  {
					    			 var rs= window.showModalDialog('/jsp/type/perform/MemberPiao.jsp?ordersid='+data+"&numbers="+form1.numbers.value,self,vc);
					    			 if(rs>0)
					    			 {
					    			 	window.open(location.href+"&t="+new Date().getTime(),window.name);
					    			 }else
					    			 {
					    			 	//说明是点击的右上面得关闭按钮
					    				 sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=Hmordersids",
					    				  function(data)
					    				  {
					    				     window.open(location.href+"&t="+new Date().getTime(),window.name);
					    				  }
					    				  );
					    			 }
					    		  }
					    		  );
			    }
			  }//判断订票时间 和 不选择座位点击
			  );



	//

}

</script>

<object
     classid = "clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"
     codebase = "http://ntcc.redcome.com/print/jre-6u17-windows-i586-iftw-rv.exe#Version=1,6,0,0"
     WIDTH = 1 HEIGHT = 1 NAME = "printApplet" >
     <PARAM NAME = CODE VALUE = "PrintApplet.class" >
     <PARAM NAME = ID VALUE = "printApplet" >
     <PARAM NAME = CODEBASE VALUE = "." >
     <PARAM NAME = ARCHIVE VALUE = "printApplet.jar" >
     <PARAM NAME = NAME VALUE = "printApplet" >
     <param name = "type" value = "application/x-java-applet;version=1.6">
     <param name = "scriptable" value = "true">
 </object>

<form name="form1" action="/jsp/type/perform/PerformOrders1.jsp" method="post">

<input type="hidden" name="act" value="AdminOnlineReservations">
<input type="hidden" name="numbers" value="/">
<input type="hidden" name="price" value="">
<input type="hidden" name="price_id" value="/">
<input type="hidden" name="Venues" value="<%=nobj2.getSubject(teasession._nLanguage) %>">
<input type="hidden" name="psid" value="<%=psid %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
<input type="hidden" name="nexturl" value="<%=nexturl %>">
<input type="hidden" name="ip" value="<%out.print(request.getServerName()+":"+request.getServerPort()); %>">
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

    PriceDistrict pdobj = PriceDistrict.find(i,psid);//分区价格显示图
    if(i%row==1){
      out.print("<tr>");

    }

    out.print("<td   ");
    if(seobj.isExists())
    {
      out.print("   bgcolor=\"#CCCCCC\" ");
    }
    if(pdobj.isExist())
    {
    	 PriceSubarea psobj3 = PriceSubarea.find(pdobj.getPricesubareaid());
    	out.print(" title=");
    	out.print("楼层:"+seobj.getRegion()+"&#10;");
    	out.print("排号:"+seobj.getLinagenumber()+"&#10;");
    	out.print("座号:"+seobj.getSeatnumber()+"&#10;");
    	out.print("票价:"+psobj3.getPrice()+"元");
    }
    out.print(">");
    if(pdobj.isExist())
    {
    	if(OrderDetails.isPitchon(psid,i))//显示已经销售
    	{
    		out.print("<img src=/tea/image/piao/LOCK.jpg>");
    	}else
    	{
	        PriceSubarea psobj2 = PriceSubarea.find(pdobj.getPricesubareaid());
	        SeatPic spobj = SeatPic.find(psobj2.getPicturepath());

	    	out.print("<img src = "+spobj.getPicpath());
	    	out.print(" id =myimg"+i+"  name=myimg"+i);
	    	out.print(" onclick=myImgs('"+i+"','"+spobj.getPicpath()+"','"+seobj.getRegion()+"','"+seobj.getLinagenumber()+"','"+seobj.getSeatnumber()+"','"+psobj2.getPrice()+"','"+pdobj.getPricesubareaid()+"');  style=cursor:pointer");
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

 <div class="Notes">
<table>


		<%

		Enumeration e = PriceSubarea.find(teasession._strCommunity," and psid ="+psid,0,20);
        int count = PriceSubarea.count(teasession._strCommunity," and psid ="+psid);
		for(int i = 1;e.hasMoreElements();i++)
		{
			int prsid = ((Integer)e.nextElement()).intValue();
			PriceSubarea prsobj = PriceSubarea.find(prsid);
			SeatPic spobj = SeatPic.find(prsobj.getPicturepath());
			int ys =  OrderDetails.count2(teasession._strCommunity," and od.psid ="+psid+" and price ="+prsobj.getPrice());//已经售出
			int qb = PriceDistrict.count(teasession._strCommunity," and psid = "+psid +" and pricesubareaid = "+prsid);

			if(i==1)
			{
              out.print("<tr>");
              out.print("<td><table cellspacing=\"0\" cellpadding=\"0\"><tr><td><img src=\"/tea/image/piao/LOCK.jpg\">&nbsp;</td><td class=\"td01\">已经售出的座位　</td><tr></table></td>");
			}else
            {
              if(i%4==1)
              {
                out.print("<tr>");
              }
            }

			out.print("<td>");
			out.print("<table cellspacing=\"0\" cellpadding=\"0\"><tr><td><img src="+spobj.getPicpath()+">&nbsp;</td><td class=\"td01\">");
			out.print(prsobj.getSubareaname()+"&nbsp;");
			out.print(prsobj.getPrice()+"元　</td></tr>");
			out.print("<tr><td></td><td>未售："+(qb-ys)+"</td></tr>");
			out.print("<tr><td></td><td>已售："+ys+"</td></tr></table>");
			out.print("</td>");
            if(i%4==0)
            {
              out.print("</tr>");
            }
            if(i==count)
            {
              out.print("<td><table cellspacing=\"0\" cellpadding=\"0\"><tr><td><img src=/tea/image/piao/SELECTED.jpg>&nbsp;</td><td class=\"td01\">选择的座位　</td><tr></table></td>");
              out.print("</tr>");
            }
		}
		 %>

</table>
</div>
</div>
</div>
</td>
<td class="Seatingtdright">
<div class="Seatingright">
	<div class="Tickets">
    <div class="TicketsCon">
    <div class="title">选座信息：</div>
<table id="testTbl" cellpadding="0" cellspacing="0" border="0">
</table>

<span id="show">
<div class="show01">
票种：
<select name="vote" onChange="f_vote();">
	<option value=",0,<%=PriceSubarea.getPsPrsubid(psid,teasession._strCommunity) %>,<%=PriceSubarea.getPsPrice(psid,teasession._strCommunity) %>,">标准票</option>
	<%
	String vote_s="/";
	Enumeration ve = Vote.find(teasession._strCommunity," and psid = "+psid,0,100);
	while(ve.hasMoreElements())
	{
		int voteid = ((Integer)ve.nextElement()).intValue();
		Vote voobj = Vote.find(voteid);
		String  vcstr = Vote.getVoteCarfare(voteid);
		String vcstr2 = Vote.getCarfare(voteid);
		out.print("<option value="+","+voteid+","+vcstr+","+vcstr2+",");
		out.print(">"+voobj.getVotename());
		out.print("</option>");
	}
	%>
</select>
</div>
<div class="show02">
<input type="button" value="会员卡出票" onClick="f_member();">
</div>
<div class="show03">数量：<span id="showsl">0</span>张</div>
<div class="show04">总价:<span id="showzj">0</span>元</div>
<div class="show06"><a href="#" onClick="f_PrintPreview();">打印预览</a></div>
<div class="show05"><a href=# onclick=f_submit();><img src=/res/REDCOME/0910/09109946.gif></a></div>
</span>
</div>

<div class="Ticketsbottom"></div>
</div>
<div class="Indicate">注：<br>　　如果是会员票请点击会员卡出票，只有标准票才能会员卡出票，其他票种不能用会员打折，每个剧目每张会员卡一次限购2张。</div>
   </div>
    </td></tr></table>
</form>
        </div>
		<script>
		   document.getElementById('show').style.display='none';
		</script>
     <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
  <script>
var load=document.getElementById('load');
load.style.display='none';
</script>
</body>
</html>
