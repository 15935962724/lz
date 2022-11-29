<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.admin.mov.*" %>

<%
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
  int zhifu = 0;//支付方式的id
  if(request.getParameter("zhifu")!=null && request.getParameter("zhifu").length()>0)
    zhifu = Integer.parseInt(request.getParameter("zhifu"));


 Payinstall piobj = Payinstall.find(zhifu);
 zhifu = piobj.getPay();

 int membertype=0,payid=0;
 if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
 {
   membertype=Integer.parseInt(teasession.getParameter("membertype"));
 }

 if(teasession.getParameter("payid")!=null && teasession.getParameter("payid").length()>0)
 {
   payid=Integer.parseInt(teasession.getParameter("payid"));
 }
// out.print(membertype+"="+payid);

   MemberType mtobj = MemberType.find(membertype);
    MemberPay mpobj = MemberPay.find(payid);
RegisterInstall riobj = RegisterInstall.find(membertype);
//添加审核
String memberorder = teasession.getParameter("memberorder");
//if(riobj.getVerify()==1){
  if(!"0".equals(memberorder))
  {
    MemberOrder moobj = MemberOrder.find(memberorder);
    moobj.setPaymode(zhifu);
  }
//}

  %>
  <html>
  <HEAD>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
       <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </HEAD>
<body>
<script src="<%=community.getJspBefore(teasession._nLanguage)%>"></script>
 <%=tea.entity.admin.mov.RegisterInstall.getNavigation((membertype),teasession._nLanguage) %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
    <td>服务名称：</td>
    <td><%=mtobj.getMembername() %></td>
  </tr>
   <tr>
    <td>服务费用：</td>
    <td><%out.print(mpobj.getPaymoney()+"&nbsp;&nbsp;元&nbsp;&nbsp;"+mpobj.getPaytime()+"&nbsp;&nbsp;年");%></td>
  </tr>
  <tr>
    <td>服务介绍：</td>
    <td><%=mpobj.getPaycontent()%></td>
  </tr>
</table>

<%

if(piobj.getPaytype() == 1){
  %>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td height="30" align="center" id="zftu2">
        <input type="button" value="立即支付--<%=Payinstall.PAYNAME[zhifu]%>" onClick="window.open('<%=piobj.getPayurl()%>?pay=<%=zhifu %>&memberorder=<%=memberorder%>','_blank');" src="/res/9000gw/u/0710/071044798.jpg" id="image">
      &nbsp;&nbsp;&nbsp;
      <input type=button value="返回上一步" onClick="javascript:history.back()">
      </td>
    </tr>
  </table>
<%}else if(piobj.getPaytype()==2){
%>
 <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td>支付方式：</td>
    <td><%=piobj.getPayname() %></td>
    </tr>
    <tr>
    <td>支付说明：</td>
    <td><%=piobj.getPaycontent() %></td>
    </tr>
</table>

<%
 if(mtobj.getSkips()==0)//判断是否跳转
  {
    out.print("<a href=\"javascript:history.back();\">上一步</a>&nbsp;&nbsp;&nbsp;");
    out.print("<a href="+mtobj.getFileurl()+">返回首页</a>");
  }else
  {
    out.print("<script>setTimeout('window.location.replace(\""+mtobj.getFileurl()+"\");',1000);</script>");
  }


}
%>



<script src="<%=community.getJspAfter(teasession._nLanguage)%>"></script>
</body>
</html>
