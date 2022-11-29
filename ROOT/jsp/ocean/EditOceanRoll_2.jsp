<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*" %>
<%


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}

Ocean oce = Ocean.find(ids);
%>
<html>
<head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<%@include file="/jsp/include/Calendar3.jsp" %>
<title>订单提交成功</title>
</head>

<body class="OceanPassport">
<script type="">
window.history.forward(1);
</script>
<div class="body">
  <table class="Flow4">
    <tr>
       <td class="td01"></td><td class="td02">服务条款</td><td class="td03">填写登记表</td><td class="td04">确认订单</td><td class="td05">支付费用（首信易支付）</td>
    </tr></table>
    <div class="Ocean">
      <div class="Ocean_top"></div><div class="Ocean_con"><div class="Ocean_bottom">
      <div class="Pay_top"></div>
        <form  name="form1" action="/servlet/EditOcean" method="get" enctype="multipart/form-data">
        <input  type="hidden" value="EditOceanRoll2" name="act">
        <input  type="hidden" name="idss" value="<%=ids%>" >

        <table  border="0" class="Pay">
          <tr>
            <td class="td01">订单号：　　<span class="tespan01"><%=oce.getOceanorder()%></span>
            </td>
          </tr>
          <tr>
            <td>付款总金额：　　<span class="tespan01"><%=oce.getMoney()%></span></td>
          </tr>
          <tr>
            <td class="td02"><label>
            请记住您的订单号，用于领取海洋护照。
</label>
            </td>
          </tr>
          <tr>
            <td class="td03">请点击“首信易支付”进入支付通道，完成支付</td>
          </tr>
          <tr>
            <td class="td04">点击“首信易支付通道”，您将进入网上安全支付平台。按系统提示选择您持有卡的所属银行进行操作，一分钟即可完成</td>
          </tr>
             <tr>
            <td nowrap align="center"><a href="/jsp/pay/hybeijing/Send.jsp?ids=<%=ids%>&oceanorder=<%=oce.getOceanorder()%>"  target="_blank"><img src="\tea\image\oceanRoll\logo.jpg"></a></td>
          </tr>
        </table>
        <table class="Pay_table">
        <tr>
        <td colspan="4" class="td01">支持下列银行：</td>
        </tr>
        <tr>
        <td>中国工商银行</td> <td>中国银行</td> <td>中国建设银行</td> <td>中国农业银行</td>
        </tr>
        <tr>
        <td>招商银行</td> <td>中国邮政储蓄</td> <td>中国民生银行</td> <td>广东发展银行</td>
        </tr>
        <tr>
        <td>中信银行</td> <td>兴业银行</td> <td>北京银行</td> <td>深圳发展银行</td>
        </tr>
        <tr>
        <td>深圳平安银行</td> <td>交通银行</td> <td>华夏银行</td> <td>中国光大银行</td>
        </tr>
        <tr>
        <td>上海浦东发展银行</td> <td>广州市商业银行</td> <td>顺德信用社</td> <td>广州市农村信用合作社</td>
        </tr>
        <tr>
        <td>上海农村商业银行</td> <td>北京农村商业</td> <td>银行渤海银行</td> <td>国际信用卡</td>
        </tr>
        </table>
        <div class="Tips">特别提示</div>
        <div class="Tips01"><span>安全保证：</span>您在网上支付过程中，银行卡信息的填写是在各大银行的支付网关上进行的，本站不收集任何银行卡资料，所以不会出现您所担心的安全问题。</div>
        <div class="Tips01">目前国内各大银行的支付网关都采用国际流行的SSL或SET方式加密的。在支付过程中您可以注意到浏览器右下角会出现“<span>小锁</span>”的标记，这个标志代表您目前的所有操作都是在加密保护模式下完成的，您的任何私人信息在传送过程中都是安全的，不会被第三方窃取。</div>
        <div class="Tips01"><span>支付提示：</span>为了保障用户款项的安全，您在支付货款时请通过本站提供的支付渠道，否则后果由用户自己承担。</div>
        <input  type="button"  value="" onClick="window.history.back();" class="Back"/>

        </form>
        </div>
    </div>
</div>
<div class="footer">Copyright(c)2001-2005 北京海洋馆·版权所有 地址：北京海淀区高粱桥斜街乙18号（北京动物园北门内）<br/>
定票热线：（010）62123910 网址：www.BJ-sea.com</div>
</div>
</body>
</html>
