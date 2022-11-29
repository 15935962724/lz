package tea.ui.member.order;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.html.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.service.Robot;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.*;
import tea.entity.node.Node;

public class ProcessSaleOrder extends TeaServlet
{

    public ProcessSaleOrder()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            int i = Integer.parseInt(teasession.getParameter("Trade"));
            Trade trade = Trade.find(i);
            if (!trade.isVendor(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            int j = 0;
            do
            {
                String s = teasession.getParameter("TradeItem" + j);
                if (s == null)
                {
                    break;
                }
                int l = Integer.parseInt(s);
                String s2 = teasession.getParameter("SQuantity" + l);
                int i1 = 0;
                try
                {
                    i1 = Integer.parseInt(s2);
                } catch (Exception _ex)
                {
                    outText(teasession,response, r.getString(teasession._nLanguage, "InvalidSQuantity"));
                    return;
                }
                TradeItem tradeitem = TradeItem.find(l);
                tradeitem.set(i1);
                j++;
            } while (true);

            String community = teasession.getParameter("community");
            if (community == null)
            {
                Node obj = Node.find(teasession._nNode);
                community = obj.getCommunity();
            }

            j = Integer.parseInt(teasession.getParameter("Status"));
            int k = trade.getStatus();
            String s1 = teasession.getParameter("VText");
            byte abyte0[] = teasession.getBytesParameter("Voice");
            BigDecimal bigdecimal = trade.getPayByPoint();
            BigDecimal bigdecimal1 = trade.getTotal();
            RV rv = trade.getCustomer();

            if (j == 1 && trade.getPayType() == 1 && k >= 3) //取消订单,退过余额
            {
                SClient sclient = SClient.find(community, trade.getCustomer().toString());
                java.math.BigDecimal total = new java.math.BigDecimal(teasession.getParameter("Total"));
                sclient.setPrice(total.abs());
            }

            int j1 = BuyPoint.find(teasession._rv, rv, trade.getCurrency());
            BuyPoint buypoint = BuyPoint.find(j1);
            if (j == 1)
            {
                buypoint.set(buypoint.getCurrentPoint().add(bigdecimal), buypoint.getUsedPoint().add(bigdecimal.negate()));
                trade.setPayByPoint(new BigDecimal(0.0D));
                trade.setConvertedPoint(new BigDecimal(0.0D));
                int k1;
                for (Enumeration enumeration = trade.findConvertCurrency(); enumeration.hasMoreElements(); trade.setBuyPoint(k1, new BigDecimal(0.0D)))
                {
                    k1 = ((Integer) enumeration.nextElement()).intValue();
                }

            }
            if (j == 5)
            {
                buypoint.set(buypoint.getCurrentPoint().add(trade.getConvertedPoint()));
                for (Enumeration enumeration1 = trade.findConvertCurrency(); enumeration1.hasMoreElements(); )
                {
                    int l1 = ((Integer) enumeration1.nextElement()).intValue();
                    BigDecimal bigdecimal4 = trade.getBuyPoint(l1);
                    if (BuyPoint.isExisted(teasession._rv, rv, l1))
                    {
                        BuyPoint buypoint1 = BuyPoint.find(BuyPoint.find(teasession._rv, rv, l1));
                        buypoint1.set(buypoint1.getCurrentPoint().add(bigdecimal4));
                    } else
                    {
                        BuyPoint.create(teasession._rv, rv, l1, bigdecimal4, new BigDecimal(0.0D));
                    }
                }

            }
            if (j == 9)
            {
                BigDecimal bigdecimal2 = trade.getSh();
                BigDecimal bigdecimal3 = trade.getTax();
                BigDecimal bigdecimal5 = bigdecimal2.add(bigdecimal3);
                BigDecimal bigdecimal6 = buypoint.getCurrentPoint().add(trade.getConvertedPoint().negate());
                BigDecimal bigdecimal7 = bigdecimal.add(bigdecimal5.negate());
                if (bigdecimal6.add(bigdecimal).compareTo(new BigDecimal(0.0D)) == -1)
                {
                    outText(teasession,response, r.getString(teasession._nLanguage, "UnRefundable"));
                    return;
                }
                buypoint.set(bigdecimal6);
                trade.setConvertedPoint(new BigDecimal(0.0D));
                if (bigdecimal1.add(bigdecimal.negate()).compareTo(bigdecimal5) == 1)
                {
                    buypoint.set(buypoint.getCurrentPoint().add(bigdecimal), buypoint.getUsedPoint().add(bigdecimal.negate()));
                    trade.setPayByPoint(new BigDecimal(0.0D));
                    trade.setRefund(bigdecimal, bigdecimal1.add(bigdecimal.negate()).add(bigdecimal5.negate()));
                } else
                {
                    buypoint.set(buypoint.getCurrentPoint().add(bigdecimal7.negate()), buypoint.getUsedPoint().add(bigdecimal7.negate()));
                    trade.setPayByPoint(bigdecimal5);
                    trade.setRefund(bigdecimal7, bigdecimal1.add(bigdecimal.negate()));
                }
                BigDecimal bigdecimal8;
                BuyPoint buypoint2;
                for (Enumeration enumeration2 = trade.findConvertCurrency(); enumeration2.hasMoreElements(); buypoint2.set(buypoint2.getCurrentPoint().add(bigdecimal8.negate())))
                {
                    int j2 = ((Integer) enumeration2.nextElement()).intValue();
                    bigdecimal8 = trade.getBuyPoint(j2);
                    trade.setBuyPoint(j2, new BigDecimal(0.0D));
                    trade.setReclaimedBuyPoint(j2, bigdecimal8);
                    buypoint2 = BuyPoint.find(BuyPoint.find(teasession._rv, rv, j2));
                }

            }
            String express = teasession.getParameter("express");
            if (express != null)
            {
                trade.setExpress(Integer.parseInt(express));
            }
            String paytype = teasession.getParameter("paytype");
            if (paytype != null)
            {
                trade.setPayType(Integer.parseInt(paytype));
            }
            String unshippedYear = teasession.getParameter("unshippedYear");
            if (unshippedYear != null)
            {
                trade.setUnshipped(tea.htmlx.TimeSelection.makeTime(unshippedYear, teasession.getParameter("unshippedMonth"), teasession.getParameter("unshippedDay"), teasession.getParameter("unshippedHour"), teasession.getParameter("unshippedMinute")));
            }
            String comeYear = teasession.getParameter("comeYear");
            if (comeYear != null)
            {
                trade.setCome(tea.htmlx.TimeSelection.makeTime(comeYear, teasession.getParameter("comeMonth"),
                        teasession.getParameter("comeDay"), teasession.getParameter("comeHour"),
                        teasession.getParameter("comeMinute")));
            }
            String estimateYear = teasession.getParameter("estimateYear");
            if (estimateYear != null)
            {
                trade.setEstimate(tea.htmlx.TimeSelection.makeTime(estimateYear, teasession.getParameter("estimateMonth"),
                        teasession.getParameter("estimateDay"), teasession.getParameter("estimateHour"),
                        teasession.getParameter("estimateMinute")));
            }
            String gathering = teasession.getParameter("gathering");
            if (gathering != null)
            {
                trade.setGathering(new java.math.BigDecimal(gathering));
            }
            String invoice=teasession.getParameter("invoice");
            if(invoice!=null)
                trade.setInvoice(Integer.parseInt(invoice));
            TradeMember.create(i,j,teasession._rv.toString());//记录 那位会员更改的状态
            trade.set(j, teasession._nLanguage, s1, teasession.getParameter("ClearVoice") != null, abyte0);
            boolean flag = teasession.getParameter("SendEmail") == null;
            int i2 = Message.create(teasession._strCommunity,trade.getVendor(), null, 0, 0, flag ? 0 : 2, 0, teasession._nLanguage, r.getString(teasession._nLanguage, Trade.TRADE_STATUS[j]) + " " + r.getString(teasession._nLanguage, "Order") + "#" + i,
                                    "<html>" + new Paragraph(new Text(s1)) + new Anchor("http://" + request.getServerName() + "/servlet/Trade?Trade=" + i, new Text(r.getString(teasession._nLanguage, "ClickHere"))) + "</html>", null, abyte0, "", null, tea.entity.member.Profile.find(rv._strR).getEmail(), "", "", null, null, 0, 0);
            if (!flag)
            {
                try
                {
                    Robot.activateRobot(i2);
                } catch (Exception _ex)
                {}
            }
            response.sendRedirect("SaleOrders?Status=" + k);
            return;
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
        r.add("tea/ui/member/order/ProcessSaleOrder").add("tea/ui/member/offer/Offers");
    }
}
