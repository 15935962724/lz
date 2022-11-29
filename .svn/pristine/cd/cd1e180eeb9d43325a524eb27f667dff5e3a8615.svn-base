<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
int node = Integer.parseInt(teasession.getParameter("node"));
Hostel obj = Hostel.find(node,teasession._nLanguage);
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body onload="f_load();">
<h1>酒店信息</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD nowrap>酒店名称：</TD>
    <td><font color="#DF451C"><strong><%=obj.getName()%></strong></font></td>
  </tr>
  <tr>
    <TD nowrap>星级：</TD>
    <td><%
  if(obj.getStarClass() == 0){
  out.print("无要求");
  }
      for(int i=1; i <=10;i++){
 if(obj.getStarClass() == i){
    out.print("<img src=/tea/image/star/level"+i+".gif>");
 }
      }

    %></td>
  </tr>
  <tr>
    <TD nowrap>电话：</TD>
    <td><%=obj.getPhone()%> </td>
  </tr>
  <tr>
    <TD nowrap>传真：</TD>
    <td><%=obj.getFax()%></td>
  </tr>
  <tr>
    <TD nowrap>联系人：</TD>
   <td><%=obj.getContact()%></td>
  </tr>
  <tr>
    <TD nowrap>地址：</TD>
    <td><%=obj.getAddress()%> </td>
  </tr>
  <tr>
    <TD nowrap>邮编：</TD>
    <td><%=obj.getPostalcode()%> </td>
    </tr>

 <tr>
    <TD nowrap >市：</TD>
    <td><%
    City city = City.find(obj.getCity());
    if(city.getCityname()==null){}else
     out.println(city.getCityname());%></td>
  </tr>
  <tr>
    <TD nowrap>区：</TD>
    <td><%
     City borough = City.find(obj.getBorough());
     if(borough.getCityname()==null){}
    else
     out.print(borough.getCityname());
    %> </td>
  </tr>

    <tr>
    <TD nowrap>地理位置：</TD>
    <TD nowrap>距火车站：<font color="red"><%=obj.getPlaceh()%></font>公里&nbsp;&nbsp;&nbsp;&nbsp;距飞机场：<font color="red"><%=obj.getPlacef()%></font>公里&nbsp;&nbsp;&nbsp;&nbsp;距市中心：<font color="red"><%=obj.getPlaces()%></font>公里&nbsp;&nbsp;&nbsp;&nbsp;距地铁：<font color="red"><%=obj.getPlaced()%></font>公里 </td>
  </tr>
    <tr>
    <TD nowrap>图片：</TD>
    <%if(obj.getPicture().length()==0){out.print("<td>暂无图片</td>");}else{ %>
    <td><img alt="" src="<%=obj.getPicture()%>" width="100" height="80" /> </td>
    <%} %>
 </tr>
    <tr>
    <TD nowrap>Logo：</TD>
    <%if(obj.getLogo().length()==0){out.print("<td>暂无Logo</td>");}else{ %>
    <td><img alt="" src="<%=obj.getLogo()%>" width="100" height="80" /> </td>
    <%} %>
  </tr>
  <tr>
<td>房型与房价：</td>
  <%
  String sb = ",";
  java.util.Enumeration enumer1 = tea.entity.node.RoomPrice.findByNode(node);
  if(enumer1.hasMoreElements()){%>

<td >
  <table width="100%" id="tablecenter">
  <tr ID=tableonetr>
    <td nowrap>房型    </td>
    <td nowrap>门市价    </td>
    <td nowrap>前台自付价    </td>
    <td nowrap>网上支付价    </td>
    <td nowrap>周末价    </td>
  </tr>
  <%
  while (enumer1.hasMoreElements()) {
    int id = ((Integer) enumer1.nextElement()).intValue();
    RoomPrice obj1 = tea.entity.node.RoomPrice.find(id);
    sb = sb + id + ",";
%>


  <tr>
    <td><%=obj1.getRoomtype(teasession._nLanguage)%>    </td>
    <td><%=obj1.getRetail()%>元    </td>
    <td><%=obj1.getProscenium()%>元    </td>
    <td><%=obj1.getNet()%>元    </td>
    <td><%=obj1.getWeekend()%>元    </td>
  </tr>
<%}out.print("</table></td>");}
else{
  out.print("<td>暂无房型</td>");
}
%>
</tr>
    <tr>
    <TD nowrap>特价：</TD>
    <td>房型：&nbsp;<%=obj.getHousexing() %>&nbsp;&nbsp;价格：&nbsp;<%=obj.getPrice() %>&nbsp;&nbsp;有效期：&nbsp;<%=obj.getTimeyouxiaoToString()%>&nbsp;&nbsp;</td>
   </tr>
  <tr>
    <TD nowrap>特价简介：</TD>
    <td><%=obj.getSpecialintro()%> </td>
  </tr>
    <tr>
    <TD nowrap>酒店说明：</TD>
    <td><%=obj.getClew()%> </td>
  </tr>
    <tr>
    <TD nowrap>酒店简介：</TD>
    <td><%=obj.getIntro()%> </td>
  </tr>
  <tr>
    <TD nowrap>酒店设施：</TD>
    <TD nowrap>餐厅：<%=obj.getDiningroom()%>&nbsp;&nbsp;商务中心：<%=obj.getCommerce()%>&nbsp;&nbsp;娱乐中心：<%=obj.getAmusement() %>&nbsp;&nbsp;商场：<%=obj.getEmporium() %>&nbsp;&nbsp;其他：<%=obj.getElses() %></td>
  </tr>
    <tr>
    <TD nowrap>付款方式：</TD>

    <%-- <td><%=Hostel.PAY_MENT[obj.getPayment()]%>
    <%
    if(obj.getPayment()==0)out.println("本酒店订房客人只能到前台自付房款");
    if(obj.getPayment()==1)out.println("前台自付但需要信用卡担保:本酒店订房客人需到前台自付,订房时需提供信用卡号担保");
    if(obj.getPayment()==2)out.println("本酒店订房,客人需把住房款预付到酒店指定账户");
    if(obj.getPayment()==3)out.println("本酒店委托网站代收住房款");
    %>
    </td>--%>
    <td>
    <%
DbAdapter db =new DbAdapter();
db.executeQuery("select payment from hostelpay where node="+node);
while(db.next()){
  out.print(Hostel.PAY_MENT[db.getInt(1)]+"：　　"+Hostelpay.getPaymenttexts(node,db.getInt(1))+"<br/>");
}
db.close();
    %>
    </td>
  </tr>
</table>
<center>
<input type=button value="返回" onClick="javascript:history.back()">
</center>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
</body>
</html>
