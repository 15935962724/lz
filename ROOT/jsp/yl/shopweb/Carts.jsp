<%@page import="tea.entity.yl.shop.*"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@ page import="util.Config" %>
<%@ page import="tea.db.DbAdapter" %>
<%

    Http h=new Http(request,response);
/* if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
} */
/* 

Site s=Site.find(1); */

    String act = h.get("act");
    if("checkCart".equals(act))
    {
        int checkLength = 0;
        boolean isLzCategory = false;
        boolean includeLzCar = false;
        String[] ps=h.getCook("cart","|").split("[|]");
        for(int i=1;i<ps.length;i++){
            String[] arr=ps[i].split("&");
            int checkFlag = Integer.parseInt(arr[2]);
            if(checkFlag==1){
                checkLength++;
                //判断product_id是否商品的id，如果不是则为套装id
                int product_id=Integer.parseInt(arr[0]);
                ShopProduct p=ShopProduct.find(product_id);
                if(p.isExist){
                    if(p.category==ShopCategory.getCategory("lzCategory"))
                    {
                        includeLzCar = true;
                    }
                }
            }
        }
        if(checkLength==0){
            out.print("请至少选中一件商品！");
            return;
        }else{
            if(h.member<1){
                out.print("&nbsp;&nbsp;&nbsp;&nbsp;对不起！您还未登录，登陆后才可提交订单！<br/>"
                        +"已是网站会员，点击 <a href=javascript:parent.location='/html/folder/19061184-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>登录</a>"
                        +"&nbsp;&nbsp;还不是网站会员，点击 <a href=javascript:parent.location='/html/folder/19061185-1.htm'  style='font-weight:bold;font-size:14px;color:#0079D2'>注册</a>");
                return;
            }else if(includeLzCar){
                Profile myp = Profile.find(h.member);
                if(myp.qualification==1||myp.membertype==2){//已通过审核可ShopOrderFormUnit1以购买
                    isLzCategory = checkLength==1;
                    if(!isLzCategory){
                        out.print("对不起！购物车中有粒子，而且不是单一粒子产品，不能提交订单！");
                        return;
                    }
                }else{
                    out.print("对不起！您还未提交资质或已提交但审核未通过或资质已过期，不能去结算，请尽快提交您资质审核资料！<br/>如想尽快完成订，请致电：<b style='color:#FF7F00;font-size:16px'>010-12345678</b><p align='center'>我要提交 <a href='/html/folder/14110054-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>资质审核</a></p>");
                    return;
                }
            }
        }

        out.print(1);
        return;
    }

    String[] ps=h.getCook("cart","|").split("[|]");

    List<String> tpslist = new ArrayList<String>();

    List<String> sblist = new ArrayList<String>();

    for (int i = 1; i < ps.length; i++) {
        String[] arr=ps[i].split("&");
        //判断product_id是否商品的id，如果不是则为套装id
        int product_id=Integer.parseInt(arr[0]);
        ShopProduct sp1 = ShopProduct.find(product_id);
        ShopCategory sc1 = ShopCategory.find(sp1.category);

        if(sc1.path.indexOf(Config.getString("tps"))!=-1){//tps
            tpslist.add(ps[i]);
        }else{
            sblist.add(ps[i]);
        }
    }


    boolean flag = false;
//boolean buyflag = false;

%><!doctype html><head>
<link rel="stylesheet" href="/res/lizi/css/bootstrap.css">
<link rel="stylesheet" href="/res/lizi/css/animate.css">
<link rel="stylesheet" href="/res/lizi/css/style1.css">
<link rel="stylesheet" href="/res/lizi/css/common.css">
<script src="/res/lizi/js/jquery-1.11.3.min.js"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>

<script>
    var ls=parent.document.getElementsByTagName("HEAD")[0];
    document.write(ls.innerHTML);
    var arr=parent.document.getElementsByTagName("LINK");
    for(var i=0;i<arr.length;i++)
    {
        document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
    }
</script>
</head>
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
    .carttitle table{font-size:14px;}
    .Mycontent{margin-bottom:30px;min-height:400px;}
    .proCar td img{width:auto;max-height:72px;}
    .delepc{margin-left:15px;}
    .are a {
        color: #333;
        width: 31px;
        height: 29px;
        display: inline-block;
        line-height: 23px;
        text-align: center;
        font-weight: bold;
        font-size: 21px;
        border: 1px solid #dcdcdc;
        background: #EDEDED;
    }
    .quan {
        height: 29px;
        width: 63px;
        margin: 0;
        border: none;
        border-top: 1px solid #dcdcdc;
        border-bottom: 1px solid #dcdcdc;
        text-align:center;
    }
    .car-jsb{
        width:100%;
        border-top:1px #dcdcdc solid ;
        background:#F3F6FA;
        overflow:hidden;
        height:70px;
        line-height:70px;
        padding:0 15px 0 4%;
        margin-top:30px;
    }
    .car-jsb span a{
        color:#333;
        margin-right:15px;
    }
    .car-js{
        float:right;
        margin-top:19px;
        color:#333;
    }
    .car-js .btn-lz {
        color: #fff;
        background: #044694;
        border: none;
        font-size: 15px;
        padding: 8px 30px;
        height:auto;
        line-height: 1.42857143;
        font-weight:normal;
        margin-left:15px;
    }
    .car-js b {
    color: #df6c0a;
    font-size: 16px;
    }
    </style>
    </head>
<body>
<%-- <%=s.header%> --%>
<div class="Mycontent">
    <div class="Mytop"></div>
    <div class="Mycon">
        <div class="ShoppingCart shopCar">
<%--            <ul class="Order_cart" id="Order_cart_S1">--%>
<%--                <li class="step1">1.我的购物车</li>--%>
<%--                <li class="step2">2.填写核对订单信息</li>--%>
<%--                <li class="step3">3.成功提交订单</li>--%>
<%--            </ul>--%>
            <div class="cartimg"></div>
            <%
                if(ps.length<1)
                {
                    out.print("<div class='cartnone' style='height:170px;line-height:170px;font-size:16px;text-align:center;margin:0;background:#f3f3f3;'><img src='/tea/image/cart-empty-bg.png' style='width: 50px;margin-right: 20px;'>购物车内暂时没有商品，您可以去<a href='/html/folder/19080995-1.htm' style='color:#0079D2;'>产品</a>挑选喜欢的商品</div>");
                }else
                {
                    %>
    <form name="fcar" id="fcar" action="/Favs.do" method="post" target="_ajax">
    <%
                    if(tpslist.size()>0){
%>
    <div class="carttitle">
        <h1 class='table'>治疗计划系统TPS</h1>

            <input type="hidden" name="fav"/>
            <input type="hidden" name="nexturl"/>
            <input type="hidden" name="act"/>
            <table class="table table-hover mytab" id="tab1" cellpadding="0" cellspacing="0">
                <thead>
                <tr>
                    <th style='width:95px;'><label style='margin-bottom:0'><input type="checkbox" onclick="cheall(this,'tab1');" id="cheallNode"/>&nbsp;全选</label></th>
                    <th>商品图片</th>
                    <th>商品名称</th>
                    <th style='width:95px'>软件大小</th>
                    <th style='width:95px'>软件版本</th>
                    <th>购买方式</th>
                    <th style='width:95px'>商品单价</th>
                    <th style='width:95px'>操作</th>
                </tr>
                </thead>
                <tbody>
                <%

                    for(int i=0;i<tpslist.size();i++){
                        String[] arr=tpslist.get(i).split("&");
                        //判断product_id是否商品的id，如果不是则为套装id
                        int product_id=Integer.parseInt(arr[0]);
                        int quantity=1;//数量Integer.parseInt(arr[1])

                        String carstr = product_id+"&1&0";

                        ShopProduct p=ShopProduct.find(product_id);
                        ShopPackage spage = new ShopPackage(0);
                        List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
                        String pname = "";
                        float price = 0.0f;
                        int hosid = Integer.parseInt(h.getCook(p.product+"","0"));
                        //if(p.isExist){
                            pname=p.getAnchor(h.language);
                            Profile pf = Profile.find(h.member);
                            price = p.price;
                        //}
                        out.print("<tr class='"+(p.isExist?"proCar":"tzCar")+"' >");
                        out.print("<td style=''><input type='checkbox' protype='0' name='proid' product='"+product_id+"' value='"+tpslist.get(i)+"' onclick='car.update0(this,"+product_id+")'/>&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                        out.print("<td>");
                        if(p.isExist)
                            out.print(p.getAnchor('t'));
                        out.print("</td>");
                        out.print("<td>"+p.name[1]+"</td>");
                        ShopProductModel spm = ShopProductModel.find(p.model_id);
                        out.print("<td>"+MT.f(p.color)+"</td>");


                        out.print("<td>"+MT.f(p.size)+"</td>");

                        int category = p.category;
                        ShopCategory sc = ShopCategory.find(category);
                        List<ShopCategory> sclist = ShopCategory.find(" AND father="+sc.father+" ORDER BY sequence",0,200);
                        List<ShopProductModel> spmlist =  ShopProductModel.find(" AND category = "+sc.category,0,20);

                        String selstr = "";
                            ShopProduct sp = ShopProduct.find(product_id);
                            ShopCategory sc1 = ShopCategory.find(sp.category);
                        selstr += (sc1.name[1]+spm.getModel());
                        /*selstr +="<select name='' onchange=''>";
                        if(sclist.size()>0){
                            for (int j = 0; j < sclist.size(); j++) {
                                ShopCategory sc1 = sclist.get(j);
                                selstr += ("<option  "+((sc1.category==sc.category?"selected='selected'":""))+">"+sc1.name[1]+"</option>");
                            }
                        }else{
                            selstr +=("<option value='' >暂无</option>");
                        }

                        selstr +="</select>";*/
                        /*selstr +="<select name=''>";
                        if(spmlist.size()>0){
                            for (int j = 0; j < spmlist.size(); j++) {
                                ShopProductModel spm1 = spmlist.get(j);

                                ShopProduct sp1 = ShopProduct.find(p.brand,spm1.getId());
                                selstr +=("<option  "+((spm1.getId()==p.model_id?"selected='selected'":""))+">"+spm1.getModel()+"</option>");
                            }
                        }else{
                            selstr +=("<option value='' >暂无</option>");
                        }
                        selstr +="</select>";*/

                        out.print("<td>"+selstr+"</td>");

                        out.print("<td><input name='quantity' class='quan'  value='1'  product='"+carstr+"' price='"+price+"' type='hidden' /><span style='font-size:13px;'>&yen;</span>"+price+"</td>");
                        //out.print("<td align='center' valign='middle' class='td_01'>");
                        //out.print("<a class='qsub' href='javascript:;' onClick='car.update(this,false)'>-</a><input name='quantity' class='quan'  value='"+arr[1]+"'  product='"+ps[i]+"' price='"+price+"' onChange='car.update(this)' /><a href='javascript:;' onClick='car.update(this,true)'>+</a></td>");
                        out.print("<td><a href='###' onClick=\"car.del(this,'"+tpslist.get(i)+"','"+(p.isExist?MT.f(p.name[h.language]):"[套装]"+MT.f(spage.getPackageName()))+"')\">删除</a></td>");
                        out.print("</tr>");

                    }

                %>
                <tr class='last '>
                    <td>备注：</td>
                    <td colspan='7'>
                        <input type='text' name="tpsbz" class='form-control w100'>
                    </td>
                </tr>
                </tbody>
            </table>
    </div>
    <%
                    }else{
                        %>
        <input type='hidden'  name="tpsbz" ><%
                    }


        if(sblist.size()>0){
    %>
    <div class="carttitle">
        <h1 class='table'>设备</h1>

            <table class="table table-hover mytab"  id="tab2" cellpadding="0" cellspacing="0">
                <thead>
                <tr>
                    <th style=''><label><input type="checkbox"  onclick="cheall(this,'tab2');" id="cheallNode"/>&nbsp;全选</label></th>
                    <th>商品图片</th>
                    <th>商品名称</th>
                    <th>商品单价</th>
                    <th>商品数量</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <%

                    for(int i=0;i<sblist.size();i++){
                        String[] arr=sblist.get(i).split("&");
                        //判断product_id是否商品的id，如果不是则为套装id
                        int product_id=Integer.parseInt(arr[0]);
                        int quantity=Integer.parseInt(arr[1]);//数量

                        String carstr = product_id+"&"+quantity+"&0";

                        ShopProduct p=ShopProduct.find(product_id);
                        ShopPackage spage = new ShopPackage(0);
                        List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
                        String pname = "";
                        float price = 0.0f;
                        int hosid = Integer.parseInt(h.getCook(p.product+"","0"));
                        //if(p.isExist){
                        pname=p.getAnchor(h.language);
                        Profile pf = Profile.find(h.member);
                        price = p.price;
                        //}
                        out.print("<tr class='"+(p.isExist?"proCar":"tzCar")+"' >");
                        out.print("<td style=''><input type='checkbox' name='proid' protype='1' product='"+product_id+"' value='"+carstr+"' onclick='car.update0(this,"+product_id+")'/>&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                        out.print("<td>");
                        if(p.isExist)
                            out.print(p.getAnchor('t'));
                        out.print("</td>");
                        out.print("<td>"+p.name[1]+"</td>");
                        ShopProductModel spm = ShopProductModel.find(p.model_id);

                        int category = p.category;
                        ShopCategory sc = ShopCategory.find(category);
                        List<ShopCategory> sclist = ShopCategory.find(" AND father="+sc.father+" ORDER BY sequence",0,200);
                        List<ShopProductModel> spmlist =  ShopProductModel.find(" AND category = "+sc.category,0,20);
//<input name='quantity' class='quan'  value='"+arr[1]+"'  product='"+product_id+"' price='"+price+"' type='hidden' />
                        out.print("<td><span style='font-size:13px;'>&yen;</span>"+price+"</td>");
                        //out.print("<td align='center' valign='middle' class='td_01'>");
                        out.print("<td class='are are3'><a  href='javascript:;' onClick='car.update(this,false)'>-</a><input name='quantity' class='quan'  value='"+arr[1]+"'  product='"+carstr+"' price='"+price+"' onChange='car.update(this)' /><a href='javascript:;' onClick='car.update(this,true)'>+</a></td>");
                        out.print("<td><a href='###' onClick=\"car.del(this,'"+carstr+"','"+(p.isExist?MT.f(p.name[h.language]):"[套装]"+MT.f(spage.getPackageName()))+"')\">删除</a></td>");
                        out.print("</tr>");

                    }

                %>
                <tr class='last '>
                    <td>备注：</td>
                    <td colspan='5'>
                        <input type='text' name="sbbz" class='form-control w100'>
                    </td>
                </tr>
                <%--
                <tr>
                    <td colspan="2" style='text-align:left;padding-left:15px'>
                                <span>
                                    <label>
                                        <input type="checkbox" onclick="cheall(this);car.update0(this);car.update1(this)"/>&nbsp;全选
                                    </label>
                                </span>
                        <span class='delepc'>
                                    <a href="javascript:delche()">删除选中的商品</a>
                                </span>
                        &lt;%&ndash;                                <span class='gobuy'>&ndash;%&gt;
                        &lt;%&ndash;                                    <a href="javascript:location='/'">继续购物</a>&ndash;%&gt;
                        &lt;%&ndash;                                </span>&ndash;%&gt;
                    </td>
                   &lt;%&ndash; <td colspan="2" align="right" class='textright' style='text-align:right;'>

                        <!-- 重量总计：<span id="gross">0.00</span>kg　原始金额：￥<span id="price">0.00</span>元  --><!-- - 返现：￥0.00元 -->
                        <!-- <br/> -->商品总金额：<b>&yen<span class="total1">0.00</span>元</b>
                    </td>&ndash;%&gt;
                    <td>
                        <input type="button" class='btn btn-default btn-lz butsub' value="去结算" onClick="<%= (flag?"alert('购物车里有下架商品不能提交！');":"checkCart()")%>"/>
                    </td>
                </tr>--%>
                </tbody>
            </table>
    </div>
    <%
            }else{
            %>
        <input  type="hidden" name="sbbz" class='form-control w100'>
        <%
            }

        %>
    </form>
        <div class='car-jsb'>
            <span>
                <label>
                    <input type="checkbox" onclick="cheall(this);car.update0(this)"/>&nbsp;全选
                </label>
            </span>
            <span class='delepc'>
                <a href="javascript:delche()">删除选中的商品</a>
            </span>
<%--            <span class='gobuy'>--%>
<%--                <a href="javascript:location='/'">继续购物</a>--%>
<%--            </span>--%>
            <span class=''>
                <a  onclick="car.clear()">清空购物车</a>
            </span>
            <!-- 重量总计：<span id="gross">0.00</span>kg　原始金额：￥<span id="price">0.00</span>元  --><!-- - 返现：￥0.00元 -->
            <!-- <br/> -->
            <p class='car-js'>结算总额：<b>&yen<span class="total0">0.00</span>元</b>
                <input type="button" class='btn btn-default btn-lz butsub' value="去结算" onClick="<%= (flag?"alert('购物车里有下架商品不能提交！');":"checkCart()")%>"/>
            </p>
    </div>

    <%


                }
            %>
            <script>
                fcar.nexturl.value=location.pathname+location.search;
                i/*f(fcar){
                    fcar.nexturl.value=location.pathname+location.search;
                }
                if(fcar1){
                    fcar1.nexturl.value=location.pathname+location.search;
                }*/

            </script>
        </div>
    </div>
    <div class="Mybottom"></div>
</div>
<script type="text/javascript">
    my.del=function(a,p,n)
    {
        mt.show(mt.res("确定要删除“{0}”吗？",n),2);
        mt.ok=function()
        {
            cookie.set('cart',cookie.get('cart').replace(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"),"|"));
            location.reload();
        };
    }

    function checkCart(){
        var protype0 = 0;
        var protype1 = 0;
        jQuery('input:checkbox[name=proid]:checked').each(function(i){
            if(jQuery(this).attr("protype")==0){
                protype0++;
            }
            if(jQuery(this).attr("protype")==1){
                protype1++;
            }
        });
        if((protype0+protype1)==0){
            mt.show("请选择商品提交！");
            return;
        }
        if(protype0>0&&protype1>0){
            mt.show("请选择同一种商品提交订单！");
            return;
        }
        mt.send("?act=checkCart",
            function(d){
                if(d==1){
                    //host 19090017
                    //test 19090241
                    var tpsbz = fcar.tpsbz.value;
                    var sbbz = fcar.sbbz.value;

                    parent.location='/html/folder/19092425-1.htm?sbbz='+sbbz+'&tpsbz='+tpsbz;
                }else{
                    mt.show(d);
                }
            }
        )
    }


    function showmes(){
        mt.show("对不起！您还未提交资质或已提交但审核未通过或资质已过期，不能去结算，请尽快提交您资质审核资料！<br/>如想尽快完成订，请致电：<b style='color:#FF7F00;font-size:16px'>010-68533123</b><p align='center'>我要提交 <a href='/html/folder/14110054-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>资质审核</a></p>");
    }
    function showuser(){
        mt.show("&nbsp;&nbsp;&nbsp;&nbsp;对不起！您还未登录，登陆后才可提交订单！<br/>"
            +"已是网站会员，点击 <a href='/html/folder/19061184-1.htm' target='_blank' style='font-weight:bold;font-size:14px;color:#0079D2'>登录</a>"
            +"&nbsp;&nbsp;还不是网站会员，点击 <a href='/html/folder/19061185-1.htm' target='_blank' style='font-weight:bold;font-size:14px;color:#0079D2'>注册</a>");
    }
    function showlz(){
        mt.show("粒子产品只能单独购买，每次只能购买一种活度的粒子，请检查购物车里的商品再去结算。");
    }

    function cheall(obj,name){
        var chearr;
        if(name){
            chearr = jQuery("#"+name).find("input");
        }else{
            chearr = jQuery(".mytab").find("input");
        }

        obj.className=obj.checked?"checked":"checkbox";

        //var chearr = jQuery("#"+name).find("input");
        //var chearr = document.getElementsByTagName("INPUT");
        for(var i=0;i<chearr.length;i++){
            if(chearr[i].type=='checkbox'){
                chearr[i].checked = obj.checked;
                if(jQuery(chearr[i]).attr("product")){
                    car.update0(obj,jQuery(chearr[i]).attr("product"));
                }
            }

        }

    }
    function delche(){
        var chearr = document.getElementsByName("proid");
        var delflag = false;
        for(var i=0;i<chearr.length;i++){
            if(chearr[i].checked){
                delflag = true;
                break;
            }
        }
        if(delflag){
            mt.show("确定从购物车中删除所有选中商品？",2);
            mt.ok=function()
            {
                for(var i=0;i<chearr.length;i++){
                    if(chearr[i].checked){
                        var p = chearr[i].value;
                        cookie.set('cart',cookie.get('cart').replace(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"),"|"));
                    }
                }
                location.reload();
            }
        }else{
            mt.show("请选择商品！");
        }
    }

    var cheallNode = document.getElementById("cheallNode");
    //cheallNode.checked=true;
    cheall(cheallNode);
    car.update0(cheallNode);
    //car.update1(cheallNode);
    //car.update(null);
</script>
<script>
    mt.fit();
</script>
<%-- <%=s.footer%> --%>
</body>
</html>
