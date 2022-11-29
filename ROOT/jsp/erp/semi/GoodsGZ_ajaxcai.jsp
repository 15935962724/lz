<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%@page import="java.math.BigDecimal" %> <%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String act =teasession.getParameter("act");
//商品的类别ajax
if("goodstype".equals(teasession.getParameter("act")))
{
  int father = Integer.parseInt(teasession.getParameter("father"));
  int goodstype2 = 0;
  if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
  {
    goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
  }
  if(father>0){
    java.util.Enumeration ge = GoodsType.findByFather(father);
    out.print( "<select name=\"goodstype2\"><option value=''>请选择二级类别</option>");

    while(ge.hasMoreElements())
    {
      GoodsType gobj = (GoodsType)ge.nextElement();
      out.print("<option value="+gobj.getGoodstype());
      if(goodstype2==gobj.getGoodstype())
      {
        out.print(" SELECTED ");
      }
      out.print(">"+gobj.getName(teasession._nLanguage));
      out.print("</option>");
    }
    out.print("</select>");
  }else
  {
    out.print(" <select name=goodstype2><option value=''>请选择二级类别</option></select>");
  }
  return;
}

//选择加盟店时候要添加联系人的ajax
if("supplshow".equals(act))
{
   int supplnamehidden = 0;
   if(teasession.getParameter("supplnamehidden")!=null && teasession.getParameter("supplnamehidden").length()>0)
   {
     supplnamehidden = Integer.parseInt(teasession.getParameter("supplnamehidden"));
     LeagueShop lsobj = LeagueShop.find(supplnamehidden);

     java.util.Enumeration e = AdminUsrRole.find(teasession._strCommunity,"AND unit="+lsobj.getBumen(),0,Integer.MAX_VALUE);
     out.print("<select name=\"member2\" onchange=f_member2();> <option value=0>---------------</option>");
     while(e.hasMoreElements())
     {
       String armember = ((String)e.nextElement());
       Profile pobj = Profile.find(armember);
       String memberall="/"+armember+"/"+pobj.getTelephone(teasession._nLanguage)+"/"+pobj.getAddress(teasession._nLanguage)+"/";
       out.print("<option value="+memberall);
       out.print(">"+pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage));
       out.print("</option>");
     }
      out.print("</select>");
   }
   return;
}
////给商品细节表中添加数据 入库单用的方法
if("gDetails".equals(act))
{
  int discount = 10;//折扣默认数值为 10
  String discount2="10";//商品打折
  int type = 0;
  if(teasession.getParameter("type")!=null&&teasession.getParameter("type").length()>0)
  {
    type = Integer.parseInt(teasession.getParameter("type"));
  }
  int node = Integer.parseInt(teasession.getParameter("node"));
  String purchase = teasession.getParameter("purchase");//销售单编号
  if(GoodsDetails.isGdid(teasession._strCommunity,node,purchase,type)>0)
  {
    out.print("您所选的商品在列表中已经存在！");
    return;
  }else if(GoodsDetails.isGZ(teasession._strCommunity,purchase,type)>0)
  {
    out.print("半成品只能组装成一个成品！");
    return;
  }
  else  if(GoodsDetails.isGdid(teasession._strCommunity,node,purchase,type)>0)
  {
    out.print("此商品已有合成规则");
    return;
  }
  Node nobj = Node.find(node);
  Goods g=Goods.find(node);
  Commodity cobj = Commodity.find_goods(node);
  BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
  java.math.BigDecimal sup =bpobj.getList();// bpobj.getSupply();
  if(sup==null)
  {
    //bpobj.getSupply() =new java.math.BigDecimal("0");
    sup =new java.math.BigDecimal("0");
  }
  String dsupply=sup.toString();//折后单价
  //折扣乘以数量的价格总计
  String total =sup.toString();
  if(type==2 || type==3 || type==4 || type==5)
  {
    total=bpobj.getList().toString();
  }

  GoodsDetails.create(purchase,node,String.valueOf(sup),String.valueOf(discount),dsupply,1,total,"",teasession._strCommunity,type,0,discount2);
  return;
}
//给商品细节表中添加数据 销售单用的方法
if("gDetailspai".equals(act))
{
  int discount = 10;//折扣默认数值为 10
   String discount2="10";//商品打折
    if(teasession.getParameter("discount")!=null&&teasession.getParameter("discount").length()>0)
  {
    discount = Integer.parseInt(teasession.getParameter("discount"));
    if(discount>0)
    {
      discount = 5;
    }
  }
  int type = 0;
  if(teasession.getParameter("type")!=null&&teasession.getParameter("type").length()>0)
  {
    type = Integer.parseInt(teasession.getParameter("type"));
  }
  int node = 0;
  if(teasession.getParameter("node")!=null&& teasession.getParameter("node").length()>0)
  {
    node = Integer.parseInt(teasession.getParameter("node"));
  }
  String purchase = teasession.getParameter("purchase");//销售单编号
  if(GoodsDetails.isGdid(teasession._strCommunity,node,purchase,type)>0)
  {
    out.print("您所选的商品在列表中已经存在！");
    return;
  }

  Node nobj = Node.find(node);
  Goods g=Goods.find(node);
  Commodity cobj = Commodity.find_goods(node);
  BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
  java.math.BigDecimal sup =bpobj.getSupply();// bpobj.getSupply();
  if(sup==null)
  {
    //bpobj.getSupply() =new java.math.BigDecimal("0");
    sup =new java.math.BigDecimal("0");
  }
  String dsupply=sup.toString();//折后单价
  //折扣乘以数量的价格总计
  String total =sup.toString();
 // if(type==2 || type==3 || type==4 || type==5)
 // {
  //  total=bpobj.getList().toString();
 // }else{
    if(Paidinfull.getDis(node)>0 && sup.intValue()>Paidinfull.getFloor(node)){
      dsupply=( (sup.multiply(new java.math.BigDecimal(Paidinfull.getDis(node)*0.1))).setScale(2,2)).toString();
      total= (sup.multiply(new java.math.BigDecimal(Paidinfull.getDis(node)*0.1))).setScale(2,2).toString();
      discount2=String.valueOf(Paidinfull.getDis(node));

    }
    //默认打5折的计算

    dsupply=  (new java.math.BigDecimal(dsupply).multiply(new java.math.BigDecimal(discount)).multiply(new java.math.BigDecimal(0.1))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
    total=(new java.math.BigDecimal(total).multiply(new java.math.BigDecimal(discount)).multiply(new java.math.BigDecimal(0.1))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
     //  System.out.println("dsupply:"+(new java.math.BigDecimal(dsupply).multiply(new java.math.BigDecimal(discount)).multiply(new java.math.BigDecimal(0.1))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
 // }
  GoodsDetails.create(purchase,node,sup.toString(),String.valueOf(discount),dsupply,1,total,"",teasession._strCommunity,type,0,discount2);
  return;
}
//删除一个商品
if("Gdelete".equals(act))
{
  int gdid = Integer.parseInt(teasession.getParameter("gdid"));
  GoodsDetails  gdobj = GoodsDetails.find(gdid);
  gdobj.delete();

  out.print("商品删除！");
  return;
}
//入库单修改商品的价格
if("List".equals(act))
{
  int nodeid = 0;
  if(teasession.getParameter("nodeid")!=null && teasession.getParameter("nodeid").length()>0)
  {
    nodeid = Integer.parseInt(teasession.getParameter("nodeid"));
  }
  String list = teasession.getParameter("list");
  int quantity = 0;
  if(teasession.getParameter("quantity")!=null && teasession.getParameter("quantity").length()>0)
  {
    quantity = Integer.parseInt(teasession.getParameter("quantity"));
  }
  int gdid = 0;
  if(teasession.getParameter("gdid")!=null && teasession.getParameter("gdid").length()>0)
  {
    gdid = Integer.parseInt(teasession.getParameter("gdid"));
  }


  Node nobj = Node.find(nodeid);
  Goods g=Goods.find(nodeid);
  Commodity cobj = Commodity.find_goods(nodeid);
  BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);

  bpobj.set(new java.math.BigDecimal(list), bpobj.getPrice());//修改价格
  GoodsDetails gdobj = GoodsDetails.find(gdid);
  gdobj.set(list,String.valueOf(new java.math.BigDecimal(list).multiply(new java.math.BigDecimal(quantity))),quantity);
  return;

}
//销售单修改的价格
//dsupply="+dsupply+"&total_i="+total_i+"&discount2="+discount2,
if("Paidinfull".equals(act))
{
  int nodeid = 0;
  if(teasession.getParameter("nodeid")!=null && teasession.getParameter("nodeid").length()>0)
  {
    nodeid = Integer.parseInt(teasession.getParameter("nodeid"));
  }
  String supply = teasession.getParameter("supply");//商品单价
  int quantity = 0;//商品数量
  if(teasession.getParameter("quantity")!=null && teasession.getParameter("quantity").length()>0)
  {
    quantity = Integer.parseInt(teasession.getParameter("quantity"));
  }
  int gdid = 0;//商品细节表的 id
  if(teasession.getParameter("gdid")!=null && teasession.getParameter("gdid").length()>0)
  {
    gdid = Integer.parseInt(teasession.getParameter("gdid"));
  }
  //折扣
  String discount = teasession.getParameter("discount");
  //折后单价
  String dsupply = teasession.getParameter("dsupply");
  // 金额
  String total_i = teasession.getParameter("total_i");
  String discount2 = teasession.getParameter("discount2");
  GoodsDetails gdobj = GoodsDetails.find(gdid);
  gdobj.set(gdobj.getPaid(),gdobj.getNode(),supply,discount,dsupply,quantity,total_i, gdobj.getRemarksarr(),gdobj.getTime_s(),gdobj.getType(),gdobj.getWarehouse(),discount2);
  return;

}
//修改备注
if("remarksarr".equals(act))
{
  String remarksarr = teasession.getParameter("remarksarr");
   int gdid = 0;//商品细节表的 id
  if(teasession.getParameter("gdid")!=null && teasession.getParameter("gdid").length()>0)
  {
    gdid = Integer.parseInt(teasession.getParameter("gdid"));
  }
  GoodsDetails gdobj = GoodsDetails.find(gdid);
  gdobj.set(remarksarr);
  return;
}
//修改显示单子下面的文字
if("f_show".equals(act))
{
  int suppid=0;
  if(teasession.getParameter("suppid")!=null&&teasession.getParameter("suppid").length()>0)
  {
    suppid = Integer.parseInt(teasession.getParameter("suppid"));
  }
  String purchase = teasession.getParameter("purchase");
  java.math.BigDecimal total_2 =GoodsDetails.getTotal_2(purchase);

  LeagueShop lsobj = LeagueShop.find(suppid);
//  lsobj.getSummoney()

java.math.BigDecimal ss= new java.math.BigDecimal("0");
ss = lsobj.getSummoney().subtract(Paidinfull.getTotalaaa(teasession._strCommunity,suppid));
out.print("您的应付余额:&nbsp;<font color=red>"+(ss.subtract(total_2)).setScale(2,2)+"</font>&nbsp;元,您的配送余额:&nbsp;<font color=red>"+LeagueShopImprest.dispatchMoney(" and lsid="+suppid)+"</font>。请在三日内验收签字回传，否则我司将按此单确认.配赠送品不退换<br>");
out.print("此次产品中有&nbsp;<font color=red>"+(ss.subtract(total_2).multiply(new java.math.BigDecimal("0.2"))).setScale(2,2)+"</font>&nbsp;(此次进货额的20%)元");
out.print("产品在&nbsp;<font color=red>"+GoodsDetails.getTimes_sas(purchase)+"</font>&nbsp;(出单日起三个月内)前可调换一次，否则此次产品不再享有退换的权利。");
return;
}
//配送单中修改价格和数量
if("distri_ajax".equals(act))
{
  String list = teasession.getParameter("list");
  int quantity = 0;
  if(teasession.getParameter("quantity")!=null && teasession.getParameter("quantity").length()>0)
  {
    quantity = Integer.parseInt(teasession.getParameter("quantity"));
  }
  int gdid = 0;
  if(teasession.getParameter("gdid")!=null && teasession.getParameter("gdid").length()>0)
  {
    gdid = Integer.parseInt(teasession.getParameter("gdid"));
  }
  GoodsDetails gdobj = GoodsDetails.find(gdid);
  gdobj.set(list,String.valueOf(new java.math.BigDecimal(list).multiply(new java.math.BigDecimal(quantity))),quantity);
  return;
}
%>

