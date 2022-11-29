<%@page import="util.Config"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

String orderId = MT.dec(h.get("orderId"));
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
sql.append(" AND order_id="+DbAdapter.cite(orderId));
par.append("&orderId="+orderId);

int sum=ShopOrderData.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

String nexturl = h.get("nexturl");

%><!DOCTYPE html><html><head>


<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<script src="/tea/city.js"></script>
<style>
    .con-left-list .tit-on<%= (so.getOrderType()+1)%>{color:#044694;}

</style>
</head>
<body>
<!-- <h1>订单详细</h1>
 -->
<%
int tpflag = 0;
String hdstr = "";
String tmstr = "";
int status = so.getStatus();
String statusContent = "";
/*if(status==0)
	  statusContent = "待付款";
else*/ if(status==4)
	  statusContent = "已完成";
else if(status==5)
	  statusContent = "取消订单";
else
    statusContent = "待付款";
    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
    Profile p=Profile.find(so.getMember());//12.6新加 手机号更改为获取p的mobile，之前为获取sod的a_mobile；
    float price = so.getAmount().floatValue();
    Profile profile = Profile.find(so.getMember());
    ArrayList sodList = ShopOrderData.find(" AND order_id="+Database.cite(so.getOrderId()),0,Integer.MAX_VALUE);
    if(sodList.size()>0){
        ShopOrderData sorderdata = (ShopOrderData)sodList.get(0); //订单详细
        price=sorderdata.getAmount().floatValue();
    }
%>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
<table class="right-tab" border="1" cellspacing="0" style="margin:0px;">
<tr style="font-weight:bold;"><td colspan="4" align='left' style="font-size:15px;">订单信息</td></tr>
<tr>
	<td width="10%" align='right'>订单编号</td><td align='left'><%=MT.f(so.getOrderId()) %></td>
	<td align='right'>下单时间</td><td align='left'><%=MT.f(so.getCreateDate(),1) %></td>
</tr>
<tr>
	<td width="10%" align='right'>当前状态</td><td align='left'><%=MT.f(statusContent) %></td>
	<td width="10%" align='right'>支付方式</td><td align='left'><%= ShopOrder.payTypeARR[so.getPayType()] %></td>
</tr>
    <%if(so.getOrderType()==1&&so.getPayType()!=0){//tps,已支付%>
    <tr>
        <td width="10%" align='right'>激活码状态</td><td align='left'><%=MT.f(ShopOrder.jhpstastusARR[so.getJhpstastus()])%></td>
        <td width="10%" align='right'></td><td align='left'></td>
    </tr>
    <%}%>

    <tr>
        <td width="10%" align='right'>开票状态</td><td align='left'><%out.print(so.getInvoiceStatus() == 1 ? "已开票" : "未开票");%></td>
        <td width="10%" align='right'></td><td align='left'></td>
    </tr>
<%
if(so.getStatus()==5)
{
%>
<tr>
	<td width="10%" align='right'>取消原因</td><td colspan='3' align='left'><%=MT.f(so.getCancelReason()) %></td>
</tr>
<%
}
%>
    <tr style="font-weight:bold;"><td colspan="4" align='left'>收货人信息</td></tr>
    <tr>
        <td align='right'>收货人姓名</td><td align='left'><%=MT.f(sod.getA_consignees())%></td>
        <td align='right'>手机号</td><td align='left'><%=MT.f(sod.getA_mobile())%></td>
    </tr>
    <tr>
        <td align='right'>地址</td><td align='left'><%=MT.f(sod.getA_address())%></td>
        <td align='right'>邮编</td><td align='left'><%=MT.f(so.getYoubian())%></td>
    </tr>
    <tr>
        <td align='right'>邮箱</td><td align='left'><%=MT.f(so.getMail())%></td>
    </tr>

    <tr style="font-weight:bold;"><td colspan="4" align='left'>开票信息</td></tr>
    <tr>
        <td align='right'>是否开票</td><td align='left'><%= (so.getIsinvoice()==0?"否":"是") %></td>
        <td align='right'<%=so.getIsinvoice()==0?"style='display: none'":""%> >是否补开</td>
        <td align='left'<%=so.getIsinvoice()==0?"style='display: none'":""%> ><%if(so.getIsbkinvoice()==0){%>
          否
        <%}else {%>
          是
        <%}%></td>

    </tr>
    <tbody <%= (so.getIsinvoice()==0?"style='display: none'":"") %> >
    <%--<tr>
        <td align='right'>是否补开</td><td align='left'><%= (so.getIsbkinvoice()==0?"否":"是") %></td>
    </tr>--%>
    <tr>
        <td align='right'>名称</td><td align='left'><%=MT.f(so.getInvoiceName())%></td>
        <td align='right'>税号</td><td align='left'><%=MT.f(so.getInvoiceDutyParagraph())%></td>
    </tr>
    <tr>
        <%--<td align='right'>地址省</td><td align='left'><%=MT.f(so.getInvoiceProvinces())%></td>--%>
        <td align='right'>地址省</td><td align='left'><%
            String a = MT.f(so.getInvoiceProvinces())+ "";
            String b = "";
            try{
                b = a.substring(0, 2);
                a=a.substring(0,4);
            }catch (Throwable e){
                b = "0";
                a="0";
            }
            int pro = Integer.valueOf(b);
            int src = Integer.valueOf(a);
        %>
            <script>
                var a = getProvince("<%=pro%>");
                var b = getSrcity2('<%=pro%>', '<%=src%>');
                document.write(a);
                document.write("  ");
                document.write(b);
            </script></td>
        <td align='right'>地址</td><td align='left'><%=MT.f(so.getInvoiceAddress())%></td>
    </tr>
    <tr>
        <td align='right'>电话</td><td align='left'><%=MT.f(so.getInvoiceMobile())%></td>
        <td align='right'>开户行</td><td align='left'><%=MT.f(so.getInvoiceOpeningBank())%></td>
    </tr>
    <tr>
        <td align='right'>账号</td><td align='left'><%=MT.f(so.getInvoiceAccountNumber())%></td>
        <td align='right'>费用名称</td><td align='left'><%=MT.f(so.getInvoiceCostName())%></td>
    </tr>
    </tbody>
</table>
<style>
	.tab1 td,.tab1 th{
		text-align:center;
	}
</style>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act"/>
<table class="right-tab tab1" border="1" cellspacing="0" style="margin-top:20px;">
<tr id="tableonetr">
  <th>商品图片</th>
  <th>商品名称</th>
    <%
        if(so.getOrderType()==1){
            %>
    <th>软件大小</th>
    <th>软件版本</th>
    <th>购买方式</th>
    <th>激活码</th>
    <%}%>
  <th>商品单价</th>
  <th>商品数量</th>
</tr>
<%
if(sum<1){
	out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else{
	Profile pf = Profile.find(so.getMember());
    Iterator it=ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE).iterator();
    for(int i=1;it.hasNext();i++) {
        ShopOrderData t = (ShopOrderData) it.next();

        int product_id = t.getProductId();
        ShopProduct sp = ShopProduct.find(product_id);
        ShopPackage spage = new ShopPackage(0);

        out.print("<tr>");
        out.print("<td>"+sp.getAnchor('t')+"</td>");
        out.print("<td>"+sp.name[1]+"</td>");

        if(so.getOrderType()==1){
            out.print("<td>"+MT.f(sp.color)+"</td>");
            out.print("<td>"+MT.f(sp.size)+"</td>");
            ShopCategory sc1 = ShopCategory.find(sp.category);
            ShopProductModel spm = ShopProductModel.find(sp.model_id);
            out.print("<td>"+sc1.name[1]+spm.getModel()+"</td>");
            List<JihuoUse>list_jihuo = JihuoUse.find("AND orderid="+DbAdapter.cite(t.getOrderId())+" AND productid="+t.getProductId(),0,Integer.MAX_VALUE);//根据订单和商品获取激活码使用记录
            if(list_jihuo.size()>0) {//有激活码
                String jihuo_code = JihuoCode.find(list_jihuo.get(0).getCodeid()).getCode();//获取激活码
                out.print("<td>"+MT.f(jihuo_code)+"</td>");
            }else {//无激活码
                    out.print("<td>暂无激活码</td>");

            }

        }
        out.print("<td>"+MT.f((double)t.getUnit(),2)+"</td>");
        out.print("<td>"+t.getQuantity()+"</td>");
        out.print("</tr>");
    }


}
%>
	<tr><td colspan="<%= (so.getOrderType()==1?"9":"6")%>" style="text-align:right !important;" class='tagsize'>
		<%-- 商品总价：<span>&yen&nbsp;<%=MT.f((double)so.getAmount(),2)%></span>&nbsp;&nbsp;&nbsp;&nbsp; --%>
            商品总价：<span>&yen&nbsp;<%=MT.f((double)so.getAmount(),2)%></span>
	</td></tr>

</table>


<br/>
	<div class="center text-c pd20">
		<button class="btn btn-default" type="button" onclick="printView('<%=MT.enc(orderId)%>')">打印预览</button>
	</div>
<%-- <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button> --%>
</form>
	</div>
</div>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,oid,did)
{
  if(a=='refund')
  {
	  location.href="/jsp/yl/shopweb/ShopExchangedAdd.jsp?oid="+oid+"&did="+did;
  }
};

function printView(orderId){
	 window.open("/html/folder/14110866-1.htm?orderId="+orderId);
};
mt.fit();
</script>
</body>
</html>
