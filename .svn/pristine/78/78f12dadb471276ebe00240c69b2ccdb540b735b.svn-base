<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="java.math.*" %>
<%@page import="java.text.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;
}
String url = request.getParameter("url");
String code = request.getParameter("code");


Resource r=new Resource("/tea/ui/member/offer/Offers").add("/tea/ui/member/offer/ShoppingCarts").add("/tea/ui/member/Glance");



if("delete".equals(request.getParameter("act")))
{
	  Buy buy = Buy.find(Integer.parseInt(request.getParameter("CartItem")));
	  buy.delete();
	  response.sendRedirect("/jsp/admin/phoneorder/order_list.jsp?code="+code+"&url="+url);
	  return ;
}
int i = 0;


SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd HH:mm aaa");
DecimalFormat df = new DecimalFormat("#,###0.00");

Community community=Community.find(teasession._strCommunity);

String s="¥";

Profile p = Profile.find(code);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<script language="javascript" src="/tea/load.js"  type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<script>
	function yanzheng()
	{
		var codepw = form1.codepw.value;
		var kahao = form1.kahao.value;
		//alert(kahao);
		if(codepw=='')
		{
			alert("请您输入密码!");
			return;
		}
		currentPos = "show";
		send_request("/jsp/admin/phoneorder/order_input_ajax.jsp?codepw="+codepw+"&kahao="+kahao);

	}
	function sub()
	{
		if(form1.codepw.value=='')
		{
			alert("密码不能为空");
			return false;
		}
		if(form1.city.value=='')
		{
			alert("城市不能为空!");
			return false;
		}

	}
	function f_citychange()
{
  var sf=document.getElementById("span_freight");
  var state_v=form1.state.value;//省份
  var city_v=form1.city0.value;//市
  var city = form1.city.value;//县

  var freight="0.00";
  var t = parseInt(form1.total.value);

  if(city_v.length<1)
  		freight="请先选择收货地址";

  var str ='';



	if(form1.community.value=='9000gw')
	{
		if(state_v=='21' && city_v=='2101' && (city=='210102' || city=='210103' || city=='210104' || city=='210105' || city=='210106')){//同城
			 freight="5.00";//"12.00
			    if(t>100)
				  {
				  		freight ="0.00";
				  }
				str ='(沈阳超市物流配送范围：和平、沈河、大东、铁西、皇姑 5元超过100免费)';
		}else{
			alert("沈阳超市物流配送范围：和平、沈河、大东、铁西、皇姑，请重新选择城市");
			form1.city.value='';
		}

	}
  sf.innerHTML="配送运费:"+freight+str;
  form1.freight.value = freight;
}

function f_load()
{
  form1.city.attachEvent("onchange",f_citychange);
  f_citychange();
}
</script>
<body onLoad="f_load();" id="bodynone">
<h1>录入信息</h1>
<div id="head6"><img height="6" alt=""></div>

<form action="/servlet/EditOrderInput" method="post" name="form1"  onsubmit="return sub();">
<input type="hidden" name ="act" value="order_list">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	  <tr><td colspan="10" id="gouwuchebg">&nbsp;</td></tr>
      <tr id=tableonetr>
        <td>　</td>
        <td><%=r.getString(teasession._nLanguage, "提交时间")%></td>

        <td><%=r.getString(teasession._nLanguage, "商品编号")%></td>
        <td><%=r.getString(teasession._nLanguage, "交易内容")%></td>
        <td><%=r.getString(teasession._nLanguage, "折扣价")%></td>

        <td><%=r.getString(teasession._nLanguage, "数量")%></td>
        <td>积分</td>
        <td colspan="2"><%=r.getString(teasession._nLanguage, "合计")%></td>
      </tr>
      <%
      int j = 0;
      java.math.BigDecimal total = new java.math.BigDecimal(0.0D);
int freight =0;


      java.util.Enumeration e2 = Buy.findBuys(teasession._strCommunity," and rmember="+DbAdapter.cite(code)+" and lurumember ="+DbAdapter.cite(teasession._rv.toString()));
      if(!e2.hasMoreElements())
      {
      		response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info="
								+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "购物车中没有商品，请您选购商品"), "UTF-8") + "&nexturl="+url);
						return;
      }
      while(e2.hasMoreElements())
      {
        int k = ((Integer)e2.nextElement()).intValue();
        Buy buy = Buy.find(k);
        int l = buy.getNode();
        Node node = Node.find(l);

        BuyPrice buyprice = BuyPrice.find(buy.getCommodity(), buy.getCurrency());
        Commodity commodity = Commodity.find(buy.getCommodity());


		 BigDecimal price = buyprice.getPrice();
        int quantity = buy.getQuantity();
        BigDecimal bigdecimal4 = new BigDecimal(quantity);
        BigDecimal sum = price.multiply(bigdecimal4);
        total=total.add(sum);


%>
      <tr id="<%=j%2!=0?"true":"flase"%>" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td><%
        out.print("<input type=checkbox name=buys value="+k);

        out.print(" checked >");

        %></td>

        <td nowrap id="time"><%=sdf.format(buy.getTime())%></td>


        <td><%=commodity.getSerialNumber()%></td>
        <td nowrap><a href="/servlet/Node?Node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
        <td><%=s+df.format(price)%></td>

        <td align=CENTER><%=quantity%></td>
        <td align=right><%=sum.intValue()%></td>
        <td align=right><%=s+df.format(sum.setScale(2,4))%></td>
        <td id="delete"><input name="button"  type="button" class="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))window.open('/jsp/admin/phoneorder/order_list.jsp?CartItem=<%=k%>&act=delete&code=<%=code %>&url=<%=url %>','_self');" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"/>        </td>
      </tr>
      <%
           j++;
         }



         %>
      <tr id="xj">
        <td>&nbsp;</td>
        <td><%=r.getString(teasession._nLanguage, "SubTotal")%>:</td>
        <td colspan="8" id="price2"><%=s+df.format(total)%></td>

             <input type=hidden name=total value="<%=total%>" >

      </tr>

      <tr id="yf">
        <td>&nbsp;</td>

        <td><span id="span_freight"></span> </td>
        <input type=hidden name="freight" value="<%=freight%>" >
      </tr>
    </table>

<hr>
	 <!--收货地址 -->

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
   <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
      <Td id="left"><%=r.getString(teasession._nLanguage, "福利卡号")%>:</Td>
      <td><%

      	if(code!=null && !code.equals("null"))
      	{
      		out.print(code);
      		out.print("<input type=hidden name=\"kahao\" value="+code);
      	}else
      	{
      		out.print("<input type=\"text\" name=\"kahao\" value=\"\" size=40>");
      	}
       %> </td>
      <td >&nbsp;</td>
    </tr>
   <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
      <Td id="left"><%=r.getString(teasession._nLanguage, "福利密码")%>:</Td>
      <td><input type="password"  class="edit_input"  name="codepw" value="" size=40 maxlength=40>　&nbsp;
      <input type="button" value="验证密码" onClick="return yanzheng();">
        </td>
      <td id="show"><span class="goju">*</span>系统验证福利卡密码</td>
    </tr>
    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
      <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
      <td><script>selectcard('state','city0','city','<%if(p.getCity(teasession._nLanguage)!=null)out.print(p.getCity(teasession._nLanguage));else{out.print("210102&辽宁省 沈阳市 和平区");}%>');</script></td><td id="cart1right">　</td>
    </tr>
    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
      <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
      <td><textarea name=address rows=2 cols=40><%if(p.getAddress(teasession._nLanguage)!=null)out.print(p.getAddress(teasession._nLanguage)); %></textarea></td>
      <td><span class="goju">*</span>将根据此地址发送您选的商品并计算发货费用；</td>
    </tr>
    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
      <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
      <td><input type="TEXT" class="edit_input"  name=email value="<%if(p.getEmail()!=null)out.print(p.getEmail()); %>" size=40 maxlength=40>　
        </td>
      <td><span class="goju">*</span>我们会通过邮件形式通知您发货情况；</td>
    </tr>
    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
      <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
      <td><input type="TEXT" class="edit_input"  name=firstname value="" size=20 maxlength=20></td>
      <td><span class="goju">*</span>接收时需要接受人签字；</td>
    </tr>
    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
      <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
      <td><input type="TEXT" class="edit_input"  name=organization value="<%if(p.getOrganization(teasession._nLanguage)!=null)out.print(p.getOrganization(teasession._nLanguage)); %>" size=40 maxlength=40></td>
      <td><span class="goju">*</span>指明接收单位，以免地址有误时错送；</td>
    </tr>
    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
      <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
      <td><input type="TEXT" class="edit_input"  name=zip value="<%if(p.getZip(teasession._nLanguage)!=null)out.print(p.getZip(teasession._nLanguage)); %>" size=20 maxlength=20>　
        </td>
      <td><span class="goju">*</span>正确填写，以方便发货方更快的找到您；</td>
    </tr>
    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
      <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=telephone value="<%if(p.getTelephone(teasession._nLanguage)!=null)out.print(p.getTelephone(teasession._nLanguage));%>" size=20 maxlength=20>　
        </td>
      <td><span class="goju">*</span>紧急联系方式，请正确填写。</td>
    </tr>
  </table>
   <div align="center">
          <input type="submit" name="Submit" value="生成新订单">&nbsp;
          <input type="reset" name="reset" value="重    置">&nbsp;
          <input type="button" name="reset" value="返    回" onClick="javascript:history.go(-1)">
          <input type="hidden" name="condition" value="">
      </div>

</form>
</body>
</HTML>
