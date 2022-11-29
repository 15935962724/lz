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
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.service.Robot;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.node.Node;

public class EditPurchaseOrder extends TeaServlet
{

    public EditPurchaseOrder()
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
            int i = Integer.parseInt(teasession.getParameter("Trade"));
            Trade trade = Trade.find(i);
            if (!trade.isCustomer(teasession._rv) && !trade.isVendor(teasession._rv))
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
                int k = Integer.parseInt(s);
                String s3 = teasession.getParameter("SQuantity" + k);
                int l = 0;
                try
                {
                    l = Integer.parseInt(s3);
                } catch (Exception _ex)
                {
                    outText(teasession, response, r.getString(teasession._nLanguage, "InvalidSQuantity"));
                    return;
                }
                TradeItem tradeitem = TradeItem.find(k);
                tradeitem.set(l);
                j++;
            } while (true);
            String community = teasession.getParameter("community");
            if (community == null)
            {
                Node obj = Node.find(teasession._nNode);
                community = obj.getCommunity();
            }
            String s1 = teasession.getParameter("bEmail").trim();
            String s2 = teasession.getParameter("bFirstName").trim();
            String s4 = ""; // teasession.getParameter("bLastName").trim();
            String s5 = teasession.getParameter("bOrganization");
            String s6 = teasession.getParameter("bAddress");
            String s7 = teasession.getParameter("bCity");
            String s8 = teasession.getParameter("bState");
            String s9 = teasession.getParameter("bZip");
            String s10 = teasession.getParameter("bCountry");
            String s11 = teasession.getParameter("bTelephone");
            String s12 = teasession.getParameter("bFax");
            String s13 = teasession.getParameter("ShipToBilling");
            teasession.getParameter("UpdateProfile");
            String s14 = teasession.getParameter("sEmail").trim();
            String s15 = teasession.getParameter("sFirstName").trim();
            String s16 = ""; // teasession.getParameter("sLastName").trim();
            String s17 = teasession.getParameter("sOrganization");
            String s18 = teasession.getParameter("sAddress");
            String s19 = teasession.getParameter("sCity");
            String s20 = teasession.getParameter("sState");
            String s21 = teasession.getParameter("sZip");
            String s22 = teasession.getParameter("sCountry");
            String s23 = teasession.getParameter("sTelephone");
            String s24 = teasession.getParameter("sFax");
            String paytype = teasession.getParameter("paytype");
            String explain = teasession.getParameter("explain");
            if (s13 != null)
            {
                s14 = s1;
                s15 = s2;
                s16 = s4;
                s17 = s5;
                s18 = s6;
                s19 = s7;
                s20 = s8;
                s21 = s9;
                s22 = s10;
                s23 = s11;
                s24 = s12;
            }
            //Integer.parseInt(teasession.getParameter("Shipping"));
            String s25 = teasession.getParameter("CText");
            byte abyte0[] = teasession.getBytesParameter("Voice");
            int i1 = Integer.parseInt(teasession.getParameter("Status"));
            if (!RequestHelper.isEmail(s1))
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidEmailAddress"));
                return;
            }
            if (s2.length() == 0)
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidFirstName"));
                return;
            }
            /*if (s4.length() == 0)
              {
                outText(teasession,response, r.getString(teasession._nLanguage, "InvalidLastName"));
                return;
              }*/
            if (s6.length() == 0)
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidAddress"));
                return;
            }
            if (s7.length() == 0)
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidCity"));
                return;
            }
            if (s8.length() == 0)
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidState"));
                return;
            }
            if (s14.trim().length() == 0)
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidEmailAddress"));
                return;
            }
            if (s15.length() == 0)
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidFirstName"));
                return;
            }
            /*if (s16.length() == 0)
              {
                outText(teasession,response, r.getString(teasession._nLanguage, "InvalidLastName"));
                return;
              }*/
            if (s18.length() == 0)
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidAddress"));
                return;
            }
            if (s19.length() == 0)
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidCity"));
                return;
            }
            if (s20.length() == 0)
            {
                outText(teasession, response, r.getString(teasession._nLanguage, "InvalidState"));
                return;
            }
            if (i1 == 3 && trade.getStatus() != 3 && "1".equals(paytype))
            {
                java.math.BigDecimal total = new java.math.BigDecimal(teasession.getParameter("Total"));
                SClient sclient = SClient.find(community, trade.getCustomer().toString());
                if (sclient.getPrice().add(total).intValue() >= 0)
                {
                    sclient.setPrice(total);
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("对不起,充值卡中余额不足.<a href=\"javascript:history.back();\" >后退</A>", "UTF-8"));
                    return;
                }
            }

            int j1 = trade.getStatus();
            BigDecimal bigdecimal = trade.getPayByPoint();
            RV rv = trade.getVendor();
            trade.set(i1, teasession._nLanguage, s1, s2, s4, s5, s6, s7, s8, s9, s10, s11, s12, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, teasession._nLanguage, s25, teasession.getParameter("ClearVoice") != null, abyte0, explain); //, Integer.parseInt(teasession.getParameter("paytype"))
            if (i1 == 1)
            {
                int k1 = BuyPoint.find(rv, teasession._rv, trade.getCurrency());
                BuyPoint buypoint = BuyPoint.find(k1);
                buypoint.set(buypoint.getCurrentPoint().add(bigdecimal), buypoint.getUsedPoint().add(bigdecimal.negate()));
                trade.setPayByPoint(new BigDecimal(0.0D));
                trade.setConvertedPoint(new BigDecimal(0.0D));
                int i2;
                for (Enumeration enumeration = trade.findConvertCurrency(); enumeration.hasMoreElements(); trade.setBuyPoint(i2, new BigDecimal(0.0D)))
                {
                    i2 = ((Integer) enumeration.nextElement()).intValue();
                }
            }
            boolean flag = teasession.getParameter("SendEmail") == null;
            int l1 = Message.create(teasession._strCommunity,teasession._rv, null, 0, 0, flag ? 0 : 2, 0, teasession._nLanguage, r.getString(teasession._nLanguage, Trade.TRADE_STATUS[i1]) + r.getString(teasession._nLanguage, "Order") + "#" + i,
                                    "<html>" + new Paragraph(new Text(s25)) + new Anchor("http://" + request.getServerName() + "/servlet/Trade?Trade=" + i, new Text(r.getString(teasession._nLanguage, "ClickHere"))) + "</html>", null, abyte0, "", null, tea.entity.member.Profile.find(rv._strR).getEmail(), "", "", null, null, 0, 0);
            if (!flag)
            {
                try
                {
                    Robot.activateRoboty(teasession._nNode, l1);
                } catch (Exception _ex)
                {}
            }
            if (trade.isCustomer(teasession._rv)) //消费者
            {
                response.sendRedirect("PurchaseOrders?Status=" + j1);
            } else //卖主
            {
                StringBuilder param = new StringBuilder();
                if (paytype != null)
                {
                    param.append("&paytype=" + paytype);
                }
                response.sendRedirect("ProcessSaleOrder?Status=" + i1 + "&Trade=" + i + param.toString());
            }
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
        r.add("tea/ui/member/order/EditPurchaseOrder").add("tea/ui/member/offer/Offers");
    }
}
