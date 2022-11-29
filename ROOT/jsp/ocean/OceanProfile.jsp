<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.site.Community" %>
<%@ page import = "tea.entity.node.Node" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import="tea.ui.TeaServlet"%>

<%
TeaSession teasession = new TeaSession(request);
Community community = Community.find(teasession._strCommunity);

String ss = community.getTerm(teasession._nLanguage);

%>
<html>
<head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
</head>
<body class="OceanPassport">
<div class="body">
      <div class="Ocean">
      <div class="Ocean_top">
      </div>
      <div class="Ocean_con">
        <div class="Ocean_bottom">
          <div class="Ocean_bottom_con">
          <div class="SeaRules"></div>
         <div class="TermsService"><div class="TermsService_top">北京海洋馆海洋护照会员守则</div>

　　一、	海洋护照简介<br>
　　北京海洋馆海洋护照（以下简称海洋护照）是面向游客限时、限量发行的一种入馆凭证。海洋护照上印有持卡人本人照片、姓名，护照序列号，身份识别条形码及护照类别等基础信息。为保证会员和北京海洋馆双方的合法权益，请您在办理海洋护照时填写真实有效的个人信息，并认真阅读海洋护照使用须知，需要帮助时可及时联系北京海洋馆的工作人员，我们将为您提供优质满意的服务。<br>
　　海洋护照有效期：办理成功之日起至2012年4月30日<br>
　　海洋护照分类：<br>
　　　　　成人海洋护照：380元/人<br>
　　　　　学生海洋护照：170元/人（1.2米以上、18岁以下儿童及中小学生）<br><br>
　　二、会员权益<br>
　　1、凭本人有效海洋护照，可全年不限次参观北京海洋馆、动物园及熊猫馆。<br>
　　2、享受海洋馆内消费优惠：好味岛就餐9折，每消费1元积1分，可兑换相应餐品；卖场购物9折优惠、特例商品除外。<br>
　　3、可报名参加海洋馆会员专属活动，并享受海洋馆精彩活动价格优惠（如夏令营、冬令营等，以活动公示为准）。请您留意手机短信活动通知，并登陆北京海洋馆网站会员动态浏览详细活动内容。<br>
　　4、享受北京海洋馆银海潜水俱乐部潜水项目9折优惠（咨询电话： 15110052510/15110052511）。<br>
　　5、免费预约“海洋科普进校园”讲座（咨询电话010-62176655-6760）。<br>
　　6、可申请成为海洋馆蓝色海洋环保志愿者（咨询电话010-62176655-6760）。<br>
　　7、免费领取会员刊物《海洋PARK》：欢迎您与我们分享心情故事、展示宝贝照片。刊物每季度出版一期，会员可持海洋护照到会员办公室免费领取。<br>
　　8、<span style="color:#f00;">轻松享受更多优惠：</span>凭本人海洋护照在海洋馆特约商户处消费享有优惠，优惠信息请登陆网站特约商户栏目（首页左上角）查询。<br><br>
　　三、海洋护照使用说明<br>
　　1、入园检票须知<br>
　　海洋护照仅限本人使用，入园参观游览必须出示海洋护照，遗忘携带或途中丢失将无法进入。<br>
　　2、带领儿童参观须知<br>
　　每位成人会员可以带领两名身高1.2米以下的儿童进馆参观，1.2米以上、18岁以下儿童需购买半价门票或办理学生海洋护照。<br>
　　3、海洋护照的专属性<br>
　　海洋护照售出后不予退换，仅限本人使用（有效期自办理之日起至2012年4月30日），切勿冒用或借用。检票人员一经查出非本人使用，北京海洋馆有权将此卡没收，请妥善保管好您的海洋护照。<br>
　　4、海洋护照补办须知<br>
　　若您的海洋护照卡不慎丢失，请尽快致电会员服务热线进行挂失并申请补办。补办过程为“身份核实——原护照卡挂失——提交补办申请——领取新卡”。为了保障补办过程顺畅进行，请您详尽填写会员资料，或拨打会员服务热线及时更新、完善您的会员资料。补办截至时间为<soan style="color:#f00;">2011年12月31日。</span><br>
　　5、注意事项<br>
　　本卡仅限日场（9：00—17：30）参观使用，不包含其它收费项目，北京海洋馆举办的特殊活动无效。游客须遵守北京海洋馆、北京动物园安全规则及附例。<br><br>
　　四、海洋护照使用说明<br>
　　办理2011年限量版海洋护照即可成为北京海洋馆会员，会员是热衷海洋环保事业，关爱海洋生物的优秀公民。北京海洋馆丰富多彩的海洋生物展示及舒适的游览环境离不开广大会员朋友共同的爱心呵护，我们由衷地感谢您对北京海洋馆的支持与厚爱。<br>
　　成为北京海洋馆的会员后，将视为您已接受并承诺遵守本守则，祝您游览愉快！<br><br>

</div>
<table style="margin-top:5px;"><tr><td><a href="/jsp/ocean/EditOceanOver.jsp"><img src="/res/bj-sea/u/1003/100328486.gif"></a></td><td>　<a href="#" onClick="window.close();"/><img src="/res/bj-sea/u/1003/100328485.gif"></a></td></table>
              <div class="Introduction"><a href="/jsp/ocean/OceanFlack.jsp"　target="_blank"><img src="/res/bj-sea/u/0902/090264978.jpg"/></a></div>
          </div>
        </div>
      </div>
    </div>
<!--/jsp/ocean/EditOceanRoll.jsp-->
<div class="footer">Copyright(c)2001-2005 北京海洋馆·版权所有 地址：北京海淀区高粱桥斜街乙18号（北京动物园北门内）<br/>
定票热线：（010）62123910 网址：www.BJ-sea.com</div>
</div>
</body>
</html>
