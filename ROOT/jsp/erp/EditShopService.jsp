<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.math.*" %>
<%@page import="java.util.*" %>
<%

request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

int shopservice=Integer.parseInt(request.getParameter("shopservice"));
String no="",name="",spec="";
boolean dtype=false;
int brand=0;
float deduct=1.00F,point=0F;
BigDecimal price=BigDecimal.ONE;
if(shopservice>0)
{
  ShopService ss=ShopService.find(shopservice);
  no=ss.getNo();
  name=ss.getName();
  dtype=ss.isDType();
  deduct=ss.getDeduct();
  point=ss.getPoint();
  spec=ss.getSpec();
  price=ss.getPrice();
  brand=ss.getBrand();
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>添加/编辑服务项目</title>
</head>
<body id="bodynone" onload="form1.no.focus();">
<h1>添加/编辑服务项目</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditShopService" onsubmit="return submitText(this.brand,'无效-品牌')&&submitText(this.no,'无效-编码')&&submitText(this.name,'无效-名称');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="shopservice" value="<%=shopservice%>"/>
<input type="hidden" name="nexturl" value="/jsp/erp/ShopServices.jsp"/>
<input type="hidden" name="act" value="edit"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>品牌:</td>
    <td>
    <select name="brand"><option value="">---------------</option>
    <%
    Enumeration e=Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
    while(e.hasMoreElements())
    {
      int id=((Integer)e.nextElement()).intValue();
      out.print("<option value="+id);
      if(id==brand)out.print(" selected='true'");
      out.print(">"+Brand.find(id).getName(teasession._nLanguage));
    }
    %>
    </select>
    </td>
  </tr>
  <tr>
    <td>编码:</td>
    <td><input name="no" type="text" value="<%=no%>"></td>
  </tr>
  <tr>
    <td>名称:</td>
    <td><input name="name" type="text" value="<%=name%>"></td>
  </tr>
  <tr>
    <td>服务价:</td>
    <td><input name="price" type="text" value="<%=price%>" mask="float"></td>
  </tr>
  <tr>
    <td>规格:</td>
    <td><input name="spec" type="text" value="<%=spec%>" size="40" ></td>
  </tr>
  <tr>
    <td>提成类型:</td>
    <td>
      <input name="dtype" type="radio" value="false" checked="checked" id="dtype0" /><label for="dtype0">基于系数</label>
      <input name="dtype" type="radio" value="true" id="dtype1" <%if(dtype)out.print(" checked='true'");%> /><label for="dtype1">基于数量</label>
    </td>
  </tr>
	<tr>
      <td>提成量:</td>
      <td><input name="deduct" type="text" value="<%=deduct%>" mask="float"></td>
    </tr>
	<tr>
      <td>积分:</td>
      <td><input name="point" type="text" value="<%=point%>" mask="float"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" value="保存">
      <input type="button" value="返回" onclick='history.back();'></td>
    </tr>
</table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
