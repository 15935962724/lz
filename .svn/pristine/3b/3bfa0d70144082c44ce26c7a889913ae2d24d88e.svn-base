<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Http h = new Http(request, response);
    if (h.member < 1) {
//response.sendRedirect("/servlet/StartLogin?community="+h.community);
        out.print("<script>parent.location='" + "/servlet/StartLogin?community=" + h.community + "';</script>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/res/lizi/css/bootstrap.css">
    <link rel="stylesheet" href="/res/lizi/css/animate.css">
    <link rel="stylesheet" href="/res/lizi/css/style1.css">
    <link rel="stylesheet" href="/res/lizi/css/common.css">
    <script src='/tea/mt.js'></script>
    <script src="/res/lizi/js/jquery-1.11.3.min.js"></script>
    <script src="/res/lizi/js/bootstrap.min.js"></script>

</head>
<body>
<!-- <div id="Header" class="animate-box" data-animate-effect="fadeInLeft"></div> -->
<div class="container-fluid banner animate-box" data-animate-effect="fadeInLeft">
    <div class="row">
        <div class="col-md-12 animate-box" data-animate-effect="fadeInLeft">
            <%--<a class="btn btn-primary" href="/html/folder/19092171-1.htm" role="button">医生申请</a> 正式--%>
            <%--<a class="btn btn-primary" href="/html/folder/19092172-1.htm" role="button">服务商申请</a>--%>
                <%--<a class="btn btn-primary" href="/html/folder/19092171-1.htm" role="button">医生申请</a>
            <a class="btn btn-primary" href="/html/folder/19092172-1.htm" role="button">服务商申请</a>--%>
            <%
                int member = h.member;
                List<UpProfile> list = UpProfile.find("AND isdele=0 and profile=" + member, 0, Integer.MAX_VALUE);
                int type = 3;
                if (list.size() > 0) {//已经提交过了只展示提交过得那个
                    UpProfile up = list.get(0);
                    type = up.getUptype();//1是医生0是服务商

                }
                if (Profile.find(h.member).getMembertype() == 1) {//   /html/folder/19082256-1.htm 申请页面测试

            %>
            <a class="btn btn-primary" onclick="mt.show('您已经是医生，不能再申请医生')" role="button">医生申请</a>
            <a class="btn btn-primary" onclick="mt.show('您已经是医生，不能再申请服务商')" role="button">服务商申请</a>
                <%}else if(Profile.find(h.member).getMembertype() == 2){%>
            <a class="btn btn-primary" onclick="mt.show('您已经是服务商，不能再申请医生')" role="button">医生申请</a>
            <a class="btn btn-primary" onclick="mt.show('您已经是服务商，不能再申请服务商')" role="button">服务商申请</a>
                <%} else {if (type == 3) {%>
            <a class="btn btn-primary" href="/html/folder/19092171-1.htm" role="button">医生申请</a>
            <a class="btn btn-primary" href="/html/folder/19092172-1.htm" role="button">服务商申请</a>
            <%} else if (type == 0) {%>
            <a class="btn btn-primary" onclick="mt.show('您已经申请服务商，不能再申请医生')" role="button">医生申请</a>
            <a class="btn btn-primary" href="/html/folder/19092172-1.htm" role="button">服务商申请</a>
            <%} else if (type == 1) {%>
            <a class="btn btn-primary" href="/html/folder/19092171-1.htm" role="button">医生申请</a>
            <a class="btn btn-primary" onclick="mt.show('您已经申请医生，不能再申请服务商')" role="button">服务商申请</a>
            <%
                }}
            %>


        </div>
    </div>
</div>

<div class="container con01 animate-box sq" data-animate-effect="fadeInLeft">
    <div class="row">
        <div class="col-md-12 animate-box" data-animate-effect="fadeInLeft" style="min-width: 1200px;">
            <span class="animate-box" data-animate-effect="fadeInLeft"><em>①</em> 注册账户</span>
            <span class="animate-box" data-animate-effect="fadeInLeft"><em>②</em> 提交申请</span>
            <span class="animate-box" data-animate-effect="fadeInLeft"><em>③</em> 资质审核</span>
            <span class="last animate-box" data-animate-effect="fadeInLeft"><em>④</em> 完成</span>
        </div>
    </div>
</div>

<div class="container con02" style="padding:0">
    <div class="row">
        <div class="col-md-12" style="min-width: 1200px;">
            <h1 class="nav nav-tabs sq-tab animate-box" data-animate-effect="fadeInLeft" role="tablist">
                <em class="col-md-3"></em>
                <span role="presentation" class="col-md-3 active"><a href="#profile" aria-controls="profile" role="tab"
                                                                     data-toggle="tab">医生</a></span>
                <span role="presentation" class=" col-md-3"><a href="#home" aria-controls="home" role="tab"
                                                               data-toggle="tab">服务商</a></span>
                <em class="col-md-3"></em>

            </h1>

        </div>
    </div>
</div>
<div>
    <div class="tab-content animate-box" data-animate-effect="fadeInLeft">
        <div class="sq-box1 sq-box2">
            <div class="container con02">
                <div class="row">
                    <p class="sq-r">入驻权益</p>
                    <div role="tabpanel" style="overflow: hidden;background: #fff;margin-bottom:35px;height:341px;"
                         class="tab-pane active animate-box" data-animate-effect="fadeInLeft" id="home">
                        <div class="col-md-4 box animate-box" data-animate-effect="fadeInLeft">
                            <div class="addo-feature">
                                <p><img src="/tea/yl/img/list011.png"/></p>
                                <h3>三大品牌支持</h3>
                                <p class="sq-pp">平台下属原子高科、宁波君安、上海欣科三大碘[<sup>125</sup>I]密封籽源品牌，为vip用户提供更多选择。</p>
                            </div>
                        </div>
                        <div class="col-md-4 box animate-box" data-animate-effect="fadeInLeft">
                            <div class="addo-feature">
                                <p><img src="/tea/yl/img/list051.png"/></p>
                                <h3>积分权益</h3>
                                <p class="sq-pp">VIP用户享有专属积分权益，积分可兑换相关服务。</p>
                            </div>
                        </div>
                        <div class="col-md-4 box animate-box" data-animate-effect="fadeInLeft">
                            <div class="addo-feature">
                                <p><img src="/tea/yl/img/list031.png"/></p>
                                <h3>全新服务体验</h3>
                                <p class="sq-pp">以“源于客户、服务用户”为理念，为vip用户提供“一站式”解决方案和计划。</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="background: #f5f7fe;padding-top:34px;padding-bottom:100px;">
                <div class="container con02" style="padding:0">
                    <div class="row">
                        <p class="sq-r">入驻要求</p>
                        <div class="container-fluid con03 con02 animate-box" data-animate-effect="fadeInLeft"
                             style="padding:0">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tab-content animate-box" data-animate-effect="fadeInLeft">
                                        <div role="tabpanel" class="tab-pane active animate-box"
                                             data-animate-effect="fadeInLeft" id="pro">
                                            <div role="tabpanel" class="tab-pane animate-box"
                                                 data-animate-effect="fadeInLeft" id="vip">
                                                <div class="pane">
                                                    <p>1. 符合国家相关法律、法规规定</p>
                                                    <p>2. 具有开展碘[<sup>125</sup>I]密封籽源项目的相关资质</p>
                                                    <p>3. 接受平台的相关管理制度和规则。</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="sq-box1" style="display:none">
            <div class="container con02">
                <div class="row">
                    <p class="sq-r">入驻权益</p>
                    <div role="tabpanel" style="overflow: hidden;background: #fff;margin-bottom:35px;height:341px"
                         class="tab-pane active animate-box" data-animate-effect="fadeInLeft" id="home">
                        <div class="col-md-3 box animate-box" data-animate-effect="fadeInLeft">
                            <div class="addo-feature">
                                <p><img src="/tea/yl/img/list011.png"/></p>
                                <h3>三大品牌支持</h3>
                                <p class="sq-pp">平台下属原子高科、宁波君安、上海欣科三大碘[<sup>125</sup>I]密封籽源品牌，为服务商提供更多选择。</p>
                            </div>
                        </div>
                        <div class="col-md-3 box animate-box" data-animate-effect="fadeInLeft">
                            <div class="addo-feature">
                                <p><img src="/tea/yl/img/list021.png"/></p>
                                <h3>打造品牌营销体系</h3>
                                <p class="sq-pp">依托中国同辐股份有限公司在核技术应用领域的影响力，通过多样化的品牌营销手段，助力服务商开拓市场，打造整体品牌营销体系。</p>
                            </div>
                        </div>
                        <div class="col-md-3 box animate-box" data-animate-effect="fadeInLeft">
                            <div class="addo-feature">
                                <p><img src="/tea/yl/img/list031.png"/></p>
                                <h3>专业技术支持</h3>
                                <p class="sq-pp">提供专业的技术人员为服务商及所在区域的客户进行培训，指导。</p>
                            </div>
                        </div>
                        <div class="col-md-3 box animate-box" data-animate-effect="fadeInLeft">
                            <div class="addo-feature">
                                <p><img src="/tea/yl/img/list041.png"/></p>
                                <h3>全新体验升级</h3>
                                <p class="sq-pp">平台以“源于客户、服务用户”为理念，为服务商提供一站式服务升级体验。</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="background: #f5f7fe;padding-top:34px;padding-bottom:100px;">
                <div class="container con02" style="padding:0">
                    <div class="row">
                        <p class="sq-r">入驻要求</p>
                        <div class="container-fluid con03 con02 animate-box" data-animate-effect="fadeInLeft"
                             style="padding:0">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tab-content animate-box" data-animate-effect="fadeInLeft">
                                        <div role="tabpanel" class="tab-pane active animate-box"
                                             data-animate-effect="fadeInLeft" id="pro">
                                            <div class="pane">
                                                <p>1. 符合国家相关法律、法规规定，拥有正规的公司资质。</p>
                                                <p>2. 具有一定的客户资源和相关产品市场推广服务经验。</p>
                                                <p>3. 接受并签署平台的技术服务协议，并按照协议相关约束的条款开展业务合作。</p>
                                                <p>4. 接受平台市场管理制度的相关规定，并严格按照市场管理制度开展业务合作。</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    mt.fit();

    $("h1.nav span").click(function () {
        $(this).addClass("active").siblings("span").removeClass("active");
        var a1 = $(this).index() - 1;
        console.log(a1);
        $('.sq-box1').eq(a1).show().siblings("div").hide();
    });
    mt.fit();
</script>
<!-- <script src="js/jquery.waypoints.min.js"></script>
<script src="js/main.js"></script> -->
</body>
</html>