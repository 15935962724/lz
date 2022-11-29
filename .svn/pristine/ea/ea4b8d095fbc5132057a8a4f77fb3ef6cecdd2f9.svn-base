<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*"%><%@ page import="javax.servlet.*"%><%@ page import="tea.entity.RV"%><%@ page import="tea.entity.member.*"%><%@ page import="tea.entity.admin.*"%><%@ page import="tea.entity.node.*"%>
<%@ page import="tea.entity.site.*"%><%@ page import="tea.http.RequestHelper"%><%@ page import="java.io.*"%><%@ page import="javax.servlet.*"%><%@ page import="tea.entity.site.*"%>
<%@ page import="tea.html.*"%><%@ page import="tea.htmlx.*"%><%@ page import="tea.resource.*"%><%@ page import="tea.ui.*"%><%@ page import="tea.db.DbAdapter"%>
<%
request.setCharacterEncoding("utf-8");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);

String member = request.getParameter("member");
if(member == null)
if(teasession._rv != null)
{
  member = teasession._rv._strR;
} else
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member_en=java.net.URLEncoder.encode(member,"UTF-8");




Resource r = new Resource("/tea/ui/member/Glance");
r.add("/tea/resource/Hostel");


RV rv=new RV(teasession._strCommunity,member);

Community community=Community.find(teasession._strCommunity);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<base href="http://<%=request.getServerName()%>/"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<body>
<!--mail之前 -start- -->
<%//=community.getMailBefore(teasession._nLanguage)%>
<!--mail之前 -end- -->

<div id="glancemember">
<span id="title" ><%=r.getString(teasession._nLanguage, "会员信息")%></span>
<ul id="item">
<%
{
  Profile p=Profile.find(member);
  out.print("<LI>姓:"+p.getLastName(teasession._nLanguage)+"</LI>");
  out.print("<LI>名:"+p.getFirstName(teasession._nLanguage)+"</LI>");
  out.print("<LI>性别:"+(p.isSex()?"男":"女")+"</LI>");
  out.print("<LI>E-Mial:<a href=mailto:"+p.getEmail()+" >"+p.getEmail()+"</a></LI>");
  out.print("<LI>注册时间:"+p.getTime()+"</LI>");
  out.print("<LI>地址:"+p.getAddress(teasession._nLanguage)+"</LI>");
  out.print("<LI>生日:"+p.getBirthToString()+"</LI>");
  out.print("<LI>传真:"+p.getFax(teasession._nLanguage)+"</LI>");
  out.print("<LI>手机:"+p.getMobile()+"</LI>");
  out.print("<LI>电话:"+p.getTelephone(teasession._nLanguage)+"</LI>");
  out.print("<LI>邮编:"+p.getZip(teasession._nLanguage)+"</LI>");
  out.print("<LI>单位:"+p.getOrganization(teasession._nLanguage)+"</LI>");
  out.print("<LI>个人主页:<a target=_blank href="+p.getWebPage(teasession._nLanguage)+" >"+p.getWebPage(teasession._nLanguage)+"</a></LI>");
  out.print("<LI><input type=button value=编辑 onclick=\"window.open('/jsp/user/EditAddress.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"','_self');\"></LI>");
}
%>
</ul>
</div>


<div id="glanceres">
<span id="title" ><%=r.getString(teasession._nLanguage, "管理资源")%></span>
<ul id="item">
<%
{
  License license=License.getInstance();
  if(license.getWebMaster().equals(member))
  {
    try
    {
      java.io.InputStream is=new java.net.URL("http://map.redcome.com/jsp/util/Map_2.jsp").openStream();
      StringBuffer sb=new StringBuffer();
      int value=0;
      while((value=is.read())!=-1)
      {
        sb.append((char)value);
      }
      is.close();
      String str=new String(sb.toString().getBytes("ISO-8859-1"),"UTF-8");
      out.print(str);
    }catch(IOException ioe)
    {
      System.out.println("Glance3.jsp:行67:map.redcome.com出错");
    }
  }else
  {
    out.print("<LI>共会员:"+Profile.countByCommunity(teasession._strCommunity)+"</LI>");
    out.print("<LI>在线人数:"+Online.countByCommunity(teasession._strCommunity)+"</LI>");
    out.print("<LI>信息数目:"+Community.countByCommunity(teasession._strCommunity)+"</LI>");
  }

}
%>
</ul>
</div>


<div id="glanceorder">
<span id="title" >商品或订单</span>
<ul id="item">
<%
int count=Buy.countBuys(rv,teasession._strCommunity);
if(count==0)
{
  out.print("<li>购物车中没有商品");
}else
{
  out.print("<LI><A href=\"/jsp/offer/ShoppingCarts.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+count+" "+r.getString(teasession._nLanguage, "Buys")+"</A></LI>");
}

count=Trade.count(false, rv, 1,teasession._strCommunity);
if(count==0)
{
  out.print("<li>没有销售单");
}else
{
  out.print("<LI><A href=\"/jsp/order/SaleOrders2.jsp?Type=1&node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+count+" "+r.getString(teasession._nLanguage, "SaleOrders")+"</A></LI>");
}

count=Trade.count(false, rv, 1,teasession._strCommunity);
if(count==0)
{
  out.print("<li>没有购买单");
}else
{
  out.print("<LI><A href=\"/jsp/order/PurchaseOrders.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+count+" "+r.getString(teasession._nLanguage, "PurchaseOrders")+"</A></LI>");
}

count=Destine.countByMember(teasession._strCommunity,member);
if(count==0)
{
  out.print("<li>没有预定酒店住房");
}else
{
  out.print("<LI><A href=\"/jsp/type/hostel/DestineOrders.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+count+" "+r.getString(teasession._nLanguage, "DestineOrders")+"</A></LI>");
}

%>
</ul>
</div>



<div id="glancemessage">
<span id="title" ><%=r.getString(teasession._nLanguage, "MessageFolders")%></span>
<ul id="item">
<%
count=Message.count("Inbox", rv);
if(count==0)
{
  out.print("<li>收信箱中没有信件");
}else
{
  out.print("<LI><A href=\"/jsp/message/InboxMessages.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+count+" "+r.getString(teasession._nLanguage, "InboxMessages")+"</A></LI>");
}

count=Message.count("Sent", rv);
if(count==0)
{
  out.print("<li>发信箱中没有信件");
}else
{
  out.print("<LI><A href=\"/jsp/message/SendMessages.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+count+" "+r.getString(teasession._nLanguage, "SentMessages")+"</A></LI>");
}
%>
</ul>
</div>





<div id="glanceoa">
<span id="title" ><%=r.getString(teasession._nLanguage, "我的办公室")%></span>
<ul id="item">
<%
count=Flowitem.count(teasession._strCommunity," AND flowitem IN(SELECT flowitem FROM Flowbusiness WHERE nextmember="+DbAdapter.cite(member)+" )");////必须存在工作事务;
if(count==0)
{
  out.print("<li>没有待办工作");
}else
{
  out.print("<LI><A href=\"/jsp/admin/flow/Flowitems2.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+count+" "+r.getString(teasession._nLanguage, "项待办工作")+"</A></LI>");
}

%>
</ul>
</div>








<div id="glanceblog">
<span id="title" ><%=r.getString(teasession._nLanguage, "我的博客")%></span>
<ul id="item">
<%
{
  String sn=request.getServerName();
  int i=sn.indexOf(".");
  sn=member+"."+sn.substring(i+1);
  if(request.getServerPort()!=80)
  {
    sn=sn+":"+request.getServerPort();
  }
  out.print("<LI><A href=\"http://"+sn+"\">"+r.getString(teasession._nLanguage, "我的主页")+"</A></LI>");

  count=Talkback.countEdNodes(rv);
  out.print("<LI><A href=\"/jsp/node/TalkbackedNodes.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "评论列表")+":"+count+"</A></LI>");

  out.print("<LI><A href=\"/jsp/community/CommunitySetWeblog.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "模板定义")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/general/WeblogEditNode.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "栏目设置")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/section/WeblogSelectCssJs.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "样式选择")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/section/WeblogEditCssJs.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "样式修改")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/profile/EditCallboard.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "自定义公告")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/section/WeblogEditSection.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "自定义空白面板")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/general/WeblogContentManage.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "内容管理")+"</A></LI>");

}
%>
</ul>
</div>





<div id="glancescore">
<span id="title" ><%=r.getString(teasession._nLanguage, "差点系统")%></span>
<ul id="item">
<%
{
  out.print("<LI><A href=\"/jsp/type/score/ScoreList.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "最近20次成绩")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/type/score/ScoreHistory.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "历史差点指数")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/section/WeblogSelectCssJs.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "差点管理")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/type/score/ScoreManage.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "样式修改")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/type/score/ScoreQuery.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "查看会友成绩")+"</A></LI>");
  out.print("<LI><A href=\"/jsp/type/score/ScoreInfo.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "个人资料")+"</A></LI>");
}
%>
</ul>
</div>


<div id="glancebbs">
<span id="title" ><%=r.getString(teasession._nLanguage, "论坛信息")%></span>
<ul id="item">
<%
{
  r.add("/tea/resource/BBS");
  count=BBS.countByMember(teasession._strCommunity,member);
  out.print("<LI><A href=\"/jsp/type/bbs/MyBBS.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "1169716387125")+":"+count+"</A></LI>");

  count=BBSReply.countByMember(teasession._strCommunity,member);
  out.print("<LI><A href=\"/jsp/type/bbs/MyBBSReply.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "1169716387126")+":"+count+"</A></LI>");
}
%>
</ul>
</div>




<div id="glancejob">
<span id="title" ><%=r.getString(teasession._nLanguage, "招聘系统")%></span>
<ul id="item">
<%
{
  //r.add("/tea/resource/Job");

  out.print("<LI><A href=\"/jsp/type/resume/Resume.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "简历中心")+"</A></LI>");

  out.print("<LI><A href=\"/jsp/type/job/AppHistory.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "我的职位夹")+"</A></LI>");
}
%>
</ul>
</div>





<div id="glancesms">
<span id="title" ><%=r.getString(teasession._nLanguage, "短信系统")%></span>
<ul id="item">
<%
{
  //r.add("/tea/resource/Job");
  count=SMSMessage.countSendByMember(member,teasession._strCommunity);
  out.print("<LI><A href=\"/jsp/sms/SMSMessageList.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "短信发送记录")+":"+count+"</A></LI>");

  count=SMSMessage.findReverseByMember(member,teasession._strCommunity).split("<tr><td>").length-1;
  out.print("<LI><A href=\"/jsp/sms/SMSRMessageList.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "回复短信记录")+":"+count+"</A></LI>");
}
%>
</ul>
</div>



<div id="glancenetdisk">
<span id="title" ><%=r.getString(teasession._nLanguage, "网络硬盘")%></span>
<ul id="item">
<%
{
  out.print("<LI><A href=\"/jsp/netdisk/NetDiskFrame.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "个人网络硬盘")+"</A></LI>");

  int size=tea.entity.admin.NetDiskSize.getSizeByMember(member);
  if(size>0)
  {
    java.io.File dir = new java.io.File(application.getRealPath("/res/"+teasession._strCommunity+"/netdiskmember/" +member));
    int useSize=tea.entity.admin.NetDiskSize.getUseSize(dir);
    out.print("<LI><table  border=0 cellpadding=0 cellspacing=0 width=200 ><tr><td style=\"height:20px;background-color:#FF0000;width:"+useSize/(size/100F)+"%;\" title=已用空间 ></td><td style=\"width:"+(size-useSize)/(size/100)+"%;background-color:#999999;height:20px;\"></td></tr></table>");
  }

  out.print("<LI><A href=\"/jsp/netdisk/EditNetDisk.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "网络硬盘(企业公用)")+"</A></LI>");

  count=NetDiskShare.countByMember(teasession._strCommunity,member);
  out.print("<LI><A href=\"/jsp/netdisk/NetDiskShareList.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"\">"+r.getString(teasession._nLanguage, "朋友共享的文件")+":"+count+"</A></LI>");
}
%>
</ul>
</div>




<div id="glancephonebook">
<span id="title" ><%=r.getString(teasession._nLanguage, "通讯录")%></span>
<ul id="item">
<%
{
  //r.add("/tea/resource/Job");
  java.util.Enumeration enumer=SMSGroup.findByMember(member,teasession._strCommunity) ;
  while(enumer.hasMoreElements())
  {
    int id=((Integer)enumer.nextElement()).intValue();
    SMSGroup smsg=SMSGroup.find(id);
    count=SMSPhoneBook.count(member,teasession._strCommunity," AND groupid="+id);
    out.print("<LI><A href=\"/jsp/sms/psmanagement/PhoneBookManage.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"&groupid="+id+"\">"+smsg.getName()+":"+count+"</A></LI>");
  }
  count=SMSPhoneBook.count(member,teasession._strCommunity," AND groupid=0");
  out.print("<LI><A href=\"/jsp/sms/psmanagement/PhoneBookManage.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity+"&groupid=0\">未分类:"+count+"</A></LI>");
}
%>
</ul>
</div>


<!--mail之后 -start- -->
<%//=community.getMailAfter(teasession._nLanguage)%>
<!--mail之后 -end- -->




