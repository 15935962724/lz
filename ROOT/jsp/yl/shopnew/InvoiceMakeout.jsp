<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%@page import="util.DateUtil"%>
<%@page import="java.text.SimpleDateFormat"%><%@page import="java.util.Calendar"%>
<%@ page import="util.Config" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int invoiceid = h.getInt("invoiceid");
//根据发票id查询发票和发票详情
Invoice invoice=Invoice.find(invoiceid);
int status=invoice.getStatus();//发票状态

List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid="+invoiceid, 0, Integer.MAX_VALUE);
String nexturl=h.get("nexturl");
//只有财务开完发票订单管理员才可以编辑，否则订单管理员不能编辑发票号和开票日期
String disa="";
if(status!=2){
	disa="disabled='disabled'";
}
%><!DOCTYPE html><html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>

<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>


</head>
<body>
	
	<table id="tablecenter" cellspacing="0">
		<tr><td colspan="10"><h3>订单基本信息</h3></td></tr>
		<tr>
			<td>开票单位</td>
			
			<td>开票数量</td>
			<td>开票金额</td>
			<td>活度</td>
			<td>订单编号</td>
			<td><%
				int mypuid1 = InvoiceData.getPuid(invoiceid);
				if(Config.getInt("junan")==mypuid1){
					out.print("质检号");
				}else{
					out.print("销售编号");
				}
			%></td>
			<td>生产批号</td>
			<td>收件人</td>
		</tr>
		<%

		SimpleDateFormat sdf=new SimpleDateFormat("yyMMdd");
			String ordercode="";//订单编号
			String ph="";//生产批号
			String yxq="";//有效期
			String scdate="";//生产日期
			String factory="";//厂家
			Float num = 0f;
			for(int i=0;i<lstdata.size();i++){
				InvoiceData data=lstdata.get(i);//发票
				num += data.getAmount();
				String orderid=data.getOrderid();//订单id
				ShopOrder order=ShopOrder.findByOrderId(orderid);//订单
				List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id="+Database.cite(orderid), 0, 1);//订单详情
				ShopOrderData orderdata=lstorderdata.get(0);//订单详情
				ShopOrderExpress soe = ShopOrderExpress.findByOrderId(orderid);
				ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderid);
				out.print("<tr>");
				out.print("<td>"+invoice.getHospital()+"</td>");
				
				out.print("<td>"+data.getNum()+"</td>");
				out.print("<td>"+data.getAmount()+"</td>");
				out.print("<td>"+MT.f(orderdata.getActivity())+"</td>");
				out.print("<td>"+MT.f(order.getOrderId())+"</td>");
				out.print("<td>"+MT.f(soe.NO1)+"</td>");
				out.print("<td>"+MT.f(soe.NO2)+"</td>");
				out.print("<td>"+MT.f(sod.getA_consignees())+"</td>");
				out.print("</tr>");
				//生成票面备注
				if(i==lstdata.size()-1){
					ordercode+=order.getOrderId();
					ph+=MT.f(soe.NO2);
					if(MT.f(soe.NO2)!=""){
						String d=soe.NO2.substring(2);
						if(d.length()==6){
							String date = "";
							try{
								String d2=d.substring(0,2);
								String d3=d.substring(2,4);
								String d4=d.substring(4,6);
								date="20"+d2+"-"+d3+"-"+d4;
							}catch (Throwable e){

							}

							
							scdate+=d;//生产日期
							yxq+=MT.f(soe.vtime)==""?sdf.format(sdf.parse(DateUtil.addMonth(date,6))):sdf.format(soe.vtime);//有效期
							
						}else{
							String date = "";
							try {
								String d2 = d.substring(0, 1);
								String d3 = d.substring(1, 3);
								String d4 = d.substring(3, 5);
								date = "201" + d2 + "-" + d3 + "-" + d4;
							}catch (Throwable e){

							}
							
							scdate+=d;//生产日期
							yxq+=MT.f(soe.vtime)==""?sdf.format(sdf.parse(DateUtil.addMonth(date,6))):sdf.format(soe.vtime);//有效期
							
						}
						
					}
					
					
					
				}else{
					ordercode+=order.getOrderId()+"/";
					ph+=MT.f(soe.NO2)+"/";
					String date = "";
					if(MT.f(soe.NO2)!=""){

						String d=soe.NO2.substring(2);
						try{
							String d2=d.substring(0,2);
							String d3=d.substring(2,4);
							String d4=d.substring(4);
							date="20"+d2+"-"+d3+"-"+d4;
						}catch (Throwable e){

						}

						scdate+=d+"/";//生产日期
						yxq+=MT.f(soe.vtime)==""?sdf.format(sdf.parse(DateUtil.addMonth(date,6))):sdf.format(soe.vtime)+"/";//有效期
						
					}
				    
					
					
				}
				factory=ShopProduct.find(orderdata.getProductId()).factory;
				
				
			}
			invoice.setAmount(num);
			invoice.set();
			StringBuffer sb=new StringBuffer();
			sb.append("订单编号"+MT.f(ordercode)+"\t\t");
			sb.append("批号"+MT.f(ph)+"\t\t");
			sb.append("有效期"+MT.f(yxq)+"\t\t");
			sb.append("生产日期"+MT.f(scdate)+"\t\t");
			sb.append("单价"+invoice.getAmount()/invoice.getNum()+"元\t\t");
			sb.append("金额"+invoice.getAmount()+"元\t\t");
			sb.append("注册证号国药H20041350\t\t");
			sb.append("厂家"+MT.f(factory)+"\t\t");
		%>
	</table>
	<form name="form2" action="/Invoices.do" method="post" target="_ajax">
	<input type="hidden" name="invoiceid" value="<%=invoiceid %>" />
	<input type="hidden" name="status" value="<%=status %>"/>
	<input type="hidden" name="act" value="submit" />
	<input type="hidden" name="nexturl" value="<%=nexturl %>" />
	<table id="tablecenter" cellspacing="0">
		<tr>
			<td>发票号</td>
			<td><%-- <input type="text" name="invoiceno" disabled="disabled" value="<%=MT.f(invoice.getInvoiceno()) %>"/> --%>
			<input type="text" name="invoiceno"  value="<%=MT.f(invoice.getInvoiceno()) %>" <%=disa %>/><!-- 由原来的不可不编辑改为可编辑3.12 -->
			</td>
		</tr>
		<tr>
			<td>开票价</td>
			<%--<td><%=invoice.getAmount()/invoice.getNum() %></td>--%>
			<%if(invoice.getAmount()!=0||invoice.getNum()!=0){%>
			<td><%=MT.f(invoice.getAmount()/invoice.getNum()).substring(0,MT.f(invoice.getAmount()/invoice.getNum()).length()-1) %></td>
			<%}else {%>
			<td> </td>
			<%}%>

		</tr>
		<tr>
			<td>开票总金额</td>
			<td><%=invoice.getAmount() %></td>
		</tr>
<%
	if(invoice.getPuid()==((int)Config.getInt("gaoke"))){
%>
		<tr>
			<td>开票活度</td>
			<td><%=MT.f(invoice.getActivity()) %></td>
		</tr>
		<%
	}
%>
		<tr>
			<td>快递单号</td>
			<td>
				<%
					if(status==2){
				%>
				<input type="text" name="courierno"  value="<%=MT.f(invoice.getCourierno()) %>"/>
				<%
					}else{
				%>
				<input type="text" name="courierno" disabled="disabled" value="<%=MT.f(invoice.getCourierno()) %>"/>
				<%
					}
				%>
			</td>
		</tr>
		<tr>
			<td>开票日期</td>
			<td>
				<%-- <input type="text"  alt="开票日期" id="makeoutdate" name="makeoutdate"  value="<%=MT.f(invoice.getMakeoutdate(),1)%>" 
   disabled="disabled" > --%>
   <input type="text"  alt="开票日期" id="makeoutdate" name="makeoutdate"  value="<%=MT.f(invoice.getMakeoutdate(),1)%>" readonly="readonly" onclick="mt.date(this,true)"  <%=disa %>>
   <%
   	if(status==2){
   %>
   <input type="button" onclick="fngettime()" value="获取当前时间"/>
   <%
   	}
   %>
			</td>
		</tr>
		<tr>
			<td>用户备注</td>
			<td><%=MT.f(invoice.getRemark()) %></td>
		</tr>
		<tr>
			<td>内部备注</td>
			<td>
				<%
					if(status==2){
						out.print(MT.f(invoice.getInternalremark()));
					}else{
				%>
				<textarea rows="5" cols="60" name="internalremark"></textarea>
				<%
					}
				%>
			</td>
		</tr>
		<tr>
			<td>票面备注</td>
			<td>
				<%
					if(status==2){
						out.print(MT.f(invoice.getNominalremark()));
					}else{
				%>
				<textarea rows="10" cols="60" name="nominalremark"><%=sb.toString() %></textarea>
				<%
					}
				%>
			</td>
		</tr>
	</table>
	</form>
<br>
<%
	if(status==2){
%>
<button class="btn" type="button" onclick="fnsubmit()">补填快递信息</button>
<%
	}else{
%>
<button class="btn" type="button" onclick="fnsubmit()">开具发票</button>
<%
	}
%>
<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>

<script>
function fnsubmit(){
	form2.submit();
}
function fngettime(){
	var date = new Date();

    var month = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : "0" + (date.getMonth()+1);

    var day = (date.getDate()) > 9 ? (date.getDate()) : "0" + (date.getDate());

    var hours = (date.getHours()) > 9 ? (date.getHours()) : "0" + (date.getHours());

    var minutes = (date.getMinutes()) > 9 ? (date.getMinutes()) : "0" + (date.getMinutes());

    var seconds = (date.getSeconds()) > 9 ? (date.getSeconds()) : "0" + (date.getSeconds());

     

    var dateString = 

        date.getFullYear() + "-" + 

        month + "-" + 

        day + " " + 

        hours + ":" + 

        minutes + ":" + 

        seconds;

         

    

    
	//alert(currentdate);
	
	document.getElementById("makeoutdate").value=dateString;
	
	return; 
	
}

</script>
</body>
</html>
