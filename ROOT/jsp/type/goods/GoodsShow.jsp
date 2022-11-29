<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@ page import="tea.entity.league.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int node = Integer.parseInt(teasession.getParameter("node"));
Node nobj = Node.find(node);

Goods gobj=Goods.find(teasession._nNode);



//  smallpicture=goods.getSmallpicture(teasession._nLanguage);
//  if(smallpicture !=null && smallpicture.length()>0){
  //
  //    lensmaill=new java.io.File( application.getRealPath(smallpicture)).length();
  //  }
  //  bigpicture=goods.getBigpicture(teasession._nLanguage);
  //  if(bigpicture !=null && bigpicture.length()>0)
  //  {
    //    lenbig=new java.io.File( application.getRealPath(bigpicture)).length();
    //  }
    //  recommendpicture=goods.getCommendpicture(teasession._nLanguage);
    //  if(recommendpicture !=null && recommendpicture.length()>0)
    //  {
      //    lenrecommend=new java.io.File( application.getRealPath(recommendpicture)).length();
      //  }
      //  father=node.getFather();
      //  company=goods.getCompany();
      //  goodstype=goods.getGoodstype();
      //  correspond=goods.getCorrespond();
      //  correspond2=goods.getCorrespond2();
      //  correspond3=goods.getCorrespond3();
      //  correspond4=goods.getCorrespond4();
      //  correspond5=goods.getCorrespond5();
      //  correspond6=goods.getCorrespond6();
      //  measure=goods.getMeasure(teasession._nLanguage);
      //  spec=goods.getSpec(teasession._nLanguage);
      //  status=goods.isStatus();
      //  capability=goods.getCapability(teasession._nLanguage);
      //  brand=goods.getBrand();
      //  used=goods.getUsed();
      //  dtype=goods.isDType();
      //  deduct=goods.getDeduct();
      //  //条形码或编号
      //  number = node.getNumber();

      %>
      <html>
      <head>
      <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
      <script src="/tea/tea.js" type="text/javascript"></script>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
          <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
            <META HTTP-EQUIV="Expires" CONTENT="0">

              <body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
              <h1>商品内容详细页面查看</h1>

              <div id="head6"><img height="6" src="about:blank"></div>

                <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                  <tr>
                    <td>展示位置：</td>
                    <td><%out.print(Node.find(nobj.getFather()).getSubject(teasession._nLanguage));%></td>
                  </tr>
                  <tr>
                    <td>品牌：</td>
                    <td><%=Brand.find(gobj.getBrand()).getName()%></td>
                  </tr>
                  <tr>
                    <td>类型：</td>
                    <td><%
                    String gts[] =  gobj.getGoodstype().split("/");
                    StringBuffer sp = new StringBuffer();
                    for(int index=2;index<gts.length;index++)
                    {
                      GoodsType gtobj=GoodsType.find(Integer.parseInt(gts[index]));
                      sp.append(gtobj.getName(teasession._nLanguage)+"&nbsp;&nbsp;");
                    }
                    out.print(sp.toString());
                    %></td>
                    </tr>
                    <tr>
                      <td>商品名称：</td>
                      <td><%=nobj.getSubject(teasession._nLanguage)%></td>
                    </tr>
                    <tr>
                      <td>编号:</td>
                      <td><%=nobj.getNumber()%></td>
                    </tr>
                       <tr>
                      <td>条形码或:</td>
                      <td><%=gobj.getBarcode()%></td>
                    </tr>

                    <tr>
                      <td>计量单位:</td>
                      <td><%=gobj.getMeasure(teasession._nLanguage)%></td>
                    </tr>
                    <tr>
                      <td>规格:</td>
                      <td><%=gobj.getSpec(teasession._nLanguage)%></td>
                    </tr>
                    <tr>
                      <td>产品状态:</td>
                      <td><%if(gobj.isStatus()){out.print("有货");}else{out.print("缺货");}%></td>
                    </tr>
                    <tr>
                      <td>小图片:</td>
                      <td><%
                      long lensmaill = 0;
                      String smallpicture=gobj.getSmallpicture(teasession._nLanguage);
                      if(smallpicture !=null && smallpicture.length()>0){

                        lensmaill=new java.io.File( application.getRealPath(smallpicture)).length();
                      }
                      if(lensmaill>0)
                      {
                        out.print(" <img src="+smallpicture+" />");
                      }
                      %>
                      </td>
                    </tr>
                      <tr>
                      <td>大图片:</td>
                      <td><%
                      long lensmail2 = 0;
                      String bigpicture=gobj.getBigpicture(teasession._nLanguage);
                      if(bigpicture !=null && bigpicture.length()>0){

                        lensmail2=new java.io.File( application.getRealPath(bigpicture)).length();
                      }
                      if(lensmail2>0)
                      {
                        out.print(" <img src="+bigpicture+" />");
                      }
                      %>
                      </td>
                    </tr>
                      <tr>
                      <td>推荐图片:</td>
                      <td><%
                      long lensmail3 = 0;
                      String recommendpicture=gobj.getCommendpicture(teasession._nLanguage);
                      if(recommendpicture !=null && recommendpicture.length()>0){

                        lensmail3=new java.io.File( application.getRealPath(recommendpicture)).length();
                      }
                      if(lensmail3>0)
                      {
                        out.print(" <img src="+recommendpicture+" />");
                      }
                      %>
                      </td>
                    </tr>
                    <tr>
                      <td>使用类型:</td>
                      <td><%
                      if(gobj.getUsed()==1)
                      {
                        out.print("前台展示");
                      }else if(gobj.getUsed()==2)
                      {
                        out.print("卡管理使用");
                      }
                      %>
                      </td>
                    </tr>
                     <tr>
                      <td>提成类型:</td>
                      <td><%
                      if(gobj.isDType())
                      {
                        out.print("基于数量");
                      }else
                      {
                        out.print("基于系数");
                      }
                      out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提成量:");
                      out.print(gobj.getDeduct());
                      %>
                      </td>
                    </tr>
                    <tr>
                    <td>详细内容:</td>
                    <td><%=nobj.getText(teasession._nLanguage) %></td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
                  <tr ID=Tableonetr>
                    <td nowrap>供货商</td>
                    <td nowrap>库存预警数量</td>
                    <td nowrap>进货价</td>
                    <td nowrap>供货价</td>
                    <td nowrap>销售价</td>
                  </tr>
                  <%
                  java.util.Enumeration  enumeration = tea.entity.node.Commodity.findByGoods(node);
                  if(!enumeration.hasMoreElements())
                  {
                    out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
                  }
                  while( enumeration.hasMoreElements() )
                  {
                    int cid = ((Integer)enumeration.nextElement()).intValue();
                    Commodity coobj = Commodity.find(cid);
                    BuyPrice bpobj = BuyPrice.find(cid, 1);

                    %>

                    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onmouseout="javascript:this.bgColor='';" >
                      <td><%=tea.entity.admin.Supplier.find(coobj.getSupplier()).getName(teasession._nLanguage)%></td>
                      <td id= MinQuantityid><%=coobj.getMinQuantity()%></td>
                      <td><%=bpobj.getList()%></td>
                      <td><%=bpobj.getSupply()%></td>
                      <td><%=bpobj.getPrice()%></td>
                      <input type="hidden" name="delete" value="ON"/>
                      <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
                      <input type="hidden" name="commodity" value="<%=cid%>"/>
                    </tr>
                    <%
                    }
                    %>

                </table>

                <br>
                <input type="button" value="关闭"  onClick="javascript:window.close();">
                <br>

              </body>
      </html>
