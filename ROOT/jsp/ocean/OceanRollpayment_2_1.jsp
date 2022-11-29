<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>

<%
TeaSession teasession = new TeaSession(request);

String oceanorder=teasession.getParameter("oceanorder");

String paytype="",paytype2="",paytype3="",paytype4="",paytype5="";
int type=0;
if(teasession.getParameter("paytype")!=null && teasession.getParameter("paytype").length()>0)
{
  paytype=teasession.getParameter("paytype");
  type=1;
}
if(teasession.getParameter("paytype2")!=null && teasession.getParameter("paytype2").length()>0)
{
  paytype2=teasession.getParameter("paytype2");
  type=2;
}

if(teasession.getParameter("paytype3")!=null && teasession.getParameter("paytype3").length()>0)
{
  paytype3=teasession.getParameter("paytype3");
  type=3;
}

if(teasession.getParameter("paytype4")!=null && teasession.getParameter("paytype4").length()>0)
{
  paytype4=teasession.getParameter("paytype4");
  type=4;
}

if(teasession.getParameter("paytype5")!=null && teasession.getParameter("paytype5").length()>0)
{
  paytype5=teasession.getParameter("paytype5");
  type=5;
}

if(teasession.getParameter("paytype")!=null && teasession.getParameter("paytype").length()>0)
{
  paytype=teasession.getParameter("paytype");
  type=1;
}

%>
<html>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<body bgcolor="#ffffff">
<h1>
<font color="#cccccc"> 1.填写海洋护照登记表>> 2.选择支付方式  >></font><font color="#000"> 3.确认支付金额 >> </font> <font color="#cccccc"> 4.交易成功</font>
</h1>
<form action="">

<table width="200" border="0" id="tablecenter">
  <!--tr>
    <td colspan="2" nowrap><IMG alt="step11" src="/tea/image/oceanRoll/pay_step_12.gif" > 选择支付方式 &gt;&gt;  <IMG alt="step22" src="/tea/image/oceanRoll/pay_step_21.gif"> 确认充值金额 &gt;&gt;  <IMG alt="step32" src="/tea/image/oceanRoll/pay_step_32.gif"> 充值成功 </td>
  </tr-->
  <tr>
    <td colspan="2"  >&nbsp;</td>
  </tr>
  <tr>
    <td width="128" nowrap>支付方式：</td>
    <td>
    <%
    if(type==1)
    {
      %>
      <img src="/tea/image/oceanRoll/alipay.jpg" width="164" height="73" alt="">
      <%
      }else    if(type==2)
      {
        %>
        <img src="/tea/image/oceanRoll/bank1.gif" width="164" height="73" alt="">
        <%
        }else    if(type==3)
        {
          %>
          <img src="/tea/image/oceanRoll/yeepay.jpg" width="164" height="73" alt="">
          <%
          }else    if(type==4)
          {
            %>
            <img src="/tea/image/oceanRoll/vnet.jpg" width="164" height="73" alt="">
            <%
            }else    if(type==5)
            {
              %>
              <img src="/tea/image/oceanRoll/99bill1.gif" width="164" height="73" alt="">
              <%
              }
              %>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>应付金额：
      <label style="color:#FF0000"></label></td>
      <td><label style="color:#FF0000">300</label>
        元</td>
  </tr>
  <tr>
    <td>
      <form name="form1" method="post" action="/jsp/ocean/OceanSuccess.jsp">
    <input name="oceanorder" type="hidden" value="<%=oceanorder%>">
      <label>
        <input  type="submit" name="button"  value="进入下一步" onclick="window.open('/jsp/ocean/OceanSuccess.jsp?oceanorder=<%=oceanorder%>','_self')">
      </label>
</form>
    </td>
    <td><form action="">
      <label>
        <input type="button" name="button2" id="button2" value="取消" onclick="window.history.back();">
      </label>
</form>
    </td>
  </tr>
</table>
</form>
</body>
</html>
