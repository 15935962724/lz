<%@page import="tea.entity.westrac.IntegralMyScore"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="tea.entity.member.*" %>
<%@ page import="tea.entity.integral.*"%>
<jsp:directive.page import="java.math.BigDecimal"/>
<jsp:directive.page import="java.net.URLEncoder"/>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

Resource r=new Resource();






 
int id = 0;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
{
	id = Integer.parseInt(teasession.getParameter("id"));
}

IntegralPrize obj = IntegralPrize.find(id);	

if(!obj.isExists())
{
	out.print("您的参数有问题，请检查....");
	return;
}

String shoppings = "";
int shopint = 0;
 String coding="";//商品编码
 String recomm="";//小编推荐
 String text="";//奖品介绍
 String explain="";//使用说明
 String dpic=null;//小图和大图
 
 if(obj.isExists())
 {
  shoppings = obj.getShopping();
  shopint = obj.getShop_integral();
  
   coding=obj.getCoding();//商品编码
   recomm=obj.getRecomm();//小编推荐
   text=obj.getText();//奖品介绍
   explain=obj.getExplain();//使用说明

   dpic=obj.getDpic(); 

} 
%>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script>

	function f_ymig() 
	{
		ymPrompt.win('/jsp/integral/IntegralExchange.jsp?t='+new Date().getTime()+'&igid='+formwmember.id.value,600,300,'礼品兑换',null,null,null,true);
	} 
	
</script>
<form action="?" method="POST" enctype="multipart/form-data" name="formwmember" >
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="Node" value="<%=teasession._nNode%>"/>

<input type="hidden" name="id" value="<%=id%>">
<div class="GoodsShowTop">
<div class="title">商品详细</div>
<table border="0" cellpadding="0" cellspacing="0">
<tr><td class="left"><img src="<%=dpic %>" width="300"></td><td class="right"><div class="name"><%=shoppings%></div>
<div class="coding">商品编码：<span><%=coding %></span></div>
<div class="shopint">商品积分：<span><%=shopint%></span></div>
<div class="recomm">小编推荐：<span><%=recomm %></span></div>
<div class="ProductEva"><font>产品评价</font>


<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">

 <tr id="tableonetr"> 
      <td nowrap >1分</td>
       <td nowrap id="scoreid"><div style="width:<%=IntegralMyScore.getMembericon(teasession._strCommunity,id,IntegralMyScore.count(teasession._strCommunity," and ipid="+id+" and score =1 ")) %>;height:5px"></div></td>
</tr>
<tr id="tableonetr">
  
      <td nowrap >2分</td> 
      <td nowrap  id="scoreid"><div style="width:<%=IntegralMyScore.getMembericon(teasession._strCommunity,id,IntegralMyScore.count(teasession._strCommunity," and ipid="+id+" and score =2 ")) %>;height:5px"></div></td>
</tr>
<tr id="tableonetr">
 
      <td nowrap >3分</td>
       <td nowrap id="scoreid"><div style="width:<%=IntegralMyScore.getMembericon(teasession._strCommunity,id,IntegralMyScore.count(teasession._strCommunity," and ipid="+id+" and score =3 ")) %>;height:5px"></div></td>
</tr>
<tr id="tableonetr">
 
      <td nowrap >4分</td>
       <td nowrap id="scoreid"><div style="width:<%=IntegralMyScore.getMembericon(teasession._strCommunity,id,IntegralMyScore.count(teasession._strCommunity," and ipid="+id+" and score =4 ")) %>;height:5px"></div></td>
</tr>
<tr id="tableonetr">
 
      <td nowrap >5分</td>
       <td nowrap id="scoreid"><div style="width:<%=IntegralMyScore.getMembericon(teasession._strCommunity,id,IntegralMyScore.count(teasession._strCommunity," and ipid="+id+" and score =5 ")) %>;height:5px"></div></td>
</tr>
 
</table>



</div>
</td></tr></table>
</div>
<div class="GoodsShowMiddle"><input type="button" value="立即兑换" onClick="f_ymig();"></div>
<div class="GoodsShowBottom">
<div class="title">商品介绍</div>
<table border="0" cellpadding="0" cellspacing="0">
 <tr>
<td class="left">礼品概述：</td>
    <td>
    <%=text %>
    </td>
  </tr>
<tr><td class="left">使用说明：</td><td><%=explain %></td></tr>
</table>
</div>
</form>

