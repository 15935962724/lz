<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%@page import="java.math.BigDecimal" %><%@page import="tea.entity.league.*" %> <%
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
     if(supplnamehidden>0){

       String member2 = teasession.getParameter("member2");
       supplnamehidden = Integer.parseInt(teasession.getParameter("supplnamehidden"));
       LeagueShop lsobj = LeagueShop.find(supplnamehidden);

       java.util.Enumeration e = AdminUsrRole.find(teasession._strCommunity,"AND unit="+lsobj.getBumen(),0,Integer.MAX_VALUE);
       out.print("<select name=\"member2\" onchange=f_member2();> <option value=0>请选择联系人</option>");
       while(e.hasMoreElements())
       {
         String armember = ((String)e.nextElement());
         Profile pobj = Profile.find(armember);
         String memberall="/"+armember+"/"+pobj.getTelephone(teasession._nLanguage)+"/"+pobj.getAddress(teasession._nLanguage)+"/";
         out.print("<option value="+memberall);
         if(memberall.equals(member2))
         {
           out.print(" selected ");
         }
         out.print(">"+pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage));
         out.print("</option>");
       }
       out.print("</select>");
     }else
     {
       out.print("<option value=0>请选择加盟店</option>");
     }
   }
   return;
}
////给商品细节表中添加数据 入库单用的方法
if("gDetails".equals(act))
{
  //那个供货商的
  int supplname = 0;
  if(teasession.getParameter("supplname")!=null&&teasession.getParameter("supplname").length()>0)
  {
    supplname = Integer.parseInt(teasession.getParameter("supplname"));
  }
//退货的订单
   String purid12333232321 =teasession.getParameter("purid12333232321");
  int discount = 10;//折扣默认数值为 10
  String discount2="10";//商品打折
  int type = 0;
  if(teasession.getParameter("type")!=null&&teasession.getParameter("type").length()>0)
  {
    type = Integer.parseInt(teasession.getParameter("type"));
  }


  int node = 0;
  if(teasession.getParameter("node")!=null && teasession.getParameter("node").length()>0)
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

    java.math.BigDecimal sup =new java.math.BigDecimal("0");// bpobj.getSupply();
    java.math.BigDecimal sup2 =new java.math.BigDecimal("0");// bpobj.getSupply();
  // 如果是采购单
  if(supplname>0)
  {
    Commodity cobj = Commodity.find(Commodity.getCommodity(supplname,node));
    BuyPrice bpobj = BuyPrice.find(Commodity.getCommodity(supplname,node),1);
    sup =bpobj.getList();
    sup2=bpobj.getSupply(); 

  }else if(purid12333232321!=null&&purid12333232321.length()>0)
  {
    GoodsDetails gdobj =  GoodsDetails.find(GoodsDetails.isGdid(teasession._strCommunity,node,purid12333232321,0));
    sup = new java.math.BigDecimal(gdobj.getSupply());
  }else
  {
    Commodity cobj = Commodity.find_goods(node);
    BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
    sup =bpobj.getSupply();// bpobj.getSupply();
  } 



  String dsupply=String.valueOf(sup);//折后单价
  //折扣乘以数量的价格总计
  String total =String.valueOf(sup);
//  if(type==2 || type==3 || type==4 || type==5)
//  {
//    total=sup.toString();
//  }


 int gd=  GoodsDetails.create(purchase,node,String.valueOf(sup),String.valueOf(discount),dsupply,1,total,"",teasession._strCommunity,type,0,discount2);
   GoodsDetails gdobj = GoodsDetails.find(gd);
//添加商品的销售价格
   gdobj.setSupply_2(String.valueOf(sup2)); 
   //修改供货商
   gdobj.setSupplier(supplname);

 //只有在退货 要记录退货单中的商品是 退的那个采购单中的商品
 if(type==3 || type ==1)
 {
   gdobj.setPurchaseid(purid12333232321);
 }else if(type==4)//调拨单时候修改总价格
 {
  gdobj.setCOQT(1, String.valueOf(gdobj.getCOTotal(gdobj.getCommunity(),gdobj.getQuantity(),gdobj.getNode())));
 }else if(type==5)//报损单修改总价格
 {
   gdobj.setCOQT(1, String.valueOf(gdobj.getCOTotal(gdobj.getCommunity(),gdobj.getQuantity(),gdobj.getNode())));
 }
  return;
}
//给商品细节表中添加数据 销售单用的方法
if("gDetailspai".equals(act))
{



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
  int discount = 10;//折扣默认数值为 10
  String discount2="10";//商品打折
  if(teasession.getParameter("discount")!=null&&teasession.getParameter("discount").length()>0)
  {
    discount = Integer.parseInt(teasession.getParameter("discount"));
    if(discount>0)
    {
      discount = 5;
      //如果这个订单和商品在细节表中存在，则要 获取打折折扣
      if(GoodsDetails.getDico(purchase)>0)
      {
        discount=GoodsDetails.getDico(purchase);
      }
    }
  }

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
    sup =new java.math.BigDecimal("0");
  }
  String dsupply=sup.toString();//折后单价
  //折扣乘以数量的价格总计
  String total =sup.toString();

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
  int gid = GoodsDetails.create(purchase,node,sup.toString(),String.valueOf(discount),dsupply,1,total,"",teasession._strCommunity,type,0,discount2);

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
  gdobj.set(list,String.valueOf(new java.math.BigDecimal(list).multiply(new java.math.BigDecimal(quantity))),quantity,list);
  return;

}
//销售单修改的价格
//dsupply="+dsupply+"&total_i="+total_i+"&discount2="+discount2,
if("Paidinfull".equals(act))
{

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
  gdobj.set(supply,discount,dsupply,quantity,total_i,discount2);
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
if(suppid>0){
  String purchase = teasession.getParameter("purchase");
  java.math.BigDecimal total_2 =GoodsDetails.getTotal_2(purchase);

  LeagueShop lsobj = LeagueShop.find(suppid);

  java.math.BigDecimal ss= new java.math.BigDecimal("0");
  ss = lsobj.getSummoney().subtract(Paidinfull.getTotalaaa(teasession._strCommunity,suppid));
  out.print("您的应付余额:&nbsp;<font color=red>"+(ss.subtract(total_2)).setScale(2,2)+"</font>&nbsp;元,您的配送余额:&nbsp;<font color=red>"+LeagueShopImprest.dispatchMoney(" and lsid="+suppid)+"</font>。请在三日内验收签字回传，否则我司将按此单确认.配赠送品不退换<br>");
  out.print("此次产品中有&nbsp;<font color=red>"+(ss.subtract(total_2).multiply(new java.math.BigDecimal("0.2"))).setScale(2,2)+"</font>&nbsp;(此次进货额的20%)元");
  out.print("产品在&nbsp;<font color=red>"+GoodsDetails.getTimes_sas(purchase)+"</font>&nbsp;(出单日起三个月内)前可调换一次，否则此次产品不再享有退换的权利。");
}else
{
  out.print("请先选择加盟店");
}
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
//计算配送金额
if("EditDistribution".equals(act))
{
  int suppid=0;
  if(teasession.getParameter("suppid")!=null&&teasession.getParameter("suppid").length()>0)
  {
    suppid = Integer.parseInt(teasession.getParameter("suppid"));
  }
  String purchase = teasession.getParameter("purchase");
  java.math.BigDecimal total_2 =GoodsDetails.getTotal_2(purchase);//这个订单消费的总金额
   LeagueShop lsobj = LeagueShop.find(suppid);
  java.math.BigDecimal ssss =new java.math.BigDecimal("0");
  ssss =  lsobj.getDispatchmoney().subtract(total_2);
  if(lsobj.getDispatchmoney().compareTo(total_2)==-1)//余额不足
  {
    //out.print("您的配送金额：<font color=red>"+ssss.setScale(2,2)+"</font>,您的配送余额不足,不能提交配送单.");
    out.print("/"+ssss.setScale(2,2)+"/");

  }else{
    out.print("您的配送金额：<font color=red>"+ssss.setScale(2,2)+"</font>");
  }
  return;
}
//计算调拨单中的商品总价格
if("co_ajax".equals(act))
{
  //修改的数量
  int quantity = 0;
  if(teasession.getParameter("quantity")!=null && teasession.getParameter("quantity").length()>0)
  {
    quantity = Integer.parseInt(teasession.getParameter("quantity"));
  }
  //商品细节id
  int gdid = 0;
  if(teasession.getParameter("gdid")!=null && teasession.getParameter("gdid").length()>0)
  {
    gdid = Integer.parseInt(teasession.getParameter("gdid"));
  }

  GoodsDetails gdobj = GoodsDetails.find(gdid);
  gdobj.setCOQT(quantity,String.valueOf(gdobj.getCOTotal(gdobj.getCommunity(),quantity,gdobj.getNode())));
  out.print(gdobj.getCOTotal(gdobj.getCommunity(),quantity,gdobj.getNode()).setScale(2,4));
  return;
}
//判断调拨数量和库存数量
if("co_ajaxInventory".equals(act))
{
  int gdid = 0;
  if(teasession.getParameter("gdid")!=null && teasession.getParameter("gdid").length()>0)
  {
    gdid = Integer.parseInt(teasession.getParameter("gdid"));
  }
  int warid = 0;
  if(teasession.getParameter("warid")!=null && teasession.getParameter("warid").length()>0)
  {
    warid = Integer.parseInt(teasession.getParameter("warid"));
  }
    GoodsDetails gdobj = GoodsDetails.find(gdid);
    Inventory iobj = Inventory.find(Inventory.getInvid(gdobj.getCommunity(),gdobj.getNode(),warid));
    out.print(iobj.getQuantity());
    return;
}
//删除供货商对应得商品
if("GoodsSupp".equals(act))
{

  String purchase = teasession.getParameter("purchase");
  GoodsDetails.SuppDelete(purchase);
  return;
}
//加盟店批量修改价格
if("BatchPrice".equals(act))
{
  String joinname = teasession.getParameter("joinname").trim();
  int counit =LeagueShop.count(teasession._strCommunity," AND lsname like "+DbAdapter.cite("%"+joinname+"%"));
  if(counit>0)
  {
    out.print("<div id=joinid3>");
    out.print("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"joinid4\">");
    java.util.Enumeration e = LeagueShop.findByCommunity(teasession._strCommunity," AND lsname like "+DbAdapter.cite("%"+joinname+"%"),0,10);
    while(e.hasMoreElements())
    {
      int lsid = ((Integer)e.nextElement()).intValue();
      LeagueShop lsobj = LeagueShop.find(lsid);
      out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" style=\"cursor:pointer\" onclick=f_trdw('"+lsobj.getLsname()+"');>");
      out.print("<td>");
      out.print(lsobj.getLsname());
      out.print("</td>");
      out.print("</tr>");
    }
    out.print("</table>");
    out.print("</div>");
  }

  return;
}

%>

