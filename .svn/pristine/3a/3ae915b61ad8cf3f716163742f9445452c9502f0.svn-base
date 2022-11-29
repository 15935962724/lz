<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
response.sendRedirect("/html/folder/14102033-1.htm?community="+h.community);
return;
}

int member = h.member;
Profile profile = Profile.find(h.member);
double perce = profile.membertype==2?0.03:0.01;

int product_id = h.getInt("product");
int hosid = h.getInt("hosid");
//收货人信息
ShopOrderAddress soa = new ShopOrderAddress(0);

    int sumNumber = TpsOrder.sumNumber(member, "2021-01-01 00:00:00");

//判断收货人信息是否是订单的   必须是订单的
//查询医院订单的签收人
    List<Profile> pList = Profile.getProfileByHospitalId(hosid, 0);
    Filex.logs("orderqsr.txt","pList="+pList.size());
    if(pList.size()>0){
        for (int i = 0; i < pList.size(); i++) {
            Profile profile1 = pList.get(i);
            int profile2 = profile1.getProfile();
            //根据签收人id和医院id 查询出地址
            Filex.logs("orderqsr.txt","profile2="+profile2);
            ArrayList<ShopOrderAddress> shopOrderAddresses = ShopOrderAddress.find(" AND consignees_id=" + profile2+" AND hospitalId="+hosid, 0, Integer.MAX_VALUE);
            //没有让客户新增  有直接取
            if(shopOrderAddresses.size()>0){
                soa=shopOrderAddresses.get(0);
                break;
            }
        }
    }

//发票信息
ShopNvoice sn = ShopNvoice.getObjByMember(member);

ShopQualification sqq = ShopQualification.findByMember(member);

String token = System.currentTimeMillis()+new Random().nextInt()+"";
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
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src='/tea/city.js' type="text/javascript"></script>
    <script src='/tea/jquery.js' type="text/javascript"></script>
    <script src='/tea/yl/common.js' type="text/javascript"></script>
    <style>
        .table-js span{
            font-size:16px;
            color:#000;
        }
        .table-js p{
            font-size:14px;
            color:#707070;
        }
        #tab2 thead{
            padding:10px 0px;
        }
        #tab2 td{
            padding:8px 5px;
            color:#727272;
        }
        .mt_data{
            width: 200px;
            height:212px;
        }
        .mt_data table{
            width:95%;
        }
        .mt_data #_year{
            width:36%;
        }
        .mt_data #_month{
            width:27%;
        }
        .mt_data table tr{
            height:25px;
        }
        #tab2 input{
            padding:0 5px;
        }
        .xiangxi table input{
            padding:0 5px;
        }
    </style>
</head>
<body>
<div class="container pd0 shopCar" style="width:100%;min-height:765px;">
    <div class="row clearfix">
        <!-- 收货人信息 -->
        <div class="col-md-12 column">
            <h1 class="table " data-animate-effect="fadeInLeft">当前服务商积分：<%=sumNumber%></h1>
            <h1 class="table " data-animate-effect="fadeInLeft">收货人信息</h1>
            <form name="form1" action="/ShopOrderForms.do" method="post" onsubmit="return setCityName(this)">
                <input type="hidden" name="id" value="<%=soa.getId() %>" />
                <input type="hidden" name="nexturl" value="/jsp/yl/shopweb/ShopOrderFormUnitTpsNew.jsp"/>
                <input type="hidden" name="act" value="orderAddress" />
                <input type="hidden" name="hospital" value="<%=hosid %>" />
                <table id="tab1"  style="display: <%=soa.getMember()>0?"":"none" %>" class="table table-js  mt15" data-animate-effect="fadeInLeft">
                <thead>
                <%
                    System.out.println("soa.getMember="+soa.getMember());
                    ArrayList arrayList = Profile.find1(" AND profile=" + soa.getConsignees_id(), 0, Integer.MAX_VALUE);
                    String email = "";
                    if(arrayList.size()>0){
                        Profile o =(Profile)arrayList.get(0);
                        email = MT.f(o.getEmail());
                    }
                %>
                    <tr class="" data-animate-effect="fadeInLeft">
                        <td width="110"><b><%=soa.getConsignees() %></b></td>
                        <td class="text-l" style="line-height:240%;">
                        <span style="margin-right:20px;"><%=soa.getMobile() %></span><span><%=email%></span>
                        </td>
                        <td class="text-r" style="vertical-align: top">
                        <a href="javascript:;" onclick="setAddress()"  style="color:#044694;">修改收货人</a>
                        </td>
                    </tr>
                </thead>
            </table>
            <table id="tab2" class="table table-js  mt15" style="display: <%=soa.getMember()>0?"none":"" %>" data-animate-effect="fadeInLeft" style="display: none">
                <thead>


                <tr class="" data-animate-effect="fadeInLeft"><td colspan="4" style="padding:0px;">&nbsp;</td> </tr>
                   <%-- <tr class=" first" data-animate-effect="fadeInLeft">
                        <td class="text-r" width="130">医院名称:</td>
                        <td class="text-l" width="230">原子高科有限公司</td>
                        <td class="text-r" width="50">科室:</td>
                        <td class="text-l">无</td>
                    </tr>--%>
                <tr class=" first" data-animate-effect="fadeInLeft">
                <%
                    //if(profile.membertype == 2)
                    {
                        out.print("<td class=\"text-r\" width=\"130\">医院名称：</td><td class=\"text-l\" width=\"230\">");
                        String [] sarr = profile.hospitals.split("\\|");
                        if(hosid!=0){
                            sarr = new String[]{"",hosid+""};
                        }
                        out.print("<select class='hospital_id' name='hospital_id' alt='医院名称' onchange=selectHosp(this.options[this.options.selectedIndex]);>");
                        out.print("<option value=''>--请选择--</option>");
                        for(int i=1;i<sarr.length;i++){
                            ShopHospital s1 = ShopHospital.find(Integer.parseInt(sarr[i]));
                            if(hosid == s1.getId())
                                out.print("<option selected value='"+s1.getId()+"'>"+s1.getName()+"</option>");
                            else
                                out.print("<option value='"+s1.getId()+"'>"+s1.getName()+"</option>");
                        }
                        out.print("</select></td>");
                        out.print("<td class=\"text-r\" width=\"50\">科室:</td>");
                        out.print("<td class=\"text-l\"><select name=\"department\"><option value=\"无\">--请选择--</option>");
                        for(int j=1;j<ShopQualification.DEPARTMENT_ARR.length;j++){
                            if(MT.f(soa.getDepartment()).equals(ShopQualification.DEPARTMENT_ARR[j]))
                                out.print("<option selected value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
                            else
                                out.print("<option value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
                        }
                        out.print("</select>");
                        out.print("</td>");
                    }

                %>
                </tr>
                <script type="text/javascript">
                    //查找收货人
                    mt.send("/Members.do?act=getsign&hospital=<%=hosid%>",function(d)
                    {
                        var sel = document.getElementById("_consignees");
                        sel.innerHTML = d;
                    });
                </script>
                    <tr class=" first" data-animate-effect="fadeInLeft">
                        <td class="text-r">收货人:</td>
                        <td colspan="3" class="text-l">
                            <input type="hidden" name="consignees" value="<%=MT.f(soa.getConsignees()) %>"/>
                            <input type="hidden" name="consignees_id" value="<%=MT.f(soa.getConsignees_id()) %>"/>
                            <select name="consig" alt="收货人" id="_consignees" onchange="selectPro(this.options[this.options.selectedIndex])">
                                <option><%=MT.f(soa.getConsignees(),"无") %></option>
                            </select>
                        </td>
                    </tr>
                    <tr class=" first" data-animate-effect="fadeInLeft">
                        <td class="text-r">手机号:</td>
                        <td colspan="3" class="text-l"><input  type="text" readonly="readonly" class='bors form-control' id="_mobile" name="mobile" value="<%=MT.f(soa.getMobile()) %>"  /></td>
                    </tr>
                    <tr class=" first" data-animate-effect="fadeInLeft">
                        <td class="text-r">邮箱:</td>
                        <td colspan="3" class="text-l"><input  type="text" readonly="readonly" class='bors form-control' id="_email" name="email" value="<%=MT.f(email) %>"  /></td>
                    </tr>
                    <tr class=" first" data-animate-effect="fadeInLeft">
                        <td class="text-r">&nbsp;</td>
                        <td colspan="3" class="text-l"><button type="submit" class="btn btn-default btn-lz" style="width:auto;">保存收货人信息</button></td>
                    </tr>
                    <tr class=" first" data-animate-effect="fadeInLeft"><td colspan="4" style="padding:0px;">&nbsp;</td></tr>
                </thead>
            </table>
        </form>
            <script type="text/javascript">

                //选择医院
                function selectHosp(obj){
                    //alert(obj.value + "-" + obj.text);
                    console.log(obj);
                    form1.hospital.value = obj.text;
                    //查找收货人
                    mt.send("/Members.do?act=getsign&hospital="+obj.value,function(d)
                    {
                        var sel = document.getElementById("_consignees");
                        sel.innerHTML = d;
                    });
                }
                //选择签收人
                function selectPro(obj){
                    //alert(obj.value + "-" + obj.text);
                    form1.consignees.value = obj.text;
                    form1.consignees_id.value = obj.value;
                    //查找收货人
                    mt.send("/Members.do?act=selsign&profile="+obj.value,function(d)
                    {
                        var obj = eval(d);
                        document.getElementById("_mobile").value=obj[0].mobile;
                        document.getElementById("_email").value=obj[0].email;
                    });
                }
            </script>

            <form id="form5" name="form5" action="/ShopTps.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
                <div class='xiangxi'>
                    <%
                        int puid = 0;
                        ShopProduct p=ShopProduct.find(product_id);
                        ShopProductModel spm = ShopProductModel.find(p.model_id);
                        System.out.println(MT.f(spm.getModel()));
                        if(puid==0){
                            puid = p.puid;
                        }

                        if(Config.getInt("xinke")==puid){

                        }else{
                            if(profile.membertype==2){//服务商
                                //ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid, member);
                                ShopHospital sh1 = ShopHospital.findPuid(puid,hosid);
                                puid = sh1.getInvoicePuid();
                            }
                    %>
                    <input name='puid' type="hidden" value="<%= puid%>" />
                    <%
                        }
                    %>

            <h1 class="table " data-animate-effect="fadeInLeft">商品清单</h1>
            <table class="table table-hover " data-animate-effect="fadeInLeft">
                <thead>
                    <tr class="" data-animate-effect="fadeInLeft">

                        <th class="text-l">商品图片</th>
                        <th>厂商</th>
                        <th>商品编号</th>
                        <th class="text-l">商品名称</th>
                        <th class="text-l">商品类别</th>
                        <th class="text-l">商品规格</th>
                    </tr>
                </thead>
                <tbody>
                    <%

                        out.print("<tr>");
                        ProcurementUnit pu = ProcurementUnit.find(p.puid);
                        out.println("<td>");
                        if(p.isExist)
                            out.println(p.getAnchor('t'));
                        out.println("</td>");
                        out.println("<td>"+MT.f(pu.getName())+"</td>");
                        out.println("<td>");
                        out.println(p.yucode);
                        out.println("</td>");
                        out.println("<td>"+MT.f(p.name[1])+"</td>");
                        out.println("<td>"+MT.f(ShopCategory.find(p.category).name[1])+"</td>");
                        out.println("<td>"+MT.f(spm.getModel())+"</td>");
                        out.println("</tr>");


                    %>

                </tbody>
            </table>

            <div class="text-r " style="margin:30px 0px;" data-animate-effect="fadeInLeft">
                <%if("".equals(email)){%>
                <button type="button" onclick="nosend()"  class="btn btn-default btn-lz butsub">提交订单</button>
                <%}else {%>
                <button type="button" onclick="submit()"  class="btn btn-default btn-lz butsub">提交订单</button>
                <%}%>
            </div>
        </div>

                <input type="hidden" name="hosid" value="<%=hosid %>" />
                <input type="hidden" name="product_id" value="<%=product_id%>" />
                <input type="hidden" name="act" value="addTps" />
                <input type="hidden" name="nexturl" value="/html/folder/19092169-1.htm" />
                <input type="hidden" name="consignees_id" value="<%=soa.getConsignees_id()%>">
                <input type="hidden" name="fws_id" value="<%=member%>">
        </form>
    </div>
</div>


<%--<script src="/res/lizi/js/jquery.waypoints.min.js"></script>--%>
<%--<script src="/res/lizi/js/main.js"></script>--%>
<script>
    function myact(a,id){
        if(a=="edit"){
            $("#tab1").hide();
            $("#tab2").show();
        }
    }
</script>
    <script type="text/javascript">
        form1.nexturl.value = location.pathname+location.search;


        //修改发货人信息
        function setAddress(){
            myact('edit','0');
            var hospital = form1.hospital_id.value;
            var consignees = form1.consignees.value;
            //查找收货人
            mt.send("/Members.do?act=getsign&hospital="+hospital+"&consignees="+consignees,function(d)
            {
                var sel = document.getElementById("_consignees");
                sel.innerHTML = d;
            });

            mt.fit();
        }


        mt.submit=function(f){

                <%-- if(<%=soa.getId()<1%>){
                    mt.show("对不起！收货人信息没有填写，不能提交订单！");
                    return;
                }else if(<%=ps.length<1%>){
                    mt.show("对不起！商品清单内没有商品，不能提交订单！");
                    return;
                }else --%>{
                //includeLzCar?(isLzCategory

                f.isLzCategory.value=0;

                var payType=1;
                var temp = document.getElementsByName("payType");
                for(var i=0;i<temp.length;i++)
                {
                    if(temp[i].checked){
                        payType = temp[i].value;
                    }
                }
                f.payType.value=payType;

                f.submit();



            }

        };
        function fnsub(f){

            $.post("/ShopOrders.do?act=checkpriceunit&limitdate=2017-10-1&product_id=<%= product_id %>&hospital_id=<%= hosid %>", function(data) {

                if(<%=soa.getId()<1%>){
                    mt.show("对不起！收货人信息没有填写，不能提交订单！");
                    return false;
                }

                    <%-- if(<%=soa.getId()<1%>){
                           mt.show("对不起！收货人信息没有填写，不能提交订单！");
                           return false;
                       }else if(<%=ps.length<1%>){
                           mt.show("对不起！商品清单内没有商品，不能提交订单！");
                           return false;
                       }else --%>{
                    //includeLzCar?(isLzCategory

                    var payType=1;
                    var temp = document.getElementsByName("payType");
                    for(var i=0;i<temp.length;i++)
                    {
                        if(temp[i].checked){
                            payType = temp[i].value;
                        }
                    }
                    f.payType.value=payType;

                    fn.ajaxjq("/ShopOrders.do?act=submitajax",$("#form5").serialize(),function(data){

                            location = '/html/folder/19092408-1.htm?orderId='+data.orderId;

                    });
                    //f.submit();



                }



            });


        }




        mycity=function(s0,s1,s2,dv)
        {
            var h='';
            s0+='-';
            for(var i=2;i<s0.length;i+=2)
            {
                var v=s0.substring(0,i);
                var l=v.substring(0,i-2)||0;
                for(var j=0;j<CITY[l].length;j++)
                {
                    if(CITY[l][j][0]==v)
                    {
                        h+=CITY[l][j][2]+' ';
                        break;
                    }
                }
                if(v=="11"||v=="12"||v=="31"||v=="50")i+=2;
            }
            document.getElementsByName("cityname")[0].value = h;
            document.getElementById("cityaddress").innerHTML = h;
        };
        function setCityName(obj){
            if(mt.check(obj)){
                var cityid = document.getElementsByName("city2")[0].value;
                mycity(cityid);
            }else{
                return false;
            }
        };
        function showfp(){
            document.getElementById("stab1").style.display = 'none';
            document.getElementById("stab2").style.display = 'none';
            document.getElementById("fap").style.display = '';
        }

        function showRecipient(){
            mt.show("/jsp/yl/shopweb/RecipientSearch.jsp",2,"查询收货人",500,450);
        }
        mt.receive=function(id,n,m){
            form1.sor_id.value=id;
            form1.consignees.value=n;
            form1.mobile.value=m;
        }

        //是否为新增收货人
        function onNewAdd(obj){
            if(obj.checked == true){
                form1.sor_id.value = '0';
            }else{
                form1.sor_id.value = '<%=soa.getSor_id()%>';
            }
        }

        mycity('<%= soa.getCity() %>');
        mt.fit();

        jQuery(document).ready(function(){


            jQuery(".hospital_id").change();
        });


        function nosend() {
            mt.show("收货人未填写邮箱，请登录收货人账号绑定邮箱再下单。");
        }
    </script>
</body>
</html>