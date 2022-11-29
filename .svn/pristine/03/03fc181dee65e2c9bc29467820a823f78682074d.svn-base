package tea.ui.yl.shop;

import java.io.*;
import java.text.*;
import java.util.*;
import java.math.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.yl.shop.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ShopTrades extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        ServletContext application = this.getServletContext();
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        try
        {
            if ("city".equals(act))
            {
                out.print("<html><body style='margin:0;background:transparent;'><script src='/tea/mt.js'></script><script src='/tea/city.js'></script><form name='f'><script>mt.city('city0','city1','city2','" + h.get("city") + "');a=f.elements;function cha(){var id=0;for(var i=0;i<a.length;i++){t=a[i].value;if(t)id=t;parent.$('city').value=id;}}for(var i=0;i<a.length;i++)a[i].attachEvent('onchange',cha);</script></form>");
                return;
            }
            out.println("<script>var mt=parent.mt,$=parent.$,doc=parent.document;</script>");
            if (h.member < 1)
            {
                out.println("<script>mt.show('您还没有登陆或登陆已超时！请重新登陆',2,'/my/Login.jsp');</script>");
                return;
            }

            //添加/删除 常用地址/发票
         /*   if (act.startsWith("u"))
            {
                if ("uaadd".equals(act))
                {
                    UAddress t = new UAddress(0);
                    t.member = h.member;
                    t.name = h.get("name");
                    t.city = h.getInt("city");
                    t.address = h.get("address");
                    t.mobile = h.get("mobile");
                    t.tel = h.get("tel");
                    t.email = h.get("email");
                    t.zip = h.get("zip");
                    t.time = h.getDate("time");
                    t.set();
                    out.print("<script>parent.f_act('Address','Edit'," + t.uaddress + ")</script>");
                } else if ("uiadd".equals(act))
                {
                    UInvoice t = new UInvoice(0);
                    t.member = h.member;
                    t.type = h.getInt("type");
                    t.payable = h.getInt("payable");
                    t.titname = h.get("titname" + t.type);
                    t.nsrcode = h.get("nsrcode");
                    t.address = h.get("address");
                    t.tel = h.get("tel");
                    t.bank = h.get("bank");
                    t.account = h.get("account");
                    t.content = h.getInt("content");
                    t.time = new Date();
                    t.set();
                    out.print("<script>parent.f_act('Invoice','Edit'," + t.uinvoice + ")</script>");
                } else
                {
                    if ("uadel".equals(act))
                    {
                        int uaddress = h.getInt("uaddress");
                        UAddress t = UAddress.find(uaddress);
                        if (t.member != h.member)
                            return;
                        t.delete();
                        out.print("<script>t=$('_ua" + uaddress + "');");
                    } else if ("uidel".equals(act))
                    {
                        int uinvoice = h.getInt("uinvoice");
                        UInvoice t = UInvoice.find(uinvoice);
                        if (t.member != h.member)
                            return;
                        t.delete();
                        out.print("<script>t=$('_ui" + uinvoice + "');");
                    }
                    out.print("while(t.tagName!='TR')t=t.parentNode;t.parentNode.removeChild(t);</script>");
                }
                return;
            }*/
            int trade = h.getInt("trade");
            ShopTrade t = ShopTrade.find(trade);
            if (act.startsWith("e")) //修改订单信息
            {
                if ("eAddress".equals(act))
                {
                    t.aname = h.get("name");
                    t.acity = h.getInt("city");
                    t.aaddress = h.get("address");
                    t.amobile = h.get("mobile");
                    t.atel = h.get("tel");
                    t.aemail = h.get("email");
                    t.azip = h.get("zip");
                    t.set();
                } else if ("eInvoice".equals(act))
                {
                    t.itype = h.getInt("type");
                    t.ipayable = h.getInt("payable");
                    t.ititname = h.get("titname" + t.itype);
                    t.insrcode = h.get("nsrcode");
                    t.iaddress = h.get("address");
                    t.itel = h.get("tel");
                    t.ibank = h.get("bank");
                    t.iaccount = h.get("account");
                    t.icontent = h.getInt("icontent");
                    t.set();
                } else if ("ePayment".equals(act))
                {
                    t.ppayment = h.getInt("ppayment");
                    t.ptime = h.getInt("ptime");
                    t.set();
                } else if ("eRemark".equals(act))
                {
                    t.remark = h.get("remark");
                    t.set();
                }
                out.print("<script>parent.f_act('" + act.substring(1) + "','View')</script>");
                return;
            } else if ("add".equals(act)) //提交订单
            {
                BigDecimal coupon = BigDecimal.ZERO;
                BigDecimal total = BigDecimal.ZERO;
                String[] ps = h.getCook("cart", "|").split("[|]");
                for (int i = 1; i < ps.length; i++)
                {
                    String[] arr = ps[i].split("&");
                    ShopProduct p = ShopProduct.find(Integer.parseInt(arr[0]));
                    if (p.time == null)
                        continue;
                    Item it = new Item(0);
                    it.trade = trade;
                    it.product = p.product;
                    it.pcolor = Integer.parseInt(arr[1]);
                    it.psize = Integer.parseInt(arr[2]);
                    it.price = p.price;
                    it.quantity = Integer.parseInt(arr[3]);
                    it.set();
                    //
                    p.set("inventory", String.valueOf(p.inventory - it.quantity)); //库存
                    //
                    BigDecimal quantity = new BigDecimal(arr[3]);
                    total = total.add(new BigDecimal(String.valueOf(p.price)).multiply(quantity));
                    coupon = coupon.add(total.subtract(new BigDecimal(String.valueOf(p.getCoupon())).multiply(quantity)));
                }
                BigDecimal actually = total;
                int tmp = h.getInt("coupon");
                if (tmp > 0)
                {
                    Coupon c = Coupon.find(tmp);
                    if (h.member == c.activate)
                    {
                        c.set("trade", String.valueOf(t.trade));
                        t.coupon = coupon.setScale(2, 4).floatValue();
                        actually = total.subtract(coupon);
                    }
                }
                t.total = total.setScale(2, 4).floatValue();
                t.actually = actually.setScale(2, 4).floatValue();
                t.time = new Date();
                t.code = new SimpleDateFormat("yyMMdd").format(t.time) + new DecimalFormat("0000").format(t.trade);
                t.state = 1;
                t.set();
                out.print("<script>parent.cookie.remove('cart');parent.location='/my/TradeOk.jsp?trade=" + trade + "';</script>");
                return;
            } else if ("state".equals(act))
            {
                int state = h.getInt("state");
                t.set("state", String.valueOf(state));
                if (state == 4) //确认
                {
                    Iterator it = Item.findByTrade(t.trade).iterator();
                    while (it.hasNext())
                    {
                        Item i = (Item) it.next();
                        ShopProduct p = ShopProduct.find(i.product);
                        p.set("sales", String.valueOf(++p.sales)); //销量
                    }
                } else if (state == 5 || state == 6) //取消 拒收
                {
                    Iterator it = Item.findByTrade(t.trade).iterator();
                    while (it.hasNext())
                    {
                        Item i = (Item) it.next();
                        ShopProduct p = ShopProduct.find(i.product);
                        p.set("inventory", String.valueOf(p.inventory + i.quantity)); //库存
                    }
                    //优惠券
                    it = Coupon.find(" AND trade=" + t.trade, 0, 100).iterator();
                    while (it.hasNext())
                    {
                        Coupon c = (Coupon) it.next();
                        c.set("trade", "0");
                    }
                    //
                    if (t.pay == 1)
                    {
                        Money.create(t.member, t.actually, h.member, "订单：" + t.code + "的退款");
                    }
                }
            } else if ("staten".equals(act))
            {
                int state = h.getInt("state");
                t.set("state", String.valueOf(state));
                if (state == 5) //确认
                {
                    Iterator it = Item.findByTrade(t.trade).iterator();
                    while (it.hasNext())
                    {
                        Item i = (Item) it.next();
                        ShopProduct p = ShopProduct.find(i.product);
                        p.set("sales", String.valueOf(++p.sales)); //销量
                    }
                } else if (state == 4) //取消 拒收
                {
                    Iterator it = Item.findByTrade(t.trade).iterator();
                    while (it.hasNext())
                    {
                        Item i = (Item) it.next();
                        ShopProduct p = ShopProduct.find(i.product);
                        p.set("inventory", String.valueOf(p.inventory + i.quantity)); //库存
                    }
                    /*//优惠券
                    it = Coupon.find(" AND trade=" + t.trade, 0, 100).iterator();
                    while (it.hasNext())
                    {
                        Coupon c = (Coupon) it.next();
                        c.set("trade", "0");
                    }
                    //
                    if (t.pay == 1)
                    {
                        Money.create(t.member, t.actually, h.member, "订单：" + t.code + "的退款");
                    }*/
                }
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
