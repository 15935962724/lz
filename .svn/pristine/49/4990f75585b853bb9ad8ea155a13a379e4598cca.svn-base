<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl=request.getParameter("nexturl");
if(request.getParameter("changequantity") != null)//修改数量
{
  int i=0;
  do
  {
    String s1 =  request.getParameter("buy" + i);
    if(s1 != null)
    {
      int quantity = Integer.parseInt(request.getParameter("quantity" + i));
      Buy buy = Buy.find(Integer.parseInt(s1));
      buy.set(quantity);
      i++;
    } else
    {
      response.sendRedirect(nexturl);
      return;
    }
  } while(true);
}else if(request.getParameter("clearsc") != null)//清空购物车
{
  int i = 0;
  do
  {
    String s1 =  request.getParameter("buy" + i);
    if(s1 != null)
    {
      Buy buy = Buy.find(Integer.parseInt(s1));
      buy.delete();
      i++;
    } else
    {
      response.sendRedirect(nexturl);
      return;
    }
  } while(true);
}
String[] buys=request.getParameterValues("buys");
if("buys2".equals(teasession.getParameter("act")))
{
  buys = (String[])session.getAttribute("buys2");
}
if(buys==null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("请先选择商品!","UTF-8")+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}
int _nSupplier=-1;
for(int i=0;i<buys.length;i++)
{
  int buy=Integer.parseInt(buys[i]);
  Buy obj=Buy.find(buy);
  Commodity commodity = Commodity.find(obj.getCommodity());
  if(_nSupplier!=-1&&_nSupplier!=commodity.getSupplier())
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("请您选择相同的“供应商”提供的产品下定单.","UTF-8")+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
    return;
  }
  _nSupplier=commodity.getSupplier();
}
Resource r=new Resource("/tea/ui/member/offer/Offers");
int currency=Integer.parseInt(request.getParameter("currency"));
String s2 = r.getString(teasession._nLanguage, Common.CURRENCY[currency]);//货币种类
Profile p = Profile.find(teasession._rv._strR);
String s11 = p.getCountry(teasession._nLanguage);
java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm aaa");
Community community=Community.find(teasession._strCommunity);
Supplier supplier=Supplier.find(_nSupplier);

%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
            <script type="text/javascript">
            function f_ch_bank()
            {
              var trh=document.all('defray');
              var trb=document.getElementById('trbank');
              trb.style.display=trh[1]?"":"none";
            }
            function f_edit()
            {
              if(foCheckout.state.value=='' || foCheckout.city0.value=='' || foCheckout.city.value=='' )
              {
                alert("省洲不能为空！");
                return false;
              }
              if(foCheckout.address.value=='')
              {
                alert("收货地址不能为空!");
                return false;
              }
              if(foCheckout.email.value=='')
              {
                alert("Email不能为空!");
                return false;
              }

              if(foCheckout.firstname.value=='')
              {
                alert("姓名不能为空!");
                return false;
              }
              if(foCheckout.organization.value=='')
              {
                alert("单位不能为空!");
                return false;
              }

              if(foCheckout.zip.value=='')
              {
                alert("邮编不能为空!");
                return false;
              }
              if(foCheckout.telephone.value=='')
              {
                alert("电话不能为空!");
                return false;
              }


            }
            </script>
            </head>
            <body id="bodynone">
            <div id="jspbefore" style="display:none"> <%=community.getJspBefore(teasession._nLanguage)%> </div>
            <div id="tablebgnone" class="cart1">
              <h1><%=r.getString(teasession._nLanguage, "填写收货地址")%></h1>
              <div id="head6"><img height="6" src="about:blank"></div>
			  <span id="gopath2"></span>
                <FORM name=foCheckout METHOD=POST action="/jsp/offer/CheckoutCart2.jsp" onsubmit="return f_edit(this);">
                  <input type="hidden" name="nexturl" value="<%=nexturl%>" />
                  <input type="hidden" name="currency" value="<%=currency%>" />
                  <h2>列表-<%=supplier.getName(teasession._nLanguage)+" "+buys.length%></h2>
                  <table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
                    <tr ID=tableonetr>
                      <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
                      <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
                      <TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
                      <TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>
                      <TD><%=r.getString(teasession._nLanguage, "Point")%></TD>
                    </tr>
                    <%
                    java.math.BigDecimal total = new java.math.BigDecimal(0.0D);
                    java.math.BigDecimal total_point = new java.math.BigDecimal(0.0D);
                    java.math.BigDecimal points = new java.math.BigDecimal(0.0D);//积分的总和
                    java.math.BigDecimal pointsinfo = new java.math.BigDecimal(0.0D);


                    for(int i=0;i<buys.length;i++)
                    {
                      int buy=Integer.parseInt(buys[i]);
                      Buy obj=Buy.find(buy);
                      int l = obj.getNode();
                      Node node = Node.find(l);

                      BuyPrice buyprice = BuyPrice.find(obj.getCommodity(), currency);
                      Commodity commodity = Commodity.find(obj.getCommodity());


                      BigDecimal price = buyprice.getPrice();
                      int quantity = obj.getQuantity();
                      BigDecimal bigdecimal4 = new BigDecimal(quantity);

                      BigDecimal point = buyprice.getPoint();
                      //  if(buyprice.getOptions() == 0)
                      //  {
                        //  point = price.multiply(bigdecimal4).multiply(point);
                        //  }
                        //  else
                        //  {
                          //    point = point.multiply(bigdecimal4);
                          //  }
                          if(buyprice.getOptions() == 0)
                          {
                            point = point.multiply(bigdecimal4);
                          }
                          else
                          {
                            point = point.multiply(bigdecimal4);
                          }
                          points = points.add(point);

                          total=total.add(price.multiply(bigdecimal4));
                          total_point =price.multiply(bigdecimal4);
                          out.print("<input type=hidden name=buys value="+buy+">");
                          %>
                          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                            <td nowrap><%=sdf.format(obj.getTime())%></td>
                            <td nowrap><a href="/servlet/Node?node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
                            <td><%=s2+price%></td>
                            <td><%=obj.getQuantity()%></td>
                            <td><%=point.intValue()%></td>
                          </tr>
                          <%
                          }
                          %>
                          <!-- 总共的价格 -->
                          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                            <td colspan="5">购买的商品数:<%=buys.length%>　价格合计:<%=s2+total%></td>
                          </tr>
                          <!-- 总共的个数 -->
                  </table>
                  <!-- 积分管理在这个表格里 -->
                  <h2>积分</h2>
                  <table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
                    <tr>
                      <td height="32"> 您本次购买将获得本站积分<%=points.intValue()%>分<input type="hidden" name="totals" value="<%=total.intValue()%>" /></td>
                    </tr>
                    <!--tr>
                    <td><table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><%=supplier.getName(teasession._nLanguage)%></td>
                        <td><input type="text" name="point"></td>
                          <td>请在此处填写您<%=supplier.getName(teasession._nLanguage)%>的积分卡号，如果没有可以为空；</td>
                      </tr>
                  </table></td>
</tr-->
</table>
<!--收货地址 -->
<h2>填写收货地址</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
    <td><script>selectcard('state','city0','city','');</script>
    <%--
    <select name="state">
      <option value="">--------------</option>
      <%
      for(int bstate_i=0;bstate_i<Common.PROVINCE.length;bstate_i++)
      {
      out.print("<option value="+Common.PROVINCE[bstate_i]);
      if(Common.PROVINCE[bstate_i].equals(p.getState(teasession._nLanguage)))
      {
      out.print(" SELECTED ");
      }
      out.print(" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[bstate_i]));
      }
      %>
    </select>
    <%=r.getString(teasession._nLanguage, "City")%>:
    <input type="TEXT" class="edit_input"  name=city value="<%=p.getCity(teasession._nLanguage)%>" size=20 maxlength=20>
    --%>
 </td>
  </tr>
  <tr>
    <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
    <td><textarea name=address rows=2 cols=40><%=p.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")%></textarea></td>
    <td>*我们将根据此地址发送您选的商品并计算发货费用；</td>
  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=email value="<%=p.getEmail()%>" size=40 maxlength=40></td>
      <td>*我们会通过邮件形式通知您发货情况；</td>
  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=firstname value="<%=p.getFirstName(teasession._nLanguage)%>" size=20 maxlength=20>
    </td>
    <td>*接收时需要接受人签字；</td>
  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=organization value="<%=p.getOrganization(teasession._nLanguage)%>" size=40 maxlength=40></td>
      <td>*指明接收单位，以免地址有误时错送；</td>
  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=zip value="<%=p.getZip(teasession._nLanguage)%>" size=20 maxlength=20></td>
      <td>*正确填写，以方便发货方更快的找到您；</td>
  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
    <td><input type="TEXT" class="edit_input"  name=telephone value="<%=p.getTelephone(teasession._nLanguage)%>" size=20 maxlength=20></td>
      <td>*紧急联系方式，请正确填写。</td>
  </tr>
</table>
<h2>配送方式</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
    <td nowrap ><input name="ps" type="radio" value="0" checked>
      平邮 </td>
      <td> 如果您不急于使用此商品可以考虑选择平邮，此种方式邮购费由本公司负责； </td>
  </tr>
  <!--tr>
    <td nowrap ><input name="ps" type="radio" value="0" checked>
      平邮 </td>
      <td> 如果您不急于使用此商品可以考虑选择平邮，此种方式邮购费用最低但邮递时间很长； </td>
  </tr-->
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input name="ps" type="radio" value="1">
      快递</td>
      <td>此方式邮递时间很短，但费用需要自己缴纳，且需要与我们联系； </td>
  </tr>
  <!--tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input name="ps" type="radio" value="1">
      快递</td>
      <td> 此方式邮递时间很短，但需要携带个人相关证件到快地公司去取，费用也相应贵些； </td>
  </tr-->
  <!--tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input name="ps" type="radio" value="2">
      EMS</td>
      <td> 邮政特快专递服务，是中国邮政的一个服务产品，主要是采取空运方式，加快递送速度，一般来说根据地区远近，1－4天到达。 </td>
  </tr-->
</table>
<h2>支付方式</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

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
        <td align="center"> <input type="radio" name="defray" value="<%=piid%>" <%if(piid==1)out.print(" checked=checked "); %>  ></td>
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
          <input type="radio" name="defray" value="<%=piid2%>" id="lzj_an">
          </td>
          <td align="center"><b><%= piobj2.getPayname() %></b></td>
          <td><span id=lzj_fu><%=piobj2.getPaycontent()%></span></td>
        </td>
      </tr>
    <%
    }

    if(!e.hasMoreElements() && !e2.hasMoreElements())
    {
      out.print("<tr><td>暂无支付方式，请联系管理员！</td></tr>");
    }
    %>
      </table>
<%--
  <!--tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td>其它支付 </td>
  <td><input name="defray" type="radio" value="10">双象卡
    <input name="defray" type="radio" value="11">电话银行
    <input name="defray" type="radio" value="12">银行电汇</td>
</tr-->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td nowrap >网上支付</td>
  <td>

  <input name="defray" type="radio" value="1" checked>快钱
  <input name="defray" type="radio" value="2" >云网
  <input name="defray" type="radio" value="3" >网银在线
 </td>
</tr> --%>
</table>


<h2>发票</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><input name="fp" type="radio" value="false" checked="checked" />
</td>
<td> 不要发票 </td>
  </tr>
  <tr>
    <td><input name="fp" type="radio" value="true">
    </td>
    <td> 要发票 </td>
  </tr>
</table>
<input type="submit" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Continue")%>" >
<input type="button" class="edit_button" value="返回" onClick="history.back();" >
</FORM>
<div id="jspafter" style="display:none"> <%=community.getJspAfter(teasession._nLanguage)%> </div>
<script>
 if(top.location==self.location)
{
   jspbefore.style.display='';
   jspafter.style.display='';
 }
</script></div>
</body>
</html>
