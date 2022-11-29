<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shopnew.Invoice" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Set" %>
<%@ page import="tea.entity.yl.shopnew.InvoiceData" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();

    Integer puid = h.getInt("puid");        // 厂商id
    double money = h.getDouble("money");    // 发票总额
    int profile = h.getInt("profile");      // 服务商id
    String ids = h.get("ids");              // 发票id集合

    double total = h.getDouble("total");    // 订单服务费总额
    String oids = h.get("oids");            // 订单id集合


%>
<!DOCTYPE html>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src="/tea/yl/jquery-1.7.js"></script>
    <script src="/tea/yl/top.js"></script>

    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

</head>
<body>
<style>
    .mytab input[type=number]:focus{border:1px #ccc solid;}
    .mytab input::-webkit-outer-spin-button,
    .mytab input::-webkit-inner-spin-button {
        -webkit-appearance: none;
    }
    .mytab input[type="number"]{
        -moz-appearance: textfield;
    }
</style>
<h1></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form2" action="/ServiceInvoices.do" id="form2" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act" name="save"/>
    <input type="hidden" name="puid" value="<%=puid%>" />
    <input type="hidden" name="money" value="<%=money%>" />
    <input type="hidden" name="profile" value="<%=profile%>" />
    <input type="hidden" name="ids" value="<%=ids%>" />
    <input type="hidden" name="total" value="<%=total%>" />
    <input type="hidden" name="oids" value="<%=oids%>" />

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr><td colspan="20">服务费发票: <span style="float:right;" id="totalMoney">服务费发票总金额:￥ <em style="color:red;display:inline-block"><%=money%></em></span></td></tr>
            </thead>
            <tr>
                <th width='60'>序号</th>
                <th>发票号</th>
                <th>服务商</th>
                <th>金额</th>
            </tr>
            <tbody class='mytab'>
                <%
                    String[] split = ids.split(",");

                    for (int i = 0; i < split.length; i++) {

                        Integer sid = Integer.parseInt(split[i]);
                        ServiceInvoice si = ServiceInvoice.find(sid);
                        Profile p = Profile.find(si.getProfile());
                %>
                <tr>
                    <td><%=i+1 %></td>
                    <td width="120"><%=MT.f(si.getInvoiceCode()) %></td>
                    <td><%=MT.f(p.getMember()) %></td>
                    <td width="120"><%=MT.f(si.getMoney()) %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
            <tr><td colspan="20" style="color:red">请您确认订单发票和服务费发票金额,确认完成进行匹配!</td></tr>
        </table>
    </div>
    <div class='radiusBox' style="margin-top:10px;">
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr><td colspan="20">订单发票: <span style="float:right;" id="totalMoney">订单计提服务费总金额:￥ <em style="color:red;display:inline-block"><%=total%></em></span></td></tr>
            </thead>
            <tr>
                <th width='60'>序号</th>
                <th width="120">发票号</th>
                <th>服务商</th>
                <th>医院</th>
                <th>开票金额</th>
                <th width="120">计提服务费金额</th>
            </tr>
            <tbody class='mytab'>
                <%
                    String[] split1 = oids.split(",");
                    for (int i = 0; i < split1.length; i++) {
                        Integer id = Integer.parseInt(split1[i]);
                        Invoice io = Invoice.find(id);

                        int phpuid = InvoiceData.getPuid(io.getId());

                        //ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, io.getMember());
                        ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, io.getMember(),io.getHospitalid());

                        Profile p = Profile.find(io.getMember());
                        Map<String,Double> map = Invoice.getTaxAmount(puj.tax, io.getId(),0.9844,1.13);
                        Set<Map.Entry<String, Double>> entries = map.entrySet();
                        Double taxAmount = 0.0;
                        for (Map.Entry<String, Double> entry : entries) {
                            Double value = entry.getValue();
                            taxAmount+=value;
                        }
                        DecimalFormat df = new DecimalFormat("0.00"); // 取两位小数
                        double taxamountNew = Double.parseDouble(df.format(taxAmount));
                %>
                <tr>
                    <td><%=i+1 %></td>
                    <td><%=MT.f(io.getInvoiceno()) %></td>
                    <td><%=MT.f(p.getMember()) %></td>
                    <td><%=MT.f(io.getHospital()) %></td>
                    <td><%=MT.f(io.getAmount()) %></td>
                    <td><%=taxamountNew %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
            <tr><td colspan="20" style="color:red">请您确认订单发票和服务费发票金额,确认完成进行匹配!</td></tr>
        </table>
    </div>
    <div class='mt15'><a class="btn btn-primary" type="button" onclick="myact('save','')">确认匹配</a>&nbsp;&nbsp;<a id="closeIframe" class="btn btn-default" type="button" ng-click="">取消</a></div>

</form>

<script type="text/javascript" >

    form2.nexturl.value=location.pathname+location.search;
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    $('#closeIframe').click(function(){
        parent.layer.close(index);
    });
    function myact(a,id){
        if(a=="save"){
            fn.ajax("/ServiceFees.do?act=save",$("#form2").serialize(),function (data) {
                if(data.type==0){
                    mtDiag.show("操作执行成功!","msg");
                    parent.location.href='/jsp/yl/shop/ServiceInvoices.jsp?puid=<%=puid%>';
                    parent.layer.close(index);

                }else{
                    mtDiag.show("系统异常，请重试!","msg");
                }
            })
        }
    }



</script>
</body>
</html>
