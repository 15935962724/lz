package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.yl.shop.ProductStock;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.StockOperation;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

public class StockOperations extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();

        // 查询所有操作记录
        if("findSOList".equals(act)){
            try {
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");

                StringBuffer sql = new StringBuffer();
                Date t0=h.getDate("t0");
                if(t0!=null)
                {
                    sql.append(" AND so.time>"+DbAdapter.cite(t0));
                }
                Date t1=h.getDate("t1");
                if(t1!=null)
                {
                    sql.append(" AND so.time<"+DbAdapter.cite(t1));
                }
                int type = h.getInt("type");
                if (type>-1){
                    sql.append(" and so.type="+type);
                }
                int member = h.getInt("member");
                if(member>0){
                    sql.append(" and so.member="+member);
                }
                String orderId = h.get("orderId");
                if(orderId!=null && !"".equals(orderId)){
                    sql.append(" and so.oid in (select id from shoporder where order_id like "+ Database.cite("%"+orderId+"%")+")");
                }

                String quality = h.get("quality");
                if(quality!=null && !"".equals(quality)){
                    sql.append(" AND ps.quality like  "+Database.cite("%"+quality+"%"));
                }

                String batch = h.get("batch");
                if(batch!=null && !"".equals(batch)){
                    sql.append(" AND ps.batch like  "+Database.cite("%"+batch+"%"));
                }

                int sum = StockOperation.count(sql.toString());

                // sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");

                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try {
                        List<StockOperation> soList = StockOperation.find(sql.toString()+" order by so.time desc", pos, page_size);
                        for (int i = 0; i < soList.size(); i++) {
                            StockOperation so = soList.get(i);
                            int psid= so.getPsid();
                            ProductStock ps=ProductStock.find(psid);
                            Profile p = Profile.find(so.getMember());
                            Date time = so.getTime();
                            ShopOrder shopOrder = ShopOrder.find(so.getOid());
                            JSONObject jo2 = new JSONObject();
                            jo2.put("obj", JSON.toJSON(so));
                            jo2.put("member",p.getMember());
                            jo2.put("time", MT.f(time,1));
                            jo2.put("orderId",shopOrder.getOrderId());
                            jo2.put("quality",ps.getQuality());
                            jo2.put("batch",ps.getBatch());
                            ja.put(jo2);
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                    jsonSb.append(ja);
                } else {
                    jsonSb.append("\"\"");
                }
                jsonSb.append(",\"type\":\"0\"}");
                out.print(jsonSb.toString());
                return;
            } catch (Exception e) {
                Filex.logs("member.txt", "Members:" + act + "e" + e);
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
                out.print(jo.toString());
                return;
            }
        }

    }
}
