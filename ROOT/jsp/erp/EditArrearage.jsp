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
  <title>欠款提货单</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
       <script type="">
       function f_c()
       {
         var rs = window.showModalDialog('/jsp/erp/LookClient.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:657px;dialogHeight:405px;');
       }
       </script>
        <div id="lzi_rkd">
          <h1>欠款提货单</h1>
          <form action="/servlet/EditPurchase" method="POST" name="form1" onsubmit="return f_submit();">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td width="9%">客户名称：</td>
              <td width="24%"><input type="text" name="" value=""> &nbsp;<input type="button" value="查找" onblur="f_c();"/></td>
                  <td nowrap>仓库名称：</td>
                  <td colspan="2"><select name="waridname" class="lzj_huo">
                    <option value="0">---------------</option>
                      <option value="0">北京仓库</option>
                   </select>
                  </td>
            </tr>
            <tr>
              <td colspan="2"><input type="button" value="选择商品"  onclick="f_xuanze();">
              </td>
              <td nowrap>提货日期：</td>
              <td><input name="time_s" size="7" readonly="readonly"  value="">
                <A href="###"><img onclick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a> </td>
                <td width="6%" nowrap>提货单号：</td>
                <td width="29%"><input type="text" name="purchase" id="ruku" value="20090414002" readonly="readonly" style="background:#cccccc"></td>
            </tr>
          </table>
          <span id="show">
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
          </span>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td width="5%" nowrap>经办人：</td>
              <td width="11%" id="jin1"><select name="member" class="lzj_huo">
                <option value="">---------------</option> </select> </td>
                <td width="5%" nowrap>提货人：</td>
              <td width="11%" id="jin1"><select name="member" class="lzj_huo">
                <option value="">---------------</option> </select> </td>
                  <td width="5%" nowrap>首付金额：</td>
              <td width="11%" id="jin1"><input type="text" name="" value="" size="6"> &nbsp;元</td>
                <td width="4%" nowrap>备注：</td>
                <td width="80%" id="jin2"><input type="text" name="remarks" value=""  size="80"/></td>
            </tr>
          </table>
          <br>
          <input type="submit" value="保存欠款提货单"/>&nbsp;
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
