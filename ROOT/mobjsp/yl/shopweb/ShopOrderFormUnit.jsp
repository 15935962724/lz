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
    int quantity = h.getInt("quantity");

    float activity = h.getFloat("activity");

    int isallocate = h.getInt("isallocate",-1);

    int hosid = h.getInt("hosid");
    Filex.logs("checkpro.txt","jsp医院id+"+hosid+"");
//收货人信息
    ShopOrderAddress soa = new ShopOrderAddress(0);

/*if(hosid!=0&&soa.getHospitalId()!=hosid){
soa = ShopOrderAddress.find(0);
}*/


//判断收货人信息是否是订单的   必须是订单的
//查询医院订单的签收人
    List<Profile> pList = Profile.getProfileByHospitalId(hosid, 0);
    Filex.logs("orderqsr.txt","pList="+pList.size());
    if(pList.size()>0){
        Profile profile1 = pList.get(0);
        int profile2 = profile1.getProfile();
        //根据签收人id和医院id 查询出地址
        Filex.logs("orderqsr.txt","profile2="+profile2);
        ArrayList<ShopOrderAddress> shopOrderAddresses = ShopOrderAddress.find(" AND consignees_id=" + profile2+" AND hospitalId="+hosid, 0, Integer.MAX_VALUE);
        //没有让客户新增  有直接取
        if(shopOrderAddresses.size()>0){
            soa=shopOrderAddresses.get(0);
        }

    }
//发票信息
    ShopNvoice sn = ShopNvoice.getObjByMember(member);

    ShopQualification sqq = ShopQualification.findByMember(member);

    String token = System.currentTimeMillis()+new Random().nextInt()+"";
    session.setAttribute("token", token);

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
    <title>提交订单</title>
    <link rel="stylesheet" href="/mobjsp/yl/css/common.css">
    <link rel="stylesheet" href="/mobjsp/yl/css/swiper.min.css">
    <script src="/mobjsp/yl/js/swiper.min.js"></script>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src='/tea/city.js' type="text/javascript"></script>
    <script src='/tea/jquery.js' type="text/javascript"></script>
    <script src='/tea/yl/common.js' type="text/javascript"></script>
    <style>
        .detail01{
            border-bottom:0.02rem solid #dcdcdc;
        }
        .detail01 .pic{
            height:1.8rem;
            width:2.25rem;
        }
        .detail01 .nr{
            justify-content: center;
            align-items: left;
        }
        .detail01 .nr span{
            margin:0 !important;
            line-height:160% !important;
        }
        textarea,input[type=button], input[type=submit], input[type=text],input[type=file], button { cursor: pointer; -webkit-appearance: none; }
    </style>
</head>
<body>
<div id="Body">
    <!-- <div id="Header">
        <header class="flex">
            <div class="logo"><img src="http://www.brachysolution.com/res/Home/structure/14112579.png" /></div>
            <div class="head-r flex">
                <div class="search"></div>
                <nav>
                    <em></em>
                </nav>
            </div>
        </header>
    </div> -->
    <form name="form1" action="/ShopOrderForms.do"  method="post" onsubmit="return setCityName(this)">
        <input type="hidden" name="id" value="<%=soa.getId() %>" />
        <input type="hidden" name="nexturl" value="/jsp/yl/shopweb/ShopOrderFormUnit.jsp"/>
        <input type="hidden" name="act" value="orderAddress" />
        <input type="hidden" name="hospital" value="<%=hosid %>" />

    <div id="Content"  style="padding-bottom:1.2rem;">
        <div class="order-sign" id="tab2"  style="display: <%=soa.getMember()>0?"none":"" %>" >
            <%
                //if(profile.membertype == 2)
                {
                    out.print("<div class='sign2 flex'><span class='bold'>医院名称:</span>");
                    String [] sarr = profile.hospitals.split("\\|");
                    if(hosid!=0){
                        sarr = new String[]{"",hosid+""};
                    }
                    out.print("<span ><select class='hospital_id' name='hospital_id' alt='医院名称' onchange=selectHosp(this.options[this.options.selectedIndex]);>");
                    out.print("<option value=''>--请选择--</option>");
                    for(int i=1;i<sarr.length;i++){
                        ShopHospital s1 = ShopHospital.find(Integer.parseInt(sarr[i]));
                        if(hosid == s1.getId())
                            out.print("<option selected value='"+s1.getId()+"'>"+s1.getName()+"</option>");
                        else
                            out.print("<option value='"+s1.getId()+"'>"+s1.getName()+"</option>");
                    }
                    out.print("</select></span></div>");
                    out.print("<div class='sign2 flex'><span class='bold'>科室:</span>");
                    out.print("<span><select name=\"department\"><option value=\"无\">--请选择--</option>");
                    for(int j=1;j<ShopQualification.DEPARTMENT_ARR.length;j++){
                        if(MT.f(soa.getDepartment()).equals(ShopQualification.DEPARTMENT_ARR[j]))
                            out.print("<option selected value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
                        else
                            out.print("<option value='"+ShopQualification.DEPARTMENT_ARR[j]+"'>"+ShopQualification.DEPARTMENT_ARR[j]+"</option>");
                    }
                    out.print("</select>");
                    out.print("</span></div>");
                }
            %>
            <div class='sign2 flex'>
                <span class='bold'>收货人:</span>
                <span><input type="hidden" name="consignees" value="<%=MT.f(soa.getConsignees()) %>"/>
                            <input type="hidden" name="consignees_id" value="<%=MT.f(soa.getConsignees_id()) %>"/>
                            <select name="consig" alt="收货人" id="_consignees" onchange="selectPro(this.options[this.options.selectedIndex])">
                                <option><%=MT.f(soa.getConsignees(),"无") %></option>
                            </select></span>
            </div>
            <div class='sign2 flex'>
                <span class='bold'>手机号:</span>
                <span><input style='width:100%;background:#eee;font-size:0.26rem;border: 0.02rem #dcdcdc solid;-webkit-border-radius: 0.04rem;-moz-border-radius: 0.04rem;border-radius: 0.04rem;padding: 0 0.1rem;height: 0.66rem'  type="text" readonly="readonly"  id="_mobile" name="mobile" value="<%=MT.f(soa.getMobile()) %>" alt="手机号" /></span>
            </div>
            <div class='sign2 flex'>
                <span class='bold'>详细地址:</span>
                <span><input  style='width:100%;background:#eee;font-size:0.26rem;border: 0.02rem #dcdcdc solid;-webkit-border-radius: 0.04rem;-moz-border-radius: 0.04rem;border-radius: 0.04rem;padding: 0 0.1rem;height: 0.66rem' type="text" readonly="readonly"  id="_address" name="address" value="<%=MT.f(soa.getAddress()) %>" alt="详细地址" /></span>
            </div>
            <input type="submit" class="but" value="保存" />

        </div>
    </form>


        <script type="text/javascript">
            //查找收货人
            mt.send("/Members.do?act=getsign&hospital=<%=hosid%>",function(d)
            {
                var sel = document.getElementById("_consignees");
                sel.innerHTML = d;
            });
        </script>
        <div class="address flex" id="tab1" style="display: <%=soa.getMember()>0?"":"none" %>">
                <span class="tit">
                    <%=soa.getConsignees() %>　<%=MT.f(soa.getMobile()) %>
                    <a onclick="setAddress()" class='che-ad'>修改收货人</a>
                </span>
            <span class="info">
                    <%=MT.f(soa.getAddress()) %>
                </span>
            <span class="info" style="color:#999">
                    <%=MT.f(soa.getHospital()) %>      <%=MT.f(soa.getDepartment()) %>
                </span>
        </div>
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

                form1.consignees_id.value = obj.value;
                if(obj.value==""){
                    form1.consignees.value = "";
                }else{
                    form1.consignees.value = obj.text;
                }
                //查找收货人
                mt.send("/Members.do?act=selsign&profile="+obj.value,function(d)
                {
                    var obj = eval(d);
                    document.getElementById("_mobile").value=obj[0].mobile;
                    document.getElementById("_address").value=obj[0].address;
                });
            }
        </script>
        <form id="form5" name="form5" action="/ShopOrders.do" method="post"  target="_ajax" onsubmit="return mt.check(this)">
            <div class='xiangxi'>
                <%
                    int puid = 0;
                    ShopProduct p=ShopProduct.find(product_id);
                    if(puid==0){
                        puid = p.puid;
                    }
                    if(Config.getInt("xinke")==puid){

                    }else{
                        //ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid, member);
                        if(profile.membertype==2){//服务商
                            //ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid, member);
                            ShopHospital sh1 = ShopHospital.findPuid(puid,hosid);
                            puid = sh1.getInvoicePuid();
                        }
                %>
                <input name='puid' type="hidden" value="<%= puid%>" />
                <%
                    }
                    int checkLength = 1;
                    boolean isLzCategory = false;
                    boolean includeLzCar = false;

                    int issxinke = 0;
                    //非欣科隐藏
                    if(Config.getInt("xinke")==p.puid){
                        issxinke = 1;
                    }else{

                    }

                %>
                <div class="pro-info flex">
            <h2 class="h2 flex bold">商品清单</h2>
            <div class="detail01 flex">
                    <span class="pic flex">
                        <img src="http://www.brachysolution.com/res/Home/structure/19061406.png" />
                    </span>
                <span class="nr flex">
                    <%
                        //int num=0;//数量
                        float totalprice = 0.0f;

                        ShopPackage spage = new ShopPackage(0);
                        List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
                        String pname = "";
                        boolean isLiziClazz = false;
                        Calendar c = Calendar.getInstance();
                        //c.set(Calendar.DATE, c.get(Calendar.DATE) +21);
                        c.set(Calendar.DATE, c.get(Calendar.DATE) +8);//2017/7/4 屈通知由21天改为8天
                        Date maxDate = c.getTime();

                        float price = 0.0f;

                        if(p.isExist){
                            pname=p.getAnchor(h.language);
                            if(p.category==ShopCategory.getCategory("lzCategory"))
                            {
                                isLiziClazz = true;
                                includeLzCar = true;
                            }
                            Profile pf = Profile.find(h.member);
                            price = p.price;
                            //所有改为展示商品显示价格
                            if(pf.membertype==2){//代理商价格
                                ShopPriceSet sps = ShopPriceSet.find(hosid,p.product,0);
                                if(sps.agentPrice>0){
                                    price=sps.price;
                                }
                            }
                        }else{
                            spage = ShopPackage.find(product_id);
                            pname="[套装]"+MT.f(spage.getPackageName());
                            ShopProduct s = ShopProduct.find(spage.getProduct_id());
                            //if(s.category==ShopCategory.getCategory("lzCategory"))isLiziClazz = true;
                            spagePList.add(0,s);
                            String [] sarr = spage.getProduct_link_id().split("\\|");
                            for(int m=1;m<sarr.length;m++){
                                ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[m]));
                                //if(!isLiziClazz&&s1.category==ShopCategory.getCategory("lzCategory")){isLiziClazz=true;includeLzCar=true;}
                                spagePList.add(m,s1);
                            }
                            price = (float)spage.getSetPrice();
                        }
                        totalprice+=price*quantity;
                       //out.print("<tr>");
                        ProcurementUnit pu = ProcurementUnit.find(p.puid);
                       // out.println("<td>");
                        if(p.isExist)
                           // out.println(p.getAnchor('t'));
                       // out.println("</td>");
                       // out.println("<td>"+MT.f(pu.getName())+"</td>");
                       // out.println("<td>");
                        if(p.isExist)
                         //   out.println(p.yucode);
                       // out.println("</td>");
                       // out.println("<td>"+pname+"</td>");
                        //out.println("<td>");
                        /*if(isLiziClazz){
                            StringBuffer caliBuff = new StringBuffer("<span class='calidate'>");
                            if(p.model_id>0){
                                ShopProductModel spm = ShopProductModel.find(p.model_id);
                                String activityStr = spm.getModel().replaceAll("[a-zA-Z]","");
                                if(activityStr.indexOf("-")!=-1){
                                    String[] activityArr = activityStr.split("-");
                                    Double activityMin =  Double.parseDouble(activityArr[0]);
                                    Double activityMax =  Double.parseDouble(activityArr[1]);
                                    caliBuff.append("<input class='form-control ' type='text' alt='粒子活度' title='粒子活度范围："+activityStr+"' style='font-size:0.26rem;width:50px;padding:0 5px;' name='activity' value='"+(activity==0?"":activity)+"' onkeyup=\"keyupActivity(this)\" onblur=\"blurActivity(this,"+activityMin+","+activityMax+")\" />");
                                }else
                                    caliBuff.append("<input type='hidden' name='activity' value='"+activityStr+"' />"+activityStr);
                            }
                            //caliBuff.append("校准时间：<input alt='校准时间' name='calidate_"+product_id+"' value='' onClick='mt.date(this,false,\""+new Date()+"\",\""+maxDate+"\")' readonly style='width:100px' class='date'/>");

                            caliBuff.append("</span>");
                            //out.println(caliBuff.toString());
                        }*/
                        out.println("</td>");
                      /*  StringBuffer caliBuff = new StringBuffer("");
                        if(Config.getInt("xinke")==p.puid){//非欣科隐藏
                            caliBuff.append("<td><input alt='校准时间' name='calidate' value='' onClick='mt.date(this,false,\""+new Date()+"\",\""+maxDate+"\")' readonly style='width:100px' class='date'/></td>");
                        }else{
                            caliBuff.append("<td>"+MT.f(new Date())+"</td><input name='calidate' type='hidden' value='"+MT.f(new Date())+"' class='hidden'/>");
                        }
                       // out.println(caliBuff.toString());
                       // out.println("<td class='price'><span style='font-size:13px;'>&yen;</span><input name='orderprice' type='hidden' value='"+price+"' />"+MT.f(price,2)+"</td>");
                        //out.println("<td>"+quantity+"</td>");//<li class='are'><a href='###' onclick='numDec()'>-</a><a href='###' onclick='numAdd()'>+</a></li>
                        //out.println("<td><input type='text' id='quantity' name='quantity' class='form-control' style='padding:0 5px;' value='"+quantity+"' onkeyup='keyup()'/></td>");
                        if(p.puid==Config.getInt("junan")){
                           // out.print("<td><div class='productstockcount'></div></td>");
                        }*/
                        //out.println("</tr>");

                       /* if(!p.isExist){
                            for(int n=0;n<spagePList.size();n++){
                                ShopProduct s1 = spagePList.get(n);
                                price = s1.price;
                                out.println("<tr class='tzP'><td>"+s1.yucode+"</td>");
                                out.println("<td>"+s1.getAnchor('t')+"</td>");
                                out.println("<td>"+s1.getAnchor(h.language)+"</td>");
                                out.println("<td class='price'><span style='font-size:13px;'>&yen;</span>"+MT.f(price,2)+"</td>");
                                out.println("<td></td>");
                                out.println("</tr>");
                            }
                        }*/

                        //}
                        isLzCategory = checkLength==1;
                        //out.println("<tr><td><td colspan='4'>"+(includeLzCar?(isLzCategory?"粒子":"有粒子不唯一"):"不是粒子")+"</tr>");

                        if(isLzCategory){
                            //根据用户id查询用户地址信息
                            //ShopOrderAddress soad = ShopOrderAddress.getObjByMember(h.member);
                            ShopHospital hospital = ShopHospital.find(hosid, 90);
                            if(hospital.getId() > 0){
                                out.print("<script>mt.show(\"系统提示！您所在【"+hospital.getName()+"】的资质即将到期，请尽快办理！\")</script>");
                            }

                            /*验证医院资质是否已过期*/
                            ShopHospital sh = ShopHospital.findcheck(hosid);
                            if(sh.getId() > 0){
                                out.print("<input type=\"hidden\"  name=\"pastdue\" value=\"0\" />");
                            }
                        }

                    %>
                        <span class="tit bold"><%= p.name[1]%></span>
                        <span class="version"><em>商品编号</em><%= MT.f(p.yucode)%></span>
                        <span class="version"><em>厂　　商</em><%= pu.getName()%></span>
                    <span class="version"><em>商品单价</em>￥<%= MT.f(price,2)%></span>
                        <%
                            if(p.puid==Config.getInt("junan")){
                                %>
                    <%--<span class="version"><em>库存数量</em><i class='productstockcount' style='font-style: normal;'></i></span>--%>
                    <%
                            }
                        %>
                    </span>
            </div>
        </div>

        <div class="sign02 flex">
            <p class="flex">
                <span class="sp1">粒子活度:</span>
                <%
                    if(isLiziClazz){
                        StringBuffer caliBuff = new StringBuffer("");
                        if(p.model_id>0){
                            ShopProductModel spm = ShopProductModel.find(p.model_id);
                            String activityStr = spm.getModel().replaceAll("[a-zA-Z]","");
                            if(activityStr.contains("[")){
                                activityStr = activityStr.split("\\[")[0];
                            }
                            if(activityStr.indexOf("-")!=-1){
                                String[] activityArr = activityStr.split("-");
                                Double activityMin =  Double.parseDouble(activityArr[0]);
                                Double activityMax =  Double.parseDouble(activityArr[1]);
                                caliBuff.append("<input class='form-control' type='text' alt='粒子活度' title='粒子活度范围："+activityStr+"' style='font-size:0.26rem;width:50px;padding:0 5px;' name='activity' value='"+(activity==0?"":activity)+"' onkeyup=\"keyupActivity(this)\" onblur=\"blurActivity(this,"+activityMin+","+activityMax+")\" />");
                            }else
                                caliBuff.append("<input type='hidden' name='activity' value='"+activityStr+"' /><span class='sp2'>"+activityStr+"</span>");
                        }
                        //caliBuff.append("校准时间：<input alt='校准时间' name='calidate_"+product_id+"' value='' onClick='mt.date(this,false,\""+new Date()+"\",\""+maxDate+"\")' readonly style='width:100px' class='date'/>");

                        out.println(caliBuff.toString());
                    }
                %>
               <%-- <input type="text" placeholder="请输入粒子活度" />--%>
            </p>
            <p class="flex">
                <span class="sp1">校准时间:</span>
                <%
                    StringBuffer caliBuff = new StringBuffer("");
                    if(Config.getInt("xinke")==p.puid){//非欣科隐藏
                        caliBuff.append("<input alt='校准时间' name='calidate' value='' onClick='mt.date(this,false,\""+new Date()+"\",\""+maxDate+"\")' readonly style='width:100px' class='date'/>");
                    }else{
                        caliBuff.append("<span class='sp2'>"+MT.f(new Date())+"</span><input name='calidate' type='hidden' value='"+MT.f(new Date())+"' class='hidden'/>");
                    }
                    out.print(caliBuff);
                %>
                <%--<input type="text" placeholder="请选择校准时间" />--%>
            </p>
            <p class="flex">
                <span class="sp1">商品数量:</span>
                <%--<input type="text" placeholder="请输入商品数量" />--%>
                <input type='text' id='quantity' name='quantity' style="font-size:0.26rem;" class='form-control'  value='<%=quantity%>' onchange='keyup()'/>
            </p>
        </div>

        <div class="sign03 flex">
            <textarea placeholder="备注说明:" name="userRemarks"></textarea>
        </div>


        <div class="detail04 flex">
            <span class="deta-je">应付总额</span>
            <span class="deta-je2 ">￥<span class="total1"></span></span>
            <input id="btn" type="button" value="提交订单" class="butsub" onclick="return fnsub(this.form)" />
        </div>
    </div>
            <%-- <input type="hidden" name="puid" value="<%=puid %>" /> --%>
            <input type="hidden" name="hosid" value="<%=hosid %>" />
            <%-- <input type="hidden" name="quantity" value="<%=num %>"/> --%>
            <input type="hidden" name="amount" value="<%=totalprice%>" />
            <input type="hidden" name="product_id" value="<%=product_id%>" />
            <input type="hidden" name="iswx" value="1" />
            <input type="hidden" name="cityname" />

            <input type="hidden" name="allocate" />
            <input type="hidden" name="allocatetype" />


            <input type="hidden" name="act" value="submit" />
            <input type="hidden" name="nexturl" value="/html/folder/14110391-1.htm" />
            <input name='orderprice' type='hidden' value='<%= price%>' />
            <input type="hidden"  name="payType" value="" />
            <input type="hidden"  name="isLzCategory" value="" />
            <input type="hidden" name="token" value="<%=token %>" />
            <input name='junan' type='hidden' value='<%= Config.getInt("junan")==p.puid?1:0 %>' />
        </form>
</div>
<script>
    $(function () {
        $("em.flex i").click(function () {
            $(this).addClass('cur').siblings("i").removeClass("cur");
        });

    })
</script>
    <script>
        function myact(a,id){
            if(a=="edit"){
                $("#tab1").hide();
                $("#tab2").show();
            }
        }
        form1.nexturl.value = location.pathname+location.search;
        function fncheck(){
            //alert("aaaa");
            mt.send("/ShopOrders.do?act=checkprice",function(d)
            {
                //alert(d);
                if(d!='0')
                {
                    mt.show(d+'，此商品管理员没有设置开票价格，请与管理员联系，设置开票价格后才可提交订单！');
                    return false;
                }else{
                    return true;
                }
            });


        }
        //选择发票类型
        function selNvoice(v){
            if(v == 1){
                document.getElementById('nvoice_t').style.display = 'none';
                form3.type.value = '1';
            }else{
                document.getElementById('nvoice_t').style.display = '';
                form3.type.value = '2';
            }
            mt.fit();
        }

        //修改发货人信息
        function setAddress(){
            /*document.getElementById('nvoice_show').style.display = 'none';
            document.getElementById('nvoice_edit').style.display = '';
            document.getElementById('address_up').style.display = '';*/
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

        function keyupActivity(obj){
            obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
            obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是
            obj.value = obj.value.replace(/^[2-9]/g,""); //验证第一个字符是数字而不是
            obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
            obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
            obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数
            findProductStockCount();
        }

        function blurActivity(obj,activityMin,activityMax){
            if(obj.value!=''&&(obj.value<activityMin||obj.value>activityMax)){
                mt.show("活度超出范围 "+activityMin+"-"+activityMax+"！");
                obj.value = activityMin;
                findProductStockCount();
            }
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
                var includeLzCar = <%=includeLzCar%>;
                var isLzCategory = <%=isLzCategory%>;
                if(includeLzCar){
                    if(isLzCategory){
                        f.isLzCategory.value=1;
                    }else{
                        mt.show("对不起！购物车中有粒子，而且不是单一粒子产品，不能提交订单！");
                        return;
                    }
                }else{
                    f.isLzCategory.value=0;
                }
                var payType=1;
                var temp = document.getElementsByName("payType");
                for(var i=0;i<temp.length;i++)
                {
                    if(temp[i].checked){
                        payType = temp[i].value;
                    }
                }
                f.payType.value=payType;

                var pastdue = f.pastdue;
                if(pastdue&&pastdue.value=='0'){
                    mt.show('当前医院资质已到期，不能提交订单！');
                    return;
                }
                var activity = f.activity;
                if(activity&&activity.value==''){
                    mt.show('抱歉，请先填写粒子活度！！！');
                    return;
                }
                var calidate = f.calidate;
                if(calidate&&calidate.value==''){
                    mt.show('抱歉，请先填写粒子的校准时间！！！');
                    return;
                }

                f.submit();



            }

        };
        function fnsub(f){
            $.post("/ShopOrders.do?act=checkpriceunit&limitdate=2017-10-1&product_id=<%= product_id %>&hospital_id=<%= hosid %>", function(data) {
                if(data.length>2){
                    if(data.indexOf('对不起')==-1){
                        var astr=data+'，此商品管理员没有设置开票价格，请与管理员联系，设置开票价格后才可提交订单！';
                        mt.show(astr);
                        return false;
                    }else{
                        mt.show(data);
                        return false;
                    }

                }
                if(<%=soa.getId()<1%>){
                    mt.show("对不起！收货人信息没有填写，不能提交订单！");
                    return false;
                }
                <%
                System.out.println(MT.f(soa.getConsignees())+"==");
                %>
                if(<%=MT.f(soa.getConsignees()).length()==0%>){
                    mt.show("对不起！收货人名称没有填写，不能提交订单（如没有收货人可选请联系系统管理员添加）！");
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
                    var includeLzCar = <%=includeLzCar%>;
                    var isLzCategory = <%=isLzCategory%>;
                    if(includeLzCar){
                        if(isLzCategory){
                            f.isLzCategory.value=1;
                        }else{
                            mt.show("对不起！购物车中有粒子，而且不是单一粒子产品，不能提交订单！");
                            return false;
                        }
                    }else{
                        f.isLzCategory.value=0;
                    }
                    var payType=1;
                    var temp = document.getElementsByName("payType");
                    for(var i=0;i<temp.length;i++)
                    {
                        if(temp[i].checked){
                            payType = temp[i].value;
                        }
                    }
                    f.payType.value=payType;

                    var pastdue = f.pastdue;
                    if(pastdue&&pastdue.value=='0'){
                        mt.show('当前医院资质已到期，不能提交订单！');
                        return false;
                    }
                    var activity = f.activity;
                    if(activity&&activity.value==''){
                        mt.show('抱歉，请先填写粒子活度！！！');
                        return false;
                    }
                    var calidate = f.calidate;
                    if(calidate&&calidate.value==''){
                        mt.show('抱歉，请先填写粒子的校准时间！！！');
                        return false;
                    }

                    var quantity = form5.quantity.value;
                    if(quantity>2000){
                        mt.show('抱歉，订货量不能大于2000！！！');
                        return false;
                    }

                    //判断当前医院有无未提交订单，从2017年10月1日开始算起



                    /* $.post("/ShopOrders.do?act=submitajax", function(data) {

                    }); */

                    fn.ajaxjq("/ShopOrders.do?act=submitajax",$("#form5").serialize(),function(data){
                        if(data.type>0){
                            if(data.type==1){
                                mt.show('对不起！您还未登录，登陆后才可提交订单！');
                                return;
                            } else if(data.type==3){
                                mt.show(data.mes);
                                return;
                            } else if(data.type==4){
                            	 mt.show('Token失效，请联系管理员！');
                                 return;
                            }
                            allocatefun();
                        }else{
                            //host 14110391
                            //test 19070110
                            location = '/mobjsp/yl/shopweb/ShopOrderPayment.jsp?orderId='+data.orderId;
                        }
                    });
                    //f.submit();



                }



            });


        }

        function allocatefun(){
            mt.show("库存不足，是否同意调配？",2);
            mt.ok = function(){
                form5.allocate.value = 1;
                form5.allocatetype.value = 0;
                $(".butsub").click();
            }
            mt.cancel = function(){
                /*form5.allocate.value = 1;
                form5.allocatetype.value = 1;
                $(".butsub").click();*/
            }
            //fnsub();

        }


        function setCityName(obj){
            /*if(mt.check(obj)){
                var cityid = document.getElementsByName("city2")[0].value;
                mycity(cityid);
            }else{
                return false;
            }*/
        }
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

        mt.fit();

        jQuery(document).ready(function(){


            jQuery(".hospital_id").change();
        });

        /*商品数量+1*/
        function numAdd(){
            var quantity = document.getElementById("quantity").value;
            var num_add = parseInt(quantity)+1;
            if(quantity==""){
                num_add = 1;
            }
            if(num_add>2000){
                document.getElementById("quantity").value=num_add-1;
                mt.show("商品数量不能大于2000");
            }else{
                document.getElementById("quantity").value=num_add;
                calculatetotal();
            }
        }

        /*商品数量-1*/
        function numDec(){
            var quantity = document.getElementById("quantity").value;
            var num_dec = parseInt(quantity)-1;
            if(num_dec>0){
                document.getElementById("quantity").value=num_dec;
                calculatetotal();
            }
        }
        /*商品数量框输入*/
        function keyup(){
            var quantity = document.getElementById("quantity").value;
            var re = /^[1-9]+[0-9]*]*$/;
            if(!re.test(quantity) ||  parseInt(quantity)!=quantity || parseInt(quantity)<1){
                document.getElementById("quantity").value = 1;
                calculatetotal();
                return;
            }
            if(quantity>2000){
                document.getElementById("quantity").value=quantity.substring(0,quantity.length-1);
                mt.show("商品数量不能大于2000");
            }
            calculatetotal();
        }

        function calculatetotal(){
            //var total = 2.368;
            var orderprice = form5.orderprice.value;
            var quantity = form5.quantity.value;
            var total = orderprice * quantity;
            $(".total1").html(total);
            form5.amount.value = total;
        }
        calculatetotal();

        var perce = '<%= perce %>';
        var junan = '<%=Config.getInt("junan")==p.puid?1:0 %>';
        function findProductStockCount(){
            if(junan==1){
                mt.send("/ProductStocks.do?act=findProductStockCount&activity="+form5.activity.value+"&perce="+perce,function(data){
                    data = eval('(' + data + ')');
                    if(data.type>0){
                        if(data.type==1){
                            //location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
                            return;
                        }
                        mtDiag.close();
                        mtDiag.show(data.mes);
                        return;
                    }else{
                        //form1.productstockcount.value = data.count;
                        jQuery(".productstockcount").html(data.count);
                        //console.log(data);
                    }
                });
            }
        }
        findProductStockCount();
    </script>
</body>
</html>