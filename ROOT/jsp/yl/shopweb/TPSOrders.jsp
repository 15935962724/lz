<%@page import="tea.db.DbAdapter" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Database" %>
<%@page import="tea.entity.Http" %>
<%@page import="tea.entity.MT" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int menu = h.getInt("id");
    StringBuffer sql = new StringBuffer(), par = new StringBuffer("?");
    par.append("&menu=" + menu);

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

    int orderType = h.getInt("orderType");
    sql.append(" AND (so.orderType = " + orderType + " )");
    par.append("&orderType=" + orderType);

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

    int puid = h.getInt("puid", -1);
    if (puid != -1) {
        sql.append(" AND invoiceStatus=" + puid);
        par.append("&invoiceStatus=" + puid);
    }


    String[] TAB = {"全部订单", "待付款", "已完成", "已取消"};
    String[] SQL = {"  ", " AND status=0", " AND status=4", " AND status=5"};

    int tab = h.getInt("tab", 0);
    par.append("&tab=" + tab);

    int pos = h.getInt("pos");
    par.append("&pos=");


%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>

    .con-left-list .tit-on<%= (orderType+1)%> {
        color: #044694;
    }

</style>
</head>
<body style='min-height:800px;'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
    <div class="con-left">
        <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
    </div>
    <div class="con-right">
        <form name="form1" action="?">
            <input type="hidden" name="id" value="<%=menu%>"/>
            <input type="hidden" name="tab" value="<%=tab%>"/>
            <input type="hidden" name="orderType" value="<%=orderType%>"/>

            <div class="con-right-box">
                <div class="right-line1">
                    <p>
                        <span class="right-box-tit">订单编号：</span>
                        <input type="text" class="right-box-inp" name="orderId" value="<%=MT.f(orderId)%>"/>
                        <span>订单时间：</span>
                        <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                        <span style="padding:0 8px">至</span>
                        <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    </p>
                    <p>
                        <span class="right-box-tit">开票状态：</span>
                        <select name='puid' style="width:342px;"  class="right-box-yy">
                            <option value=''>请选择</option>
                            <option <%= (puid==1?"selected='selected'":"") %> value=1>已开票</option>
                            <option <%= (puid==0?"selected='selected'":"") %> value=0>未开票</option>
                        </select>
                    </p>
                </div>
                <input type="submit" class="right-search" value="查询">
            </div>
        </form>
        <div class="right-list">
            <%
                out.print("<ul class='right-list-zt'>");
                for (int i = 0; i < TAB.length; i++) {
                    out.print("<li><a href='javascript:mt.tab(" + i + ")' class='" + (i == tab ? "current" : "") + "'>" + TAB[i] + "(" + ShopOrder.count(sql.toString() + SQL[i]) + ")</a></li>");
                }
                out.print("</ul>");
            %>
            <form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
                <input type="hidden" name="orderId"/>
                <input type="hidden" name="status"/>
                <input type="hidden" name="cancelReason"/>
                <input type="hidden" name="tab" value="<%=tab%>"/>
                <input type="hidden" name="nexturl"/>
                <input type="hidden" name="act"/>
                <table class="right-tab" border="1" cellspacing="0">
                    <tr>

                        <th>序号</th>
                        <th>订单编号</th>
                        <th><%
                            if (orderType == 1) {
                                out.print("购买方式");
                            } else {
                                out.print("设备名称");
                            }
                        %></th>
                        <th>开票状态</th>
                        <th>订单金额</th>
                        <th>下单时间</th>
                        <th>支付方式</th>
                        <%
                            if (orderType == 1) {
                        %>
                        <th>激活码/授权码</th>
                        <%
                            }
                        %>
                        <th>订单状态</th>
                        <th>操作</th>
                    </tr>
                    <%
                        sql.append(SQL[tab]);

                        int sum = ShopOrder.count(sql.toString());
                        if (sum < 1) {
                            out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
                        } else {
                            //sql.append(" order by createDate desc");
                            Iterator it = ShopOrder.find(sql.toString() + " order by createDate desc ", pos, 20).iterator();
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
                                if(status==0)
                                    statusContent = "待确认";
                                else if(status==1||status==2||status==-1||status==-2||status==-3||status==-4||status==-5)
                                    statusContent = "待发货";
                                else if(status==3)
                                    statusContent = "待收货";
                                else if(status==4)
                                    statusContent = "已完成";
                                else if(status==5)
                                    statusContent = "已取消";
                                else if(status==7)
                                    statusContent = "已退货";
                    %>
                    <tr>
                        <td><%=i%>
                        </td>
                        <td class="orderId"><%=t.getOrderId()%>
                        </td>
                        <%-- <td><%=uname%></td> --%>
                        <td>
                            <%

                                if (orderType == 1) {
                                    Iterator its = ShopOrderData.find("AND order_id="+DbAdapter.cite(t.getOrderId()),0,Integer.MAX_VALUE).iterator();
                                    for(int j=1;its.hasNext();j++) {
                                        ShopOrderData t1 = (ShopOrderData) its.next();
                                        int product_id = t1.getProductId();
                                        ShopProduct sp = ShopProduct.find(product_id);
                                        ShopCategory sc1 = ShopCategory.find(sp.category);
                                        ShopProductModel spm = ShopProductModel.find(sp.model_id);
                                        out.print(sc1.name[1]+spm.getModel());
                                    }
                                } else {
                                    if (odata != null) {
                                        ShopProduct sp1 = ShopProduct.find(odata.getProductId());
                                        out.print(sp1.name[1]);
                                    }
                                }
                            %>
                        </td>
                        <td>
                            <%if(t.getInvoiceStatus()==0){%>
                              未开票
                            <%}else {%>
                               已开票
                            <%}%>
                        </td>
                        <td><%=t.getAmount() %>
                        </td>
                        <td><%=MT.f(t.getCreateDate(), 1)%>
                        </td>
                        <td><%= ShopOrder.payTypeARR[t.getPayType()]%>
                        </td>
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
                                  <td><%=codes%></td>
                                <%} else {
                                    out.print("<td>暂无激活码</td>");
                                }
                            }
                        %>
                        <td>
                            <%= statusContent%>
                        </td>
                        <td>
                            <%

                                out.println("<a href=\"javascript:mt.act('data','"+MT.enc(t.getOrderId())+"');\">查看</a>");

                                if(status==0){
                                    out.println("<a href=\"javascript:mt.act('status','"+t.getOrderId()+"',5,'取消订单');\" >取消订单</a>");
                                }
                                if(!t.isPayment()){
                                    out.println("<a href=\"javascript:mt.act('payment','"+MT.enc(t.getOrderId())+"');\" >去支付</a>");
                                }
                                if(status==4||status==3){
                                    out.println("<a href=\"javascript:mt.act('refund','" + MT.enc(t.getOrderId()) + "',7,'申请退货');\">申请退货</a>");
                                }


                            %>
                        </td>
                    </tr>
                    <%
                            }
                            if (sum > 20)
                                out.print("<tr><td colspan='10' id='ggpage' align='right'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 20));
                        }
                    %>
                </table>

                <%
                    Profile pro = Profile.find(h.member);
                    if (pro.getMembertype() == 2) {
                        sql.append(" AND isLzCategory=1");
                        sql.append(" order by createDate desc");
                %>
                <div class='center text-c pd20'>
                    <button class="btn btn-primary btn-blue" type="button" onclick="dcorder()">导出</button>
                </div>
                <%} %>
            </form>
            <form action="/ShopOrders.do" name="form3" method="post" target="_ajax">
                <input name="act" value="exp_sh" type="hidden"/>
                <input name="exflag" value="0" type="hidden"/>
                <input type='hidden' name='category' value="14102669">
                <input type='hidden' name="sql" value="<%= sql.toString() %>"/>
            </form>
        </div>
    </div>
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
                layer.prompt({title: '取消订单原因', formType: 2}, function (pass, index) {
                    if (pass == "") {
                        layer.alert("“取消订单原因”不能为空！");
                    } else {
                        form2.cancelReason.value = t.value;
                        form2.submit();
                    }
                    layer.close(index);
                });

            } else {
                mt.show('你确定要"' + statusContent + '"吗？', 2, 'form2.submit()');
            }
        } else if (a == 'data') {
            //window.open("ShopOrderDatas.jsp?orderId="+orderId);
            location.href = "/jsp/yl/shopweb/ShopOrderDatasTps.jsp?orderId=" + orderId;

        } else if (a == 'payment') {
            //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
            window.open("/html/folder/22040062-1.htm?orderId=" + orderId);
        } else if (a == 'refund') {
            //window.open("ShopOrderDatasRefund.jsp?orderId="+orderId);
            location.href = "/jsp/yl/shopweb/ShopOrderDatasRefund.jsp?orderId=" + orderId;
        } else if (a == 'getfp') {
            //parent.location="/jsp/yl/shopweb/ShopGetFp.jsp?orderId="+orderId;
            parent.location = "/html/folder/14113269-1.htm?orderId=" + orderId;
        } else if (a == 'printOrder') {
            /* form2.action=("/jsp/yl/shop/ShopOrderDatasReceipt.jsp");
            form2.target='_self';form2.method='get';form2.submit(); */
            // parent.location="/jsp/yl/shop/ShopOrderDatasReceipt.jsp";
            location.href = "/jsp/yl/shop/ShopOrderDatasReceipt.jsp?orderId=" + orderId;
        } else if (a == 'edit_invoice') {
            layer.open({
                type: 2,
                id: 'add',
                title: '发票编辑',
                shadeClose: true,
                area: ['645px', '570px'],
                closeBtn: 1,
                content: '/jsp/yl/shopweb/Invoice_edit.jsp?orderid=' + orderId
            });

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
