package tea.ui.member.order;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.member.*;
import java.math.*;
import tea.entity.*;
import tea.entity.integral.*;

public class EditTrade extends TeaServlet
{
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if (teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        String referer = request.getHeader("referer");
        if (referer == null || referer.indexOf(request.getServerName()) == -1)
        {
            response.sendError(404, request.getRequestURI());
            return;
        }
        String act = request.getParameter("act");
        String nexturl = request.getParameter("nexturl");
        try
        {
            if ("createorder".equals(act)) // 创建订单
            {
                String point = request.getParameter("point");
                int supplier = Integer.parseInt(request.getParameter("supplier"));
                BigDecimal total = new BigDecimal(request.getParameter("total")); //总计
                BigDecimal freight = new BigDecimal(request.getParameter("freight")); //运费
                String state = request.getParameter("state");
                String city = request.getParameter("city");
                String address = request.getParameter("address");
                String email = request.getParameter("email");
                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");
                String organization = request.getParameter("organization");
                String zip = request.getParameter("zip");
                String telephone = request.getParameter("telephone");
                int ps = Integer.parseInt(request.getParameter("ps")); // 配送方式
                int defray = Integer.parseInt(request.getParameter("defray")); // 支付方式
                int fp = Integer.parseInt(request.getParameter("fp"));
                String fptt = request.getParameter("fptt");
                String buys[] = request.getParameterValues("buys");

                Profile p = Profile.find(teasession._rv._strV);
                p.setState(state, teasession._nLanguage);
                p.setCity(city, teasession._nLanguage);
                p.setAddress(address, teasession._nLanguage);
                p.setEmail(email);
                p.setFirstName(firstname, teasession._nLanguage);
                p.setLastName(lastname, teasession._nLanguage);
                p.setOrganization(organization, teasession._nLanguage);
                p.setZip(zip, teasession._nLanguage);
                p.setTelephone(telephone, teasession._nLanguage);

                String trade = Trade.createByBuys(teasession._strCommunity, teasession._rv, 0, point, supplier, total.add(freight), freight, teasession._nLanguage, state, city, address, email, firstname, lastname, organization, zip, telephone, ps, defray, fp, fptt, buys);
                //nexturl = "/jsp/pay/index.jsp";
                //response.sendRedirect("/jsp/pay/index.jsp?subject=" +java.net.URLEncoder.encode(trade, "UTF-8")  + "&total_fee=" + total);
               // return;
                nexturl = "/jsp/offer/CheckoutCart3.jsp?community=" + teasession._strCommunity + "&trade=" + trade + "&defray=" + defray;

            } else if ("edittrade".equals(act)) // 编辑订单
            {
                String trade = request.getParameter("trade");
                Trade obj = Trade.find(trade);
                int status = -1;
                String _strStatus = request.getParameter("status");
                if (_strStatus != null)
                {
                    status = Integer.parseInt(_strStatus);
                }
                int paystate = -1;
                String _strPaystate = request.getParameter("paystate");
                if (_strPaystate != null)
                {
                    paystate = Integer.parseInt(_strPaystate);
                }
                String state = request.getParameter("state");
                String city = request.getParameter("city");
                String address = request.getParameter("address");
                String email = request.getParameter("email");
                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");
                String organization = request.getParameter("organization");
                String zip = request.getParameter("zip");
                String telephone = request.getParameter("telephone");
                String remark = request.getParameter("remark");
                String remark2 = request.getParameter("remark2");
                int ps = Integer.parseInt(request.getParameter("ps")); // 配送方式
                int defray = Integer.parseInt(request.getParameter("defray")); // 支付方式
                int fp = Integer.parseInt(request.getParameter("fp"));
                String fptt = request.getParameter("fptt");
                String proof = request.getParameter("proof");
                // 发货时间
                Date stime = null;
                String _strStime = request.getParameter("stime");
                String _strStimeYear = request.getParameter("stimeYear");
                if (_strStimeYear != null)
                {
                    _strStime = _strStimeYear + "-" + request.getParameter("stimeMonth") + "-" + request.getParameter("stimeDay");
                }
                if (_strStime != null && _strStime.length() > 0)
                {
                    stime = Trade.sdf.parse(_strStime);
                }
                // 预计到达时间
                Date ftime = null;
                String _strFtime = request.getParameter("ftime");
                String _strFtimeYear = request.getParameter("ftimeYear");
                if (_strFtimeYear != null)
                {
                    _strFtime = _strFtimeYear + "-" + request.getParameter("ftimeMonth") + "-" + request.getParameter("ftimeDay");
                }
                if (_strFtime != null && _strFtime.length() > 0)
                {
                    ftime = Trade.sdf.parse(_strFtime);
                }
                obj.set(teasession._rv, status, teasession._nLanguage, state, city, address, email, firstname, lastname, organization, zip, telephone, remark, remark2, ps, defray, paystate, fp, fptt, proof, stime, ftime);
            } else if ("saleneworder".equals(act)) // 确认收货地址
            {
                String trades[] = request.getParameterValues("trades");
                if (trades != null)
                {
                    for (int i = 0; i < trades.length; i++)
                    {
                        Trade obj = Trade.find(trades[i]);
                        obj.set(teasession._rv, Trade.TRADES_CONFIRMED, obj.getPaystate());
                    }
                } else
                {
                    String trade = request.getParameter("trade");
                    int status = Integer.parseInt(request.getParameter("status"));
                    String address = request.getParameter("address");
                    String email = request.getParameter("email");
                    String firstname = request.getParameter("firstname");
                    String lastname = request.getParameter("lastname");
                    String organization = request.getParameter("organization");
                    String zip = request.getParameter("zip");
                    String telephone = request.getParameter("telephone");
                    Trade obj = Trade.find(trade);
                    obj.set(teasession._rv, status, teasession._nLanguage, address, email, firstname, lastname, organization, zip, telephone);
                }
            } else if ("salecancelorder".equals(act)) // 已经取消的订单
            {
                String trades[] = request.getParameterValues("trades");
                if (trades != null)
                {
                    for (int i = 0; i < trades.length; i++)
                    {
                        Trade obj = Trade.find(trades[i]);
                        obj.set(teasession._rv, obj.getOldStatus(), obj.getPaystate());
                    }
                }
            } else if ("salepayment".equals(act)) // 财务审核
            {
                String trades[] = request.getParameterValues("trades");
                if (trades != null)
                {
                    for (int i = 0; i < trades.length; i++)
                    {
                        Trade obj = Trade.find(trades[i]);
                        obj.set(teasession._rv, obj.getStatus(), 2);
                    }
                } else
                {
                    String trade = request.getParameter("trade");
                    int paystate = Integer.parseInt(request.getParameter("paystate"));
                    String proof = request.getParameter("proof");
                    Trade obj = Trade.find(trade);
                    obj.set(teasession._rv, paystate, proof);
                }
            } else if ("saleunshipped2".equals(act)) // 商城备货
            {
                String trade = request.getParameter("trade");
                String remark2 = request.getParameter("remark2");
                Trade obj = Trade.find(trade);
                obj.set(teasession._rv, obj.getStatus(), remark2, obj.getStime(), obj.getFtime());
            } else if ("saleunshipped".equals(act)) // 准备发货
            {
                String trades[] = request.getParameterValues("trades");
                if (trades != null)
                {
                    for (int i = 0; i < trades.length; i++)
                    {
                        Trade obj = Trade.find(trades[i]);
                        obj.set(teasession._rv, Trade.TRADES_UNSHIPPED, obj.getPaystate());
                        obj.set(new Date(), new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 3L)); //设置发货时间和预计到达时间
                    }
                } else
                {
                    String trade = request.getParameter("trade");
                    int status = Integer.parseInt(request.getParameter("status"));
                    String remark2 = request.getParameter("remark2");
                    // 发货时间
                    Date stime = null;
                    String _strStime = request.getParameter("stime");
                    String _strStimeYear = request.getParameter("stimeYear");
                    if (_strStimeYear != null)
                    {
                        _strStime = _strStimeYear + "-" + request.getParameter("stimeMonth") + "-" + request.getParameter("stimeDay");
                    }
                    if (_strStime != null && _strStime.length() > 0)
                    {
                        stime = Trade.sdf.parse(_strStime);
                    }
                    // 预计到达时间
                    Date ftime = null;
                    String _strFtime = request.getParameter("ftime");
                    String _strFtimeYear = request.getParameter("ftimeYear");
                    if (_strFtimeYear != null)
                    {
                        _strFtime = _strFtimeYear + "-" + request.getParameter("ftimeMonth") + "-" + request.getParameter("ftimeDay");
                    }
                    if (_strFtime != null && _strFtime.length() > 0)
                    {
                        ftime = Trade.sdf.parse(_strFtime);
                    }
                    Trade obj = Trade.find(trade);
                    obj.set(teasession._rv, status, remark2, stime, ftime);
                }
            }
            else if ("salefinished".equals(act)) // 完成
            {
                String trades[] = request.getParameterValues("trades");
                if (trades != null)
                {
                    for (int i = 0; i < trades.length; i++)
                    {
                        Trade obj = Trade.find(trades[i]);
                        obj.set(teasession._rv, Trade.TRADES_FINISHED, obj.getPaystate());
                        /*对积分的添加   对会员表中的积分 进行修改*/
                        obj.getPoint();///取得积分,这里是字符串的形式
                        obj.getFtimeToString();
                        obj.getCustomer()._strV.toString();
                        Profile pro = Profile.find(obj.getCustomer()._strV.toString());
                        int addnum=0;
                        addnum=Integer.parseInt(obj.getPoint());//有可能报错，原有类型是字符串。

                        Date dates = new Date();
                        IntegralCycle.create(pro.getMember(),addnum,dates,4,pro.getCommunity());
                    }
                } else
                {
                    String trade = request.getParameter("trade");
                    int status = Integer.parseInt(request.getParameter("status"));
                    String rejectedtype = request.getParameter("rejectedtype");
                    String rejectedwhy = request.getParameter("rejectedwhy");
                    Trade obj = Trade.find(trade);
                    if (status == Trade.TRADES_REJECTED) //拒收
                    {
                        obj.set(teasession._rv, rejectedtype, rejectedwhy);
                    } else
                    {
                        obj.set(teasession._rv, status, obj.getPaystate());
                    }
                }
            }
            else if ("salerefund".equals(act)) //退款
            {
                String trades[] = request.getParameterValues("trades");
                if (trades != null)
                {
                    Date rtime = new Date();
                    for (int i = 0; i < trades.length; i++)
                    {
                        Trade obj = Trade.find(trades[i]);
                        BigDecimal rtotal = obj.getTotal().subtract(obj.getFreight());
                        obj.set(teasession._rv, Trade.TRADES_REFUND, rtotal, 0, rtime, "");
                    }
                } else
                {
                    String trade = request.getParameter("trade");
                    BigDecimal rtotal = new BigDecimal(request.getParameter("rtotal"));
                    int rtype = Integer.parseInt(request.getParameter("rtype"));
                    String rproof = request.getParameter("rproof");
                    Trade obj = Trade.find(trade);
                    obj.set(teasession._rv, Trade.TRADES_APPROVED_REFUND, rtotal, rtype, new Date(), rproof);
                }
            } else if ("salerollback".equals(act)) //回滚
            {
                String trade = request.getParameter("trade");
                int id = TradeMember.getLast(trade);
                TradeMember tm = TradeMember.find(id);
                if (!teasession._rv.toString().equals(tm.getMember()))
                {
                    response.sendError(403);
                    return;
                }
                tm.delete(); //把最后一次删除
                id = TradeMember.getLast(trade);
                tm = TradeMember.find(id);
                Trade obj = Trade.find(trade);
                obj.set(null, tm.getStatus(), tm.getPaystate());
            } else if ("saleexport".equals(act)) //导出
            {
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("Order.xls", "UTF-8"));
                StringBuilder sql = new StringBuilder();

                String _strTrade = request.getParameter("trade");
                String _strPrice_from = request.getParameter("price_from");
                String _strPrice_to = request.getParameter("price_to");
                String _strStatus = request.getParameter("status");
                if (_strTrade != null && (_strTrade = _strTrade.trim()).length() > 0)
                {
                    sql.append(" AND trade LIKE ").append(DbAdapter.cite("%" + _strTrade + "%"));
                }
                boolean _bPf = _strPrice_from != null && (_strPrice_from = _strPrice_from.trim()).length() > 0;
                boolean _bPt = _strPrice_to != null && (_strPrice_to = _strPrice_to.trim()).length() > 0;
                if (_bPf || _bPt)
                {
                    if (_bPf)
                    {
                        sql.append(" AND total>=").append(_strPrice_from);
                    }
                    if (_bPt)
                    {
                        sql.append(" AND total<").append(_strPrice_to);
                    }
                }
                if (_strStatus != null && _strStatus.length() > 0)
                {
                    sql.append(" AND status=").append(_strStatus);
                }

                String order = request.getParameter("order");
                if (order == null)
                {
                    order = "trade";
                }

                String desc = request.getParameter("desc");
                if (desc == null)
                {
                    desc = "desc";
                }

                ServletOutputStream os = response.getOutputStream();
                jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                jxl.write.WritableSheet ws = wwb.createSheet("export.xls", 0);
                ws.addCell(new jxl.write.Label(0, 0, "订单号"));
                ws.addCell(new jxl.write.Label(1, 0, "时间"));
                ws.addCell(new jxl.write.Label(2, 0, "会员"));
                ws.addCell(new jxl.write.Label(3, 0, "总价"));
                ws.addCell(new jxl.write.Label(4, 0, "状态"));
                ws.addCell(new jxl.write.Label(5, 0, "支付状态"));
                ws.addCell(new jxl.write.Label(6, 0, "地址"));
                ws.addCell(new jxl.write.Label(7, 0, "邮箱"));
                ws.addCell(new jxl.write.Label(8, 0, "电话"));

                Enumeration e = Trade.find(teasession._strCommunity, sql.toString(), 0, Integer.MAX_VALUE);
                for (int i = 1; e.hasMoreElements(); i++)
                {
                    String trade = (String) e.nextElement();
                    Trade obj = Trade.find(trade);
                    RV rv = obj.getCustomer();
                    Profile p = Profile.find(rv._strR);
                    ws.addCell(new jxl.write.Label(0, i, trade));
                    ws.addCell(new jxl.write.Label(1, i, obj.getTimeToString()));
                    ws.addCell(new jxl.write.Label(2, i, p.getLastName(teasession._nLanguage) + p.getFirstName(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(3, i, String.valueOf(obj.getTotal())));
                    ws.addCell(new jxl.write.Label(4, i, r.getString(teasession._nLanguage, Trade.TRADE_STATUS[obj.getStatus()])));
                    ws.addCell(new jxl.write.Label(5, i, Trade.PAYSTATE_TYPE[obj.getPaystate()]));
                    ws.addCell(new jxl.write.Label(6, i, obj.getCityToString(teasession._nLanguage) + " " + obj.getAddress(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(7, i, obj.getEmail()));
                    ws.addCell(new jxl.write.Label(8, i, obj.getTelephone(teasession._nLanguage)));
                }
                wwb.write();
                wwb.close();
                return;
            } else
            {

            }
            response.sendRedirect(nexturl);
        } catch (Exception ex)
        {
            ex.printStackTrace();
            throw new ServletException(ex.getMessage());
        }
    }
}
