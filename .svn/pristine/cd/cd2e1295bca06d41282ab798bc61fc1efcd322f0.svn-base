<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int size=10;
int pos2=h.getInt("pos2");


StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
String ids=h.get("ids");
String idarr[]=ids.split(",");
String idarr2="";
int max=idarr.length;
/* if(idarr.length>size){
	max=pos+size;
} */
//out.print("<script>alert("+pos2+','+max+")</script>");
for(int i=pos2;i<max;i++){
	String a=idarr[i];
	//out.print("<script>alert('"+a+"')</script>");
	if(i==max-1){
		idarr2+=a;
	}else{
		idarr2+=a+",";
	}
	//out.print("<script>alert('"+idarr2+"')</script>");
}

sql.append(" and id in ("+idarr2+")");
par.append("&ids="+ids);



String nums=h.get("nums");
par.append("&nums="+nums);

//总数量和总金额
int invoval=h.getInt("invoval");
par.append("&invoval="+invoval);
int numval=h.getInt("numval");
par.append("&numval="+numval);
String[] numarr=nums.split(",");
Map map = new HashMap();
for(int i=0;i<numarr.length;i++){
	map.put(idarr[i], numarr[i]);
}
String amounts=h.get("amounts");
par.append("&amounts="+amounts);
String[] amountarr=amounts.split(",");
Map map2 = new HashMap();
for(int i=0;i<amountarr.length;i++){
	map2.put(idarr[i], amountarr[i]);
}
par.append("&pos2=");
String nexturl=h.get("nexturl");

%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
.mt_data td,.mt_data th{padding:3px}
	.con-left-list .tit-on1{color:#044694;}

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
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(3){
		font-weight: bold;
	}
	.right-tab th,.right-tab td{padding:0px 3px;}
</style>

</head>
<body style='min-height:600px'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<form name="form2" action="" method="post" target="_ajax">
			<input type="hidden" name="ids" value="<%=ids %>"/>
			<input type="hidden" name="nums" value="<%=nums %>"/>
			<input type="hidden" name="amounts" value="<%=amounts %>"/>
			<input type="hidden" name="hospitalid" value="" />
			<input type="hidden" name="nexturl"/>
			<input type="hidden" name="act"/>
			<div class="results">
				<table class="right-tab" border="1" cellspacing="0" style="margin-top:0px;">
					<tr id="tableonetr">

						<th class="td2">序号</th>
						<th class="td3">订单编号</th>
						<th class="td4">医院</th>
						<th class="td5">下单时间</th>
						<th class="td6">数量</th>
						<th class="td7">开票金额</th>
						<th class="td9">未开数量</th>
						<th class="td10">申请开票数量</th>
						<th class="td11">申请开票金额</th>
					</tr>
					<%


						int sum=idarr.length;

						int totalnum=0;
						float totalamount=0;
						int hospitalid=0;//医院id
						if(sum<1)
						{
							out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
						}else
						{
							sql.append("order by charindex(','+rtrim(cast(id as varchar(10)))+',',',"+idarr2+",')");

							Iterator it=ShopOrder.find(sql.toString(),0,size).iterator();
							Filex.logs("ytinvoice.txt", sql.toString());
							for(int i=1;it.hasNext();i++)
							{
								ShopOrder t=(ShopOrder)it.next();
								int noinvoicenum=t.getNoinvoicenum();//未开票数量
								ShopOrderDispatch dispatch=ShopOrderDispatch.findByOrderId(t.getOrderId());
								String hospital="";//医院
								if(dispatch.getId()>0){
									hospital=dispatch.getA_hospital();
									hospitalid=dispatch.getA_hospital_id();
								}else{
									String oldorderid=t.getOldorderid();
									ShopOrderDispatch dispatch2=ShopOrderDispatch.findByOrderId(oldorderid);
									hospital=dispatch2.getA_hospital();
									hospitalid=dispatch2.getA_hospital_id();
								}
								List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+Database.cite(t.getOrderId()), 0, Integer.MAX_VALUE);
								//每个订单只能添加一种粒子产品
								//数量
								int num=0;
								//开票金额
								double invoiceamount=0;
								if(lstdata.size()>0){
									ShopOrderData data=lstdata.get(0);
									num=data.getQuantity();
									invoiceamount=data.getAgent_amount();
								}

					%>
					<tr>

						<td><%=i %></td>
						<td><%=MT.f(t.getOrderId()) %></td>
						<td><%=MT.f(hospital) %></td>
						<td><%=MT.f(t.getCreateDate(),1) %></td>
						<td><%=num %></td>
						<td><%=invoiceamount %></td>

						<td><%=noinvoicenum %></td>
						<td><%=map.get(String.valueOf(t.getId())).toString() %></td>
						<td><%=map2.get(String.valueOf(t.getId())).toString() %></td>
					</tr>
					<%

								totalnum+=Integer.parseInt(map.get(String.valueOf(t.getId())).toString());

								totalamount+=Float.parseFloat(map2.get(String.valueOf(t.getId())).toString());
							}
							if(sum>size)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos2, sum,size));
						}%>
				</table>
			</div>

			<div class='center text-c pd20' style="padding-bottom:0px;font-size:16px;font-weight: bold;">
				<span id="invoicetotal">当前页开票总金额：<%=totalamount %></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id="invoicenum">当前页开票总数量：<%=totalnum %></span>
			</div>
			<div class='center text-c pd20' style="padding-bottom:0px;font-size:16px;font-weight: bold;">
				<span id="invoicetotal">开票总金额：<%=invoval %></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id="invoicenum">开票总数量：<%=numval %></span>
			</div>
			<div class="center text-c pd20">
				<input type="button" class="btn btn-primary btn-blue" onclick="fnsub(<%=hospitalid %>,'<%=ids %>','<%=nums %>','<%=amounts %>',<%=invoval %>,<%=numval %>,'<%=nexturl %>')" value="确认开票" />　
				<input type="button" class="btn btn-default" value="取消" onclick="location.href='/jsp/yl/shopwebnew/AskInvoice.jsp'"/>
			</div>
		</form>
	</div>
</div>



<script type="text/javascript">
function fnsub(a,b,c,d,e,f,g){

	form2.hospitalid.value=a;
	//ShopGetFp.jsp
	location.href="/jsp/yl/shopwebnew/ShopGetFp.jsp?hospital="+a+"&ids="+b+"&nums="+c+"&amounts="+d+"&totalamount="+e+"&totalnum="+f+"&nexturl="+g;
	//form2.submit();
}

mt.fit();
</script>
</body> 
</html>
