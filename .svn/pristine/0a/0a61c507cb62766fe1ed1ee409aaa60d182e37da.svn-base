<%@page import="tea.db.DbAdapter" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Database" %>
<%@page import="tea.entity.Http" %>
<%@page import="tea.entity.MT" %>
<%@page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%



    Http h = new Http(request, response);
    if (h.member < 1) {
        String param = request.getQueryString();
        String url = request.getRequestURI();
        if (param != null)
            url = url + "?" + param;
        response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
        return;
    }
   /* String openid=h.getCook("openid",null);
    if(openid!=null){//微信浏览器访问，后台清除openid，重新登录
        List<Profile> lstp= Profile.find1(" and openid="+ DbAdapter.cite(openid), 0, 1);
        if(lstp.size()==0){
            String param = request.getQueryString();
            String url = request.getRequestURI();
            if(param != null)
                url = url + "?" + param;
            response.sendRedirect("/mobjsp/yl/user/login_wx.jsp?nexturl="+url);
            return;
        }
    }*/
    //out.print("<script>alert('"+openid+"');</script>");

    int orderType = h.getInt("orderType");
    int menu = h.getInt("id");
    StringBuffer sql = new StringBuffer(), par = new StringBuffer("?");
    par.append("&menu=" + menu);

    sql.append(" AND (so.orderType = " + orderType + " )");
    par.append("&orderType=" + orderType);

    sql.append(" AND member=" + h.member);
    par.append("&member=" + h.member);

    sql.append(" AND status!=6");
    par.append("&status!=6");
//按医院查询

    String hname = h.get("hname", "");
    if (hname.length() > 0) {
        sql.append(" and order_id in (select order_id from shoporderdispatch where a_hospital like " + Database.cite("%" + hname + "%") + ")");
        par.append("&hname=" + h.enc(hname));
    }
    String orderId = h.get("orderId", "");
    if (orderId.length() > 0) {
        sql.append(" AND order_Id LIKE " + Database.cite("%" + orderId + "%"));
        par.append("&orderId=" + h.enc(orderId));
    }

    Date time0 = h.getDate("time0");
    if (time0 != null) {
        sql.append(" AND createDate>" + DbAdapter.cite(time0));
        par.append("&createDate=" + MT.f(time0));
    }
    Date time1 = h.getDate("time1");
    if (time1 != null) {
        sql.append(" AND createDate<" + DbAdapter.cite(time1));
        par.append("&createDate=" + MT.f(time1));
    }

    int invoice_status = h.getInt("invoice_status", -1);
    if (invoice_status != -1) {
        sql.append(" AND invoiceStatus = " + invoice_status);
        par.append("&puid=" + invoice_status);
    }


    String[] TAB = {"全部订单", "待付款", "已完成", "已取消"};
    String[] SQL = {"  ", " AND status=0", " AND status=4", " AND status=5"};
    int tab = h.getInt("tab", 0);
    par.append("&tab=" + tab);

    int pos = h.getInt("pos");
    par.append("&pos=");


%><!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
    <title><%= (orderType==1?"TPS":"设备")%>订单</title>

    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
</head>
<body>

<div class="body">
    <form name="form1" action="?">
        <input type="hidden" name="id" value="<%=menu%>"/>
        <input type="hidden" name="tab" value="<%=tab%>"/>
        <input type="hidden" name="orderType" value="<%=h.getInt("orderType")%>">
        <div class="order-sea">
            <div class="order-sea-left fl-left">
                <p>
                    <span class="ft14 order-l-span">订单编号：</span>
                    <input type="text" class="right-box-inp" name="orderId" value="<%=MT.f(orderId)%>"/>
                </p>
                <p>
                    <span class="ft14 order-l-span">订单时间：</span>
                    <span class="time">
                        <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                        <span style="">~</span>
                        <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    </span>
                </p>
                <p>
                    <span class="ft14 order-l-span">开票状态：</span>
                    <span class="invice_status">
                        <select name='invoice_status'>
                    <option value=''>请选择</option>
                    <option <%= (invoice_status==1?"selected='selected'":"") %> value=1>已开票</option>
                    <option <%= (invoice_status==0?"selected='selected'":"") %> value=0>未开票</option>
                </select>
                    </span>
                </p>
            </div>
            <input type="submit" class="fl-right order-cxb order-cxb2 ft14" value="查询">
        </div>

    </form>

    <div class="order-lx">
        <%
            out.print("<ul>");
            for (int i = 0; i < TAB.length; i++) {
                out.print("<li class='ft14 fl-left " + (i == tab ? "on" : "") + "'><a href='javascript:mt.tab(" + i + ")'>" + TAB[i] + "(" + ShopOrder.count(sql.toString() + SQL[i]) + ")</a></li>");
            }
            out.print("</ul>");
        %>
    </div>

    <form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
        <input type="hidden" name="orderId"/>
        <input type="hidden" name="status"/>
        <input type="hidden" name="cancelReason"/>
        <input type="hidden" name="tab" value="<%=tab%>"/>
        <input type="hidden" name="nexturl"/>
        <input type="hidden" name="act"/>


        <%
            sql.append(SQL[tab]);

            int sum = ShopOrder.count(sql.toString());
            if (sum < 1) {
                out.print("<p class='text-c'>暂无记录!</p>");
            } else {
                //sql.append(" order by createDate desc");
                Iterator it = ShopOrder.find(sql.toString() + " order by createDate desc ", pos, 5).iterator();
                for (int i = 1 + pos; it.hasNext(); i++) {
                    ShopOrder t = (ShopOrder) it.next();

                    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(t.getOrderId());

                    String querySql = " AND order_id=" + DbAdapter.cite(t.getOrderId());
                    List<ShopOrderData> sodList = ShopOrderData.find(querySql, 0, Integer.MAX_VALUE);
                    ShopOrderData odata = null;
                    if (sodList.size() > 0) {

                        //Filex.logs("yt.txt",t.getOrderId());
                        odata = sodList.get(0);
                    }
                    String uname = MT.f(Profile.find(t.getMember()).member);
                    int status = t.getStatus();
                    String statusContent = "";
                    if (status == 0)
                        statusContent = "待付款";
                    else if (status == 1 || status == 2 || status == -1 || status == -2 || status == -3 || status == -4 || status == -5)
                        statusContent = "待发货";
                    else if (status == 3)
                        statusContent = "待收货";
                    else if (status == 4)
                        statusContent = "已完成";
                    else if (status == 5)
                        statusContent = "<a href='###' onclick=\"layer.alert('" + MT.f(t.getCancelReason()) + "');\">已取消</a>";
                    else if (status == 7)
                        statusContent = "已退货";
        %>
        <div class="order-list">
            <p class="order-line1 ft14">
                <span class="fl-left order-tit"><%=MT.f(sod.getA_hospital()) %></span>
                <span class="fl-right order-zt"><%if (tab == 0) {%><%=statusContent%><%}%></span>
            </p>
            <ul class="ft14">
                <li>
                    <span class="list-spanr5 fl-left">订单编号：</span>
                    <span class="list-spanr fl-left"><%=t.getOrderId()%></span>
                </li>
                <%if (orderType == 1) {//展示激活码%>
                <li>
                    <span class="list-spanr5 fl-left">购买方式：</span>
                    <%
                        Iterator its = ShopOrderData.find("AND order_id=" + DbAdapter.cite(t.getOrderId()), 0, Integer.MAX_VALUE).iterator();
                        for (int j = 1; its.hasNext(); j++) {
                            ShopOrderData t1 = (ShopOrderData) its.next();
                            int product_id = t1.getProductId();
                            ShopProduct sp = ShopProduct.find(product_id);
                            ShopCategory sc1 = ShopCategory.find(sp.category);
                            ShopProductModel spm = ShopProductModel.find(sp.model_id);%>
                    <span class="list-spanr fl-left"><%=sc1.name[1] + spm.getModel()%></span>
                    <%
                        }
                    %>

                </li>
                <%} else {//展示设备名称%>
                <li>
                    <span class="list-spanr5 fl-left">设备名称：</span>
                <%
                    if (odata != null) {
                        ShopProduct sp1 = ShopProduct.find(odata.getProductId());
                %>

                <span class="list-spanr fl-left"><%=sp1.name[1]%></span>
                <%
                        }
                    }
                    String[]atr ={"未开票","已开票 "};
                %>
                </li>
                <li>
                    <span class="list-spanr5 fl-left">开票状态：</span>
                    <span class="list-spanr fl-left"><%=atr[t.getInvoiceStatus()]%></span>
                </li>
                <li>
                    <span class="list-spanr5 fl-left">订单金额：</span>
                    <span class="list-spanr fl-left"><%= t.getAmount() %></span>
                </li>
                <li>
                    <span class="list-spanr5 fl-left">支付方式：</span>
                    <span class="list-spanr fl-left"><%= ShopOrder.payTypeARR[t.getPayType()]%></span>
                </li>
                <%

                if (orderType == 1) {
                                List<JihuoUse> list = JihuoUse.find("AND orderid=" + DbAdapter.cite(t.getOrderId()), 0, Integer.MAX_VALUE);
                                if (list.size() > 0) {
                                    String codes = "";
                                    for (int j = 0; j < list.size(); j++){
                                        String code = JihuoCode.find(list.get(j).getCodeid()).getCode();
                                        codes += code;
                                        if(j!=list.size()-1){
                                            codes+="、";
                                        }
                                    }%>
                <li>
                    <span class="list-spanr5 fl-left">激活码：</span>
                    <span class="list-spanr fl-left"><%= codes%></span>
                </li>
                                <%} else {%>
                <li>
                    <span class="list-spanr5 fl-left">激活码：</span>
                    <span class="list-spanr fl-left">无</span>
                </li>
                                <%}
                            }

                                %>



                <%-- <li>
                     <span class="list-spanr5 fl-left">厂商：</span>
                     <span class="list-spanr fl-left"><%= ProcurementUnit.findName(t.getPuid()) %></span>
                 </li>--%>
                <%--<li>
                    <span class="list-spanr5 fl-left">数量：</span>
                    <span class="list-spanr fl-left">
                       <%
                           if (sodList.size() > 0) {
                               out.print(odata.getQuantity());
                           }
                       %>
                   </span>
                </li>--%>

                <%--<li>
                    <span class="list-spanr5 fl-left">已开票数量：</span>
                    <span class="list-spanr fl-left"><%=t.getIsinvoicenum() %></span>
                </li>--%>

                <li>
                    <span class="list-spanr5 fl-left">下单时间：</span>
                    <span class="list-spanr fl-left"><%=MT.f(t.getCreateDate(), 1)%></span>
                </li>
            </ul>
            <p class="order-btnp">


                <%

                    List<ShopExchanged> exchangelst = ShopExchanged.find(" and order_id=" + Database.cite(t.getOrderId()), 0, Integer.MAX_VALUE);
                    if (exchangelst.size() == 0) {
                        if (status != 5 && t.getInvoiceStatus() == 0) {
                            if (Profile.find(h.member).membertype != 2) {
                                if (status > 0) {
                                    //out.println("<a href=\"javascript:mt.act('getfp','"+MT.enc(t.getOrderId())+"');\">索要发票</a>");
                                }
                            } else {
                                //out.println("<a href=\"javascript:mt.act('getfp','"+MT.enc(t.getOrderId())+"');\">索要发票</a>");
                            }
                        }
                    }

                    out.println("<a class='btn' href=\"javascript:mt.act('data','" + MT.enc(t.getOrderId()) + "');\">查看</a>");
                    if (status == 0)
                        out.println("<a class='btn' href=\"javascript:mt.act('status','" + t.getOrderId() + "',5,'取消订单');\" >取消订单</a>");


                    if (status == 3) {

                        Profile m = Profile.find(h.member);
                        //if(m.membertype==2)
                       // out.println("<a  class='btn' onclick=\"mt.act('printOrder','" + t.getOrderId() + "');\" >打印发货单</a>");
                        //out.println("<a class='btn' href=\"javascript:mt.act('printOrder','"+t.getOrderId()+"');\">打印发货单</a>");
                        //if(m.membertype != 2) //服务器，不允许确认收货，只能通过签收人微信扫码
                       // out.println("<a class='btn' href=\"javascript:mt.act('status','" + t.getOrderId() + "',4,'确认收货');\">确认收货</a>");
                    }
                    //if(status==4||status==5)
                    //	out.println("|<a href=\"javascript:mt.act('status','"+t.getOrderId()+"',6,'删除订单');\">删除</a>");
                    if (status == 4) {
                        ShopExchanged ex = ShopExchanged.findByOrderId(t.getOrderId());
                        if (ex.id > 0) {
                           // out.println("<a class='btn' href=\"javascript:mt.act('refund','" + MT.enc(t.getOrderId()) + "');\">查看退货</a>");

                        } else {
                          //  out.println("<a class='btn' href=\"javascript:mt.act('refund','" + MT.enc(t.getOrderId()) + "');\">申请退货</a>");

                        }
                        Date createDate = t.getCreateDate();
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        Calendar c = Calendar.getInstance();
                        Date new_date = createDate;
                        c.setTime(new_date);
                        c.add(Calendar.MONTH,3);
                        Date new_date1 = c.getTime();
                        if(new_date1.after(new Date())) {//订单日期三个月内允许补开发票
                            if (t.getIsinvoice() == 0 && t.getIsbkinvoice() == 0) {
                                out.println("<a class='btn' href=\"javascript:mt.act('bkinvoice','" + MT.enc(t.getOrderId()) + "');\">补开发票</a>");
                            }
                        }
                        Profile m = Profile.find(h.member);
                                    /*if(m.membertype==2){
                                        out.println("<a class='btn' href=\"javascript:mt.act('printOrder','"+t.getOrderId()+"');\">打印发货单</a>");
                                    }*/
                        //if(m.membertype == 2||m.membertype==0){
                      //  out.println("<a  class='btn' onclick=\"mt.act('printOrder','" + t.getOrderId() + "');\" >打印发货单</a>");
                        //}
                    }

                %>
            </p>
        </div>

        <%
                }
                if (sum > 5)
                    out.print("<div id='ggpage'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 5) + "</div>");
            }
        %>


        <%
            Profile pro = Profile.find(h.member);
            if (pro.getMembertype() == 2) {
                sql.append(" AND isLzCategory=1");
                sql.append(" order by createDate desc");
        %>
        <!--div class='center text-c pd20'><button class="btn btn-primary btn-blue" type="button" onclick="dcorder()">导出</button></div-->
        <%} %>

    </form>


</div>
<script>
    form2.nexturl.value = location.pathname + location.search;
    mt.act = function (a, orderId, status, statusContent) {
        form2.act.value = a;
        form2.orderId.value = orderId;
        if (a == 'del') {
            mt.show('你确定要删除吗？', 2, 'form2.submit()');
        } else if (a == 'status') {
            form2.status.value = status;
            if (status == 5) {
                /*layer.prompt({title: '取消订单原因', formType: 2}, function (pass, index) {
                    if (pass == "") {
                        layer.alert("“取消订单原因”不能为空！");
                    } else {
                        form2.cancelReason.value = t.value;
                        form2.submit();
                    }
                    layer.close(index);
                });*/
                mt.show("<textarea id='_content' cols='33' style='width: 100%;' rows='6' title='请填写取消订单原因...'></textarea>",2,'取消订单原因',348);
                mt.ok=function()
                {
                    var t=parent.$$('_content');
                    if(t.value=='')
                    {
                        alert('“取消订单原因”不能为空！');
                        return false;
                    }
                    form2.cancelReason.value = t.value;
                    form2.submit();
                }

            } else {
                mt.show('你确定要"' + statusContent + '"吗？', 2, 'form2.submit()');
            }
        } else if (a == 'data') {
            //window.open("ShopOrderDatas.jsp?orderId="+orderId);
            location.href = "/mobjsp/yl/shopweb/ShopOrderDatasNew_Other.jsp?orderId=" + orderId;

        } else if (a == 'payment') {
            //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
            window.open("/html/folder/14110391-1.htm?orderId=" + orderId);
        } else if (a == 'refund') {
            //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
            location.href = "/mobjsp/yl/shopweb/ShopOrderDatasRefundNew.jsp?orderId=" + orderId;
        } else if (a == 'getfp') {
            //parent.location="/jsp/yl/shopweb/ShopGetFp.jsp?orderId="+orderId;
            parent.location = "/html/folder/14113269-1.htm?orderId=" + orderId;
        } else if (a == 'printOrder') {
            /* form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt.jsp");
            form2.target='_self';form2.method='get';form2.submit(); */
            // parent.location="/jsp/yl/shop/ShopOrderDatasReceipt.jsp";
            location.href = "/jsp/yl/shop/ShopOrderDatasReceipt.jsp?orderId=" + orderId;
        }else if(a=='bkinvoice'){
            location.href = "/jsp/yl/shop/Invoice_edit.jsp?orderId=" + orderId;
        }
    };

    function dcorder() {
        form3.submit();
    }

    mt.receive = function (v, n, h) {
        document.getElementById("hname").value = v;
    };
    mt.fit();
</script>
</body>
</html>
