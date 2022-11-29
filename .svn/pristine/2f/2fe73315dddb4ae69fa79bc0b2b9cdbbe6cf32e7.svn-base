package tea.ui.member.offer;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.Commodity;
import tea.html.*;
import tea.http.MultipartRequest;
import tea.http.RequestHelper;
import tea.resource.Common;
import tea.resource.Resource;
import tea.service.Robot;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class CheckoutCart3 extends TeaServlet
{
    public CheckoutCart3()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = teasession.getParameter("Vendor");
            int i = Integer.parseInt(teasession.getParameter("Currency"));
            String s1 = teasession.getParameter("bEmail");
            String s2 = teasession.getParameter("bFirstName");
            String s3 = teasession.getParameter("bLastName");
            String s4 = teasession.getParameter("bOrganization");
            String s5 = teasession.getParameter("bAddress");
            String s6 = teasession.getParameter("bCity");
            String s7 = teasession.getParameter("bState");
            String s8 = teasession.getParameter("bZip");
            String s9 = teasession.getParameter("bCountry");
            String s10 = teasession.getParameter("bTelephone");
            String s11 = teasession.getParameter("bFax");
            String s12 = teasession.getParameter("TradeOShipToBilling");
            String s13 = teasession.getParameter("TradeOUpdateProfile");
            String s14 = teasession.getParameter("sEmail");
            String s15 = teasession.getParameter("sFirstName");
            String s16 = teasession.getParameter("sLastName");
            String s17 = teasession.getParameter("sOrganization");
            String s18 = teasession.getParameter("sAddress");
            String s19 = teasession.getParameter("sCity");
            String s20 = teasession.getParameter("sState");
            String s21 = teasession.getParameter("sZip");
            String s22 = teasession.getParameter("sCountry");
            String s23 = teasession.getParameter("sTelephone");
            String s24 = teasession.getParameter("sFax");
            int j = Integer.parseInt(teasession.getParameter("Shipping"));
            Shipping shipping = Shipping.find(j);
            int k = shipping.getPayMethod();
            String s25 = shipping.getParameters();
            int l = Integer.parseInt(teasession.getParameter("Coupon"));
            int i1 = Integer.parseInt(teasession.getParameter("PayByPoint"));
            int j1 = Integer.parseInt(teasession.getParameter("BuyPoint"));
            int payType = Integer.parseInt(teasession.getParameter("paytype"));
            String community = teasession.getParameter("community");
            BuyPoint buypoint = BuyPoint.find(j1);
            Coupon coupon = Coupon.find(l);
            boolean flag = false;
            if (!RequestHelper.isEmail(s1))
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidEmailAddress"));
                return;
            }
            if (s2.length() == 0)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidFirstName"));
                return;
            }
            /*
            if (s3.length() == 0)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidLastName"));
                return;
            }*/
            if (s5.length() == 0)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidAddress"));
                return;
            }
            if (s6.length() == 0)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidCity"));
                return;
            }
            if (s7.length() == 0)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidState"));
                return;
            }
            if (s12 != null)
            {
                s14 = s1;
                s15 = s2;
                s16 = s3;
                s17 = s4;
                s18 = s5;
                s19 = s6;
                s20 = s7;
                s21 = s8;
                s22 = s9;
                s23 = s10;
                s24 = s11;
            }
            BigDecimal bigdecimal = null; //发货
            try
            {
                bigdecimal = new BigDecimal(teasession.getParameter("Sh"));
            } catch (Exception _ex)
            {}
            if (bigdecimal == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidShipping"));
                return;
            }
            BigDecimal bigdecimal1 = null; //税
            try
            {
                bigdecimal1 = new BigDecimal(teasession.getParameter("Tax"));
            } catch (Exception _ex)
            {}
            if (bigdecimal1 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidTax"));
                return;
            }
            BigDecimal bigdecimal2 = null; //折扣
            try
            {
                bigdecimal2 = new BigDecimal(teasession.getParameter("Discount"));
            } catch (Exception _ex)
            {}
            if (bigdecimal2 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidDiscount"));
                return;
            }
            BigDecimal bigdecimal3 = null;
            try
            {
                bigdecimal3 = new BigDecimal(teasession.getParameter("SubTotal")); //小计
            } catch (Exception _ex)
            {}
            if (bigdecimal3 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidSubTotal"));
                return;
            }
            BigDecimal bigdecimal4 = null; //合计
            try
            {
                bigdecimal4 = new BigDecimal(teasession.getParameter("Total"));
            } catch (Exception _ex)
            {}
            if (bigdecimal4 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidTotal"));
                return;
            }
            BigDecimal bigdecimal5 = bigdecimal4.add(bigdecimal.negate()).add(bigdecimal1.negate());
            RV rv = new RV(s,community);
            BigDecimal bigdecimal6 = new BigDecimal(0.0D);
            Vector vector = new Vector();
            int k1 = 0;
            do
            {
                String s26 = teasession.getParameter("Buy" + k1);
                if (s26 == null)
                {
                    break;
                }
                vector.addElement((s26));
                int l1 = Integer.parseInt(teasession.getParameter("ConvertCurrency" + k1));
                BigDecimal bigdecimal9 = new BigDecimal(teasession.getParameter("ConvertPoint" + k1));
                if (l1 == i)
                {
                    bigdecimal6 = bigdecimal6.add(bigdecimal9);
                }
                k1++;
            } while (true);
            BigDecimal bigdecimal7 = buypoint.getCurrentPoint();
            BigDecimal bigdecimal8 = bigdecimal7;
            BigDecimal bigdecimal10 = bigdecimal6;
            if (i == 6)
            {
                if (i1 == 0)
                {
                    if (bigdecimal7.compareTo(bigdecimal5) == 1)
                    {
                        bigdecimal8 = bigdecimal5;
                        bigdecimal10 = new BigDecimal(0.0D);
                    } else
                    {
                        outText(teasession, response, super.r.getString(teasession._nLanguage, "NoEnoughPoint"));
                        return;
                    }
                } else
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "NotAllowed"));
                    return;
                }
            } else
            {
                if (i1 == 0)
                {
                    if (bigdecimal7.compareTo(bigdecimal5) == 1)
                    {
                        bigdecimal8 = bigdecimal5;
                        bigdecimal10 = new BigDecimal(0.0D);
                    } else
                    if (bigdecimal10.compareTo(bigdecimal7.add(bigdecimal2.negate())) == 1)
                    {
                        bigdecimal10 = bigdecimal10.add(bigdecimal7.negate()).add(bigdecimal2);
                    } else
                    {
                        bigdecimal10 = new BigDecimal(0.0D);
                    }
                } else
                {
                    if (bigdecimal10.compareTo(bigdecimal2.negate()) == 1)
                    {
                        bigdecimal10 = bigdecimal10.add(bigdecimal2);
                    } else
                    {
                        bigdecimal10 = new BigDecimal(0.0D);
                    }
                }
            }
            String s27 = teasession.getParameter("Remark");
            if (s27 == null)
            {
                s27 = "";
            }
            byte abyte0[] = teasession.getBytesParameter("Voice");
            Date date = new Date(System.currentTimeMillis());
            if (s13 != null) //更新注册地址
            {
                Profile profile = Profile.find(teasession._rv._strR);
                profile.set(teasession._nLanguage, s2, s3, s1, s4, s5, s6, s7, s8, s9, s10, s11);
            }
            int i2 = 0;
            if (i1 == 0)
            {
                i2 = Trade.createByBuys(rv, teasession._rv, vector.elements(), flag, teasession._nLanguage, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, i, j, bigdecimal, bigdecimal1, l, bigdecimal2, teasession._nLanguage, s27, abyte0, bigdecimal8, new BigDecimal(0.0D), new BigDecimal(0.0D), bigdecimal10, payType, community);
                buypoint.set(buypoint.getCurrentPoint().add(bigdecimal8.negate()), buypoint.getUsedPoint().add(bigdecimal8));
            } else
            {
                i2 = Trade.createByBuys(rv, teasession._rv, vector.elements(), flag, teasession._nLanguage, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, i, j, bigdecimal, bigdecimal1, l, bigdecimal2, teasession._nLanguage, s27, abyte0, new BigDecimal(0.0D), new BigDecimal(0.0D), new BigDecimal(0.0D), bigdecimal10, payType, community);
            }
            Trade trade = Trade.find(i2);
            int j2 = 0;
            do
            {
                String s28 = teasession.getParameter("Buy" + j2);
                if (s28 == null)
                {
                    break;
                }
                int l2 = Integer.parseInt(teasession.getParameter("ConvertCurrency" + j2));
                BigDecimal bigdecimal11 = new BigDecimal(teasession.getParameter("ConvertPoint" + j2));
                if (l2 != i)
                {
                    if (trade.isExisted(l2))
                    {
                        trade.setBuyPoint(l2, trade.getBuyPoint(l2).add(bigdecimal11));
                    } else
                    {
                        trade.createBuyPoint(l2, bigdecimal11);
                    }
                }
                j2++;
            } while (true);
            int k2 = Message.create(teasession._strCommunity,rv, null, 0, 0, 2, 0, teasession._nLanguage, super.r.getString(teasession._nLanguage, "InfCheckoutNotification") + " " + super.r.getString(teasession._nLanguage, "Order") + "#" + i2,
                                    "<html>" + super.r.getString(teasession._nLanguage, "InfViewOrder") + new Anchor("http://" + request.getServerName() + "/servlet/Trade?Trade=" + i2 + "&Node=" + teasession._nNode, new Text(super.r.getString(teasession._nLanguage, "ClickHere"))) + "</html>", null,
                                    abyte0, "", null, teasession._rv._strR, "", "", null, null, 0, 0);
            try
            {
                Robot.activateRoboty(teasession._nNode,k2);
            } catch (Exception _ex)
            {}
            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Pragma", "no-chache");
            if (i2 == 0) //生成订单错误, 请与webmaster联系
            {
                PrintWriter printwriter = response.getWriter();
                printwriter.print(super.r.getString(teasession._nLanguage, "InfTradeError"));
                printwriter.print(new Anchor("Node", super.r.getCommandImg(teasession._nLanguage, "Continue")));
                printwriter.close();
                return;
            }
            if (i == 1 && k == Shipping.PAYMETHOD_CYBERBJ) //货币种类是RMB(人民币) &&
            {
                PrintWriter printwriter1 = beginOut(response, teasession);
                BigDecimal bigdecimal12 = new BigDecimal(0.0D);
                if (i1 == 0)
                {
                    bigdecimal12 = Trade.find(i2).getTotal().add(bigdecimal8.negate());
                } else
                {
                    bigdecimal12 = Trade.find(i2).getTotal();
                }
                int i3 = s25.indexOf(' ');
                if (i3 == -1)
                {
                    printwriter1.println(super.r.getString(teasession._nLanguage, "InfVendorShippingParameters"));
                } else
                {
                    Form form = new Form("foCyberBJ", "POST", "http://paymentweb.cyberbj.com.cn/prs/spmode.main");
                    form.setTarget("_blank");
                    String s32 = s25.substring(0, i3);
                    String s33 = s25.substring(i3 + 1);
                    String s35 = "0";
                    String s36 = (new SimpleDateFormat("yyyyMMdd")).format(date);
                    String s37 = bigdecimal12.toString();
                    String s38 = s16 + s15;
                    String s40 = s36 + "-" + s32 + "-" + i2;
                    String s41 = RequestHelper.hmac_md5(s35 + s36 + s37 + s38 + s40 + s32, s33);
                    form.add(new Button(super.r.getString(teasession._nLanguage, "PayInCyberBJ")));
                    form.add(new HiddenField("v_action", "\312\327\266\274\265\347\327\323\311\314\263\307\315\370\311\317\260\262\310\253\326\247\270\266\306\275\314\250"));
                    form.add(new HiddenField("v_mid", s32));
                    form.add(new HiddenField("v_oid", s40));
                    form.add(new HiddenField("v_rcvname", s38));
                    form.add(new HiddenField("v_rcvaddr", s22 + " " + s20 + " " + s19 + " " + s18));
                    form.add(new HiddenField("v_rcvtel", s23));
                    form.add(new HiddenField("v_rcvpost", s21));
                    form.add(new HiddenField("v_amount", s37));
                    form.add(new HiddenField("v_ymd", s36));
                    form.add(new HiddenField("v_orderstatus", "1"));
                    form.add(new HiddenField("v_ordername", s3 + s2));
                    form.add(new HiddenField("v_moneytype", s35));
                    form.add(new HiddenField("v_md5info", s41));
                    printwriter1.print(form);
                }
                endOut(printwriter1, teasession);
            }
            if (i == 0 && k == Shipping.PAYMETHOD_ITRANSACT) //货币种类是US$(美元) &&
            {
                Profile profile1 = Profile.find(s);
                String s29 = super.r.getString(teasession._nLanguage, Common.CURRENCY[i]);
                String s30 = teasession.getParameter("CouponCode");
                String s31 = RequestHelper.makeName(teasession._nLanguage, profile1.getFirstName(teasession._nLanguage), profile1.getLastName(teasession._nLanguage));
                Form form1 = new Form("foCheckout", "POST", "https://secure.itransact.com/cgi-bin/mas/split.cgi");
                form1.add(new HiddenField("vendor_id", s25));
                form1.add(new HiddenField("mername", s31));
                form1.add(new HiddenField("acceptcards", "1"));
                form1.add(new HiddenField("altaddr", "1"));
                form1.add(new HiddenField("nonum", "1"));
                String s34 = null;
                BigDecimal bigdecimal13 = new BigDecimal(0.0D);
                Table table = new Table();
                table.setCellSpacing(2);
                table.setTitle(super.r.getString(teasession._nLanguage, "TradeSubject") + "\n" + super.r.getString(teasession._nLanguage, "Quality") + "\n" + super.r.getString(teasession._nLanguage, "Price") + "\n" + super.r.getString(teasession._nLanguage, "Quantity") + "\n" + super.r.getString(teasession._nLanguage, "Total") + "\n");
                int j3 = 0;
                do
                {
                    String s39 = teasession.getParameter("Buy" + j3);
                    if (s39 == null)
                    {
                        break;
                    }
                    s34 = teasession.getParameter("Node" + j3);
                    teasession.getParameter("Nodex" + j3);
                    teasession.getParameter("SKU" + j3);
                    teasession.getParameter("SerialNumber" + j3);
                    int k3 = Integer.parseInt(teasession.getParameter("Quality" + j3));
                    String s42 = teasession.getParameter("Subject" + j3);
                    String s43 = teasession.getParameter("Subjectx" + j3);
                    BigDecimal bigdecimal15 = new BigDecimal(teasession.getParameter("Price" + j3));
                    int l3 = Integer.parseInt(teasession.getParameter("Quantity" + j3));
                    BigDecimal bigdecimal16 = bigdecimal15.multiply(new BigDecimal(l3));
                    bigdecimal13 = bigdecimal13.add(bigdecimal16);
                    Row row4 = new Row();
                    row4.add(new Cell((new Text(s42)).toString() + (new Text(s43)).toString()));
                    row4.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Commodity.QUALITY[k3]))));
                    row4.add(new Cell(new Text(s29 + bigdecimal15)));
                    row4.add(new Cell(new Text(Integer.toString(l3))));
                    row4.add(new Cell(new Text(s29 + bigdecimal16)));
                    table.add(row4);
                    if (l == 0)
                    {
                        form1.add(new HiddenField((j3 + 1) + "-desc", s42));
                        form1.add(new HiddenField((j3 + 1) + "-cost", bigdecimal15.toString()));
                        form1.add(new HiddenField((j3 + 1) + "-qty", Integer.toString(l3)));
                    }
                    j3++;
                } while (true);
                if (bigdecimal13.compareTo(bigdecimal3) != 0)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidSubTotal"));
                    return;
                }
                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Shipping") + ":"), true));
                row.add(new Cell(new Text(s29 + bigdecimal)));
                table.add(row);
                if (bigdecimal1.compareTo(new BigDecimal(0.0D)) != 0)
                {
                    Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Tax") + ":"), true));
                    row1.add(new Cell(new Text(s29 + bigdecimal1)));
                    table.add(row1);
                }
                if (l != 0)
                {
                    Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Coupon") + ":" + s30), true));
                    row2.setFGColor("RED");
                    row2.add(new Cell(new Text(s29 + bigdecimal2)));
                    table.add(row2);
                    table.add(new Row(new Cell(new Text(coupon.getText(teasession._nLanguage)))));
                }
                BigDecimal bigdecimal14 = new BigDecimal(0.0D);
                if (i1 == 0)
                {
                    bigdecimal14 = bigdecimal3.add(bigdecimal).add(bigdecimal1).add(bigdecimal2).add(bigdecimal8.negate());
                } else
                {
                    bigdecimal14 = bigdecimal3.add(bigdecimal).add(bigdecimal1).add(bigdecimal2);
                }
                Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Total") + ":"), true));
                row3.add(new Cell(new Text(s29 + bigdecimal14)));
                table.add(row3);
                form1.add(table);
                if (l == 0)
                {
                    form1.add(new HiddenField((j3 + 1) + "-desc", super.r.getString(teasession._nLanguage, "Shipping")));
                    form1.add(new HiddenField((j3 + 1) + "-cost", bigdecimal.toString()));
                    form1.add(new HiddenField((j3 + 1) + "-qty", "1"));
                    if (bigdecimal1.compareTo(new BigDecimal(0.0D)) != 0)
                    {
                        form1.add(new HiddenField((j3 + 2) + "-desc", super.r.getString(teasession._nLanguage, "Tax")));
                        form1.add(new HiddenField((j3 + 2) + "-cost", bigdecimal1.toString()));
                        form1.add(new HiddenField((j3 + 2) + "-qty", "1"));
                    }
                    form1.add(new HiddenField("1-desc", super.r.getString(teasession._nLanguage, "Total")));
                    form1.add(new HiddenField("1-cost", bigdecimal14.toString()));
                    form1.add(new HiddenField("1-qty", "1"));
                }
                form1.add(new HiddenField("email", s1));
                form1.add(new HiddenField("first_name", s2));
                form1.add(new HiddenField("last_name", s3));
                form1.add(new HiddenField("address", s5));
                form1.add(new HiddenField("city", s6));
                form1.add(new HiddenField("state", s7));
                form1.add(new HiddenField("zip", s8));
                form1.add(new HiddenField("country", s9));
                form1.add(new HiddenField("phone", s10));
                form1.add(new HiddenField("home_page", "http://" + request.getServerName() + "/servlet/ShoppingCarts?node=" + s34));
                form1.add(new HiddenField("ret_addr", "http://" + request.getServerName() + "/servlet/CheckoutCart4"));
                form1.add(new HiddenField("passback", "Vendor"));
                form1.add(new HiddenField("Vendor", s));
                form1.add(new HiddenField("passback", "Currency"));
                form1.add(new HiddenField("Currency", i));
                form1.add(new HiddenField("passback", "Shipping"));
                form1.add(new HiddenField("Shipping", j));
                form1.add(new HiddenField("passback", "Paymethod"));
                form1.add(new HiddenField("Paymethod", k));
                form1.add(new HiddenField("passback", "Sh"));
                form1.add(new HiddenField("Sh", bigdecimal.toString()));
                form1.add(new HiddenField("passback", "Tax"));
                form1.add(new HiddenField("Tax", bigdecimal1));
                form1.add(new HiddenField("passback", "Coupon"));
                form1.add(new HiddenField("Coupon", l));
                form1.add(new HiddenField("passback", "Discount"));
                form1.add(new HiddenField("Discount", bigdecimal2));
                form1.add(new HiddenField("passback", "Total"));
                form1.add(new HiddenField("Total", bigdecimal14));
                form1.add(new HiddenField("passback", "Trade"));
                form1.add(new HiddenField("Trade", i2));
                form1.add(new HiddenField("passback", "organization"));
                form1.add(new HiddenField("organization", s4));
                form1.add(new HiddenField("passback", "fax"));
                form1.add(new HiddenField("fax", s11));
                form1.add(new HiddenField("lookup", "first_name"));
                form1.add(new HiddenField("lookup", "last_name"));
                form1.add(new HiddenField("lookup", "address"));
                form1.add(new HiddenField("lookup", "city"));
                form1.add(new HiddenField("lookup", "state"));
                form1.add(new HiddenField("lookup", "zip"));
                form1.add(new HiddenField("lookup", "country"));
                form1.add(new HiddenField("lookup", "phone"));
                form1.add(new HiddenField("lookup", "email"));
                form1.add(new Button(super.r.getString(teasession._nLanguage, "Continue")));
                PrintWriter printwriter3 = beginOut(response, teasession);
                printwriter3.print(form1);
                endOut(printwriter3, teasession);
                return;
            } else //订单提交成功
            {
                /*
                       PrintWriter printwriter2 = beginOut(response, teasession);
                       printwriter2.print(RequestHelper.format(super.r.getString(teasession._nLanguage, "InfAfterTrade"), new Anchor("Trade?Trade=" + i2, new Text(Integer.toString(i2)))));
                       printwriter2.print(new tea.html.Anchor("/servlet/Node", super.r.getString(teasession._nLanguage, "Continue")));
                       endOut(printwriter2, teasession);*/
                //发邮件
                tea.entity.site.Community community_obj = tea.entity.site.Community.find(teasession._nNode);
                String web = "http://" + request.getServerName() + ":" + request.getServerPort() + "/";
                String webn = community_obj.getName(teasession._nLanguage);
                String conent = community_obj.getMailBefore(teasession._nLanguage) + s1 + " 你好!<br>欢迎来到" + webn + "<a href=" + web + ">" + web + "</a><br>用户名:" + s1 + "<br>订单:" + i2 + "<br> 订单提交成功" + community_obj.getMailAfter(teasession._nLanguage);
                conent = new String(conent.getBytes(tea.ui.TeaServlet.CHARSET[teasession._nLanguage]), "iso-8859-1");
                String str = "订单提交成功(" + webn + ")";
                str = new String(str.getBytes(tea.ui.TeaServlet.CHARSET[teasession._nLanguage]), "iso-8859-1");
                int kssss = tea.entity.member.Message.create(teasession._strCommunity,null, community_obj.getEmail(), 0, 0, 2, 0, teasession._nLanguage, str, conent, null, null, "", null, s14, "", "", null, null, 0, 0);
                try
                {
                    tea.service.Robot.activateRoboty(teasession._nNode, kssss);
                } catch (Exception _ex)
                {}

                response.sendRedirect("/jsp/offer/CheckoutCart3.jsp?trade=" + i2);
                return;
            }
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/offer/CheckoutCart3").add("tea/ui/member/offer/Offers");
    }
}
