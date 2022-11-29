<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    String orderId = h.get("orderId");
    //根据订单id查询订单信息
    ShopOrder so = ShopOrder.findByOrderId(orderId);

%><!DOCTYPE html>
<html>
<head>
    <link href="/jsp/yl/shop/print_css.css" rel="stylesheet" type="text/css"/>

    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/tea/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/tea/jquery.jqprint-0.3.js" type="text/javascript"></script>
</head>
<body>
<div class="pring_instruct" id="_printInfo" style="width: 1000px;margin: 0 auto;">
    <div class="tits">
        <div style="font-size: 24px;font-weight: bold;margin: 15px 0;">碘[<sup>125</sup>I]密封籽源批分装指令书</div>
        <div style="font-size: 20px;font-weight: bold;margin: 15px 0;text-align: right;">文件编号：16-RSMP-PM-004-02 版本号 01
        </div>
    </div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>指令单号：<%=MT.f(so.getOrderId()) %></td>
            <td>订单号：DZ-<%=MT.f(so.getOrderId()) %></td>
            <td>产品批号：JA-<%=MT.f(so.getOrderId()) %></td>
            <td>分装完成期限：<%=MT.f(new Date()) %></td>
        </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class='tabline'>
        <tr>
            <th>序号</th>
            <th>受订活度(mCi/粒)</th>
            <th>生产批号</th>
            <th>入库活度(mCi/粒)</th>
            <th>当前活度(mCi/粒)</th>
            <th>数量(粒)</th>
        </tr>
        <%
            List<StockOperation> solist = StockOperation.find(" AND oid = " + so.getId() + " AND type = 5 AND isRetreat = 0 ", 0, Integer.MAX_VALUE);
            if (solist.size() == 0) {
                //out.print("<tr><td colspan='6'>暂无记录</td></tr>");
            } else {
                int bugSum = 0;
                for (int i = 0; i < solist.size(); i++) {
                    StockOperation son = solist.get(i);
                    ProductStock pss = ProductStock.find(son.getPsid());

                    String batch = pss.getBatch()!=null ? pss.getBatch() : "";
                    float activity = pss.getActivity();
                    String activityStr = activity>0 ? activity+"" : "";
                    String formatStr = "";
                    if(pss.getActivity() > 0 && pss.getCreatetime() != null){
                        Date createtime = pss.getCreatetime();
                        Date date = new Date();
                        long time1 = createtime.getTime();
                        long time2 = date.getTime();
                        long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
                        //double pow = Math.pow(Math.E, -(0.693 / 59.6 * T)) * activity; // 获取当前活度
                        double powsum = Math.pow(0.9884, T);
                        BigDecimal b   =   new   BigDecimal(powsum);
                        double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
                        double pow  = (activity*f1);//公式修改
                        if(T==0){
                            pow = Double.valueOf(String.valueOf(activity));
                        }
                        DecimalFormat df = new DecimalFormat("0.000");// 保留小数点后三位
                        //df.setRoundingMode(RoundingMode.FLOOR);
                        df.setRoundingMode(RoundingMode.HALF_UP);
                        double format = Double.parseDouble(df.format(pow));
                        formatStr = format+"";
                    }
                    int bugCount = son.getAmount() + son.getReserve();
                    bugSum += bugCount;

                    out.print("<tr>");
                    out.print("<td>" + (i + 1) + "</td>");
                    out.print("<td>" + son.getActivity() + "</td>");
                    out.print("<td>" + batch + "</td>");
                    out.print("<td>" + activityStr + "</td>");
                    out.print("<td>" + formatStr + "</td>");
                    out.print("<td>" + bugCount + "</td>");
                    out.print("</tr>");
                }
                out.print("<tr>");
                out.print("<td colspan=\"5\">合计数量</td>");
                out.print("<td>" + bugSum + "</td>");
                out.print("</tr>");
            }
        %>
        <tr>
            <td colspan="6" style="font-weight: bold;">包装材料定额</td>
        </tr>
        <tr>
            <td colspan="6" style="padding: 0px;border: none;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class='tabline'>
                    <tr>
                        <td>玻璃瓶（只）</td>
                        </td>
                        <td>铅罐（只）</td>
                        <td>铁皮罐（只）</td>
                        <td>纸板箱（只）</td>
                        <td>标签（套）</td>
                        <td>说明书（张）</td>
                        <td>质检证书（张）</td>
                        <td>产品合格证（张）</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        </td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="6" style="padding: 0px;border: none;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class='tabline'>
                    <tr>
                        <td colspan="2" style="border: none;">编制人：李珍</td>
                        </td>
                        <td colspan="2" style="border: none;">仓库：张胤</td>
                        <td colspan="2" style="border: none;">QA审核：龙安健</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="6" style="border: none;">一式四联&nbsp;&nbsp;&nbsp;1.存根&nbsp;&nbsp;&nbsp;2.包装&nbsp;&nbsp;&nbsp;3.质检&nbsp;&nbsp;&nbsp;4.仓库</td>
        </tr>
    </table>
</div>
<div class='center mt15'>
    <button class="btn btn-primary" type="button" onclick="printit()">打印</button>
    <button class="btn btn-default" type="button" onclick="history.back();">返回</button>
</div>

<script type="text/javascript">

    <%-- window.onload=function(){
        //alert("初始化加载");
        mt.send("/WeiXins.do?act=lzcode&orderid=<%=so.getOrderId()%>",function(data){
            //alert(data);
            document.getElementById("order_code").src = data.trim();
        })
    }; --%>

    function printit() {
        $("#_printInfo").jqprint();
    }

</script>

<script>
    mt.fit();
</script>
</body>
</html>
