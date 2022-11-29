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
if(idarr.length>size*(pos2/size+1)){
	max=pos2+size;
}
for(int i=pos2;i<max;i++){
	String a=idarr[i];
	if(i==max-1){
		idarr2+=a;
	}else{
		idarr2+=a+",";
	}
	
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
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

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
<!-- <link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css"> -->
<!-- <link href="webcss.css" rel="stylesheet" type="text/css"> -->
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">

<style>
.mt_data td,.mt_data th{padding:3px}

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
	color: #004779;
}
	.order-btnp{
	padding: 16px 4%;
	height:auto;
	line-height:20px;

	}
	.btn-default2 {
	color: #044694 !important;
	background-color: #fff !important;
	border: 1px solid #044694 !important;
	font-weight: 400 !important;
	}
	.btn-default {
	color: #333 !important;
	background-color: #fff !important;
	border: 1px solid #ccc !important;
	font-weight: 400 !important;
	}
</style>
<title>索要发票确认</title>
</head>
<body style='min-height:300px'>

<!-- <header class="header">索要发票确认</header> -->
<form name="form2" action="" method="post" target="_ajax">
<input type="hidden" name="ids" value="<%=ids %>"/>
<input type="hidden" name="nums" value="<%=nums %>"/>
<input type="hidden" name="amounts" value="<%=amounts %>"/>
<input type="hidden" name="hospitalid" value="" />
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>



<!-- <tr id="tableonetr">
  
  <td class="td2">序号</td>
  <td class="td3">订单编号</td>
  <td class="td4">医院</td>
  <td class="td5">下单时间</td>
  <td class="td6">数量</td>
  <td class="td7">开票金额</td>
  <td class="td9">未开数量</td>
  <td class="td10">申请开票数量</td>
  <td class="td11">申请开票金额</td>
</tr> -->
<%


int sum=idarr.length;
int totalnum=0;
float totalamount=0;
int hospitalid=0;//医院id
if(sum<1)
{
  out.print("<div style='text-align:center;width:100%;'>暂无记录!</div>");
}else
{
  Iterator it=ShopOrder.find(sql.toString(),0,size).iterator();
  
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
<%--<ul>
	
	
	<li>
		<span>订单号：<h3><%=MT.f(t.getOrderId()) %></h3></span>
		<span><%=MT.f(t.getCreateDate(),1) %></span>
	</li>
	<li>
		<span><%=MT.f(hospital) %></span>
		<span>数量：<%=num %></span>
		<span>金额：<%=invoiceamount %></span>
	</li>
	<li>
		<span>未开数量：<%=noinvoicenum %></span>
		<span>申请开票数量：<%=map.get(String.valueOf(t.getId())).toString() %></span>
		<span>申请开票金额：<%=map2.get(String.valueOf(t.getId())).toString() %></span>
	</li>
	
</ul>--%>

	<div class="order-list">
		<p class="order-line1 ft14">
			<span class="fl-left order-tit"><%=MT.f(hospital) %></span>
		</p>
		<ul class="ft14">
			<li>
				<span class="list-spanr5 fl-left">订单编号：</span>
				<span class="list-spanr fl-left"><%=MT.f(t.getOrderId()) %></span>
			</li>

			<li>
				<span class="list-spanr5 fl-left">数量：</span>
				<span class="list-spanr fl-left">
					<%=num %>
				</span>
			</li>
			<li>
				<span class="list-spanr5 fl-left">金额：</span>
				<span class="list-spanr fl-left">
					<%=invoiceamount %>
				</span>
			</li>
			<li>
				<span class="list-spanr5 fl-left">未开票数量：</span>
				<span class="list-spanr fl-left">
					<%=noinvoicenum %>
				</span>
			</li>

			<li>
				<span class="list-spanr5 fl-left">申请开票数量：</span>
				<span class="list-spanr fl-left"><%=map.get(String.valueOf(t.getId())).toString() %></span>
			</li>

			<li>
				<span class="list-spanr5 fl-left">申请开票金额：</span>
				<span class="list-spanr fl-left"><%=map2.get(String.valueOf(t.getId())).toString() %></span>
			</li>
		</ul>

	</div>
<%

totalnum+=Integer.parseInt(map.get(String.valueOf(t.getId())).toString());

totalamount+=Float.parseFloat(map2.get(String.valueOf(t.getId())).toString());
  }
  
  if(sum>size)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos2, sum,size)+"</div>");
}%>

</div>

<div class='center mt15 wxtop order-list'>
	<p class="detail-tit ft16" style="margin: 16px 4%;">当前开票信息</p>
	<ul>
		<li>
			<span class="list-spanr5 fl-left ft14">当前页开票总金额：</span>
			<span class="list-spanr fl-left ft14"><%=totalamount %></span>
		</li>
		<li>
			<span class="list-spanr5 fl-left ft14">当前页开票总数量：</span>
			<span class="list-spanr fl-left ft14"><%=totalnum %></span>
		</li>
		<li>
			<span class="list-spanr5 fl-left ft14">开票总金额：</span>
			<span class="list-spanr fl-left ft14"><%=invoval %></span>
		</li>
		<li>
			<span class="list-spanr5 fl-left ft14">开票总数量：</span>
			<span class="list-spanr fl-left ft14"><%=numval %></span>
		</li>
	</ul>
	<!-- <span id="invoicetotal">当前页开票总金额：<%=totalamount %></span>&nbsp;&nbsp;<span id="invoicenum">当前页开票总数量：<%=totalnum %></span>
	<br><span id="invoicetotal">开票总金额：<%=invoval %></span>&nbsp;&nbsp;<span id="invoicenum">开票总数量：<%=numval %></span> -->
	<p class="order-btnp" style='display:flex;'>
		<em style="flex: 1;"></em>
		<button type="button" class="btn btn-default2" onclick="fnsubmit(<%=hospitalid %>,'<%=ids %>','<%=nums %>','<%=amounts %>',<%=invoval %>,<%=numval %>,'<%=nexturl %>')" />确认开票</button>
		&nbsp;&nbsp;
		<button type="button" class="btn btn-default" style="margin-left:10px;" onclick="history.back(-1)"/>取消</button>
		<em style="flex: 1;"></em>
		<%-- <input type="button" value="取消" onclick="location.href='<%=nexturl %>'"/> --%>
<%--		<input type="button" class="btn fl-right" style="margin-left:10px;" value="取消" onclick="history.back(-1)"/>--%>
<%--		<input type="button" class="btn fl-right" onclick="fnsubmit(<%=hospitalid %>,'<%=ids %>','<%=nums %>','<%=amounts %>',<%=invoval %>,<%=numval %>,'<%=nexturl %>')" value="确认开票" />--%>
	</p>
</div>
	
	<!-- <div class='btnbottom detail-list'>
		<input type="button" onclick="fnsubmit(<%=hospitalid %>,'<%=ids %>','<%=nums %>','<%=amounts %>',<%=invoval %>,<%=numval %>,'<%=nexturl %>')" value="确认开票" />
		<%-- <input type="button" value="取消" onclick="location.href='<%=nexturl %>'"/> --%>
		<input type="button" value="取消" onclick="history.back(-1)"/>
	</div> -->
</form>



<script type="text/javascript">
function fnsubmit(a,b,c,d,e,f,g){
	
	form2.hospitalid.value=a;
	//ShopGetFp.jsp
	location.href="/mobjsp/yl/shopwebnew/ShopGetFp_wx.jsp?hospital="+a+"&ids="+b+"&nums="+c+"&amounts="+d+"&totalamount="+e+"&totalnum="+f+"&nexturl="+g;
	
	//form2.submit();
}
mt.fit();
</script>
</body> 
</html>
