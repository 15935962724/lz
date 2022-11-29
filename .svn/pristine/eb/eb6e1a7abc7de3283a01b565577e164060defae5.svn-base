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

Supplier supplier=Supplier.find(_nSupplier);


Community community=Community.find(teasession._strCommunity);

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
<script src="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></script>


            <div id="tablebgnone" class="cart1">
              <h1><%=r.getString(teasession._nLanguage, "填写收货地址")%></h1>
              <div id="head6"><img height="6" src="about:blank"></div>
			  <span id="gopath2"></span>
                <FORM name=foCheckout METHOD=POST action="/jsp/offer/CheckoutCat2s.jsp" onsubmit="return f_edit(this);">
                  <input type="hidden" name="nexturl" value="<%=nexturl%>" />
                  <input type="hidden" name="currency" value="<%=currency%>" />
                  <h2>列表-<%=supplier.getName(teasession._nLanguage)+" "+buys.length%></h2>
                  <table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
                    <tr ID=tableonetr>
                      <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
                      <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
                      <TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
                      <TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>

                    </tr>
                    <%
                    java.math.BigDecimal total = new java.math.BigDecimal(0.0D);
                    java.math.BigDecimal total_point = new java.math.BigDecimal(0.0D);
                    java.math.BigDecimal points = new java.math.BigDecimal(0.0D);//积分的总和
                    java.math.BigDecimal pointsinfo = new java.math.BigDecimal(0.0D);

java.util.ArrayList al=new  java.util.ArrayList();
                    for(int i=0;i<buys.length;i++)
                    {
                      int buy=Integer.parseInt(buys[i]);
                      Buy obj=Buy.find(buy);
                      int l = obj.getNode();
                      Node node = Node.find(l);

                      BuyPrice buyprice = BuyPrice.find(obj.getCommodity(), currency);
                      Commodity commodity = Commodity.find(obj.getCommodity());


                       al.add(new Integer(buy));


                      BigDecimal price = buyprice.getPrice();
                      int quantity = obj.getQuantity();
                      BigDecimal bigdecimal4 = new BigDecimal(quantity);
				
                      BigDecimal point = new BigDecimal("0");
                      if(buyprice.getPoint()!=null)
                      {
                    	  point = buyprice.getPoint();
                      }

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

                          </tr>
                          <%
                          }
                            session.setAttribute("list",al);
                          %>
                          <!-- 总共的价格 -->
                          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                            <td colspan="5">购买的商品数:<%=buys.length%>　价格合计:<%=s2+total%></td>
                          </tr>
                          <!-- 总共的个数 -->
                  </table>
                  <!-- 积分管理在这个表格里 -->

<!--收货地址 -->
<h2>填写收货地址</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
    <td><script>selectcard('state','city0','city','<%=p.getCity(teasession._nLanguage)%>');</script>
 </td>
  </tr>
  <tr>
    <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
    <td><textarea name=address rows=2 cols=40><%=p.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")%></textarea></td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=email value="<%=p.getEmail()%>" size=40 maxlength=40></td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=firstname value="<%=p.getFirstName(teasession._nLanguage)%>" size=20 maxlength=20>
    </td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=organization value="<%=p.getOrganization(teasession._nLanguage)%>" size=40 maxlength=40></td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=zip value="<%=p.getZip(teasession._nLanguage)%>" size=20 maxlength=20></td>

  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
    <td><input type="TEXT" class="edit_input"  name=telephone value="<%=p.getTelephone(teasession._nLanguage)%>" size=20 maxlength=20></td>

  </tr>
</table>

<input type="submit" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Continue")%>" >
<input type="button" class="edit_button" value="返回" onClick="history.back();" >
</FORM>

</div>

<script src="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></script>
</body>
</html>
