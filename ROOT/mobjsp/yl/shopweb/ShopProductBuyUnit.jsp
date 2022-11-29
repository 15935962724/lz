<%@page import="util.Config" %>
<%@page import="tea.ui.yl.shop.ShopIntegralRuless" %>
<%@page import="tea.entity.member.Profile" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        String param = request.getQueryString();
        String url = request.getRequestURI();
        if (param != null)
            url = url + "?" + param;
        response.sendRedirect("/mobjsp/yl/user/login_mobile.html?nexturl=" + Http.enc(url));
        return;
    }
    //产品标识，由上一页
    int category = h.getInt("category");
    int product = h.getInt("product", 0);
    int hosid = h.getInt("hosid", 0);
    int pusid = h.getInt("pusid", 0);

    ShopProduct shopProduct = ShopProduct.find(product);
    ShopCategory sc = ShopCategory.find(category);
    if (product == 0) {
        ArrayList list = ShopProduct.find(" AND category=" + category + " AND state=0 ", 0, 1);
        if (list.size() > 0) {
            shopProduct = (ShopProduct) list.get(0);
        }
    }

    //购物车中商品数量
    int carSum = 0;
    String[] ps = h.getCook("cart", "|").split("[|]");

    if (ps.length > 0) {
        for (int i = 1; i < ps.length; i++) {
            String[] arr = ps[i].split("&");

            int quantity = Integer.parseInt(arr[1]);//数量
            carSum += quantity;
        }
    }
    boolean isinterval = false;
    //List<ProcurementUnitJoin> pujlist = ProcurementUnitJoin.find(" AND profile = " + h.member, 0, Integer.MAX_VALUE);
    //获取用户信息
    Profile profile = Profile.find(h.member);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
    <%--	<title><%= MT.f(shopProduct.name[1])%></title>--%>
    <title>碘[I-125]密封籽源</title>
    <link rel="stylesheet" href="/mobjsp/yl/css/common.css">
    <link rel="stylesheet" href="/mobjsp/yl/css/swiper.min.css">
    <script src="/mobjsp/yl/js//swiper.min.js"></script>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/tea/view.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.7.js'></script>
    <script src="/mobjsp/yl/js/jquery.Spinner.js"></script>
    <script>
        $(function () {
            $(".Spinner").Spinner({value: "1", min: 1, len: 3, max: "1000"});
        });
    </script>
    <style>
        body {
            background: #eef4fb;
        }

        input.gm-inp {
            border-radius: 0;
            width:100%;
            margin:0;
        }
    .detail02 span.sp1{color:#333;}
        input[type=button], input[type=submit], input[type=text], input[type=file], button {
            cursor: pointer;
            -webkit-appearance: none;
        }
        .detail02{background:#fff;margin-top:10px;}
    </style>
</head>
<body>
<form action="" name='form1'>
    <input id="category" name='category' value='<%= category %>' type="hidden"/>
    <input id="product" name='product' value='<%= product %>' type="hidden"/>
    <input name='attribute' value='<%= MT.f(sc.attribute) %>' type="hidden"/>
    <input id='productstockcount' name='productstockcount' value='0' type="hidden"/>
    <%--会员类型--%>
    <input type="hidden" id="perce" value="<%=profile.membertype==2?"0.03":"0.01" %>">
    <%--是否是君安--%>
    <input type="hidden" id="junan" value="<%=Config.getInt("junan")==shopProduct.puid?1:0 %>">
    <%--医院id--%>
    <input type="hidden" id="hosid" value="<%= hosid %>">
    <%--厂商id--%>
    <input type="hidden" id="pusid" value="<%= pusid %>">

    <div id="Body">
            <%
		String imgstr = "http://www.brachysolution.com/res/Home/structure/19061406.png";
		String[] arr=shopProduct.picture.split("[|]");
	for(int i=1;i<arr.length;i++)
	{
	  Attch a=Attch.find(Integer.parseInt(arr[i]));
		if(i==1){
			imgstr = a.path;
		}
		}
%>
        <div id="Content">
            <div class="detail01 flex">
                <span class="pic flex">
                    <img src="<%= imgstr%>"/>
                </span>
                <span class="nr flex">
                    <span class="tit"><%= shopProduct.name[1]%></span>
                    <span class="version"><em>商品编号</em><%=MT.f(shopProduct.yucode)%></span>
				<%

                    float price = shopProduct.price;

                    if (profile.membertype == 2) {//代理商价格
                        ShopPriceSet sps = ShopPriceSet.find(hosid, product, 0);
                        if (sps.agentPrice > 0) {
                            price = sps.price;
                        }
                    }

                    if (profile.membertype != 2) {//不是代理商
                        if (product > 0) {
                            ArrayList alist = ShopIntegralRules.find(" and item=0", 0, 1);
                            if (alist.size() > 0) {
                                int integral = ((ShopIntegralRules) alist.get(0)).getIntegral();
                                if (integral > 0 && category == ShopCategory.getCategory("lzCategory")) {
                                    out.print("<span class=\"version\"><em>商品积分</em>" + (int) price / integral + "</span>");
                                }
                            }
                        }
                    }

                    out.println("<span class='tit' style='margin:0.2rem 0rem;color:#df6c0a'>￥" + price + "</span>");

                %>
                </span>
            </div>

            <div class="detail02 flex">
                <div class="p flex">
                    <span class="sp1">选择医院</span>
                    <select onchange='changehos(this)' class='hosids' name='hosid' id="hosids">
                        <option value='0'>请选择医院</option>
                    </select>
                </div>
                <div class="p flex">
                    <span class="sp1">厂　　商</span>
                    <select class='pusids' onchange='changepus(this)' name='pusid' id="pusids">
                        <option value='0'>请选择厂商</option>
                    </select>
                </div>
                <div class="p flex">
                    <span class="sp1">粒子活度</span>
                    <div class='huod' id="huod">
                        <i style="line-height: 0.66rem;font-style: normal;">暂无规格</i>
                    </div>

                    <%
                        double activityMinmy = 0;
                        double activityMaxmy = 0;
                        if (shopProduct.product > 0) {
                            boolean isLiziClazz = false;
                            if (shopProduct.category == ShopCategory.getCategory("lzCategory")) {
                                isLiziClazz = true;
                            }
                            if (isLiziClazz) {
                                int actcheck = 0;
                                StringBuffer caliBuff = new StringBuffer("");
                                if (shopProduct.model_id > 0) {
                                    ShopProductModel spm = ShopProductModel.find(shopProduct.model_id);
                                    String activityStr = spm.getModel().replaceAll("[a-zA-Z]", "");
                                    if (activityStr.indexOf("-") != -1) {
                                        String[] activityArr = activityStr.split("-");
                                        Double activityMin = Double.parseDouble(activityArr[0]);
                                        Double activityMax = Double.parseDouble(activityArr[1]);
                                        activityMinmy = activityMin;
                                        activityMaxmy = activityMax;
                                        isinterval = true;
                                        if (Config.getInt("junan") == shopProduct.puid) {
                                            actcheck = 1;
                                            caliBuff.append("</div><div class='shopProduct flex' style='margin-top: -0.15rem;'><span class='sp1'></span><input type='text' alt='粒子活度' placeholder='请输入粒子活度(范围" + activityStr + ")' title='粒子活度范围：" + activityStr + "' style='width:140px;border:1px solid #dcdcdc;' class='activity' name='activity' value='' onkeyup=\"keyupActivity(this)\" onblur=\"blurActivity(this," + activityMin + "," + activityMax + ")\" /></div>");
                                            //caliBuff.append("粒子活度：<input alt='粒子活度' title='粒子活度范围："+activityStr+"' style='width:140px;height:30px;border:1px solid #cacaca;' class='activity' name='activity' value='' onkeyup=\"keyupActivity(this)\" onblur=\"blurActivity(this,"+activityMin+","+activityMax+")\" />");
                                        } else {
                                            caliBuff.append("</div><input class='activity' name='activity' type='hidden' value='0' />");
                                        }
                                    } else {
                                        caliBuff.append("</div><input class='activity' name='activity' type='hidden' value='0' />");
                                    }
                                }
                                caliBuff.append("<input name='actcheck' value='" + actcheck + "' type='hidden' />");
                                out.println(caliBuff.toString());
                            }
                        }
                    %>
                    <%--</div>--%>
                    <%
                        //if (Config.getInt("junan") == shopProduct.puid) {
                            //out.print("<div class='shopProduct flex'><span class='sp1'>库存数量</span><span class='sp1 productstockcount'>暂无</span></div>");
                        //}
                        //选择商品
                        if (product > 0) {
                            //商品数量
                            %>
                            <div class="p flex">
                                <span class="sp1">购买数量</span>
                                <a href='###' onclick='numDec()' class='detail02-j'>-</a>
                                <input type='text' class='detail02-inp' name='quantity' id='quantity' value='1'
                                       onblur='keyup()'/>
                                <a href='###' onclick='numAdd()' class='detail02-j'>+</a>
                            </div>
                            <%
                        }
                    %>
                </div>
    <div style='height:10px;width:100%;background:#eef4fb;'></div>

                <div class="detail04 flex" style='border:none;'>
                    <input type="button" class="gm-inp"
                           onclick="<%= (profile.membertype==0?"mt.show('由于粒子产品的特殊性，普通用户无法购买，请申请成为医生用户或服务商用户进行购买！');":"addcar('"+product+"')")%>"
                           value="立即购买"/>
                </div>
                <input type="hidden" id="isinterval" value="<%=isinterval%>">
                <input type="hidden" id="activityMinmy" value="<%=activityMinmy%>">
                <input type="hidden" id="activityMaxmy" value="<%=activityMaxmy%>">
            </div>

        </div>
</form>
<script>
    mt.fit();
    $(function () {
        //初始化时获取用户下所有医院
        initshow();
    })
    //医院联动
    function changehos(obj) {
        var hosid = $("#hosids").val();
        //根据hosid查所有厂商并迭代到厂商select中
        initpus(hosid, 0);
    }
    //厂商联动
    function changepus(obj) {
        var pusid = $("#pusids").val();
        //根据厂商查所有粒子活度并迭代到活度select中
        findproduct(pusid, 0);
    }
    //加载所有医院，厂商，产品等 信息
    function initshow() {
        var pusid = $("#pusid").val();
        var hosid = $("#hosid").val()
        var product = $("#product").val();

        //页面初始化时加载
        if (product == '0') {
            //初始化 该用户下所有的医院
            inithos();
        } else {//有医院id，厂商id，产品id
            //如果hosid存在，回显医院
            inithos(hosid);
            //获取所有厂商
            initpus(hosid, pusid);
            //获取产品活度
            findproduct(pusid,product);
        }
    }
    //初始化时获取用户下所有医院
    function inithos(hosid) {
        mt.send("/ShopHospitals.do?act=findhosids", function (data) {
            data = eval('(' + data + ')');
            //type=0 返回成功
            if (data.type == 0) {
                var ops = "<option value=0>请选择</option>";
                if (data.data_list != '') {//是否存在数据
                    for (var i = 0; i < data.data_list.length; i++) {
                        var proObj = data.data_list[i];
                        ops += "<option " + (hosid == proObj.obj.id ? "selected='selected'" : "") + " value='" + proObj.obj.id + "'>" + proObj.obj.name + "</option>";
                    }
                }
                $("#hosids").html(ops);
            } else {
                mtDiag.close();
                mtDiag.show(data.mes);
            }
        });
    }

    //获取所有厂商
    function initpus(hosid, pusid) {
        mt.send("/ShopHospitals.do?act=findpusids&hosid=" + hosid, function (data) {
            data = eval('(' + data + ')');
            if (data.type == 0) {
                var ops = "<option value=0>请选择</option>";
                if (data.data_list != '') {//是否存在数据
                    for (var i = 0; i < data.data_list.length; i++) {
                        var proObj = data.data_list[i];
                        ops += "<option " + (pusid == proObj.obj.puid ? "selected='selected'" : "") + " value='" + proObj.obj.puid + "'>" + proObj.obj.name + "</option>";
                    }
                }
                $("#pusids").html(ops);
            } else {
                mtDiag.close();
                mtDiag.show(data.mes);
            }
        });
    }

    //获取产品活度列表信息
    function findproduct(pusid, productid) {
        mt.send("/ShopHospitals.do?act=findproduct&pusid=" + pusid + "&category=" + form1.category.value, function (data) {
            data = eval('(' + data + ')');
            if (data.type == 0) {
                var ops = "<em class='flex'>";
                if (data.data_list != '') {//是否存在数据
                    for (var i = 0; i < data.data_list.length; i++) {
                        var proObj = data.data_list[i];
                        ops += "<i " + (productid == proObj.product ? "class='bgred'" : "") + " ><a style='display:inline-block;width:100%;'  onclick=findproductdes('" + proObj.product + "') target='_parent'>" + proObj.model + "</a></i>";
                    }
                }else{
                    ops = "<i>暂无规格</i>";
                }

                ops = ops + "</em>";
                $("#huod").html(ops);
            } else {
                mtDiag.close();
                mtDiag.show(data.mes);
            }
        });
    }

    //选完粒子活度后跳转
    function findproductdes(proid) {
        location = '/mobjsp/yl/shopweb/ShopProductBuyUnit.jsp?product=' + proid + "&hosid=" + $("#hosids").val() + "&pusid=" + $("#pusids").val() + "&category=" + $("#category").val();
    }

    /*商品数量框输入*/
    function keyup() {
        var quantity = $("#quantity").val();
        var re = /^[1-9]+[0-9]*]*$/;
        if (!re.test(quantity)) {
            //如果输入的不是数字
            $("#quantity").val(1);
            mt.show("请您输入正确的商品数量！");
        }
        if (quantity >2000) {
            $("#quantity").val(2000);
            mt.show("商品数量不能大于2000");
        }
    }
    /*商品数量+1*/
    function numAdd() {
        var quantity = $("#quantity").val();
        var num_add = parseInt(quantity) + 1;
        if (quantity == "") {
            num_add = 1;
        }
        if (num_add > 2000) {
            $("#quantity").val(num_add - 1);
            mt.show("商品数量不能大于2000");
        } else {
            $("#quantity").val(num_add);
        }
    }

    /*商品数量-1*/
    function numDec() {
        var quantity = $("#quantity").val();
        var num_dec = parseInt(quantity) - 1;
        if (num_dec > 0) {
            $("#quantity").val(num_dec);
        }
    }

    //购买产品
    function addcar(product) {
        var hosids = $("#hosids").val();
        var pusids = $("#pusids").val();

        if (hosids == 0) {
            mt.show("请选择医院！");
            return;
        }
        if (pusids == 0) {
            mt.show("请选择厂商！");
            return;
        }
        //点击立即购买事件
        mysub();
    }

    //点击立即购买事件
    function mysub() {
        //最大最小活度
        var activityMinmy = $("#activityMinmy").val();
        var activityMaxmy = $("#activityMaxmy").val();

        if ($("#isinterval").val()=='true') {
            //请选择购买活度
            if (form1.activity.value == '') {
                mt.show("请输入购买活度!");
                return;
            }
            //粒子活度输入框
            var activity = jQuery(".activity")[0];
            if (form1.actcheck.value == 1) {
                if (activity.value != '' && (activity.value < activityMinmy || activity.value > activityMaxmy)) {
                    mt.show("活度超出范围 " + activityMinmy + "-" + activityMaxmy + "！");
                    //根据活度区间查询区间数量
                    findProductStockCount();
                    return;
                }
            }
        }else {
            mt.show("请选择购买活度!");
            return;
        }
        //跳转到下单页
         location = "/mobjsp/yl/shopweb/ShopOrderFormUnit.jsp?product=" + form1.product.value + "&hosid=" + form1.hosids.value + "&quantity=" + form1.quantity.value + "&activity=" + form1.activity.value;
    }
    //厂商为junan 订单页的粒子活度
    function blurActivity(obj, activityMin, activityMax) {
        if (form1.actcheck.value == 1) {
            if (obj.value != '' && (obj.value < activityMin || obj.value > activityMax)) {
                mt.show("活度超出范围 " + activityMin + "-" + activityMax + "！");
                obj.value = activityMin;
                //根据活度区间查询区间数量
                findProductStockCount();
            }
        }
    }

    //厂商为junan 订单页粒子活度 验证
    function keyupActivity(obj) {
        obj.value = obj.value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
        obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是
        obj.value = obj.value.replace(/^[2-9]/g, ""); //验证第一个字符是数字而不是
        obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
        //根据活度区间查询区间数量
        findProductStockCount();
    }

    //根据活度区间查询区间数量
    function findProductStockCount() {
        if ($("#junan").val() == 1) {
            mt.send("/ProductStocks.do?act=findProductStockCount&activity=" + form1.activity.value + "&perce=" + $("#perce").val(), function (data) {
                data = eval('(' + data + ')');
                if (data.type == 0) {
                    $("#productstockcount").val(data.count);
                } else {
                    mtDiag.close();
                    mtDiag.show(data.mes);
                    return;
                }
            });
        }
    }
</script>
</body>
</html>