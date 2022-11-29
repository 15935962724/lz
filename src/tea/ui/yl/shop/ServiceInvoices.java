package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import tea.db.DbAdapter;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.member.Profile;
import tea.entity.yl.shop.ProcurementUnitJoin;
import tea.entity.yl.shop.ServiceInvoice;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public class ServiceInvoices extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();

        // 查询所有
        if("findSIList".equals(act)){
            try {
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");
                int puid = h.getInt("puid");
                StringBuffer sql = new StringBuffer();
                sql.append(" and puid="+puid);
                int pujid=h.getInt("puj_id");
                if(pujid!=0&&pujid!=-1){
                    sql.append(" and puj_id="+pujid);
                }

                String invoiceCode = h.get("invoiceCode","");
                if(invoiceCode.length()>0) {
                    sql.append(" AND invoiceCode like'%" + invoiceCode + "%'");
                }
                Date t0=h.getDate("t0");
                if(t0!=null)
                {
                    sql.append(" AND time>"+ DbAdapter.cite(t0));
                }
                Date t1=h.getDate("t1");
                if(t1!=null)
                {
                    sql.append(" AND time<"+DbAdapter.cite(t1));
                }
                int type = h.getInt("type");
                if(type>-1){
                    sql.append(" and type="+type);
                }
                int state = h.getInt("state");
                if(state>-1){
                    sql.append(" and state="+state);
                }
                int profile = h.getInt("proflie");
                if(profile>0){
                    sql.append(" and profile="+profile);
                }

                // 获取总数
                int sum = ServiceInvoice.count(sql.toString());
                // sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");

                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try {
                        List<ServiceInvoice> list = ServiceInvoice.find(sql.toString(), pos, page_size);
                        for (int i = 0; i < list.size(); i++) {
                            ServiceInvoice si = list.get(i);
                            Profile p = Profile.find(si.getProfile());
                            int puj_id = si.getPuj_id();//获取服务商公司关联id
                            String company = ProcurementUnitJoin.find(puj_id).getCompany();
                            JSONObject jo2 = new JSONObject();
                            jo2.put("obj", JSON.toJSON(si));
                            jo2.put("profileName",p.member);
                            if(company==null){
                                company="无";
                            }
                            jo2.put("company",company);
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
            } catch (SQLException e) {
                Filex.logs("member.txt", "Members:" + act + "e" + e);
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
                out.print(jo.toString());
                return;
            }
            // 根据id查询
        }else if("findSI".equals(act)){
            try {
                int sid = h.getInt("sid");
                if(sid > 0) {
                    ServiceInvoice si = ServiceInvoice.find(sid);
                    jo.put("type", "0");
                    jo.put("obj", JSON.toJSON(si));
                }
            } catch (Exception e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
            }
            out.print(jo.toString());
            return;
            // 修改||添加发票
        }else if("editSI".equals(act)){
            try {
                int sid = h.getInt("sid");
                ServiceInvoice si = ServiceInvoice.find(sid);
                si.setInvoiceCode(h.get("invoiceCode"));
                si.setProfile(h.getInt("profile"));
                si.setMoney(h.getFloat("money"));
                Date time = h.getDate("time");
                si.setTime(time);
                si.setPuid(h.getInt("puid"));
                si.setPuj_id(h.getInt("company"));
                si.set();
                jo.put("type", "0");
            } catch (Exception e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
            }
            out.print(jo.toString());
            return;
            // 选择服务商
        }else if("joinProfile".equals(act)) {
            int puid = h.getInt("puid");
            try {
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");

                StringBuffer sql = new StringBuffer("");
                String member = h.get("member","");
                if (member.length()>0) {
                    sql.append(" AND member like'%" + member + "%'");
                }
                sql.append(" and profile in (select profile from procurementunit_join where puid=" + puid + ")");

                int sum = Profile.count(sql.toString());

                //int sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try {
                        List<Profile> list = Profile.find1(sql.toString(), pos, page_size);
                        for (Profile profile : list) {
                            JSONObject jo2 = new JSONObject();
                            //jo2.put("obj",JSON.toJSON(profile));
                            if (profile.member == null) {
                                jo2.put("member", "--");
                            } else {
                                jo2.put("member", profile.member);
                            }
                            jo2.put("profile", profile.profile);
                            if (profile.mobile == null) {
                                jo2.put("mobile", "--");
                            } else {
                                jo2.put("mobile", profile.mobile);
                            }
                            if (profile.email == null) {
                                jo2.put("email", "--");
                            } else {
                                jo2.put("email", profile.email);
                            }
                            ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid, profile.profile);
                            if (puj.company == null) {
                                jo2.put("company", "--");
                            } else {
                                jo2.put("company", puj.company);
                            }
                            ja.put(jo2);
                        }
                    } catch (Exception e) {
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
        }else if("delSi".equals(act)){
            try {
                int sid = h.getInt("sid");
                ServiceInvoice.delete(sid);
                jo.put("type", "0");
                jo.put("mes","操作执行成功!");
                out.println(jo);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                out.close();
            }
        }/*else if("mateOrder".equals(act)){
            String[] selectIds = req.getParameterValues("selectIds");
            for (String id : selectIds) {

            }
        }*/
        else if("joinCompany".equals(act)){
            int puid = h.getInt("puid");//服务商的profile
            int puid_id = h.getInt("puid_id");//服务商厂商id
            try {
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");

                int sum = ProcurementUnitJoin.count("AND profile="+puid+"AND puid="+puid_id);

                //int sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try {
                        List<ProcurementUnitJoin> list = ProcurementUnitJoin.find("AND profile="+puid+"AND puid="+puid_id, pos, page_size);
                        for (ProcurementUnitJoin p : list) {
                            JSONObject jo2 = new JSONObject();
                            if(p.company==null){
                                jo2.put("company","---");
                            }else {
                                jo2.put("company",p.company);
                            }
                            Profile profile = Profile.find(p.getProfile());
                            jo2.put("member",profile.getMember());
                            jo2.put("profile",p.getJid());
                            //jo2.put("obj",JSON.toJSON(profile));
                            /*if (p.member == null) {
                                jo2.put("member", "--");
                            } else {
                                jo2.put("member", profile.member);
                            }
                            jo2.put("profile", profile.profile);
                            if (profile.mobile == null) {
                                jo2.put("mobile", "--");
                            } else {
                                jo2.put("mobile", profile.mobile);
                            }
                            if (profile.email == null) {
                                jo2.put("email", "--");
                            } else {
                                jo2.put("email", profile.email);
                            }
                            ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid, profile.profile);
                            if (puj.company == null) {
                                jo2.put("company", "--");
                            } else {
                                jo2.put("company", puj.company);
                            }*/
                            ja.put(jo2);
                        }
                    } catch (Exception e) {
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
