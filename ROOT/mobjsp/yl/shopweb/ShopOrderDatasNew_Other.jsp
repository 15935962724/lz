<%@page import="util.Config" %>
<%@page import="tea.db.DbAdapter" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.member.Profile" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    StringBuffer sql = new StringBuffer(), par = new StringBuffer("?");

    String orderId = MT.dec(h.get("orderId"));
//根据订单id查询订单信息
    ShopOrder so = ShopOrder.findByOrderId(orderId);
    sql.append(" AND order_id=" + DbAdapter.cite(orderId));
    par.append("&orderId=" + orderId);

    int sum = ShopOrderData.count(sql.toString());

    int pos = h.getInt("pos");
    par.append("&pos=");

    String nexturl = h.get("nexturl");

%><!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
    <title>粒子订单</title>


    <!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 -->
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <script src="/tea/view.js" type="text/javascript"></script>
    <script src="/tea/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <script src="/tea/city.js"></script>

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
    if (status == 0)
        statusContent = "待付款";
    else if (status == 1)
        statusContent = "待发货";
    else if (status == 2 || status == 3)
        statusContent = "待收货";
    else if (status == 4)
        statusContent = "已完成";
    else if (status == 5)
        statusContent = "取消订单";

    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
    float price = so.getAmount().floatValue();
    if (so.isLzCategory()) {
        Profile profile = Profile.find(so.getMember());
        ArrayList sodList = ShopOrderData.find(" AND order_id=" + Database.cite(so.getOrderId()), 0, Integer.MAX_VALUE);
        if (sodList.size() > 0) {
            ShopOrderData sorderdata = (ShopOrderData) sodList.get(0); //订单详细
            if (profile.qualification == 1 && so.isLzCategory()) {
                price = sorderdata.getAmount().floatValue();
            }
            if (profile.membertype == 2) {//医院代理商价格
                price = sorderdata.getAgent_amount();
            }
        }
    }
%>

<div class="body">
    <div class="detail-list">
        <p class="detail-tit ft16">订单信息</p>
        <ul class="ft14">
            <li>
                <span class="list-spanr3 fl-left">订单编号：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getOrderId()) %></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">下单时间：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getCreateDate(), 1) %></span></li>
            <li>
                <span class="list-spanr3 fl-left">当前状态：</span>
                <span class="list-spanr fl-left"><%=MT.f(statusContent) %></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">支付方式：</span>
                <span class="list-spanr fl-left"><%out.print(so.getPayType() == 1 ? "在线支付" : "公司转账"); %></span>
            </li>
            <%if(so.getOrderType()==1&&so.getPayType()!=0){//tps订单，已支付%>
            <li>
                <span class="list-spanr3 fl-left">激活码状态：</span>
                <span class="list-spanr fl-left"><%out.print(MT.f(ShopOrder.jhpstastusARR[so.getJhpstastus()]));%></span>
            </li>
            <%}%>

            <li>
                <span class="list-spanr3 fl-left">开票状态：</span>
                <span class="list-spanr fl-left"><%out.print(so.getInvoiceStatus() == 1 ? "已开票" : "未开票"); %></span>
            </li>
            <%
                int mypuid = ShopOrderData.findPuid(so.getOrderId());
                if (mypuid == Config.getInt("junan")) {
            %>
            <li>
                <span class="list-spanr3 fl-left">是否调配：</span>
                <span class="list-spanr fl-left"><%= (so.getAllocate() == 0 ? "否" : "是") %></span>
            </li>
            <%
                if (so.getAllocate() == 1) {
                    out.print("<li><span class=\"list-spanr3 fl-left\">支付方式：</span><span class=\"list-spanr fl-left\">" + (so.getAllocatetype() == 0 ? "同意" : "不同意") + "</span></li>");
                } else {

                }
            %>

            <%
                }
            %>
            <%
                if (so.getStatus() == 5) {
            %>
            <li>
                <span class="list-spanr3 fl-left">取消原因</span><span
                    class="list-spanr fl-left"><%=MT.f(so.getCancelReason()) %></span>
            </li>
            <%
                }
            %>
        </ul>
    </div>
    <div class="detail-list">
        <p class="detail-tit ft16">收货人信息</p>
        <ul class="ft14">

            <li>
                <span class="list-spanr3 fl-left">收件人：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getName())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">联系电话：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getMobile())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">邮箱：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getMail())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">邮编：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getYoubian())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">地址：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getAddress())%></span>
            </li>
        </ul>
    </div>
    <%
        if (so.getStatus() == 3 || so.getStatus() == 4) {
            ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
            if (soe.time != null) {
    %>
    <div class="detail-list">
        <p class="detail-tit ft16">发货信息</p>
        <ul class="ft14">
            <li>
                <span class="list-spanr3 fl-left">快递单号：</span>
                <span class="list-spanr fl-left"><%=MT.f(soe.express_code)%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">销售编号：</span>
                <span class="list-spanr fl-left"><%=MT.f(soe.NO1)%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">生产批号：</span>
                <span class="list-spanr fl-left"><%=MT.f(soe.NO2)%></span>
            </li>
            <%
                if (Config.getInt("junan") != mypuid) {
            %>
            <li>
                <span class="list-spanr3 fl-left">有效期：</span>
                <span class="list-spanr fl-left"><%=MT.f(soe.vtime)%></span>
            </li>
            <%
                }
            %>
            <li>
                <span class="list-spanr3 fl-left">发货日期：</span>
                <span class="list-spanr fl-left"><%=MT.f(soe.time)%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">发件人：</span>
                <span class="list-spanr fl-left"><%=MT.f(soe.person)%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">联系电话：</span>
                <span class="list-spanr fl-left"><%=MT.f(soe.mobile)%></span>
            </li>
            <%
                if (MT.f(soe.express_img).length() > 0) {

                    String imgsr = "";
                    if (MT.f(soe.express_img).length() > 0) {
                        String[] imgarr = soe.express_img.split(",");
                        for (int i = 0; i < imgarr.length; i++) {
                            Attch attch = Attch.find(Integer.parseInt(imgarr[i]));
                            imgsr = attch.path;
                        }
                    }

                    out.print("<li><span class='list-spanr3 fl-left'>快递图片：</span><span class='list-spanr fl-left'><img src='" + imgsr + "' width='300px' height='300px' ></span></li>");
                }

            %>
        </ul>
    </div>
    <%
            }
        }
    %>
    <div class="detail-list">
        <p class="detail-tit ft16">发票信息</p>
        <ul class="ft14">
            <li>
                <span class="list-spanr3 fl-left">是否开票：</span>
                <span class="list-spanr fl-left"><%if (so.getIsinvoice() == 0) {%>
				  否
                <%} else {%>
				  是
                <%

                    if (so.getIsbkinvoice() == 0) {//不是补开的
                %>
                </span></li>
            <li>
                <span class="list-spanr3 fl-left">是否补开：</span>
                <span class="list-spanr fl-left">否</span>
            </li>
            <%} else {//补开%>
            <li>
                <span class="list-spanr3 fl-left">是否补开：</span>
                <span class="list-spanr fl-left">是</span>
                <%}%>
            </li>
            <li>
                <span class="list-spanr3 fl-left">名称：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getInvoiceName())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">税号：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getInvoiceDutyParagraph())%></span>
            </li>

            <li>
                <span class="list-spanr3 fl-left">地址省：</span>
                <span class="list-spanr fl-left">
                    <%
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
                    %><script>
                var a = getProvince("<%=pro%>");
                var b = getSrcity2('<%=pro%>', '<%=src%>');
                document.write(a);
                document.write("  ");
                document.write(b);
            </script>
                </span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">地址：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getInvoiceAddress())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">电话：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getInvoiceMobile())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">开户行：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getInvoiceOpeningBank())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">账号：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getInvoiceAccountNumber())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">费用名称：</span>
                <span class="list-spanr fl-left"><%=MT.f(so.getInvoiceCostName())%></span>

            <%}%></li>
        </ul>
    </div>
    <div class="detail-list">
        <p class="detail-tit ft16">订单备注</p>
        <p class="detail-bz"><%out.print(so.getUserRemarks() == null || so.getUserRemarks().length() < 1 ? "无" : MT.f(so.getUserRemarks())); %></p>
    </div>
    <div class="detail-list">
        <p class="detail-tit ft16">商品信息</p>
        <table class="detail-tab" border="1">
            <%
                sql = new StringBuffer();
                par = new StringBuffer("?");
//根据订单id查询订单信息
                so = ShopOrder.findByOrderId(orderId);
                sql.append(" AND order_id=" + DbAdapter.cite(orderId));
                par.append("&orderId=" + orderId);

                sum = ShopOrderData.count(sql.toString());
                if (sum < 1) {
                    out.print("<tr><td colspan='2' align='center'>暂无记录!</td></tr>");
                } else {
                    Profile pf = Profile.find(so.getMember());
                    Iterator it = ShopOrderData.find(sql.toString(), pos, Integer.MAX_VALUE).iterator();
                    for (int i = 1; it.hasNext(); i++) {
                        ShopOrderData t = (ShopOrderData) it.next();

                        int product_id = t.getProductId();
                        ShopProduct sp = ShopProduct.find(product_id);
                        ShopPackage spage = new ShopPackage(0);

                        out.println("<tr><td class=td1>商品图片</td><td>" + sp.getAnchor('t') + "</td></tr>");
                        out.println("<tr><td class=td1>商品名称</td><td>");
                        out.print("" + sp.name[1] + "</td></tr>");
                        if (so.getOrderType() == 1) {
                            out.print("<tr><td class=td1>软件大小</td><td>" + MT.f(sp.color) + "</td></tr>");
                            out.print("<tr><td class=td1>软件版本</td><td>" + MT.f(sp.size) + "</td></tr>");
                            out.print("<tr><td class=td1>购买方式</td>");
                            ShopCategory sc1 = ShopCategory.find(sp.category);
                            ShopProductModel spm = ShopProductModel.find(sp.model_id);
                            out.print("<td class=td1>" + sc1.name[1] + spm.getModel() + "</td></tr>");
                            List<JihuoUse>list_jihuo = JihuoUse.find("AND orderid="+DbAdapter.cite(t.getOrderId())+" AND productid="+t.getProductId(),0,Integer.MAX_VALUE);//根据订单和商品获取激活码使用记录
                            if(list_jihuo.size()>0) {//有激活码
                                String jihuo_code = JihuoCode.find(list_jihuo.get(0).getCodeid()).getCode();//获取激活码
                                out.print("<tr><td class=td1>激活码</td><td>"+MT.f(jihuo_code)+"</td>");
                            }else {//无激活码
                                out.print("<tr><td class=td1>激活码</td><td >暂无激活码</td></tr>");

                            }
                        }
                        out.print("<tr><td class=td1>商品单价</td><td>&yen&nbsp;" + MT.f((double) t.getUnit(), 2) + "</td></tr>");
                        out.print("<tr><td class=td1>商品数量</td><td>" + t.getQuantity() + "</td></tr>");
                        out.print("<tr><td class=td1>商品总价</td><td>&yen&nbsp;" + price + "</td></tr>");
                        /*<span>&yen&nbsp;</span>*/


                    }
                }
            %>
            <%--<tr><td class=td1>开票金额</td>
                &lt;%&ndash; 商品总价：<span>&yen&nbsp;<%=MT.f((double)so.getAmount(),2)%></span>&nbsp;&nbsp;&nbsp;&nbsp; &ndash;%&gt;
            <td><span>&yen&nbsp;<%=price%></span>--%>
            </td></tr>
        </table>
    </div>
</div>


<%
    if (Config.getInt("junan") == mypuid) {

%>
<div class="detail-list">
    <p class="detail-tit ft16">调配信息</p>
    <ul class="ft14">
        <li>
            <span class="list-spanr3 fl-left">是否已调配：</span>
            <span class="list-spanr fl-left"><%= (tpflag == 0 ? "否" : "是") %></span>
        </li>
        <%
            if (tpflag == 1) {
        %>
        <li>
            <span class="list-spanr3 fl-left">校准时间：</span>
            <span class="list-spanr fl-left"><%= tmstr %></span>
        </li>
        <li>
            <span class="list-spanr3 fl-left">粒子活度：</span>
            <span class="list-spanr fl-left"><%= hdstr %></span>
        </li>
        <%
            }
        %>
    </ul>
</div>
<%

    List<StockOperation> solist = StockOperation.find(" AND oid = " + so.getId() + " AND type = 5 AND isRetreat = 0 ", 0, Integer.MAX_VALUE);

%>
<div class="detail-list">
    <p class="detail-tit ft16">库存信息</p>
    <table class="detail-tab" border="1">
        <%
            if (solist.size() == 0) {
                out.print("<tr><td colspan='2' style='text-align:center;'>暂无记录</td></tr>");
            } else {
                for (int i = 0; i < solist.size(); i++) {
                    StockOperation son = solist.get(i);
                    ProductStock pss = ProductStock.find(son.getPsid());
                    //out.print("<tr><td class=td1></td><td>"+(i+1)+"</td></tr>");
                    out.print("<tr><td class=td1>购买活度</td><td>" + son.getActivity() + "</td></tr>");
                    out.print("<tr><td class=td1>质检号</td><td>" + pss.getQuality() + "</td></tr>");
                    out.print("<tr><td class=td1>批号</td><td>" + pss.getBatch() + "</td></tr>");
                    out.print("<tr><td class=td1>购买数量</td><td>");
                    out.print(son.getAmount() + son.getReserve());
                    out.print("</td></tr>");
                    out.print("<tr><td class=td1>有效期</td><td>" + son.getValid() + "</td></tr>");

                }
            }
        %>
    </table>
</div>

<%

    }
%>

<br/>

<%-- <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button> --%>
</form>
</div>
</div>
<script>
    form2.nexturl.value = location.pathname + location.search;
    mt.act = function (a, oid, did) {
        if (a == 'refund') {
            location.href = "/jsp/yl/shopweb/ShopExchangedAdd.jsp?oid=" + oid + "&did=" + did;
        }
    };

    function printView(orderId) {
        window.open("/html/folder/14110866-1.htm?orderId=" + orderId);
    };
    mt.fit();
</script>
</body>
</html>
