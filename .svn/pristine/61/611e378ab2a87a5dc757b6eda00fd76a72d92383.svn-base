<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.*"%>
<%
request.setCharacterEncoding("utf-8");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
String s = request.getParameter("Member");

if(s == null)
if(teasession._rv != null)
{
  s = teasession._rv._strR;
} else
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String s_en=java.net.URLEncoder.encode(s,"UTF-8");



String community=request.getParameter("community");
if(community==null)
{
  Node node=Node.find(teasession._nNode);
  community=node.getCommunity();
}


Resource r = new Resource("/tea/ui/member/Glance");
r.add("/tea/resource/Hostel");



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Glance")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="glancephonebook">
<ul id="title"><li>通讯录</li></ul>
<ul id="item">
<li><a href="/jsp/sms/psmanagement/GroupManage.jsp?node=<%=teasession._nNode%>&community=<%=community%>" >组管理</a></li>
<li><a href="/jsp/sms/psmanagement/PhoneBookManage.jsp?node=<%=teasession._nNode%>&community=<%=community%>" >朋友列表</a></li>
</ul>
</div>

<div id="glanceprofile">
<ul id="title"><li>会员档案</li></ul>
<ul id="item">
<li> <a href="/jsp/user/EditAddress.jsp?node=<%=teasession._nNode%>&community=<%=community%>">编辑地址</a></li>
<li> <a href="/jsp/user/ChangePassword.jsp?node=<%=teasession._nNode%>&community=<%=community%>">更改密码</a></li>
<li> <a href="/jsp/profile/LoginHistory.jsp?node=<%=teasession._nNode%>&community=<%=community%>">登录历史</a></li>
<li> <a href="/jsp/profile/Associates.jsp?node=<%=teasession._nNode%>&community=<%=community%>">助手</a></li>
<li> <a href="/jsp/profile/BuyInstructions.jsp?node=<%=teasession._nNode%>&community=<%=community%>">购买指令</a></li>
<li> <a href="/jsp/profile/Shippings.jsp?node=<%=teasession._nNode%>&community=<%=community%>">发货</a></li>
<li> <a href="/jsp/profile/Coupons.jsp?node=<%=teasession._nNode%>&community=<%=community%>">优惠券</a></li>
<li> <a href="/jsp/profile/EditHome.jsp?node=<%=teasession._nNode%>&community=<%=community%>">我的留言</a></li>
<li> <a href="/jsp/profile/CancelMembership.jsp?node=<%=teasession._nNode%>&community=<%=community%>">注销自已</a></li>
</ul>
</div>

<div id="glancefeedback">
<ul id="title"><li>回馈</li></ul>
<ul id="item">
<li><a href="/jsp/feedback/Feedbacks.jsp?node=<%=teasession._nNode%>&community=<%=community%>" >回馈</a></li>
</ul>
</div>

<div id="glancenode">
<ul id="title"><li>节点</li></ul>
<ul id="item">
<li> <a href="/jsp/node/TalkbackedNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 被回应的节点</a>
<li> <a href="/jsp/node/TalkbackingNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 参加回应的节点</a>
<li> <a href="/jsp/node/AdedNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 发布广告的节点</a>
<li> <a href="/jsp/node/AdingNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 招广告的节点</a>
<li> <a href="/jsp/node/ListedNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 被列举的节点</a>
<li> <a href="/jsp/node/ListingNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 定义列举的节点</a>
<li> <a href="/jsp/node/FavoriteNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 收藏的节点</a>
</ul>
</div>

<div id="glanceoffer">
<ul id="title"><li>提供</li></ul>
<ul id="item">
<li> <a href="/jsp/offer/ShoppingCarts.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 购物车</a>
<li> <a href="/jsp/offer/Bids.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 拍卖</a>
<li> <a href="/jsp/offer/Bargains.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 议价</a>
</ul>
</div>

<div id="glancesale">
<ul id="title"><li>销售单</li></ul>
<ul id="item">
<li> <a href="/jsp/order/SaleOrders3.jsp?Type=1&Status=0&node=<%=teasession._nNode%>&community=<%=community%>" > 新订单</a>
<li> <a href="/jsp/order/SaleOrders3.jsp?Type=1&Status=1&node=<%=teasession._nNode%>&community=<%=community%>" > 取消订单</a>
<li> <a href="/jsp/order/SaleOrders3.jsp?Type=1&Status=2&node=<%=teasession._nNode%>&community=<%=community%>" > 接收</a>
<li> <a href="/jsp/order/SaleOrders3.jsp?Type=1&Status=3&node=<%=teasession._nNode%>&community=<%=community%>" > 确认</a>
<li> <a href="/jsp/order/SaleOrders3.jsp?Type=1&Status=4&node=<%=teasession._nNode%>&community=<%=community%>" > 准备发货</a>
<li> <a href="/jsp/order/SaleOrders3.jsp?Type=1&Status=5&node=<%=teasession._nNode%>&community=<%=community%>" > 已经发货</a>
<li> <a href="/jsp/order/SaleOrders3.jsp?Type=1&Status=6&node=<%=teasession._nNode%>&community=<%=community%>" > 付款</a>
<li> <a href="/jsp/order/SaleOrders3.jsp?Type=1&Status=7&node=<%=teasession._nNode%>&community=<%=community%>" > 完成</a>
</ul>
</div>

<div id="glancepurchase">
<ul id="title"><li>购买单</li></ul>
<ul id="item">
<li> <a href="/jsp/order/PurchaseOrders.jsp?type=1&Status=0&node=<%=teasession._nNode%>&community=<%=community%>" > 新订单</a>
<li> <a href="/jsp/order/PurchaseOrders.jsp?type=1&Status=1&node=<%=teasession._nNode%>&community=<%=community%>" >取消订单</a>
<li> <a href="/jsp/order/PurchaseOrders.jsp?type=1&Status=2&node=<%=teasession._nNode%>&community=<%=community%>" > 接收</a>
<li> <a href="/jsp/order/PurchaseOrders.jsp?type=1&Status=3&node=<%=teasession._nNode%>&community=<%=community%>" > 确认</a>
<li> <a href="/jsp/order/PurchaseOrders.jsp?type=1&Status=4&node=<%=teasession._nNode%>&community=<%=community%>" >准备发货</a>
<li> <a href="/jsp/order/PurchaseOrders.jsp?type=1&Status=5&node=<%=teasession._nNode%>&community=<%=community%>" >已经发货</a>
<li> <a href="/jsp/order/PurchaseOrders.jsp?type=1&Status=6&node=<%=teasession._nNode%>&community=<%=community%>" > 付款</a>
<li> <a href="/jsp/order/PurchaseOrders.jsp?type=1&Status=7&node=<%=teasession._nNode%>&community=<%=community%>" > 完成</a>
</ul>
</div>

<div id="glancecommunity">
<ul id="title"><li>社区</li></ul>
<ul id="item">
<li> <a href="/jsp/community/JoiningCommunities.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 正在加入的社区</a>
<li> <a href="/jsp/community/JoinedCommunities.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 已经加入的社区</a>
<li> <a href="/jsp/community/OrganizingCommunities.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 组织的社区</a>
</ul>
</div>

<div id="glancemessage">
<ul id="title"><li>消息文件夹</li></ul>
<ul id="item">
<li> <a href="/jsp/message/InboxMessages.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 收信箱</a>
<li> <a href="/jsp/message/SendMessages.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 发信箱</a>
<li> <a href="/jsp/message/DraftMessages.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 草稿箱</a>
<li> <a href="/jsp/message/TrashMessages.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 废纸箱</a>
<li> <a href="/jsp/message/ManageMessageFolders.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 管理信箱</a>
<li> <a href="/jsp/message/EmailBoxs.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 电子邮箱</a>
<li> <a href="/jsp/criterion/Callboards.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 公告信息</a>
</ul>
</div>

<div id="glancerequest">
<ul id="title"><li>请求</li></ul>
<ul id="item">
<li> <a href="/jsp/request/ProfileRequests.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 详细地址请求</a>
<li> <a href="/jsp/request/JoinRequestCommunities.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 加入请求社区</a>
<li> <a href="/jsp/request/AdRequestNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 广告请求节点</a>
<li> <a href="/jsp/request/AccessRequestNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 访问请求节点</a>
<li> <a href="/jsp/request/NodeRequestNodes.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 节点请求节点</a>
</ul>
</div>

<div id="glancedestine">
<ul id="title"><li>预定单</li></ul>
<ul id="item">
<li> <a href="/jsp/type/hostel/DestineOrders.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 预定单</a>
<li> <a href="/jsp/type/sorder/PurchaseSOrder.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 服务订单</a>
<li> <a href="/jsp/profile/Center.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 消费统计</a>
</ul>
</div>

<div id="glanceresume">
<ul id="title"><li>简历</li></ul>
<ul id="item">
<li> <a href="/jsp/type/resume/Resume.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 我的简历</a>
<li> <a href="/jsp/type/job/AppHistory.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > 我的职位</a>
</ul>
</div>


<div id="glancesms">
<ul id="title"><li>&#30701;&#20449;&#31995;&#32479;</li></ul>
<ul id="item">
<li> <a href="/jsp/sms/EditSMSMessage.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > &#21457;&#36865;&#30701;&#20449;</a>
<li> <a href="/jsp/sms/SMSMessageList.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > &#30701;&#20449;&#21457;&#36865;&#35760;&#24405;</a>
<li> <a href="/jsp/sms/SMSRMessageList.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > &#22238;&#22797;&#30701;&#20449;&#35760;&#24405;</a>
<li> <a href="/jsp/community/Subscribers.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > &#29992;&#25143;&#31649;&#29702;</a>
<li> <a href="/jsp/sms/EditSMSProfile.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > &#25163;&#26426;&#35774;&#32622;</a>
<li> <a href="/jsp/sms/SMSMoneyList.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > &#20805;&#20540;&#35745;&#24405;</a>
<li> <a href="/jsp/sms/EditSMSEnterCode.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > &#35774;&#32622;&#20225;&#19994;&#21495;</a>
<li> <a href="/jsp/sms/AddSMSMoney.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > EDN-&#20805;&#20540;</a>
<li> <a href="/jsp/sms/SMSEnterprise.jsp?node=<%=teasession._nNode%>&community=<%=community%>" > EDN-&#21019;&#24314;&#20225;&#19994;</a>
</ul>
</div>

<div id="glanceoa">
<ul id="title"><li>工作报告</li></ul>
<ul id="item">
<li> <a href="/jsp/admin/workreport/Worklogs.jsp?node=<%=teasession._nNode%>&community=<%=community%>" >我的工作日志</a>
<li> <a href="/jsp/admin/workreport/Worklogs_2.jsp?node=<%=teasession._nNode%>&community=<%=community%>&member=zhangliling" >zhangliling的日志</a>
<li> <a href="/jsp/admin/workreport/Worklogs_2.jsp?node=<%=teasession._nNode%>&community=<%=community%>&member=zhangzhipeng" >zhangzhipeng的日志</a>
<li> <a href="/jsp/admin/workreport/Worklogs_2.jsp?node=<%=teasession._nNode%>&community=<%=community%>&member=liuhongyan" >liuhongyan的日志</a>
<li> <a href="/jsp/admin/workreport/Worklogs_2.jsp?node=<%=teasession._nNode%>&community=<%=community%>&member=yanjinlong" >yanjinlong的日志</a>
<li> <a href="/jsp/admin/workreport/Worklogs_2.jsp?node=<%=teasession._nNode%>&community=<%=community%>&member=liangying" >liangying的日志</a>
</ul>
</div>



<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>



