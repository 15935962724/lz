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
<script type="">
function find_sub()
{
  if(document.all("yhhz").checked)
  {
    window.open('/jsp/ocean/EditOceanOver.jsp','_self');
    return true;
  }
  else
  {
    alert("是否已看过海洋护照会员守则请选择");
      return false;
  }
}
</script>
</head>
<body class="OceanPassport">
<div class="body">
  <table class="Flow">
    <tr>
      <td class="td01"></td><td class="td02">服务条款</td><td class="td03">填写登记表</td><td class="td04">确认订单</td><td class="td05">支付费用（首信易支付）</td>
    </tr></table>
    <div class="Ocean">
      <div class="Ocean_top">
      </div>
      <div class="Ocean_con">
        <div class="Ocean_bottom">
          <div class="Ocean_bottom_con">
           <div class="Ocean_bottom_con1"></div>
           <div class="TermsService"><div class="TermsService_top">北京海洋馆海洋护照会员守则</div>

　　一、	海洋护照简介<br>
　　北京海洋馆海洋护照（以下简称海洋护照）是面向游客限时、限量发行的一种入馆凭证。海洋护照上印有持卡人本人照片、姓名，护照序列号，身份识别条形码及护照类别等基础信息。为保证会员和北京海洋馆双方的合法权益，请您在办理海洋护照时填写真实有效的个人信息，并认真阅读海洋护照使用须知，需要帮助时可及时联系北京海洋馆的工作人员，我们将为您提供优质满意的服务。<br>
　　海洋护照有效期：办理成功之日至2010年4月30日<br>
　　海洋护照分类：<br>
　　　　　成人海洋护照：330元/人<br>
　　　　　学生海洋护照：150元/人（1.2米以上、18岁以下的儿童及中小学生）<br>

　　<font><b>特别提示:</b><br>
　　您通过本网站办理的海洋护照，支付成功后，预计需要7个工作日完成海洋护照卡的制作。我们将在制卡完成后，以电子邮件方式通知您，请您随时查收电子邮件。您也可以通过本网站查询海洋护照办理的进度情况。</font><br>

<br>
　　二、会员尊享<br>
　　1、会员凭海洋护照可在有效期内不限次参观北京海洋馆、北京动物园（含熊猫馆）。<br>
　　2、尊享高品质专属会员活动，活动内容将以手机短信及时发送给会员，北京海洋馆网站会员专区也将同时予以公布。<br>
　　3、乐享馆内美食、购物优惠（9折优惠、特例商品除外）。<br><br>
　　三、海洋护照使用须知<font>（请您仔细阅读）</font><br>
　　1、此卡仅限本人使用，入馆及享受其他优惠时请主动出示。非本人使用，北京海洋馆有权将此卡收回；<br>
　　2、持卡者可在2010年4月30日前不限次数参观北京海洋馆、动物园（含熊猫馆）；<br>
　　3、凭此卡在北京海洋馆内用餐及购物可以享受9折优惠（特例商品除外）；<br>
　　4、本卡仅限日场（9：00——17：30）参观使用，北京海洋馆举办的特殊活动无效；<br>
　　5、此卡售出后，不予退换，遗失不补。<br><br>
　　四、海洋护照使用说明<br>
　　1、入园检票须知<br>
　　海洋护照仅限本人使用，持有人需出示本人海洋护照进入动物园。进入北京海洋馆时，检票人员将核对海洋护照照片和相关信息，扫描条形码验证海洋护照卡的有效性后，会员即可进馆参观游览。<br>
　　温馨提示：入园参观游览请您务必出示海洋护照，遗忘携带或途中丢失将无法进入北京海洋馆。<br>
　　2、带领儿童参观须知<br>
　　每位成人会员可以带领两名身高1.2米以下的儿童进馆参观，1.2米以上、18岁以下儿童需购买半价门票或另行办理学生海洋护照，请准确掌握要带领儿童的身高。<br>
　　3、海洋护照的专属性<br>
　　海洋护照仅限本人使用，不得冒用、借用。为了维护会员及北京海洋馆双方的权益，海洋护照售出后不予退换（有效期至2010年4月30日），请妥善保管好您的海洋护照，防止他人冒用或借用。检票人员一经检出非本人使用，北京海洋馆有权将此卡没收。<br><br>
　　五、会员责任<br>
　　办理2009年限量版海洋护照即可成为北京海洋馆会员，会员是热衷海洋环保事业，关爱海洋生物的优秀公民。北京海洋馆丰富多彩的海洋生物展示及舒适的游览环境离不开广大会员朋友共同的爱心呵护，我们由衷地感谢您对北京海洋馆的支持与厚爱。<br><br>

　　成为北京海洋馆的会员后，将视为您已接受并承诺遵守本守则，祝您游览愉快！<br>

</div>
          <div><table class="MemberCode"><tr><td><input type="checkbox" name="yhhz" />　</td><td>我已看过 <span>《海洋护照会员守则》</span></td></tr></table></div><input  type="button"  id="tongyi" onClick="return find_sub()"/>　<input  type="button"  id="butongyi" onClick="window.close();"/>

         <div class="Introduction"><a href="/jsp/ocean/OceanFlack.jsp"　target="_blank"><img src="/res/bj-sea/u/0902/090264978.jpg"/></a></div>
           </div>
        </div>
      </div>
    </div>

<div class="footer">Copyright(c)2001-2005 北京海洋馆·版权所有 地址：北京海淀区高粱桥斜街乙18号（北京动物园北门内）<br/>
定票热线：（010）62123910 网址：www.BJ-sea.com</div>
</div>
</body>
</html>
