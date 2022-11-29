<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.mov.*"%>
<%
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
  return;
}


tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
int membertype=0,payid=0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype=Integer.parseInt(teasession.getParameter("membertype"));
}

if(teasession.getParameter("payid")!=null && teasession.getParameter("payid").length()>0)
{
  payid=Integer.parseInt(teasession.getParameter("payid"));
}
String memberorder=teasession.getParameter("memberorder");
//添加 支付的金额
 MemberOrder moobj = MemberOrder.find(memberorder);
RegisterInstall riobj = RegisterInstall.find(membertype);
//if(riobj.getVerify()==1){
  if(!"0".equals(memberorder))
  {
    moobj.setPayid(payid);
  }
//}


%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<body bgcolor="#ffffff">
<script type="" src="<%=community.getJspBefore(teasession._nLanguage)%>"></script>
<div id="tablebgnone" class="register">

  <%=tea.entity.admin.mov.RegisterInstall.getNavigation((membertype),teasession._nLanguage) %>

  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>

  <form id="form1" action="/jsp/mov/Success3.jsp" method="post">
  <input type="hidden" name="membertype" value="<%=membertype%>"/>
  <input type="hidden" name="payid" value="<%=payid%>"/>
  <input type="hidden" name="memberorder" value="<%=memberorder%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td colspan="3">
        <div align="center"><b>请选择付费方式</b></div>
      </td>
    </tr>

    <%//线上支付方式显示
    java.util.Enumeration e = Payinstall.find(teasession._strCommunity," AND usetype = 1 AND paytype = 1",0,Integer.MAX_VALUE);
    if(e.hasMoreElements())
    {
      out.print("<tr><td colspan=3><div align=center>网上支付</div></td></tr>");
    }
    for(int i = 1;e.hasMoreElements();i++){
      int piid = ((Integer)e.nextElement()).intValue();
      Payinstall piobj = Payinstall.find(piid);
      %>
      <tr>
        <td align="center"> <input type="radio" name="zhifu" value="<%=piid%>" <%if(moobj.getPaymode()==piobj.getPay()){out.print(" checked=\"checked\"");}else if(i==1){out.print(" checked=checked");}%> ></td>
          <td nowrap="nowrap" align="center">
            <b><%=Payinstall.PAYNAME[piobj.getPay()] %></b>
          </td>
          <td>
            <%=piobj.getPaycontent() %>
          </td>
      </tr>
      <%} %>


       <%//线下支付方式显示
    java.util.Enumeration e2 = Payinstall.find(teasession._strCommunity," AND usetype = 1 AND paytype = 2",0,Integer.MAX_VALUE);
    if(e2.hasMoreElements())
    {
      out.print("<tr><td colspan=3><div align=center>网下支付</div></td></tr>");
    }
    for(int i = 1;e2.hasMoreElements();i++){
      int piid2 = ((Integer)e2.nextElement()).intValue();
      Payinstall piobj2 = Payinstall.find(piid2);

      %>
      <tr>
        <td align="center">
          <input type="radio" name="zhifu" value="<%=piid2%>" <%if(moobj.getPaymode()==piobj2.getPay())out.print(" checked=checked");%> id="lzj_an">
          </td>
          <td align="center"><b><%= piobj2.getPayname() %></b></td>
          <td><span id=lzj_fu><%=piobj2.getPaycontent()%></span></td>
        </td>
      </tr>
      <%}%>

      <tr>
        <td align="center" colspan="3"> <div align="center">

          <input type=button value="上一步" onClick="javascript:history.back()">

          &nbsp;&nbsp;&nbsp;&nbsp;
          <input name="submit" type="submit" value="下一步">
</div>
        </td>
      </tr>
  </table>
  </form>
</div>
<script type="" src="<%=community.getJspAfter(teasession._nLanguage)%>"></script>
</body>
</html>
