<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %>
<%@ page import="java.math.BigDecimal" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
	int rednums = 0;//红色条数
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
	StringBuffer kksql = new StringBuffer();
par.append("&menu="+menu);
	Profile p = Profile.find(h.member);
sql.append(" AND status = 2 ");
par.append("&status=2");
sql.append(" AND matchstatus = 0 ");
par.append("&matchstatus=0");

int member=h.getInt("member");//服务商id
//sql.append(" AND member = "+member);
//par.append("&member="+member);
int hid=h.getInt("hid");//医院id
sql.append(" AND hospitalid = "+hid);
	int puid = h.getInt("puid",-1);//厂商
	if(puid!=-1){
		sql.append(" AND puid = "+puid);
		par.append("&puid="+puid);
	}

	if(p.membertype!=2){//其他
		ShopQualification sq = ShopQualification.findByMember(p.profile);
		sql.append(" AND (applyUnit = "+sq.hospital_id+" or member = "+h.member+")");
		kksql.append(" AND (applyUnit = "+sq.hospital_id+" or member = "+h.member+")");
	}


	par.append("&hid="+hid);
String ids=h.get("ids");//回款id以逗号分隔
par.append("&ids="+ids);
float amount=h.getFloat("amount");//选中的回款金额
par.append("&amount="+amount);
int pos=h.getInt("pos");
par.append("&pos=");

String nexturl=h.get("nexturl");
%><!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css">
<!--script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
	  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}

</script--> 

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
.mt_data td,.mt_data th{padding:3px}
	.colorul li,.colorul li span,.colorul .inv-p,.colorul .inv-p .order-zt{
		color: red;
	}
	.colorulg li,.colorulg li span,.colorulg .inv-p,.colorulg .inv-p .order-zt{
		color:green;
	}
	.inv-p .btn-tj{text-align:center;color:#fff;width:25%;height:33px;border:1px solid #044694;background: #044694;border-radius:2px;}
	.inv-p .btn-qx{color:#333;display:inline-block;width:25%;height:33px;border:1px solid #9f9f9f;background: #fff;border-radius:2px;color:#9f9f9f;margin-right:10px;}
	body{background: #eef4fb;}
	.je p{line-height: 180%;font-weight:bold;font-size:14px;}
	.results ul, .resultlist ul{box-shadow: none;}
	.inv-p input[type=checkbox]{cursor: pointer;position: absolute;top: 17px;left:3%;width: 17px;height: 17px;-webkit-appearance: none;z-index: 9;background: url(/tea/mobhtml/img/icon14.png) center no-repeat;background-size: 17px 17px;}
	.inv-p{border-bottom: 1px solid #e6e6e6;overflow:hidden;position: relative;background: #fff;width:92%;padding:15px 4%;color:#333;}
	.inv-p input[type=checkbox]:checked {background: url(/tea/mobhtml/img/icon15.png) center no-repeat;background-size: 17px 17px;}
	.results ul li{border:none;}
	.inv-p .inv-tit {margin-left: 30px;width: 72%;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;float:left;}
	.order-zt{float:right;color:#f25f1c;}
	.results ul{margin:0;padding:0;margin:16px 0;}
	.results ul li{overflow: hidden;padding: 0 4%;width: 92%;line-height: 165%;display: flex;}
	.results .list-spanr5 {width: 85px;text-align: right;display: inline-block;}
	.results .list-spanr {flex: 1;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: auto;text-align: left;display: inline-block;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
</style>
<title>选择发票</title>
</head>
<body style='min-height:300px'>
<%
	//获取该医院的应收账款
	ShopHospital hospital=ShopHospital.find(hid);
	double oldno=hospital.getOldnoreplynew();//应收账款
	
	String timespot2=MT.f(hospital.getTimespot2());
	
%>

<form name="form2" id="form2" action="/ReplyMoneys.do" method="post" target="_ajax">
<input type="hidden" name="member" value="<%=member %>"/>
<input type="hidden" name="hospitalid" value="<%=hid %>" />
<input type="hidden" name="replyid" value="<%=ids %>" />
<input type="hidden" name="invoiceid" />
<input type="hidden" name="replyamount" value="<%=amount %>"/>
<input type="hidden" name="hangamount" />
<input type="hidden" name="matchamount" />
<input type="hidden" name="nexturl" value=""/>
<%--<input type="hidden" name="act" value="matchinvoice"/>--%>
<input type="hidden" name="act" value="matchinvoiceajax"/>
<input type="hidden" name="oldnoreply" value="<%=oldno %>"/>
<input type="hidden" name="soldnoreply" value=""/><!-- 剩余应收 -->
<input type="hidden" name="flag" value="0" />
<input type="hidden" name="puid" value="<%= puid%>" />
<div class='je' style="background:#fffaf0;padding:15px 4%;">
	<p>回款金额：<%=ShopHospital.getDecimal((double)amount) %>元</p>
	<p id="tishi" ></p>(<span style='color: red;display:inline-block;margin-top:5px;'>红色为逾期的未匹配发票</span>，<span style='color: green;display:inline-block;margin-top:5px;'>绿色为已扣的未匹配发票</span>)
</div>
<div class="results" style="padding-top:10px">



	<p class="order-line1 ft14 inv-p">
		<input type="checkbox" name="issigns0" id="issigns0" value=""/>
		<span style="margin-left:10%;">截止至<%=timespot2 %>的应收账款为：<em style="font-weight: bold;"><%=ShopHospital.getDecimal(oldno) %>元</em></span>
	</p>
	
	<!-- <li>
		<span></span>
	</li> -->

 
 
<%
	String qianinvoiceid = "";
sql.append(" and makeoutdate>="+DbAdapter.cite("2018-3-21"));
int sum=Invoice.count(sql.toString());
if(sum<1)
{
  out.print("<div style='text-align:center;width:100%;'>暂无记录!</div>");
}else
{

	int tongfu = 365;
	int junan = 365;
	int gaoke = 270;
	int pucha = 0;
	List<Invoice> lst2=Invoice.find(sql.toString()+" order by makeoutdate asc ",pos,Integer.MAX_VALUE);
	for (int i = 0; i <lst2.size() ; i++) {
		int pucha1=0;
		Invoice t = lst2.get(i);
		if(Config.getInt("tongfu")==t.getPuid()){
			pucha1 = tongfu;
		}else if(Config.getInt("gaoke")==t.getPuid()){
			pucha1 = gaoke;
		}else if(Config.getInt("junan")==t.getPuid()){
			pucha1 = junan;
		}
		long daycha = Invoice.finddaycha(t.getId());
		if(t.getDeductionstype()==0){//已扣款
			if(daycha>=pucha1){//日期超过规定日期
				rednums++;
			}
		}
	}
  List<Invoice> lst=Invoice.find(sql.toString()+" order by makeoutdate asc ",pos,20);
  for(int i=0;i<lst.size();i++)
  {
	  Invoice t=lst.get(i);
	  if(Config.getInt("tongfu")==t.getPuid()){
		  pucha = tongfu;
	  }else if(Config.getInt("gaoke")==t.getPuid()){
		  pucha = gaoke;
	  }else if(Config.getInt("junan")==t.getPuid()){
		  pucha = junan;
	  }
	  long daycha = Invoice.finddaycha(t.getId());
	  if(t.getDeductionstype()==0){//只记录未扣款
		  if(daycha>=pucha){
			  qianinvoiceid += ","+t.getId();
		  }
	  }
%>
<div style="margin-top:10px;padding:0;width:100%;overflow: hidden;"  <%
if(t.getDeductionstype()==0){//未扣款
	if(daycha>=pucha){
		out.print("class='colorul'");
	}
}else if(t.getDeductionstype()==1){
	out.print("class='colorulg'");
}
%>>



 	<p class='order-line1 ft14 inv-p'>
		<span class="check">
			<%--<input type="checkbox" isqian='<%= (daycha>=pucha?1:0) %>'  kkprice='' name="issigns" value="<%=t.getId() %>"/>--%>
			<%
				if(puid==Config.getInt("gaoke")){//高科服务费发票匹配服务费后才可进行
					if(t.getMateType()==1){
			%>
				<input type="checkbox" isqian='<%
				if(t.getDeductionstype()==1){
					out.print(0);
				}else{
					out.print((daycha>=pucha?1:0));
				}
					%>'  kkprice='' name="issigns" value="<%=t.getId() %>"/>
				<%
					}else{
						out.print("未匹配服务费发票");
					}
				}else{
				%>
				<input type="checkbox" isqian='<%= (t.getDeductionstype()==1?"0":(daycha>=pucha?1:0)) %>'  kkprice='' name="issigns" value="<%=t.getId() %>"/>
				<%
					}
		
				%>
		</span>
		<span class='fl-left inv-tit order-tit'>发票号：<%=MT.f(t.getInvoiceno()) %></span>
		<span class='fl-right order-zt'><%=Invoice.STATUS[t.getStatus()] %></span>
	</p>
	<ul>
	<li>
		<span class='list-spanr5 fl-left'>开票时间：</span>
		<span class='list-spanr fl-left'><%=MT.f(t.getCreatedate()) %></span>
	</li>
	<li>
		<span class='list-spanr5 fl-left'>开票数量：</span>
		<span class="invonum list-spanr fl-left"><%=t.getNum() %></span>
	</li>
	<li>
		<span  class='list-spanr5 fl-left'>开票金额：</span>
		<span class="invoamount list-spanr fl-left"><%=t.getAmount() %></span>
	</li>
	 <li>
		 <span  class='list-spanr5 fl-left'>已开票天数：</span>
		 <span class="list-spanr fl-left"><%= daycha%>天</span>
	 </li>
	 <li>
		 <span  class='list-spanr5 fl-left'>服务费：</span>
		 <span class="list-spanr fl-left"><%

			 int phpuid = InvoiceData.getPuid(t.getId());

			 //ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, t.getMember());
			 ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, t.getMember(),t.getHospitalid());

			 Map<String,Double> imap =  Invoice.getTaxAmount(puj.tax, t.getId(), 0.9844, 1.13);
			 double mysum = imap.get("chargeamountsum")+imap.get("taxamount");
			 BigDecimal b2=new BigDecimal(mysum);
			 double taxamount2=b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

			 out.print(taxamount2);
		 %></span>
	</li>
	<li>
		<span  class='list-spanr5 fl-left'>暂扣金额：</span>
		<span class="list-spanr fl-left"><%
			float invoiceWithhold = BackInvoice.invoiceWithhold(t.getId(),daycha);
			out.print(invoiceWithhold);
		%></span>
	</li>
	
	<%-- <li><a href="javascript:mt.act('data',<%=t.getId() %>)">查看</a>&nbsp;&nbsp;</li> --%>
	
	</ul>
</div>	
<%	
  }
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
}%>


<!-- <input type="button" name="multi" value="确定" onclick="f_ok()"/> -->
</div>
<!-- <div class='center mt15 btnbottom'> -->
	<p class='order-line1 ft14 inv-p' style='z-index:15;position:fixed;bottom:0;text-align: center;background: #fff;'>
		<input type="checkbox" id="all"/ style="top:24px;"><span style='position: absolute;top:22px;left:40px;'>全选</span>
		<input type="button" class=' btn-qx' value="取消" onclick="location.href='<%=nexturl %>'"/>
		<button class="btn btn-primary btn-tj" disabled="disabled" type="button" id="getinvoice" onclick="fnconfirm()">提交</button>
	</p>
<!-- </div> -->
	<input name="qianinvoiceid" type="hidden" value="<%= qianinvoiceid %>" />
</form>
<script>
var amount=<%=amount %>;//回款
var oldno=<%=oldno %>;//应收账款
var cha=oldno-amount;
var xys=oldno;//应收账款新
var gk=0;//挂款
$(function(){
	
	
	/* if(cha>=0){
		
		$("input[name='issigns']").each(function(){
			$(this).attr("disabled",true);
		})
	} */
	
	if(parseFloat(oldno)==0){
		
		$("input[name='issigns0']").attr("disabled",true);
	}
})
mt.act=function(a,invoiceid)
{
  
  if(a=='data')
  {
	  //alert(form2.nexturl.value);
	  //window.open("SelInvoiceDatas.jsp");
	  /* alert(form2.member.value);
	  alert(form2.hospitalid.value);
	  alert(form2.replyid.value);
	  alert(form2.replyamount.value); */
	 // parent.location="/html/folder/17100861-1.htm?invoiceid="+invoiceid+"&nexturl=/html/folder/17100826-1.htm&member="+form2.member.value+"&hid="+form2.hospitalid.value+"&ids="+form2.replyid.value+"&amount="+form2.replyamount.value;
	  //parent.location="/html/folder/17110037-1.htm?invoiceid="+invoiceid+"&nexturl=/html/folder/17100826-1.htm&member="+form2.member.value+"&hid="+form2.hospitalid.value+"&ids="+form2.replyid.value+"&amount="+form2.replyamount.value;
 	location.href="";
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
		if($("#issigns0").prop("checked")==false){
			$("#issigns0").click();
		}
	}else{
		
		$("input[name='issigns']").each(function(){
			  
			if($(this).prop("checked")==true){
				  $(this).click();
			  }
		})
		if($("#issigns0").prop("checked")==true){
			$("#issigns0").click();
		}
	}
	var len = $("input:checkbox:checked").length;
	//控制提交按钮
	if(len==0){
		$('#getinvoice').attr('disabled',"true");
		
	}else{
		$('#getinvoice').removeAttr("disabled"); 
		
	}
	
	getselamount(this);
	
});

	
	//单选操作
	$("input[name='issigns']").click(function(){  
		
		var len0 = $("#issigns0:checked").length;//选中应收账款的数量
		
		var len = $("input[name='issigns']:checked").length; 
		//控制索要发票按钮
		if(len==0&&len0==0){
			$('#getinvoice').attr('disabled',"true");
			
		}else{
			$('#getinvoice').removeAttr("disabled"); 
		}
		var alllen=document.getElementsByName("issigns").length+1;
		//控制全选
		if(len+len0<alllen){
			$("#all").prop("checked", false);  
		}
		if(len+len0==alllen){
			$("#all").prop("checked", true);  
		}
		
		getselamount(this);

	});
	function getselamount(obj){
		var len0=$("input[name='issigns0']:checked").length; //选中应收账款的数量
		var len = $("input[name='issigns']:checked").length; //勾选的发票
		var hk=<%=amount %>;
		var amount1=0;//已选发票金额
		$("input[name='issigns']:checked").each(function(){
			
			//var hk2=parseFloat($(this).parent().parent().find("td").eq(5).html());
			var hk2=parseFloat($(this).parent().parent().next('ul').find("li").eq(2).find(".invoamount").html());//开票金额
			//console.log(hk2+"==");
			amount1+=hk2;
			
		});
		
		var hf=parseFloat(amount-amount1);//回款减去发票的值
		if(len0==1){
			//有应收
			if(len>0){
				//有发票
				if(hf>0){
					if(hf<=oldno){
						xys=parseFloat(oldno-hf);
						gk=0;
						$("#tishi").html("<p>已选金额："+parseFloat(amount1)+"元，</p><p>应收账款将改为："+parseFloat(xys)+"元</p>");
					}else{
						xys=0;
						gk=parseFloat(hf-oldno);
						$("#tishi").html("<p>已选金额："+parseFloat(amount1)+"元，</p><p>应收账款将改为：0元，挂款金额："+parseFloat(gk)+"元</p>");
					}
				}else{
					mtDiag.show("回款金额不能小于勾选的发票金额！");
					//mt.show("回款金额不能小于勾选的发票金额！");
					$(obj).prop("checked",false);
				}
			}else{
				//无发票
				if(amount>=oldno){
					//回款》=应收
					xys=0;
					gk=parseFloat(amount-oldno);
					$("#tishi").html("<p>应收账款将改为：0元，挂款金额："+parseFloat(gk)+"元</p>");
					
				}else{
					//回款<应收
					xys=parseFloat(oldno-amount);
					gk=0;
					$("#tishi").html("<p>应收账款将改为："+xys+"元</p>");
					
				}
			}
		}else{
			//无应收
			if(len>0){
				
				//有发票
				if(hf>=0){
					gk=hf;
					xys=oldno;
					$("#tishi").html("<p>已选金额："+parseFloat(amount1)+"元，</p><p>挂款金额："+parseFloat(gk)+"元</p>");
					
				}else{
					mtDiag.show("回款金额不能小于勾选的发票金额！");
					//mt.show("回款金额不能小于勾选的发票金额！");
					$(obj).prop("checked",false);
				}
			}else{
				//无发票
			}
		}
		
		if(len0==0&&len==0){
			$("#tishi").html("");
		}
			
	}
	function f_ok(a)
	{
		
		var pmt=parent.mt;
		var v=a,n='',h='';
	  	pmt.receive(v,n,h);
	  	pmt.close();
	}
	//提交
	function fnconfirm(){
		var len = $("input[name='issigns0']:checked").length; 
		var len2 = $("input[name='issigns']:checked").length; 
		if(len==0&&len2==0){
			mtDiag.show("请勾选应收账款或发票！");
			return false;
		}
		if(gk<0){
			mtDiag.show("选择的开票金额不能大于回款金额！");
			return false;
		}

		var qiansum = $("input[isqian='1']").length;
		var qiansumche = $("input[isqian='1']:checked").length;
        var rednums = <%=rednums%>;
        if(rednums!=qiansumche){
			/*mtDiag.show("有未选择的预警的发票，如果不选则在服务费中会扣除账款，是否确认提交？",2);
			mt.ok = function(){
				mysub2();
			}*/
			mtDiag.show("有未选择的预警的发票，如果不选则在服务费中会扣除账款，是否确认提交？","confirm",function(){
				mysub2();
			},function(){

			});
		}else{
			mysub2();
		}


	}
	function mysub2(){
		var ids="";
		var amount1=0;
		$("input[name='issigns']:checked").each(function(){

			//var hk1=parseFloat($(this).parent().parent().find("td").eq(5).html());
			//var hk1=parseFloat($(this).parent().parent().find("li").eq(5).find(".invoamount").html());
			var hk2=parseFloat($(this).parent().parent().next('ul').find("li").eq(2).find(".invoamount").html());//开票金额
			//console.log($(this).parent().parent().find(".amount").val()+"==");
			amount1+=hk2;
			ids+=$(this).val()+",";
		});
		form2.invoiceid.value=ids;
		form2.hangamount.value=parseFloat(gk);
		form2.matchamount.value=parseFloat(amount1);//已选金额

		form2.soldnoreply.value=parseFloat(xys);//剩余应收
		//form2.nexturl.value="/html/folder/18031296-1.htm";
		//form2.nexturl.value="/mobjsp/yl/shopwebnew/ListBackInvoice_wx.jsp";
		form2.nexturl.value="/mobjsp/yl/shopweb/ListReplyMoney.jsp";
		//form2.submit();
		//console.log(amount1+"==");
		mt.send("/ReplyMoneys.do?"+jQuery("#form2").serialize(),function(data){

			data = eval('(' + data + ')');
			if(data.type>0){
				mtDiag.show(data.mes);
				return;
			}else{
				mtDiag.show("匹配发票成功!","alert",null,function(index){
					location.href = '/mobjsp/yl/shopweb/ListReplyMoney.jsp';
				});
				/*mt.show("匹配发票成功!",1);
				mt.ok = function() {
					location.href = '/mobjsp/yl/shopweb/ListReplyMoney.jsp';
				}*/
			}
		});
	}
	//应收账款
	$("input[name='issigns0']").click(function(){ 
		getselamount(this);
		
		var len1=$("input[name='issigns0']:checked").length;//应收账款的
		var len2=$("input[name='issigns']:checked").length;//发票的
		var len3=$("input[name='issigns']").length;//发票的
		var len = len3+1;//总个数
		//控制全选按钮和提交按钮
		if(len1+len2==len){
				$("#all").prop("checked", true);
				$('#getinvoice').removeAttr("disabled"); 
		}else if(len1+len2<len&&(len1>0||len2>0)){
			$("#all").prop("checked", false);
			$('#getinvoice').removeAttr("disabled"); 
		}else{
			$("#all").prop("checked", false);
			
		}
		

	});
mt.fit();
</script>
</body>
</html>
