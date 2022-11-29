package tea.ui.node.type.sorder;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.*;
import java.text.*;
import tea.entity.node.*;
import tea.service.SendEmaily;

public class EditSOrder extends tea.ui.TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        java.io.PrintWriter out = response.getWriter();
        try
        {
            int options1 = 0;
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            Node node = Node.find(teasession._nNode);
            String community = node.getCommunity();
            String subject = teasession.getParameter("Subject");
            String text = ""; // request.getParameter("text");
            Date issue = new Date(); // TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), "0", "0");
            String member = request.getParameter("member");
            String nexturl = teasession.getParameter("nexturl");
            tea.entity.RV rv;
            if (member != null)
            {
                rv = new tea.entity.RV(member, community);
            } else
            {
                rv = teasession._rv;
            }

            int status = 0;
            try
            {
                status = Integer.parseInt(request.getParameter("Status"));
            } catch (NumberFormatException ex2)
            {
            }

            boolean newbrother = teasession.getParameter("NewBrother") != null;
            boolean newnode = teasession.getParameter("NewNode") != null;
            if (newnode || newbrother)
            {
                int father;
                father = teasession._nNode;
                if (newbrother)
                {
                    father = Node.find(father).getFather();
                }
                Node node1 = Node.find(father);
                int sequence = Node.getMaxSequence(father) + 10;
                options1 = node1.getOptions1();
                int typealias = 0;
                try
                {
                    typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                } catch (Exception exception1)
                {
                }
                long options = node1.getOptions();
                options &= 0xffdffbff;
                int defautllangauge = node1.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //66
                teasession._nNode = Node.create(father, sequence, community, rv, cat.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null,null);
            } else
            {
                node.set(teasession._nLanguage, subject, text);

                if (status == 1)
                {
                    SOrder investor = SOrder.find(teasession._nNode, teasession._nLanguage);
                    if (investor.getPtype() == 1 || investor.getAptype() == 1) // 支付方式选择的时易洁卡支付,当取消订单时,退款.
                    {
                        tea.entity.member.SClient sc = tea.entity.member.SClient.find(community, node.getCreator()._strV);
                        if (investor.getPtype() == 1)
                        {
                            sc.setPrice(investor.getTotal());
                        }
                        if (investor.getAptype() == 1)
                        {
                            sc.setPrice(investor.getAtotal());
                        }
                    }
                    investor.setStatus(status);
                    EditSOrder.sendMail(community, teasession._nNode, teasession._nLanguage, node.getCreator()._strV, 1);
                    response.sendRedirect(nexturl);
                    return;
                }
            }

            SOrder so = SOrder.find(teasession._nNode, teasession._nLanguage);
            int oldstatus = so.getStatus();
            boolean bool = so.isExists();
            java.math.BigDecimal oldTotal = so.getTotal();
            java.math.BigDecimal oldAtotal = so.getAtotal();
            java.math.BigDecimal newTotal = new java.math.BigDecimal("0");
            java.math.BigDecimal newAtotal = new java.math.BigDecimal("0");
            int area = Integer.parseInt(request.getParameter("address"));
            String address = request.getParameter("detailaddress");
            Date date = null;
            try
            {
                date = tea.htmlx.TimeSelection.makeTime(request.getParameter("bespeakYear"), request.getParameter("bespeakMonth"), request.getParameter("bespeakDay"), request.getParameter("bespeakHour"), request.getParameter("bespeakMinute"));
            } catch (Exception ex1)
            {
            }
            // 预约项目
            String amount_str[] = request.getParameterValues("amount");
            String service_str[] = request.getParameterValues("service");
            int amount_int[] = new int[5];
            int service_int[] = new int[5];
            Arrays.fill(amount_int, 0);
            Arrays.fill(service_int, 0);
            for (int index = 0; index < amount_str.length; index++)
            {
                if (amount_str[index].length() > 0)
                {
                    amount_int[index] = Integer.parseInt(amount_str[index]);
                    service_int[index] = Integer.parseInt(service_str[index]);

                    Service ser_obj = Service.find(service_int[index], teasession._nLanguage); // 计算总金额
                    if (ser_obj.isExists())
                    {
                        newTotal = newTotal.add(ser_obj.getPrice().multiply(new java.math.BigDecimal(amount_int[index])));
                        System.out.println(newTotal);
                    }
                }
            }
            // 附加项目
            String aamount_str[] = request.getParameterValues("aamount");
            String aservice_str[] = request.getParameterValues("aservice");
            int aamount_int[] = new int[3];
            int aservice_int[] = new int[3];
            Arrays.fill(aamount_int, 0);
            Arrays.fill(aservice_int, 0);
            if (aamount_str != null && aservice_str != null)
            {
                for (int index = 0; index < aamount_str.length; index++)
                {
                    if (aamount_str[index].length() > 0)
                    {
                        aamount_int[index] = Integer.parseInt(aamount_str[index]);
                        aservice_int[index] = Integer.parseInt(aservice_str[index]);

                        Service ser_obj = Service.find(aservice_int[index], teasession._nLanguage); // 计算总金额
                        if (ser_obj.isExists())
                        {
                            newAtotal = newAtotal.add(ser_obj.getPrice().multiply(new java.math.BigDecimal(aamount_int[index])));
                            System.out.println(newTotal);
                        }
                    }
                }
            }

            // /附加项目 支付方式
            String aptype = request.getParameter("aptype");
            if (aptype != null)
            {
                so.setAptype(Integer.parseInt(aptype));
            }

            int idea = Integer.parseInt(request.getParameter("idea"));

            if (status == 3) // 如果 订单状态==完成订单
            {
                tea.entity.member.SClient sclient = tea.entity.member.SClient.find(community, node.getCreator()._strV);
                sclient.setPoint(so.getPoint()); // 积分

                /*
                 * if (subtract.floatValue() != 0) { tea.entity.member.SClient sclient = tea.entity.member.SClient.find(community, node.getCreator()._strR); if (sclient.isExists()) { sclient.setPrice(subtract); } else { out.print(new tea.html.Script("alert('�ͻ�������');history.back();")); return; } }
                 */
                // Client client_obj = Client.find(node.getCreator()._strR);
            }
            /*
             * java.math.BigDecimal cash; if (teasession.getParameter("cash") == null) { cash = new java.math.BigDecimal(0); } else { cash = new java.math.BigDecimal(teasession.getParameter("cash")); }
             */
            int invoice = 0;
            if (teasession.getParameter("invoice") != null)
            {
                invoice = Integer.parseInt(teasession.getParameter("invoice"));
            }

            int waiterfigure = 0;
            try
            {
                waiterfigure = Integer.parseInt(request.getParameter("waiterfigure"));
            } catch (NumberFormatException ex5)
            {
            }
            StringBuilder waiter = new StringBuilder("/"); // request.getParameter("waiter");
            String waiterarray[] = request.getParameterValues("waiter");
            if (waiterarray != null)
            {
                for (int index = 0; index < waiterarray.length; index++)
                {
                    waiter.append(waiterarray[index] + "/");
                }
            }
            String clientsign = request.getParameter("clientsign");
            Date signtime = null;
            try
            {
                String signtime_param = request.getParameter("signtime");
                if (signtime_param != null)
                {
                    signtime = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(signtime_param);
                }
            } catch (ParseException ex3)
            {
            }
            String waitersign = request.getParameter("waitersign");
            String feedback = request.getParameter("feedback");
            String phone = request.getParameter("phone");
            int exwaiter = 0;
            try
            {
                exwaiter = Integer.parseInt(request.getParameter("exwaiter"));
            } catch (Exception ex4)
            {
            }

            if (!((status == 0 && !bool) || (oldstatus == 1)) && (so.getPtype() == 1 || so.getAptype() == 1) && bool) // 易洁卡支付,如果价格更改,则算余额是否够
            { // 1 2
                if (so.getPtype() == 1 && so.getAptype() == 1) // 如果 预约项目 和 附加项目 都是 易洁卡支付,则算出总和
                {
                    oldTotal = oldTotal.add(oldAtotal);
                    newTotal = newTotal.add(newAtotal);
                } else if (so.getAptype() == 1)
                {
                    oldTotal = oldAtotal;
                    newTotal = newAtotal;
                }
                oldTotal = oldTotal.subtract(newTotal);
                System.out.println("oldTotal:" + oldTotal);
                tea.entity.member.SClient sclient = tea.entity.member.SClient.find(community, node.getCreator()._strV);
                System.out.println("oldTotal:" + sclient.getPrice());
                if (sclient.getPrice().add(oldTotal).intValue() >= 0)
                {
                    sclient.setPrice(oldTotal);
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("对不起,易洁卡中余额不足.<a href=\"javascript:history.back();\" >后退</A>", "UTF-8"));
                    return;
                }
            }
            if (so.isExists())
            {
                so.set(address, date, service_int, amount_int, aservice_int, aamount_int, idea, status, waiter.toString(), clientsign, signtime, waitersign, phone, feedback, exwaiter, invoice, waiterfigure, area);
            } else
            {
                so.create(teasession._nNode, teasession._nLanguage, address, date, service_int, amount_int, aservice_int, aamount_int, idea, status, waiter.toString(), clientsign, signtime, waitersign, phone, feedback, exwaiter, area);
            }
            delete(node);
            if ((status == 0 && !bool) || (oldstatus == 1))
            {
                response.sendRedirect("/jsp/type/sorder/Payment.jsp?node=" + teasession._nNode + "&member=" + rv._strV + "&nexturl=" + nexturl);
                return;
            } else
            {

            }
            EditSOrder.sendMail(community, teasession._nNode, teasession._nLanguage, node.getCreator()._strV, status);
            if (request.getParameter("GoBack") != null)
            {
                String parm = "";
                if (nexturl != null)
                {
                    parm = "&nexturl=" + nexturl;
                }
                response.sendRedirect("EditNode?node=" + teasession._nNode + parm);
            } else
            {
                // Node.find(teasession._nNode).finished(teasession._nNode);
                if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("SOrder?node=" + teasession._nNode + "&edit=ON");
                }
            }
        } catch (NumberFormatException ex)
        {
            ex.printStackTrace();
        } catch (IOException ex)
        {
            ex.printStackTrace();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    public static void sendMail(String community, int node, int language, String to, int status)
    {

        try
        {
            tea.entity.member.Profile pf = tea.entity.member.Profile.find(to);
            to = pf.getEmail();

            tea.entity.site.Community obj = tea.entity.site.Community.find(community);

            String subject = null;
            String content = null;
            switch (status)
            {
            case 0: // 提交
                subject = "您在“" + obj.getName(language) + "”#" + node + "订单提交成功";
                content = subject;
                break;
            case 1: // 取消
                subject = "您在“" + obj.getName(language) + "”#" + node + "订单已被取消";
                content = subject;
                break;
            case 2: // 确认
                subject = "您在“" + obj.getName(language) + "”#" + node + "订单已被确认";
                content = subject;
                break;
            case 3: // 完成
                subject = "您在“" + obj.getName(language) + "”#" + node + "订单完成";
                content = subject;
                break;
            case 4: // 接收
                subject = "您在“" + obj.getName(language) + "”#" + node + "订单已被接收";
                content = subject;
                break;
            }

            SendEmaily se = new SendEmaily(community);
            se.sendEmail(obj.getEmail(), subject, obj.getMailBefore(language) + content + obj.getMailAfter(language));
        } catch (Exception _ex)
        {

        }

    }

    // Clean up resources
    public void destroy()
    {
    }
}
