package tea.ui.node.type.buy;

import java.io.*;
import java.math.BigDecimal;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.node.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.member.Profile;

public class OfferBuy extends TeaServlet
{

    public OfferBuy()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        TeaSession teasession = new TeaSession(request);

        PrintWriter out = response.getWriter();
        try
        {
            out.print("<script>var mt=parent.mt,$=parent.$;</script>");
            if(teasession._rv == null)
            {
                out.print("<script>mt.show('您还没有登陆或登陆已超时，请重新登陆！');</script>");
                return;
            }
            BigDecimal price;
            int quantity = 0;
            try
            {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            } catch(Exception _ex)
            {
            }
            if(quantity == 0)
            {
                out.print("<script>alert('" + r.getString(teasession._nLanguage,"InvalidQuantity") + "');</script>");
                return;
            }
            int currency = Integer.parseInt(request.getParameter("currency"));
            int commodity = Integer.parseInt(request.getParameter("commodity"));
            if(commodity > 0) //如果有供货商////
            {
                Commodity obj_c = Commodity.find(commodity);
                if(!obj_c.isValidQuantity(quantity))
                {
                    StringBuilder sb = new StringBuilder();
                    sb.append("<script>alert('");
                    sb.append(r.getString(teasession._nLanguage,"InvalidQuantity"));
                    sb.append("\\r\\n原因如下:");
                    int min = obj_c.getMinQuantity();
                    if(min > 0)
                    {
                        sb.append("\\r\\n最小数量为").append(min);
                    }
                    int max = obj_c.getMaxQuantity();
                    if(max > 0)
                    {
                        sb.append("\\r\\n最大数量为").append(max);
                    }
                    int delta = obj_c.getDelta();
                    if(delta > 0)
                    {
                        sb.append("\\r\\n增量为").append(delta);
                    }
                    sb.append("');</script>");
                    out.print(sb.toString());
                    return;
                }

                BuyPrice obj_bp = BuyPrice.find(commodity,currency);
                price = obj_bp.getPrice();
                if(price == null)
                {
                    out.print("<script>alert('" + r.getString(teasession._nLanguage,"InvalidPrice") + "');</script>");
                    return;
                }
            } else
            {
                Goods g = Goods.find(teasession._nNode);
                price = g.getPrice();
            }
            /*
             * BigDecimal bigdecimal = null, list = null; try { bigdecimal = new BigDecimal(request.getParameter("Price")); } catch (Exception _ex) { outText(teasession, response, r.getString(teasession._nLanguage, "InvalidPrice")); return; } //普通会员购卖的价格. try { list = new
             * BigDecimal(request.getParameter("List")); } catch (Exception _ex) { list = bigdecimal; }
             *
             * java.math.BigDecimal price; switch (Profile.find(teasession._rv._strV).getAgent()) { case 1: price = buyprice.getPrice1(); break; case 2: price = buyprice.getPrice2(); break; case 3: price = buyprice.getPrice3(); break; default: price = buyprice.getPrice(); } if
             * (bigdecimal.compareTo(price) < 0) { outText(teasession, response, r.getString(teasession._nLanguage, "InfLowerReserve")); return; }
             */
            //判断用户在加入购物车时候 是否登陆
            javax.servlet.http.HttpSession se = request.getSession();
            if(teasession._rv == null)
            {
                int scid = ShoppingCarts.find(se.getId(),teasession._nNode,commodity,currency);
                if(scid > 0)
                {
                    ShoppingCarts sobj = ShoppingCarts.find(scid);
                    sobj.set(sobj.getQuantity() + quantity);
                } else
                {
                    ShoppingCarts.create(teasession._strCommunity,se.getId(),teasession._nNode,commodity,currency,price,quantity);
                }
            } else
            {
                int buy = Buy.find(teasession._rv,teasession._nNode,commodity,currency);
                if(buy > 0) // 如果购物车中已经存在,则 只修改数量
                {
                    Buy obj = Buy.find(buy);
                    obj.set(obj.getQuantity() + quantity);
                } else
                {
                    Buy.create(teasession._strCommunity,teasession._rv,teasession._nNode,commodity,currency,price,quantity);
                }
            }
            Node node = Node.find(teasession._nNode);
            //<br/> <a href=/jsp/offer/ShoppingCarts.jsp?community=" + teasession._strCommunity + " target=_parent class=bag>查看购物车</a>　　<a href=javascript:parent.mt.close(); class=trade>继续选购</a>
            out.print("<script>mt.show('<div id=tishi_box><span id=li_zong>您选购的</span><span id=li_shuling>[" + node.getSubject(teasession._nLanguage) + "]</span> <span id =li_zong>数量</span><span id=li_shuling>[" + quantity + "]</span> <span id=li_shuling>" + (price.multiply(new BigDecimal(quantity))) + "</span><br><span id=li_zong>已放入购物车!</span></div>',2,'/jsp/offer/ShoppingCarts.jsp?community=" + teasession._strCommunity + "');$('dl_cancel').value='继续选购';$('dl_ok').value='查看购物车';</script>");
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/node/type/buy/OfferBuy");
    }
}
