package tea.ui.yl.shop;


import org.json.JSONObject;
import tea.entity.Database;
import tea.entity.Http;
import tea.entity.member.ModifyRecord;
import tea.entity.yl.shop.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;


/**
 * 签收
 */
public class ShopOrderSigns extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();
        String message = "操作执行成功！";
        out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
        if ("sign".equals(act)) {


            try {
                String orderId = h.get("orderId");//orderid
                ArrayList<ShopOrder> shopOrders = ShopOrder.find(" AND order_id=" + Database.cite(orderId), 0, Integer.MAX_VALUE);
                if (shopOrders.size() > 0) {
                    ShopOrder shopOrder = shopOrders.get(0);
                    if (shopOrder.getStatus() == 3) {
                        shopOrder.setStatus(4);
                        shopOrder.setReceiptTime(new Date());
                        shopOrder.setSign_user_openid(h.member + "");
                        shopOrder.set();
                        ModifyRecord.creatModifyRecord(shopOrder.getOrderId(), "客服同事签收", h.member, "订单已签收");
                    } else {
                        message = "订单不是出库状态！";
                    }
                } else {
                    message = "订单信息获取失败！";
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }

        } else if (act.equals("updateissign")) {
            try {
                int h_id = h.getInt("id");
                ShopHospital hospital = ShopHospital.find(h_id);
                int issign = hospital.getIssign();
                if (issign == 0) {
                    hospital.setIssign(1);
                    hospital.set();
                } else {
                    hospital.setIssign(0);
                    hospital.set();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }

        }
        out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
    }
}
