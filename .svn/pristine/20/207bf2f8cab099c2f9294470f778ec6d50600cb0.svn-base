package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import tea.db.DbAdapter;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.yl.shop.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

/**
 * 收货人信息
 */
public class NcLzProducts extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();
        out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
        String message = "操作执行成功！";
        // 新增
        if ("add".equals(act)) {
            try {
                int member = h.member;
                int puid = h.getInt("puid",0);//厂商
                String activity = h.get("activity","");
                NcLzProduct product = NcLzProduct.find(0);
                if(activity.contains("-")){
                    product.setStatus(2);
                    product.setActivityScope(activity);
                }else {
                    product.setStatus(1);
                    product.setActivity(activity);
                }
                String nccode = h.get("nccode","");
                product.setMember(member);
                product.setNcCode(nccode);
                product.setPuid(puid);
                product.set();
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
                return;
            }
            out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
            return;
        } else if ("del".equals(act)) {
            try {
                int id = h.getInt("id");
                NcLzProduct product = NcLzProduct.find(id);
                product.setStatus(0);
                product.setMember(h.member);
                product.set();

            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
                return;
            }
            out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
            return;
            // 保存签收人信息
        }

    }
}
