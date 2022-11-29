<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.util.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl=request.getParameter("nexturl");
System.out.println("提交成功---1");
java.util.ArrayList al = (ArrayList) session.getAttribute("list");
String [] buys = new String[al.size()];

for(int i=0;i<al.size();i++)
{
  buys[i]=((Integer)al.get(i)).toString();
}



String point = request.getParameter("point");
int supplier = 0;//Integer.parseInt(request.getParameter("supplier"))
BigDecimal total = new BigDecimal(request.getParameter("total")); //总计
BigDecimal freight = new BigDecimal("0"); //运费
String state = request.getParameter("state");
String city = request.getParameter("city");
String address = request.getParameter("address");
String email = request.getParameter("email");
String firstname = request.getParameter("firstname");
String lastname = request.getParameter("lastname");
String organization = request.getParameter("organization");
String zip = request.getParameter("zip");
String telephone = request.getParameter("telephone");
int ps = 0; // 配送方式
int defray =0; // 支付方式
int fp =0;
String fptt = request.getParameter("fptt");
//String buys[] = request.getParameterValues("buys");
System.out.println("提交成功---2");
Profile p = Profile.find(teasession._rv._strV);
p.setState(state, teasession._nLanguage);
p.setCity(city, teasession._nLanguage);
p.setAddress(address, teasession._nLanguage);
//p.setEmail(email,teasession._nLanguage);
p.setEmail(email);
p.setFirstName(firstname, teasession._nLanguage);
p.setLastName(lastname, teasession._nLanguage);
p.setOrganization(organization, teasession._nLanguage);
p.setZip(zip, teasession._nLanguage);
p.setTelephone(telephone, teasession._nLanguage);
System.out.println("提交成功---3");
//String tradedddd = Trade.createByBuys(teasession._strCommunity, teasession._rv, 0, point, supplier, total.add(freight), freight, teasession._nLanguage, state, city, address, email, firstname,
//
//lastname, organization, zip, telephone, ps, defray, fp, fptt, buys);

   java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yyyyMMdd");
       Date time = new Date();
        String trade = ymd.format(time) + tea.entity.SeqTable.getSeqNo("trade");
        DbAdapter db = new DbAdapter();
        try
        {
            db.setAutoCommit(false);
            db.executeUpdate("INSERT INTO trade (trade,community,rcustomer,vcustomer,status,point,supplier,total,freight,language,state,city,address,email,firstname,lastname,organization,zip,telephone,ps,defray,paystate,fp,fptt,time,clanguage)"
                                   +" VALUES(" + DbAdapter.cite(trade) + "," + DbAdapter.cite(teasession._strCommunity)
                                   + "," + DbAdapter.cite(teasession._rv.toString()) + "," + DbAdapter.cite(teasession._rv.toString()) + "," + 0 + "," + DbAdapter.cite(point)
                                   + "," + supplier + "," + total + "," + freight + "," + teasession._nLanguage + "," + DbAdapter.cite(state) + "," + DbAdapter.cite(city)
                                   + "," +DbAdapter.cite(address) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(firstname) + "," + DbAdapter.cite(lastname)
                                   + "," + DbAdapter.cite(organization) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(telephone) + "," + ps + "," + defray + ",0," +fp
                                   + "," + DbAdapter.cite(fptt) + "," + DbAdapter.cite(time) + "," + teasession._nLanguage + "  )");
            int k1;
            for(int i = 0;i < buys.length;i++)
            {
                k1 = Integer.parseInt(buys[i]);
                Buy buy = Buy.find(k1);

                int commodity = buy.getCommodity();
                BuyPrice bp_obj = BuyPrice.find(commodity,buy.getCurrency());
                int l1 = buy.getNode();
                System.out.println(buy.getNode());
                int j2 = buy.getQuantity();
                db.executeUpdate("INSERT INTO tradeitem (trade,time,node,subject,price,quantity )VALUES( " + DbAdapter.cite(trade) + "," + DbAdapter.cite(time)
                + ", " + l1 + "," + DbAdapter.cite(Node.find(l1).getSubject(teasession._nLanguage)) + ", " + bp_obj.getPrice() + "," + j2 + ")");
                // 更改购买表中的总量
                db.executeUpdate("UPDATE Commodity SET inventory=inventory-" + j2 + " WHERE goods=" + l1);
                db.executeUpdate("UPDATE Buy SET status=" + 2 + " WHERE buy =" + k1);
            }
            db.commit();
        } catch(Exception ex)
        {
            try
            {
                db.rollback();
            } catch(Exception _ex)
            {
            }

        } finally
        {
            try
            {
                db.setAutoCommit(true);
            } catch(Exception _ex)
            {
            }
            db.close();
        }


//nexturl = "/jsp/pay/index.jsp";
//response.sendRedirect("/jsp/pay/index.jsp?subject=" +java.net.URLEncoder.encode(trade, "UTF-8")  + "&total_fee=" + total);
// return;
//nexturl = "/jsp/offer/CheckoutCart3.jsp?community=" + teasession._strCommunity + "&trade=" + trade + "&defray=" + defray;
System.out.println("提交成功---4");

Community community=Community.find(teasession._strCommunity);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
 <body id="bodynone">
<script src="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></script>
<div class="TipsSuc">
恭喜您的订单已经成功提交；您的订单号为：<span><%=trade%></span>；我们的客服人员会在24小时内与您电话联系确认订单。请您在7个工作日之内到我馆提取您商品，如逾期未能提取商品，我馆将取消订单，商品不做预留。祝您购物愉快！</br>
<div><input onclick="window.close()" type="button" value="关闭" /></div>
</div>


<script src="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></script>
</body>
</html>
