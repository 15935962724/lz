<%@page import="java.math.BigDecimal"%>
<%@page import="util.Config"%>
<%@page import="util.DateUtil"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
Profile p = Profile.find(h.member);
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

StringBuffer kksql = new StringBuffer();

sql.append(" AND status = 2 ");
par.append("&status=2");
sql.append(" AND matchstatus = 0 ");
par.append("&matchstatus=0");



int member=h.getInt("member");//服务商id
/* sql.append(" AND member = "+member);
par.append("&member="+member); */
int hid=h.getInt("hid");//医院id
sql.append(" AND hospitalid = "+hid);
par.append("&hid="+hid);
String ids=h.get("ids");//回款id以逗号分隔
par.append("&ids="+ids);
float amount=h.getFloat("amount");//选中的回款金额
par.append("&amount="+amount);
int pos=h.getInt("pos");
par.append("&pos=");

int puid = h.getInt("puid",-1);//厂商
if(puid!=-1){
	sql.append(" AND puid = "+puid);
	kksql.append(" AND puid = "+puid);
}

kksql.append(" AND status = 2 ");
kksql.append(" AND hospitalid = "+hid);
//kksql.append(" AND deductionstype = 1 ");//查询暂扣订单 已扣未还的

	//sql.append(" AND deductionstype = 0 ");

if(p.membertype!=2){//其他
	ShopQualification sq = ShopQualification.findByMember(p.profile);
	sql.append(" AND (applyUnit = "+sq.hospital_id+" or member = "+h.member+")");
	kksql.append(" AND (applyUnit = "+sq.hospital_id+" or member = "+h.member+")");
}

String nexturl=h.get("nexturl");

%><!DOCTYPE html><html><head>

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">

<style>
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(4){
		font-weight: bold;
	}
	#Content,.con-right{width:100%;}
	.con-right{margin-top:0;}
	.results{border:none;margin-top:0;}
	.right-tab{border:1px solid #dcdcdc;margin-top:0;}
	.pd20 button{background-color: #428BCA !important;opacity: 1 !important;border-color: #357ebd !important;}
	.right-tab th{background:none;font-weight: bold;border:none;height:auto;}
	.right-tab td{border:none;height:auto;padding:0 5px;}
</style>

</head>
<body style='min-height:800px'>
<%
	//获取该医院的应收账款
	ShopHospital hospital=ShopHospital.find(hid);
	double oldno=hospital.getOldnoreplynew();//应收账款
	
	String timespot2=MT.f(hospital.getTimespot2());
	
%>
<%--<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>--%>
<div id="Content">
	<h1>匹配发票</h1>
	<%--<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>--%>
	<div class="con-right">
<form name="form2" id="form2" action="/ReplyMoneys.do" onsubmit="return mt.check(this)&&mt.show(null,0)" method="post" target="_ajax">
<input type="hidden" name="member" value="<%=member %>"/>
<input type="hidden" name="hospitalid" value="<%=hid %>" />
<input type="hidden" name="replyid" value="<%=ids %>" />
<input type="hidden" name="invoiceid" />
<input type="hidden" name="replyamount" value="<%=amount %>"/>
<input type="hidden" name="hangamount" />
<input type="hidden" name="matchamount" />
<input type="hidden" name="nexturl" value=""/>
<input type="hidden" name="nexturlold" value=""/>
<input type="hidden" name="act" value="matchinvoiceajax"/>
<input type="hidden" name="oldnoreply" value="<%=oldno %>"/>
<input type="hidden" name="soldnoreply" value=""/><!-- 剩余应收 -->
<input type="hidden" name="flag" value="0" />
<input type="hidden" name="puid" value="<%= puid%>" />
<div class="results">

<%--<%
List<Invoice> lstk=Invoice.find(kksql.toString()+" order by makeoutdate asc ",pos,100);
if(lstk.size()>0){
	%>
	<table class="right-tab newTable" border="0" cellspacing="0" style="margin:0px;">
	<tr>
		<td colspan="7">已暂扣发票（选择的扣款发票的暂扣金额会在结算服务费时一起返还）</td>
	</tr>
	<tr id="tableonetr">
	  <th class="td1"><input type="checkbox" />全选</th>
	  <th>序号</th>
	  <th>发票号</th>
	  <th>索要发票时间</th>
	  <th>开票数量</th>
	  <th>开票金额</th>
	  <th>暂扣金额</th>
	</tr>	
	
	<%
	for(int i=0;i<lstk.size();i++)
	{
		  Invoice t=lstk.get(i);
		  DeductionRecord dr = DeductionRecord.findByIid(t.getId());
		  //float kou = BackInvoice.findQianKuai(","+t.getId());
		 %>
  <tr>
	<td><input type="checkbox" name="ishuanid"  value="<%=t.getId() %>"/></td>
	<td><%=(i+1) %></td>
	<td><%=MT.f(t.getInvoiceno()) %></td>
	<td><%=MT.f(t.getCreatedate(),1) %></td>
	<td><%=t.getNum() %></td>
	<td><%=t.getAmount() %></td>
	<td><%= dr.getDeductprice() %></td>
	</tr>
		 <%
	}
	%>
	</table>
	<%
}
%>--%>

<table class="right-tab newTable" border="1" cellspacing="0">
<tr id="tableonetr">
  <th class="td1"><input type="checkbox" id="all"/>全选</th>
  <th>序号</th>
  <th>发票号</th>
  <th>发票开具时间</th>
  <th>开票数量</th>
  <th>开票金额</th>
  <th>状态</th>
	<th>已开票天数</th>
	<%
					out.print("<th>服务费</th>");
			out.print("<th>暂扣金额</th>");
	%>
	<!-- <td>操作</td> -->
</tr>
<tr>
	<td><input type="checkbox" name="issigns0" value="" id="issigns0"/></td>
	<td colspan="9" >截止至<%=timespot2 %>的应收账款为：<%=ShopHospital.getDecimal(oldno) %>元</td>
</tr>
<%
sql.append(" and makeoutdate>="+DbAdapter.cite("2018-3-21"));
int sum=Invoice.count(sql.toString());
String qianinvoiceid = "";
int tongfu = 365;
int junan = 365;
int gaoke = 270;
int pucha = 0;
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无发票记录!</td></tr>");
}else
{
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
 <tr
		 <%
			 if(t.getDeductionstype()==0){//未扣款
			 	if(daycha>=pucha){
			 		out.print("style='color: red!important;' ");
				}
			 }else if(t.getDeductionstype()==1){
				 out.print("style='color: green!important;' ");
			 }
		 %>
 >
     <td>
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
        <input type="checkbox" isqian='<%= (daycha>=pucha?1:0) %>'  kkprice='' name="issigns" value="<%=t.getId() %>"/>
        <%
            }

        %>
    </td>
	<td><%=(i+1) %></td>
	<td><%=MT.f(t.getInvoiceno()) %></td>
	<%--<td><%=MT.f(t.getCreatedate(),1) %></td>--%>
	 <td><%=MT.f(t.getMakeoutdate()) %></td>
	<td><%=t.getNum() %></td>

	<td><%=t.getAmount() %></td>
	<td><%=Invoice.STATUS[t.getStatus()] %></td>
	 <td><%= daycha%>天</td>
	<td><%

		int phpuid = InvoiceData.getPuid(t.getId());

		//ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, t.getMember());
		ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, t.getMember(),t.getHospitalid());


	Map<String,Double> imap =  Invoice.getTaxAmount(puj.tax, t.getId(), 0.9844, 1.13);
	double mysum = imap.get("chargeamountsum")+imap.get("taxamount");
	BigDecimal b2=new BigDecimal(mysum);
	double taxamount2=b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
	
	out.print(taxamount2);
	%></td><td><%

	 float invoiceWithhold = BackInvoice.invoiceWithhold(t.getId(),daycha);
	 out.print(invoiceWithhold);
	%></td>
	<%-- <td><a href="javascript:mt.act('data',<%=t.getId() %>)">查看</a>&nbsp;&nbsp;</td> --%>
	
</tr>
<%
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<div id="tishi0" class='center text-c pd20' style="font-size:18px;font-weight:bold;padding-bottom:0px;">回款金额：<%=ShopHospital.getDecimal((double)amount) %>元<span id="tishi" ></span>（<span style='color: red;'>红色为逾期的未匹配发票</span>，<span style='color: green;'>绿色为已扣的未匹配发票</span>）</div>
<!-- <input type="button" name="multi" value="确定" onclick="f_ok()"/> -->
</div>
<div class='center text-c pd20'>
		<button class="btn btn-primary btn-blue" disabled="disabled" type="button" id="getinvoice" onclick="fnconfirm()">提交</button>&nbsp;&nbsp;
		<input class="btn btn-default" type="button" value="取消" onclick="history.go(-2)"/>
</div>
<input name="qianinvoiceid" type="hidden" value="<%= qianinvoiceid %>" />
</form>
	</div>
</div>
<script>
var amount=<%=amount %>;//回款
var oldno=<%=oldno %>;//应收账款
var cha=oldno-amount;
var xys=oldno;//应收账款新
var gk=0;//挂款
form2.nexturlold.value  = parent.location.pathname+parent.location.search;
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
	  location.href="/jsp/yl/shopwebnew/ListBackInvoice.jsp?invoiceid="+invoiceid+"&nexturl=/jsp/yl/shopwebnew/SelInvoice.jsp&member="+form2.member.value+"&hid="+form2.hospitalid.value+"&ids="+form2.replyid.value+"&amount="+form2.replyamount.value;
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
		/* if($("#issigns0").prop("checked")==false){
			$(this).click();
		} */
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
	if(len<1){
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
		var hk=<%=amount %>;//选中的回款金额
		var amount1=0;//已选发票金额
		$("input[name='issigns']:checked").each(function(){
			
			var hk2=parseFloat($(this).parent().parent().find("td").eq(5).html());
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
						$("#tishi").html("&nbsp;&nbsp;已选金额："+parseFloat(amount1)+"元，&nbsp;&nbsp;应收账款将改为："+parseFloat(xys)+"元");
					}else{
						xys=0;
						gk=parseFloat(hf-oldno);
						$("#tishi").html("&nbsp;&nbsp;已选金额："+parseFloat(amount1)+"元，&nbsp;&nbsp;应收账款将改为：0元，挂款金额："+parseFloat(gk)+"元");
					}
				}else{
					mt.show("回款金额不能小于勾选的发票金额！");
					$(obj).prop("checked",false);
				}
			}else{
				//无发票
				if(amount>=oldno){
					//回款》=应收
					xys=0;
					gk=parseFloat(amount-oldno);
					$("#tishi").html("&nbsp;&nbsp;应收账款将改为：0元，挂款金额："+parseFloat(gk)+"元");
					
				}else{
					//回款<应收
					xys=parseFloat(oldno-amount);
					gk=0;
					$("#tishi").html("&nbsp;&nbsp;应收账款将改为："+xys+"元");
					
				}
			}
		}else{
			//无应收
			if(len>0){
				
				//有发票
				if(hf>=0){
					gk=hf;
					xys=oldno;
					$("#tishi").html("&nbsp;&nbsp;已选金额："+parseFloat(amount1)+"元，&nbsp;&nbsp;挂款金额："+parseFloat(gk)+"元");
					
				}else{
					mt.show("回款金额不能小于勾选的发票金额！");
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
			mt.show("请勾选应收账款或发票！");
			return false;
		}
		if(gk<0){
			mt.show("选择的开票金额不能大于回款金额！");
			return false;
		}
		
		
		var qiansum = $("input[isqian='1']").length;
		var qiansumche = $("input[isqian='1']:checked").length;
		if(qiansum!=qiansumche){
			mt.show("有未选择的预警的发票，如果不选则在服务费中会扣除账款，是否确认提交？",2);
			mt.ok = function(){
				mysub2();
			}
		}else{
			mysub2();
		}
		
	}
	
	function mysub2(){
		var ids="";
		var amount1=0;
		$("input[name='issigns']:checked").each(function(){
			var hk1=parseFloat($(this).parent().parent().find("td").eq(5).html());
			amount1+=hk1;
			ids+=$(this).val()+",";
		});
		
		form2.invoiceid.value=ids;
		form2.hangamount.value=parseFloat(gk);
		form2.matchamount.value=parseFloat(amount1);//已选金额
		
		form2.soldnoreply.value=parseFloat(xys);//剩余应收
		form2.nexturl.value="/jsp/yl/shopnew/ListReplyMoneyBack.jsp";
		
		mt.send("/ReplyMoneys.do?"+jQuery("#form2").serialize(),function(data){
			data = eval('(' + data + ')');
			if(data.type>0){
				mt.show(data.mes);
				return;
			}else{
                mt.show("匹配发票成功!",1);
                mt.ok = function() {
                    location.href = '/jsp/yl/shopnew/ListReplyMoneyBack.jsp';
                }
			}
		});
		
		//form2.submit();
	}
	
	//应收账款
	$("input[name='issigns0']").click(function(){ 
		getselamount(this);
		var len1=$("input[name='issigns0']:checked").length;//应收账款的
		var len2=$("input[name='issigns']:checked").length;//发票的
		var len3=$("input[name='issigns']").length;//发票的
		var len=len3+1;//总个数
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
