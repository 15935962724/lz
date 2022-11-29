<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@ page import="tea.entity.league.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


StringBuffer param=new StringBuffer("?node="+teasession._nNode);
StringBuffer sql=new StringBuffer(" WHERE n.community="+tea.db.DbAdapter.cite(teasession._strCommunity)+" AND n.node=g.node ");
StringBuffer from=new StringBuffer(" FROM Node n,Goods g");
StringBuffer strs = new StringBuffer("");
String jilu ="";
if(teasession.getParameter("jilu")!=null&& teasession.getParameter("jilu").length()>0)
{
  jilu = teasession.getParameter("jilu");
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<body>
<script type="text/javascript">
window.name='tar';

function f_button(igd)
{
  window.returnValue=igd;
  window.close();
}
function f_goodstype(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?goodstype2="+igd+"&act=goodstype&father="+form1.goodstype1.value,
  function(data)
  {
    document.getElementById('show').innerHTML=data;
  }
  );
}
</script>
<h1>选择半成品</h1>
<h2>查询</h2>
<form name="form1" action="?" method="GET" target="tar">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>商品编号：&nbsp;<input type="text" name="number" value=" "/></td>
      <td nowrap>商品名称：&nbsp;<input type="text" name="subject" value=""/></td>
  </tr>
  <tr>
    <td nowrap>商品规格：&nbsp;<input type="text" name="spec" value=""/></td>
      <td><input type="submit" value="查询"/></td>
  </tr>
</table>
<h2>列表( <span id=spancount>0</span> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td  width="1"></td>
      <td nowrap>商品编号</td>
      <td nowrap>商品名称</td>
      <td nowrap>规格型号</td>
      <td nowrap>品牌</td>
      <td nowrap>单位</td>
      <td nowrap>进价</td>
  </tr>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_button('ss1');" title="点击表格可以添加商品"  style="cursor:pointer">
    <td  width="1"></td>
      <td nowrap>B-7896</td>
      <td nowrap>原油</td>
      <td nowrap></td>
      <td nowrap>奥瑞拉</td>
      <td nowrap>奥瑞拉</td>
      <td nowrap>540.00</td>
  </tr>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_button('ss2');" title="点击表格可以添加商品"  style="cursor:pointer">
    <td  width="1"></td>
      <td nowrap>B-7899</td>
      <td nowrap>包装盒</td>
      <td nowrap></td>
      <td nowrap>唯美度</td>
      <td nowrap>唯美度</td>
      <td nowrap>213.00</td>
  </tr>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_button('ss3');" title="点击表格可以添加商品"  style="cursor:pointer">
    <td  width="1"></td>
      <td nowrap>B-7888</td>
      <td nowrap>玻璃瓶子</td>
      <td nowrap></td>
      <td nowrap>唯美度</td>
      <td nowrap>唯美度</td>
      <td nowrap>213.00</td>
  </tr>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_button('ss4');" title="点击表格可以添加商品"  style="cursor:pointer">
    <td  width="1"></td>
      <td nowrap>B-7858</td>
      <td nowrap>精品包装盒</td>
      <td nowrap></td>
      <td nowrap>唯美度</td>
      <td nowrap>唯美度</td>
      <td nowrap>213.00</td>
  </tr>
</table>
<input type="button" value="关闭"  onClick="javascript:window.close();">
</form>
</body>
</html>
