<%@page import="util.Config" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="tea.entity.Attch" %>
<%@page import="tea.entity.yl.shop.ImportExcel" %>
<%@page import="tea.entity.Http" %>
<%@page import="org.json.JSONObject" %>
<%@page import="org.json.JSONArray" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.File" %>
<%@page import="org.apache.poi.ss.usermodel.Row" %>
<%@page import="org.json.JSONObject" %>
<%@ page import="java.util.Map" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.yl.shop.ProductStock" %>
<%@ page import="tea.entity.yl.shop.JihuoCode" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        out.print("<script>parent.location='"+"/html/folder/19061184-1.htm?community=" + h.community+"';</script>");
        //response.sendRedirect();
        return;
    }

    int member = h.member;
    Profile profile = Profile.find(h.member);
    double perce = profile.membertype == 2 ? 0.03 : 0.01;



   /* int product=h.getInt("product");
//product=14102773;
    ShopProduct p=ShopProduct.find(product);
    if(!p.isExist)
    {
        response.sendError(404);

        return;
    }
    p.updateclick();

    ShopCategory sc = ShopCategory.find(p.category);*/

   String tpsbz = h.get("tpsbz");
   String sbbz = h.get("sbbz");

//购物车中商品数量
    int carSum = 0;
    String[] ps = h.getCook("cart", "|").split("[|]");

    int istps = 0;
    if (ps.length > 0) {
        for (int i = 1; i < ps.length; i++) {
            String[] arr = ps[i].split("&");

            int product_id = Integer.parseInt(arr[0]);
            ShopProduct sp1 = ShopProduct.find(product_id);
            ShopCategory sc1 = ShopCategory.find(sp1.category);

            if (sc1.path.indexOf(Config.getString("tps")) != -1) {//tps
                int checkFlag = Integer.parseInt(arr[2]);
                if (checkFlag != 0) {
                    istps = 1;
                }
                ;
            }

            int quantity = Integer.parseInt(arr[1]);//数量
            carSum += quantity;
        }
    }


    float activity = h.getFloat("activity");

    int isallocate = h.getInt("isallocate", -1);

    int hosid = h.getInt("hosid");
//收货人信息
    ShopOrderAddress soa = ShopOrderAddress.getObjByMember(member, hosid);

    if (hosid != 0 && soa.getHospitalId() != hosid) {
        soa = ShopOrderAddress.find(0);
    }
//发票信息
    ShopNvoice sn = ShopNvoice.getObjByMember(member);

    ShopQualification sqq = ShopQualification.findByMember(member);

    String token = System.currentTimeMillis() + new Random().nextInt() + "";
    request.getSession().setAttribute("token", token);

%><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/res/lizi/css/bootstrap.css">
    <link rel="stylesheet" href="/res/lizi/css/animate.css">
    <link rel="stylesheet" href="/res/lizi/css/style1.css">
    <link rel="stylesheet" href="/res/lizi/css/common.css">
    <%--<script src="/tea/mt.js" type="text/javascript"></script>
    <script src='/tea/city.js' type="text/javascript"></script>
    <script src='/tea/yl/common.js' type="text/javascript"></script>
    <script src="/res/lizi/js/jquery-1.11.3.min.js"></script>
    <script src='/tea/yl/common.js' type="text/javascript"></script>
    <script src="/res/lizi/js/bootstrap.min.js"></script>--%>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src='/tea/city.js' type="text/javascript"></script>
    <script src='/tea/jquery.js' type="text/javascript"></script>
    <script src='/tea/yl/common.js' type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <script src="/tea/jquery-1.11.1.min.js"></script>
    <script src="/tea/yl/top.js"></script>
    <script src="/tea/view.js" type="text/javascript"></script>
    <style>
        .table-js span {
            font-size: 14px;
            color: #000;
        }
        .table-js p {
            font-size: 14px;
            color: #707070;
        }
        #tab2 thead {
            padding: 10px 0px;
        }
        #tab2 td {
            padding: 8px 5px;
            color: #727272;
        }
        .mt_data {
            width: 200px;
            height: 212px;
        }
        .mt_data table {
            width: 95%;
        }
        .mt_data #_year {
            width: 36%;
        }
        .mt_data #_month {
            width: 27%;
        }
        .mt_data table tr {
            height: 25px;
        }
        #tab2 input {
            padding: 0 5px;
        }
        .xiangxi table input {
            padding: 0 5px;
        }
        .table img {
            width: auto;
            max-height: 72px;
        }
        .shopCar h1.table{
            border-bottom:1px solid #e3e3e3;
        }
    .table-js thead{background:none !important;}
    .table-js td{border:none!important;padding:0 !important;font-size:14px;}
    .table-js .td-name{
        display:inline-block;
        border:1px solid #b6b6b6;
        padding:6px 0;
        font-size:14px;
        color:#333;
        font-weight:normal;
        width:148px;
        background:#fff;
    }
    .table-js span.act-name{
        border:1px solid #fe943e;
        background:#fff url(/res/lizi/img/icon11.png) 129px 17px no-repeat;
    }
    .table-js  .gcs-radio{
        -webkit-appearance: none;
        border:1px solid #fff;
        background:#fff;
    }
    .table-js td label{
        margin:0;
        height:36px;
        float:left;
    }
    .table-js thead tr{
        height:45px;
    }
    .table-js thead tr:hover{
        background:#f3f6fa;
    }
    .sqdz{
        color:#333;
        background: url(/res/lizi/img/icon112.png) 68px 15px no-repeat;
        width: 80px;
        display: inline-block;
        cursor: pointer;
    }
    .zkdz{
        color:#333;
        background: url(/res/lizi/img/icon113.png) 68px 15px no-repeat;
        width: 80px;
        display: inline-block;
        cursor: pointer;
    }
    .sfkp{
        font-size:14px;
        color:#333;
        margin-top:15px;
    }
    .sfkp label{
        margin:0;
        margin-right:15px;
    }
    .sfkp label input{
        margin-right:5px;
        float:left;
    }
    .btn-lz {
        color: #fff!important;
        background: #044694!important;
        border: none!important;
        font-size: 16px!important;
        padding: 8px 30px!important;
    }
    .table-js2{
    }
    .shopCar .table-js2 .td1{
        text-align:right;
    }
    .shopCar .table-js2 .td2{
        text-align:left;
        width:40%;
    }
    .table-js2 input,.table-js2 select{
        border: 1px solid #dcdcdc;
        height: 33px;
        padding: 0px 5px;
    }
    .table-js2 input{
        width:75%;
    }
    .table-js2 select{
        width:24.6%;
    }
    .table-js2 tr{
        height:45px;
    }
    .f-tables2{
        padding:20px 0;
        background:#f9f9f9;
        border:1px solid #e5e5e5;
        margin-top:15px;
    }
    .table tr td{
        font-size:14px;
    }
    .text-l span{margin-right:20px;}
    </style>
</head>
<body>
<div class="container pd0 shopCar" style="width:100%;">
    <div class="row clearfix">
        <!-- 收货人信息 -->
        <div class="col-md-12 column">
            <h1 class="table " data-animate-effect="fadeInLeft" style=''>收货人信息
                <a href="javascript:;" onclick="editAddress('0',this)" style="color:#044694;float:right;border:1px solid #044694;display:inline-block;    padding: 3px 10px; font-size: 14px; line-height: 25px; margin-top: 8px;">新增收货地址</a>

            </h1>


            <form name="form1" action="/ShopOrderForms.do" method="post" onsubmit="return setCityName(this)"
                  target="_ajax">
                <input type="hidden" name="id" value="<%=soa.getId() %>"/>
                <input type="hidden" name="nexturl" value="/jsp/yl/shopweb/ShopOrderFormUnit.jsp"/>
                <input type="hidden" name="act" value="orderAddress"/>
                <input type="hidden" name="hospital" value="<%=hosid %>"/>
                <input type="hidden" name="myname" value=""/>
                <input type="hidden" name="mymobile" value=""/>
                <input type="hidden" name="mycity" value=""/>
                <input type="hidden" name="myaddress" value=""/>
                <input type="hidden" name="myid" value=""/>
                <input type="hidden" name="myismoren" value=""/>
                <div class='f-tables' style='border:none;padding-bottom:0'>
                    <table id="tab1" style="display: " class="table table-js  mt15" data-animate-effect="fadeInLeft">
                        <thead id="tab3">

                        <%
                            int member1 = h.member;
                            List<Consignee> list = Consignee.find("AND member=" + member1 + "order by ismoren desc", 0, Integer.MAX_VALUE);
                            int list_size=list.size();
                            if (list.size() == 0) {%>
                        <tr id="number_"><td><input type="hidden" name="address_ok" id="address_ok" value="">无记录</td></tr>
                        <%
                        } else {
                            int i=0;
                            for (Consignee c : list) {

                        %>
                        <tr class="text" data-animate-effect="fadeInLeft"  <%--onmouseover="xianshi(this)"--%>>
                                <td width='200'>
                                    <label for='<%=c.getId()%>'>
                                        <span  class='td-name <%= (c.getIsmoren()==1?"act-name":i==0?"act-name":"")%>'><%=MT.f(c.getName())%></span>
                                        <input onchange='radioclick()' <%= (c.getIsmoren()==1?"checked='checked'":i==0?"checked='checked'":"")%> type="radio" name="address_ok" class="gcs-radio" id="<%=c.getId()%>" value="<%=c.getId()%>"/>
                                    </label>
                                </td>
                                <td width="110">
                                    <span><%=MT.f(c.getName())%></span>
                                </td>
                            <td class="text-l" >
                                <span style="margin-bottom:0px;">
                                    <%
                                        String a = c.getCity() + "";
                                        String b = "";
                                        try{
                                            b = a.substring(0, 2);
                                        }catch (Throwable e){
                                            b = "0";
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
                                    </script>
                                    <%=MT.f(c.getAddress())%>
                                </span>
                                <span style="margin-right:20px;"><%=MT.f(c.getMobile())%></span>

                                <span>邮箱：<%=MT.f(c.getMail())%></span>

                            </td>
                            <td class="text-c" style="display:none">
                                <a href="javascript:;" onclick="morenAddress('<%=MT.f(c.getId())%>',this)"
                                   style="color:#044694;">设为默认</a>
                                <a href="javascript:;" onclick="editAddress('<%=MT.f(c.getId())%>',this)"
                                   style="color:#044694;">修改地址</a>
                                <a href="javascript:;" onclick="deleteAddress('<%=MT.f(c.getId())%>',this)"
                                   style="color:#044694;">删除地址</a>
                            </td>
                        </tr>

                        <%
                              i++;  }
                            }
                        %>

                        </thead>
                    </table>

                    <p class='dz-p' style='margin-bottom:10px;border-bottom:1px solid #e3e3e3;height:40px;line-height:40px;margin-top:10px;'>
                        <span class='zkdz'>展开地址</span>
                    </p>
                </div>
            <script>
                $(function(){
                    $('.act-name').parents('tr').siblings('tr').hide();
                })
                $('.dz-p span').click(function(){
                    var cla=$('.dz-p span').attr('class');
                    if(cla=='sqdz'){
                        $('.act-name').parents('tr').siblings('tr').hide();
                        $('.sqdz').html('展开地址').removeClass('sqdz').addClass('zkdz');
                    }else if(cla=='zkdz'){
                        $('.act-name').parents('tr').siblings('tr').show();
                        $('.zkdz').html('收起地址').removeClass('zkdz').addClass('sqdz');
                    }
                })
            </script>
            </form>

            <form id="form5" name="form5" action="/ShopOrders.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
                <div class='xiangxi'>
                        <%


                        //if(Config.getInt("xinke")==puid){

                        //}else{
                            if(profile.membertype==2){//服务商
                                //ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid, member);
                                //ShopHospital sh1 = ShopHospital.findPuid(puid,hosid);
                                //puid = sh1.getInvoicePuid();
                            }
                       // }
                    %>

                    <h1 style='border:none;' class="table" data-animate-effect="fadeInLeft">商品清单</h1>
                    <table class="table table-hover " data-animate-effect="fadeInLeft">
                        <thead>
                        <tr class="" data-animate-effect="fadeInLeft">
                            <th style="width:95px;">序号</th>
                            <th>商品图片</th>
                            <th>商品名称</th>
                            <%
                                if(istps==1){
                            %>
                            <th style="width:95px;">软件大小</th>
                            <th style="width:95px;">软件版本</th>
                            <th>购买方式</th>
                            <%
                                }
                            %>
                            <th style="width:95px;">商品单价</th>
                            <th>商品数量</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            //String[] ps=h.getCook("cart","|").split("[|]");

                            int checkLength = 0;
                            boolean isLzCategory = false;
                            boolean includeLzCar = false;
                            int num=0;//数量
                            float totalprice = 0.0f;
                            //isLzCategory = ps.length==2;
                            int count = 0;
                            for(int i=1;i<ps.length;i++) {
                                String[] arr = ps[i].split("&");
                                int checkFlag = Integer.parseInt(arr[2]);
                                if (checkFlag == 0) continue;
                                checkLength++;
                                //判断product_id是否商品的id，如果不是则为套装id
                                int product_id = Integer.parseInt(arr[0]);
                                int quantity = Integer.parseInt(arr[1]);//数量
                                num = quantity;
                                if(istps==1){//tps只能1
                                    quantity = 1;
                                }

                                ShopProduct p = ShopProduct.find(product_id);
                                out.print("<tr>");
                                count++;
                                out.print("<td><input name='product_id' type='hidden' value='"+product_id+"' />"+count+"</td>");
                                out.print("<td><input name='quantity' type='hidden' value='"+quantity+"' />"+p.getAnchor('t')+"</td>");
                                out.print("<td>"+p.name[1]+"</td>");
                                if(istps==1){
                                    out.print("<td>"+p.size+"</td>");
                                    out.print("<td>"+p.color+"</td>");
                                    ShopProduct sp = ShopProduct.find(product_id);
                                    ShopCategory sc1 = ShopCategory.find(sp.category);
                                    ShopProductModel spm = ShopProductModel.find(sp.model_id);
                                    out.print("<td>"+sc1.name[1]+spm.getModel()+"</td>");
                                }
                                out.print("<td>"+p.price+"</td>");
                                out.print("<td>"+quantity+"</td>");
                                out.print("</tr>");
                                totalprice+= p.price*quantity;
                            }
                        %>


                        <tr class="last " data-animate-effect="fadeInLeft">
                            <td>备注</td>
                            <td colspan="<%= (istps==1?"6":"3")%>"><input style='border:1px solid #d00606' type="text" name="userRemarks" value="<%= MT.f((istps==1?tpsbz:sbbz))%>" class="form-control w100" /> </td>
                            <td colspan="">应付总额: <b>￥<span class="total"><%= totalprice%></span></b></td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="row clearfix">
                        <!-- 收货人信息 -->
                        <div class="col-md-12 column">
                            <h1 style='margin-top:10px;' class="table " data-animate-effect="fadeInLeft">发票信息</h1>

                            <div class='sfkp'>是否开发票：
                                <label>
                                    <input type="radio" value="1" onclick="selinv(1)" name="isinvoice" />是
                                </label>
                                <label>
                                    <input value="0" onclick="selinv(0)" type="radio" name="isinvoice"  />否
                                </label>
                            </div>
                            <div class='f-tables2' style=''>
                                <table id="tabfp"  class="table table-js  table-js2" data-animate-effect="fadeInLeft">
                                    <tr>
                                        <td class='td1'>名称：</td>
                                        <td class='td2'><input name="invoiceName" /></td>
                                        <td class='td1'>税号：</td>
                                        <td class='td2'><input name="invoiceDutyParagraph" /></td>
                                    </tr>
                                    <tr>
                                        <td class='td1'>地址：</td>
                                        <td class='td2'><script>mt.city("city0","city1","invoiceProvinces",'');</script></td>
                                        <td class='td1'>开户行：</td>
                                        <td class='td2'><input name="invoiceOpeningBank" /></td>
                                    </tr>
                                    <tr>
                                        <td class='td1'>详细地址：</td>
                                        <td class='td2'><input name="invoiceAddress" /></td>
                                        <td class='td1'>费用名称：</td>
                                        <td class='td2'><input name="invoiceCostName" /></td>
                                    </tr>
                                    <tr>
                                        <td class='td1'>电话：</td>
                                        <td class='td2'><input name="invoiceMobile" /></td>

                                    </tr>
                                    <tr>
                                        <td class='td1'>账号：</td>
                                        <td class='td2'><input name="invoiceAccountNumber" /></td>

                                    </tr>
                                </table>
                            </div>

                            <div class="text-r " style="margin:30px 0px;background:#f3f6fa;padding:20px 15px;border-top:1px solid #d7d7d7;" data-animate-effect="fadeInLeft">
                                <b style='font-size:16px;margin-right:20px;font-weight:normal;'>应付总额：<span class="total" style='color:#df6c0a;font-weight:bold;'>￥<%= totalprice%></span></b>
                                <button type="button" onclick="return fnsub(this.form)"  class="btn btn-default btn-lz butsub">提交订单</button>
                            </div>
                        </div>
                        <%-- <input type="hidden" name="puid" value="<%=puid %>" /> --%>
                        <input type="hidden" name="hosid" value="<%=hosid %>" />
                        <%-- <input type="hidden" name="quantity" value="<%=num %>"/> --%>
                        <input type="hidden" name="iswx" value="1" />
                        <input type="hidden" name="cityname" />

                        <input type="hidden" name="allocate" />
                        <input type="hidden" name="allocatetype" />
                        <input type="hidden" name="amount" value="<%= totalprice%>" />
                        <input type="hidden" name="orderType" value="<%= (istps==1?"1":"2")%>" />
                        <input type="hidden" name="address_ok" />


                        <input type="hidden" name="act" value="submit" />
                        <input type="hidden" name="nexturl" value="/html/folder/14110391-1.htm" />

                        <input type="hidden"  name="payType" value="" />
                        <input type="hidden"  name="isLzCategory" value="" />
                        <input type="hidden" name="token" value="<%=token %>" />
            </form>
        </div>
    </div>


    <%--<script src="/res/lizi/js/jquery.waypoints.min.js"></script>--%>
    <%--<script src="/res/lizi/js/main.js"></script>--%>
    <script>

        <%
        out.print("function delcar(){");
        for(int i=1;i<ps.length;i++) {
            String[] arr = ps[i].split("&");
            int checkFlag = Integer.parseInt(arr[2]);
            if (checkFlag == 0) continue;
            out.print("car.delsubmit('','"+ps[i]+"','','');");
        }
        out.print("}");
        %>

        function myact(a, id) {
            if (a == "edit") {
                $("#tab1").hide();
                $("#tab2").show();
            }
        }
    </script>
    <script type="text/javascript">
        form1.nexturl.value = location.pathname + location.search;

        function fncheck() {
            //alert("aaaa");
            mt.send("/ShopOrders.do?act=checkprice", function (d) {
                //alert(d);
                if (d != '0') {
                    mt.show(d + '，此商品管理员没有设置开票价格，请与管理员联系，设置开票价格后才可提交订单！');
                    return false;
                } else {
                    return true;
                }
            });


        }

    function radioclick(){
    $(".td-name").removeClass("act-name");
    var obj = $('input[name="address_ok"]:checked');
    $(obj).prev().addClass("act-name");
        //console.log(val);
    }


        var trobj;
        function editAddress(obj,thisobj) {
            trobj = thisobj;
            layer.open({
                shade: 0,
                type: 2,
                id: 'update',
                title: '新增收货地址',
                shadeClose: true,
                area: ['645px', '570px'],
                closeBtn: 1,
                content: '/jsp/yl/shopweb/Address_edit.jsp?jiesuan=1&id=' + obj

            });

        }
        function deleteAddress(obj,thisobj) {
            fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=dele_address",{id:obj},function(data){
                if(data.type>0){
                    mtDiag.close();
                    mtDiag.show(data.mes);
                    return;
                }else{
                    mtDiag.show('操作成功！',"alert",null,function(index){
                        $(thisobj).parent().parent().remove();
                        mtDiag.close();
                    });
                }
            });


        }

        function morenAddress(obj,thisobj) {
            fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=moren_address",{id:obj},function(data){
                if(data.type>0){
                    mtDiag.close();
                    mtDiag.show(data.mes);
                    return;
                }else{
                    mtDiag.show('操作成功！',"alert",null,function(index){
                        mtDiag.close();
                        console.log($(thisobj).parent().html());
                    });
                }
            });
        }



        function readd(data) {
            var a = getProvince(data.pro);
            var b = getSrcity2(data.pro, data.src);

            var xiugai = data.isxiugai;
            var number = data.number1;
            var tamp1 = '<tr class=\"text\" data-animate-effect=\"fadeInLeft\">' +
                '<td width=\"200\">'+
                '<label for=\"'+data.id+'\">'+
                '<span  class=\"td-name \">'+data.name+'</span>'+
                '<input onchange=\"radioclick()\" type=\"radio\" name=\"address_ok\" class=\"gcs-radio\" id=\"'+data.id+'\" value=\"'+data.id+'\"/>'+
                '</label>'+
                '</td>'+
                '<td width=\"110\">'+
                '<span>'+data.name+'</span>'+
                '</td>'+
                '<td class=\"text-l\" >'+
                '<span style=\"margin-bottom:0px;\">'+
                a+b+data.address+
                '</span>'+
                '<span style=\"margin-right:20px;\">'+data.mobile+'</span>'+

                '<span>邮箱：'+data.mail+'</span>'+

                '</td>'+
                '<td class=\"text-c\" style=\"display:none\">'+
                '<a href=\"javascript:;\" onclick=\"morenAddress(' + data.id + ',this)\" style=\"color:#044694;\">设为默认</a>' +
                '<a href=\"javascript:;\" onclick=\"editAddress(' + data.id + ',this)\" style=\"color:#044694;\">修改地址</a>' +
                '<a href=\"javascript:;\" onclick=\"deleteAddress(' + data.id + ',this)\" style=\"color:#044694;\">删除地址</a>' +
                '</td>'+
                '</tr>';
            var tamp2=
                '<td width=\"200\">'+
                '<label for=\"'+data.id+'\">'+
                '<span  class=\"td-name \">'+data.name+'</span>'+
                '<input onchange=\"radioclick()\" type=\"radio\" name=\"address_ok\" class=\"gcs-radio\" id=\"'+data.id+'\" value=\"'+data.id+'\"/>'+
                '</label>'+
                '</td>'+
                '<td width=\"110\">'+
                '<span>'+data.name+'</span>'+
                '</td>'+
                '<td class=\"text-l\" >'+
                '<span style=\"margin-bottom:0px;\">'+
                a+b+data.address+
                '</span>'+
    '<span style=\"margin-right:20px;\">'+data.mobile+'</span>'+

    '<span>邮箱：'+data.mail+'</span>'+

    '</td>'+
                '<td class=\"text-c\" style=\"display:none\">'+
                '<a href=\"javascript:;\" onclick=\"morenAddress(' + data.id + ',this)\" style=\"color:#044694;\">设为默认</a>' +
                '<a href=\"javascript:;\" onclick=\"editAddress(' + data.id + ',this)\" style=\"color:#044694;\">修改地址</a>' +
                '<a href=\"javascript:;\" onclick=\"deleteAddress(' + data.id + ',this)\" style=\"color:#044694;\">删除地址</a>' +
                '</td>';
            if(xiugai.indexOf("0")==-1){
                $(trobj).parent().parent().html(tamp2)
                /*init();*/
            }else {
                if(number.indexOf("0")){
                    $("#number_").remove();
                }
                $("#tab3").append(tamp1);
                $(".text").hover(function (){
                    $(this).children(".text-c").show();
                },function (){
                    $(this).children(".text-c").hide();
                })
            }


        }

        //选择发票类型
        function selNvoice(v) {
            if (v == 1) {
                document.getElementById('nvoice_t').style.display = 'none';
                form3.type.value = '1';
            } else {
                document.getElementById('nvoice_t').style.display = '';
                form3.type.value = '2';
            }
        }

        mt.fit();

        //修改发货人信息
        function setAddress() {
            /*document.getElementById('nvoice_show').style.display = 'none';
            document.getElementById('nvoice_edit').style.display = '';
            document.getElementById('address_up').style.display = '';*/
            myact('edit', '0');
            var hospital = form1.hospital_id.value;
            var consignees = form1.consignees.value;
            //查找收货人
            mt.send("/Members.do?act=getsign&hospital=" + hospital + "&consignees=" + consignees, function (d) {
                var sel = document.getElementById("_consignees");
                sel.innerHTML = d;
            });

            mt.fit();
        }

        /* mt.ajax=function(act){
             if('setAddress'==act){
                 var id = form1.id.value;
                 var consignees = form1.consignees.value;
                 var address = form1.address.value;
                 var mobile = form1.mobile.value;
                 var telphone = form1.telphone.value;
                 mt.send("/ShopOrderForms.do?act=orderAddress&id="+id+"&consignees="+encodeURIComponent(consignees)+"&address="+encodeURIComponent(address)+"&mobile="+mobile+"&telphone="+telphone,function(d)
                 {
                     alert(123);
                 });
             }
         };*/

        function keyupActivity(obj) {
            obj.value = obj.value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
            obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是
            obj.value = obj.value.replace(/^[2-9]/g, ""); //验证第一个字符是数字而不是
            obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的
            obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
            obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
            findProductStockCount();
        }

        function blurActivity(obj, activityMin, activityMax) {
            if (obj.value != '' && (obj.value < activityMin || obj.value > activityMax)) {
                mt.show("活度超出范围 " + activityMin + "-" + activityMax + "！");
                obj.value = activityMin;
                findProductStockCount();
            }
        }


        mt.submit = function (f) {

                <%-- if(<%=soa.getId()<1%>){
                    mt.show("对不起！收货人信息没有填写，不能提交订单！");
                    return;
                }else if(<%=ps.length<1%>){
                    mt.show("对不起！商品清单内没有商品，不能提交订单！");
                    return;
                }else --%>{
                //includeLzCar?(isLzCategory
                var payType = 1;
                var temp = document.getElementsByName("payType");
                for (var i = 0; i < temp.length; i++) {
                    if (temp[i].checked) {
                        payType = temp[i].value;
                    }
                }
                f.payType.value = payType;

                var pastdue = f.pastdue;
                if (pastdue && pastdue.value == '0') {
                    mt.show('当前医院资质已到期，不能提交订单！');
                    return;
                }
                var activity = f.activity;
                if (activity && activity.value == '') {
                    mt.show('抱歉，请先填写粒子活度！！！');
                    return;
                }
                var calidate = f.calidate;
                if (calidate && calidate.value == '') {
                    mt.show('抱歉，请先填写粒子的校准时间！！！');
                    return;
                }

                f.submit();


            }

        };

        function fnsub(f) {
            var addressCheck=$('input:radio[name="address_ok"]').is(":checked");
            if(addressCheck==false){
                mt.show('请选择收货地址！');
                return;
            }
            var fpCheck=$('input:radio[name="isinvoice"]').is(":checked");
            if(fpCheck==false){
                mt.show('请选择是否开发票！');
                return;
            }
            form5.address_ok.value = form1.address_ok.value;

            fn.ajax("/ShopOrders.do?act=submitajaxtps", $("#form5").serialize(), function (data) {
                if (data.type > 0) {
                    if (data.type == 1) {
                        mt.show('对不起！您还未登录，登陆后才可提交订单！');
                        return;
                    }
                    if (data.type == 3) {
                        mt.show(data.mes);
                        return;
                    }
                } else {
                    //host 14110391
                    //test 19070110

                    ///html/folder/19090023-1.htm

                    delcar();
                    location = '/html/folder/19092399-1.htm?orderId=' + data.orderId;
                }
            });


        }

        function allocatefun() {
            mt.show("库存不足，是否同意调配？", 2);
            mt.ok = function () {
                form5.allocate.value = 1;
                form5.allocatetype.value = 0;
                $(".butsub").click();
            }
            mt.cancel = function () {
                /*form5.allocate.value = 1;
                form5.allocatetype.value = 1;
                $(".butsub").click();*/
            }
            //fnsub();

        }



        function setCityName(obj) {
            if (mt.check(obj)) {
                var cityid = document.getElementsByName("city2")[0].value;
                mycity(cityid);
            } else {
                return false;
            }
        };

        function showfp() {
            document.getElementById("stab1").style.display = 'none';
            document.getElementById("stab2").style.display = 'none';
            document.getElementById("fap").style.display = '';
        }

        function showRecipient() {
            mt.show("/jsp/yl/shopweb/RecipientSearch.jsp", 2, "查询收货人", 500, 450);
        }

        mt.receive = function (id, n, m) {
            form1.sor_id.value = id;
            form1.consignees.value = n;
            form1.mobile.value = m;
        }

        //是否为新增收货人
        function onNewAdd(obj) {
            if (obj.checked == true) {
                form1.sor_id.value = '0';
            } else {
                form1.sor_id.value = '<%=soa.getSor_id()%>';
            }
        }

        mt.fit();

        jQuery(document).ready(function () {


            jQuery(".hospital_id").change();
        });

        /*商品数量+1*/
        function numAdd() {
            var quantity = document.getElementById("quantity").value;
            var num_add = parseInt(quantity) + 1;
            if (quantity == "") {
                num_add = 1;
            }
            if (num_add >= 2000) {
                document.getElementById("quantity").value = num_add - 1;
                mt.show("商品数量不能大于2000");
            } else {
                document.getElementById("quantity").value = num_add;
                calculatetotal();
            }
        }

        /*商品数量-1*/
        function numDec() {
            var quantity = document.getElementById("quantity").value;
            var num_dec = parseInt(quantity) - 1;
            if (num_dec > 0) {
                document.getElementById("quantity").value = num_dec;
                calculatetotal();
            }
        }

        /*商品数量框输入*/
        function keyup() {
            var quantity = document.getElementById("quantity").value;
            var re = /^[1-9]+[0-9]*]*$/;
            if (!re.test(quantity) || parseInt(quantity) != quantity || parseInt(quantity) < 1) {
                document.getElementById("quantity").value = 1;
                calculatetotal();
                return;
            }
            if (quantity >= 2000) {
                document.getElementById("quantity").value = quantity.substring(0, quantity.length - 1);
                mt.show("商品数量不能大于2000");
            }
            calculatetotal();
        }

        function calculatetotal() {
            //var total = 2.368;
            /*var orderprice = form5.orderprice.value;
            var quantity = form5.quantity.value;
            var total = orderprice * quantity;
            $(".total").html(total);
            form5.amount.value = total;*/
        }

        calculatetotal();

        var perce = '<%= perce %>';
        var junan = '0';

        function findProductStockCount() {
            if (junan == 1) {
                mt.send("/ProductStocks.do?act=findProductStockCount&activity=" + form5.activity.value + "&perce=" + perce, function (data) {
                    data = eval('(' + data + ')');
                    if (data.type > 0) {
                        if (data.type == 1) {
                            //location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
                            return;
                        }
                        mtDiag.close();
                        mtDiag.show(data.mes);
                        return;
                    } else {
                        //form1.productstockcount.value = data.count;
                        jQuery(".productstockcount").html(data.count);
                        //console.log(data);
                    }
                });
            }
        }

        function selinv(num){
            console.log(num);
            if(num==0){
                $(".f-tables2").hide();
            }else{
                $(".f-tables2").show();
            }
        }
        selinv(0);

        $(".text").hover(function (){
            $(this).children(".text-c").show();
        },function (){
            $(this).children(".text-c").hide();
        })

        //findProductStockCount();
    </script>
</body>
</html>