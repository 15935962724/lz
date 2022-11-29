<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.Http"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.db.DbAdapter" %>
<!DOCTYPE html>
<%
    Http h=new Http(request,response);
   /* if(h.member<1)
    {
        String param = request.getQueryString();
        String url = request.getRequestURI();
        if(param != null)
            url = url + "?" + param;
        response.sendRedirect("/mobjsp/yl/user/login_wx.jsp?nexturl="+url);
        //response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }*/
    Profile p1 = Profile.find(h.member);
    String openid=h.getCook("openid",null);
    if(openid==null){
        response.sendRedirect("/PhoneProjectReport.do?act=openid&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()+"&r="+Math.random()));
        return;
    }
    //out.print("<script>alert('"+openid+"');</script>");
    List<Profile> lstp= Profile.find1(" and openid="+ DbAdapter.cite(openid), 0, 1);
    if(lstp.size()==0){
        String param = request.getQueryString();
        String url = request.getRequestURI();
        if(param != null)
            url = url + "?" + param;
        response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
        return;
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>申请升级</title>
    <link rel="stylesheet" href="/mobjsp/yl/css/m-style.css">
    <link rel="stylesheet" href="/mobjsp/yl/css/xj-style.css">
    <script src='/tea/mt.js'></script>
    <script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
</head>
<body>
    <div class="body">
<%--        <div class="Header">--%>
<%--            <p class="header-tit ft18">--%>
<%--                <img src="../img/icon1.png" alt="" class="fl-left m-head-logo">--%>
<%--                <span>个人中心</span>--%>
<%--                <img src="../img/icon2.png" alt="" class="head-list fl-right">--%>
<%--            </p>--%>
<%--        </div>--%>
<%--        <!-- 下拉 -->--%>
<%--        <div class="head-dh-list">--%>
<%--            <h3 class="bor-b ft16">首页</h3>--%>
<%--            <h3 class="bor-b ft16 head-dh-y">--%>
<%--                解决方案--%>
<%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--            </h3>--%>
<%--            <ul>--%>
<%--                <li class="ft16">近距离治疗药物</li>--%>
<%--                <li class="ft16 head-ys-li">碘[<sup>125</sup>I]</li>--%>
<%--                <li class="ft16 head-ys-li">钯[<sup>103</sup>Pd]</li>--%>
<%--                <li class="ft16 head-ys-li">铱[<sup>90</sup>Y]</li>--%>
<%--                <li class="ft16 head-ys-li">铯[<sup>131</sup>Cs]</li>--%>

<%--                <li class="ft16">治疗计划系统TPS</li>--%>
<%--                <li class="ft16">植入设备/器械</li>--%>
<%--                <li class="ft16 head-ys-li">粒子植入设备与器械</li>--%>
<%--                <li class="ft16 head-ys-li">计划导航系统</li>--%>
<%--                <li class="ft16 head-ys-li">辐射检测与防护</li>--%>
<%--                <li class="ft16">手术支持服务</li>--%>
<%--                <li class="ft16 head-ys-li"> 前列腺设备支持服务</li>--%>
<%--                <li class="ft16 head-ys-li">远程计划系统服务</li>--%>
<%--            </ul>--%>
<%--            <h3 class="bor-b ft16">--%>
<%--                产品--%>
<%--            </h3>--%>
<%--            <h3 class="bor-b ft16 head-dh-y">--%>
<%--                患者--%>
<%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--            </h3>--%>
<%--            <ul>--%>
<%--                <li class="ft16">粒子治疗简介</li>--%>
<%--                <li class="ft16 head-ys-li">治疗部位</li>--%>
<%--                <li class="ft16 head-ys-li">适应症</li>--%>
<%--                <li class="ft16 head-ys-li">禁忌症</li>--%>
<%--                <li class="ft16">患者指南</li>--%>
<%--                <li class="ft16 head-ys-li">专业术语</li>--%>
<%--                <li class="ft16 head-ys-li">常见问题</li>--%>
<%--                <li class="ft16 head-ys-li">病患防护</li>--%>
<%--                <li class="ft16">招募计划</li>--%>
<%--            </ul>--%>
<%--            <h3 class="bor-b ft16 head-dh-y">--%>
<%--                医生--%>
<%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--            </h3>--%>
<%--            <ul>--%>
<%--                <li class="ft16">政策法规</li>--%>
<%--                <li class="ft16">医院资质</li>--%>
<%--                <li class="ft16">临床资料</li>--%>
<%--                <li class="ft16 head-ys-li">PPT</li>--%>
<%--                <li class="ft16 head-ys-li">文献</li>--%>
<%--                <li class="ft16 head-ys-li">视频</li>--%>
<%--                <li class="ft16">放射性同位素手册</li>--%>
<%--                <li class="ft16">病患防护</li>--%>
<%--            </ul>--%>
<%--            <h3 class="bor-b ft16 head-dh-y">--%>
<%--                活动资讯--%>
<%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--            </h3>--%>
<%--            <ul>--%>
<%--                <li class="ft16">行业新闻</li>--%>
<%--                <li class="ft16">会议活动</li>--%>
<%--            </ul>--%>
<%--            <h3 class="bor-b ft16 head-dh-y">--%>
<%--                关于--%>
<%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--            </h3>--%>
<%--            <ul>--%>
<%--                <li class="ft16">公司介绍</li>--%>
<%--                <li class="ft16">联系我们</li>--%>
<%--            </ul>--%>
<%--        </div>--%>
        <div class="Content">
            <div class="h_process">
                <img src="../img/banner2.jpg" alt="">
                <div class="h_process_but">
                    <%
                        int member = h.member;
                        List<UpProfile> list = UpProfile.find("AND isdele=0 and profile=" + member, 0, Integer.MAX_VALUE);
                        int type = 3;
                        if (list.size() > 0) {//已经提交过了只展示提交过得那个
                            UpProfile up = list.get(0);
                            type = up.getUptype();//1是医生0是服务商

                        }
                        if (Profile.find(h.member).getMembertype() == 1) {%>
                    <a class="btn btn-primary" onclick="mt.show('您已经是医生，不能再申请医生')" role="button">医生申请</a>
                    <a class="btn btn-primary" onclick="mt.show('您已经是医生，不能再申请服务商')" role="button">服务商申请</a>
                    <%}else if(Profile.find(h.member).getMembertype() == 2){%>
                    <a class="btn btn-primary" onclick="mt.show('您已经是服务商，不能再申请医生')" role="button">医生申请</a>
                    <a class="btn btn-primary" onclick="mt.show('您已经是服务商，不能再申请服务商')" role="button">服务商申请</a>
                    <%} else{ if (type == 3) {%>
                    <a href="/mobjsp/yl/shopweb/VIPapply.jsp" class="ft14" >医生申请</a>
                    <a href="/mobjsp/yl/shopweb/SPapply.jsp" class="ft14" >服务商申请</a>
                    <%} else if (type == 0) {%>
                    <a onclick="mt.show('您已经申请成为服务商，不能再申请医生')" class="ft16" >医生申请</a>
                    <a href="/mobjsp/yl/shopweb/SPapply.jsp" class="ft14" >服务商申请</a>
                    <%} else if (type == 1) {%>
                    <a href="/mobjsp/yl/shopweb/VIPapply.jsp" class="ft14" >医生申请</a>
                    <a onclick="mt.show('您已经申请成为医生，不能再申请服务商')" class="ft14" >服务商申请</a>
                    <%
                        }}
                    %>

                </div>
                <div class="h_process_gc">
                    <div class="h_process_gc_fl">
                        <img src="../img/①.png" alt="">
                        <span class="ft12">注册账户</span>
                    </div>
                    <span class="h_process_gc_span"></span>
                    <div class="h_process_gc_fl">
                        <img src="../img/②.png" alt="">
                        <span class="ft12">提交申请</span>
                    </div>
                    <span class="h_process_gc_span"></span>
                    <div class="h_process_gc_fl">
                        <img src="../img/③.png" alt="">
                        <span class="ft12">资质审核</span>
                    </div>
                    <span class="h_process_gc_span"></span>
                    <div class="h_process_gc_fl">
                        <img src="../img/④.png" alt="">
                        <span class="ft12">完成</span>
                    </div>
                </div>
            </div>
            <div class="tab_per">
                <div class="tab_per_tit">
                    <span class="tab_per_tit_active ft16">医生</span>
                    <span class="ft16">服务商</span>
                </div>

                <!-- VIP -->
                <div class="tab_per_txt">
                    <p class="tab_per_txt_tit ft18">入驻权益</p>
                    <div class="flex tab_per_txt_pdd">
                        <div class="tab_per_txt_k">
                            <img src="../img/xt01_03.png" alt="">
                            <span class="ft18">三大品牌支持</span>
                            <p class="ft14">平平台下属原子高科、宁波君安、上海欣科三大碘[<sup>125</sup>I]密封籽源品牌，为vip用户提供更多选择。</p>
                        </div>
                        <div class="tab_per_txt_k">
                            <img src="../img/xt01_05.png" alt="">
                            <span class="ft18">积分权益</span>
                            <p class="ft14">VIP用户享有专属积分权益，积分可兑换相关服务。</p>
                        </div>
                    </div>
                    <div class="flex tab_per_txt_pdd">
                        <div class="tab_per_txt_k">
                            <img src="../img/xt01_10.png" alt="">
                            <span class="ft18">全新服务体验</span>
                            <p class="ft14">以“源于客户、服务用户”为理念，为vip用户提供“一站式”解决方案和计划。</p>
                        </div>
                        <div class="tab_per_txt_k">

                        </div>
                    </div>
                    <p class="tab_per_txt_tit ft18">入驻要求</p>
                    <div class="tab_per_txt_rq">
                        <p>1. 符合国家相关法律、法规规定</p>
                        <p>2. 具有开展碘[<sup>125</sup>I]密封籽源项目的相关资质</p>
                        <p>3. 接受平台的相关管理制度和规则。</p>
                    </div>
                </div>
            <!-- 服务商 -->
            <div class="tab_per_txt"  style="display: none;">
                <p class="tab_per_txt_tit ft18">入驻权益</p>
                    <div class="flex tab_per_txt_pdd">
                        <div class="tab_per_txt_k">
                            <img src="../img/xt01_03.png" alt="">
                            <span class="ft18">三大品牌支持</span>
                            <p class="ft14">平台下属原子高科、宁波君安、上海欣科三大碘[<sup>125</sup>I]密封籽源品牌，为服务商提供更多选择。</p>
                        </div>
                        <div class="tab_per_txt_k">
                            <img src="../img/xt01_05.png" alt="">
                            <span class="ft18">打造品牌营销体系</span>
                            <p class="ft14">依托中国同辐股份有限公司在核技术应用领域的影响力，通过多样化的品牌营销手段，助力服务商开拓市场，打造整体品牌营销体系。</p>
                        </div>
                    </div>
                    <div class="flex tab_per_txt_pdd">
                        <div class="tab_per_txt_k">
                            <img src="../img/xt01_10.png" alt="">
                            <span class="ft18">专业技术支持</span>
                            <p class="ft14">提供专业的技术人员为服务商及所在区域的客户进行培训，指导。</p>
                        </div>
                        <div class="tab_per_txt_k">
                            <img src="../img/xt01_12.png" alt="">
                            <span class="ft18">全新体验升级</span>
                            <p class="ft14">平台以“源于客户、服务用户”为理念，为服务商提供一站式服务升级体验。</p>
                        </div>
                    </div>
                    <p class="tab_per_txt_tit ft18">入驻要求</p>
                    <div class="tab_per_txt_rq">
                        <p>1. 符合国家相关法律、法规规定，拥有正规的公司资质。</p>
                        <p>2. 具有一定的客户资源和相关产品市场推广服务经验。</p>
                        <p>3. 接受并签署平台的技术服务协议，并按照协议相关约束的条款开展业务合作。</p>
                        <p>4. 接受平台市场管理制度的相关规定，并严格按照市场管理制度开展业务合作。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/jquery.min.js"></script>
    <script src="../js/m-home.js"></script>
<script>

</script>
</body>
</html>