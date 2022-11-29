<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;
//member="0152";

int ciocompany=CioCompany.findByMember(member);
if(ciocompany<1)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你不是代表","UTF-8"));
  return;
}
CioCompany cc=CioCompany.find(ciocompany);
String name=cc.getName();
boolean receipt=cc.isReceipt();

String alert=request.getParameter("alert");


CommunityOption co = new CommunityOption(teasession._strCommunity);
Date stoptime=co.getDate("ciostoptime");
boolean isEdit=cc.isSpecial()||(stoptime!=null&&System.currentTimeMillis()<stoptime.getTime());//特殊企业或截止日期未到

%>
<html>
<head>
<link href="/res/cavendishgroup/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="tes_body">


<h1>本企业参会信息管理</h1>
<div id="tes_body02">
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<%

if(cc.getTime()==null)
{

%>

<div id="content_all02">
<div id="content_01">
<%=name%>，参会负责人您好：</div>
<div id="content_02">您的企业还没有提交参会报名表<br/>
请马上提交参会报名表！</div>
<div id="content_04"><a href="/jsp/cio/EditCioCompany.jsp?community=<%=teasession._strCommunity%>" target="_blank"><img src="/res/cavendishgroup/u/0810/081059187.gif"></a></div>
<div  id="tablebottom_002">
如遇问题请马上联系<br/>010-61392325！
</div>
</div>
<%

}else
{

%>

<div id="content_all">
<div id="content_01"><%=name%>，参会负责人您好：</div>
<div id="content_02">您的企业于<%=cc.getTimeToString()%>提交参会报名表</div>

<%
if(alert!=null) out.print("<div id='huizhi' color='red'>"+alert+"</div>");
%>

<div id="qiycanh_xx_all">
<%
if(isEdit)
{
  out.print("<div id='qiycanh_xx'>您的参会信息如需修改,请进入<br><a href='/jsp/cio/EditCioCompany.jsp?community="+teasession._strCommunity+"' target='_blank'><img src='/res/cavendishgroup/u/0810/081030896.jpg'></a></div>");
}
if(receipt)
{
  out.print("<div id='qiycanh_xx'>我们已确认了报名信息，并给您发送了回执。<br><a href='/jsp/cio/ReceiptCioCompany.jsp?community="+teasession._strCommunity+"&ciocompany="+ciocompany+"'><img src='/res/cavendishgroup/u/0810/081059175.gif'></a></div>");
}
if(isEdit)
{
  out.print("<div id='qiycanh_xx'>贵企业（集团）还没有补充人员行程信息。<br /><a href='/jsp/cio/TripCioPart.jsp?community="+teasession._strCommunity+"'><img src='/res/cavendishgroup/u/0810/081059176.gif'></a></div>");
}
if(receipt)
{
  if(cc.isClerk())
  {
    out.print("<div id='qiycanh_xx'>我们已为贵企业的参会人员安排了接送站服务。<br /><a href='/jsp/cio/SelCollectInfoView.jsp?type=js&community="+teasession._strCommunity+"'><img src='/res/cavendishgroup/u/0810/081059181.gif'></a></div>");
  }
  if(cc.isRoom())
  {
    out.print("<div id='qiycanh_xx'>我们已为贵企业的参会人员预订了酒店房间。<br/><a href='/jsp/cio/SelCollectInfoView.jsp?type=zs&community="+teasession._strCommunity+"'><img src='/res/cavendishgroup/u/0810/081059214.gif'></a></div>");
  }
  if(cc.isSeat())
  {
    out.print("<div id='qiycanh_xx'>我们已为贵企业的参会人员安排了座位。<br><a href='/jsp/cio/SelCollectInfoView.jsp?type=seat&community="+teasession._strCommunity+"'><img src='/res/cavendishgroup/u/0810/081059182.gif'></a></div>");
  }
}
%>
<div id="qiycanh_xx">
我们对本次会议的意见或建议。
<br>
<a href="/jsp/cio/EditCioFeedback.jsp?community=<%=teasession._strCommunity%>"><img src="/res/cavendishgroup/u/0810/081059184.gif"></a>
</div>
</div>
<div  id="tablebottom_002">
如需对报名信息进行变更请联系<br/>010-61392325<br/>
注：因事不到等请提前通知我们，以便于<br/>安排工作，谢谢！
</div>
</div>

<%}%>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</div>
</body>
</html>
