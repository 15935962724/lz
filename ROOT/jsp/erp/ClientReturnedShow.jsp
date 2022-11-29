<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户退货单信息</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >


<%
//  if("ruku".equals(teasession.getParameter("act"))){
//    String purid = teasession.getParameter("purid");
//    RetreatGoods pobj = RetreatGoods.find(purid);
%>
<div id="lzi_rkd">
<h1>客户退货单信息</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td width="9%">客户名称：</td>
      <td width="24%"> 北京怡康科技有限公司 </td>
       <td nowrap>仓库名称：</td>
      <td colspan="2">
      北京仓库
      </td>
      </tr>
    <tr>
      <td nowrap>退货日期：</td>
      <td>2009-04-14</td>
      <td width="6%" nowrap>退货单号：</td>
      <td width="29%">20090414002</td>
    </tr>
  </table>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>规格型号</td>
                <td align="center" nowrap>品牌</td>
                <td align="center" nowrap>单位</td>
                <td align="center" nowrap>进价</td>
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>金额</td>
              </tr>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                <td>左旋C美白霜</td>
                <td>L</td>
                <td>奥瑞拉</td>
                <td>瓶</td>
                <td>600.00</td>
                <td>100</td>
                <td>60000&nbsp;元</td>
              </tr>

              <tr>
                <td colspan="4">&nbsp;</td>
                <td align="center">合计:</td>
                <td>100</td>
                <td>60000&nbsp;元</td>
              </tr>

            </table>
             <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
               <tr>
                 <td width="5%" nowrap>经办人：</td>
                 <td width="11%" id="jin1">管理员</td>
                 <td width="5%" nowrap>退货人：</td>
                 <td width="11%" id="jin1">张先生 </td>

                 <td width="4%" nowrap>备注：</td>
                 <td width="80%" id="jin2"></td>
               </tr>
          </table>

</div>


<%//} %>
<br>
<input type="button" value="关闭"  onClick="javascript:window.close();">
</body>
</html>
