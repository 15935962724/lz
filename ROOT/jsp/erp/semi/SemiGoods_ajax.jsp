<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%@page import="tea.entity.admin.erp.semi.*" %> <%
request.setCharacterEncoding("UTF-8");


/***************添加半成品入库*********************************/


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String act =teasession.getParameter("act");
//给商品细节表中添加数据
if("sgDetails".equals(act))
{
  int type = 0;
  if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
  {
    type= Integer.parseInt(teasession.getParameter("type"));
  }
  int sgid = 0;//半成品号
  int ssid = Integer.parseInt(teasession.getParameter("ssid"));

  SemiSupplier ssobj =SemiSupplier.find(ssid);
  sgid=ssobj.getSgid();


  String purchase = teasession.getParameter("purchase");//销售单编号
  if(SemiGoodsDetails.isGdid(teasession._strCommunity,ssid,purchase)>0)
  {
    out.print("您所选的商品在列表中已经存在！");
    return;
  }
  SemiGoods sgobj = SemiGoods.find(sgid);
  java.math.BigDecimal sup = ssobj.getSupply();
  if(sup==null)
  {
    sup =new java.math.BigDecimal("0");
  }
  String total =sup.toString();

  SemiGoodsDetails.create(purchase,ssid,sup.toString(),ssobj.getNum(),total,"",teasession._strCommunity,type,0,0,0);
  return;
}
//删除一个商品
if("SGdelete".equals(act))
{
  int gdid = Integer.parseInt(teasession.getParameter("gdid"));
  SemiGoodsDetails  gdobj = SemiGoodsDetails.find(gdid);
  gdobj.delete();
  out.print("商品删除！");
  return;
}
%>

