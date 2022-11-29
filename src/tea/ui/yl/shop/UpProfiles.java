package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.yl.shop.EmpowerRecord;
import tea.entity.yl.shop.SignFor;
import tea.entity.yl.shop.UpProfile;

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
 * 用户申请升级
 */
public class UpProfiles extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();

        // 查询所有
        if("findUPList".equals(act)){
            try {
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");

                StringBuffer sql = new StringBuffer();
                String name = h.get("name","");
                if(name.length()>0){
                    sql.append(" and profile in (select profile from profile where member like'%" + name + "%')");
                }
                int uptype = h.getInt("uptype");
                if(uptype>-1){
                    sql.append(" and uptype="+uptype);
                }
                int state = h.getInt("state");
                if(state>-1){
                    sql.append(" and state="+state);
                }

                int sum = UpProfile.count(sql.toString());

                // sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");

                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try {
                        List<UpProfile> upList = UpProfile.find(sql.toString()+" order by uptime desc", pos, page_size);
                        for (int i = 0; i < upList.size(); i++) {
                            UpProfile up = upList.get(i);
                            Profile p = Profile.find(up.getProfile());
                            JSONObject jo2 = new JSONObject();
                            jo2.put("obj", JSON.toJSON(up));
                            jo2.put("member",p.getMember());
                            jo2.put("mobile",MT.f(p.getMobile()));
                            String email = "";
                            if(up.getEmail()!=null){
                                email = up.getEmail();
                            }else {
                                email = p.getEmail();
                            }
                            jo2.put("email", MT.f(email));
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
            // 申请升级服务商
        }else if("upProfile".equals(act)){
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            try {

                int upid = h.getInt("upid");
                int business = h.getInt("business.attch");
                int license = h.getInt("license.attch");
                int other = h.getInt("other.attch");
                String company = h.get("company");
                String email = h.get("eamil");
                if(business==0||license==0||company==null){
                    message = "信息不完整，操作失败";
                    out.print("<script>mt.show('" + message + "',1,'" +nexturl+ "');</script>");
                    return;
                }

                UpProfile up = UpProfile.find(upid);
                up.setProfile(h.member);
                up.setUptype(0);
                up.setBusiness(business);
                up.setLicense(license);
                up.setOther(other);
                up.setState(0);
                up.setUptime(new Date());
                up.setCompany(company);
                up.setEmail(email);
                up.set();
                message = h.get("mesg");
            } catch (SQLException e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }
            //out.print("<script>mt.show('" + message + "',1,'" + "/jsp/yl/shopweb/UpProfile.jsp" + "');</script>");
            out.print("<script>mt.show('" + message + "',1,'" +nexturl+ "');</script>");
            return;
            // 审核
        }else if("examine".equals(act)){
            try {
                int upid = h.getInt("upid");
                int state = h.getInt("state");
                int uptype = h.getInt("uptype");
                String desc = h.get("desc","");
                UpProfile up = UpProfile.find(upid);
                up.setState(state);
                up.setDescribe(desc);
                up.setExtime(new Date());
                up.setMember(h.member);
                up.set();
                if(state==1){ // 审核成功修改用户类型
                    Profile p = Profile.find(up.getProfile());
                    if(uptype==1) {
                        p.setMembertype(1);
                    }else{
                        p.setMembertype(2);
                    }
                    p.set();
                }
                jo.put("type", "0");
            } catch (SQLException e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
            }
            out.print(jo.toString());
            return;
        }else if("dele_up".equals(act)){//用户删除申请信息
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            String next_url = h.get("nexturl");
            int upid = h.getInt("upid");
            int vip = h.getInt("vip",0);
            if(vip==0) {//升级服务商
                try {
                    UpProfile up = UpProfile.find(upid);
                    up.setIsdele(1);
                    up.set();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }else {//升级vip
                try {
                    UpProfile up = UpProfile.find(upid);
                    up.setIsdele(1);
                    up.set();
                    List<EmpowerRecord> list = EmpowerRecord.find("AND upid="+upid,0,1);
                    EmpowerRecord er = list.get(0);
                    int id = er.getEid();
                    EmpowerRecord.delete(String.valueOf(id));//删除vip申请表
                    List<SignFor> list1 = SignFor.find("AND eid=" + id, 0, Integer.MAX_VALUE);
                    for (int i = 0; i <list1.size() ; i++) {//删除SingFor
                        SignFor.del(list1.get(i).getSid());
                    }


                } catch (SQLException e) {
                    e.printStackTrace();
                    out.print("<script>mt.show('系统异常,请重试！');</script>");
                }

            }
            out.print("<script>mt.show('" + message + "',1,'" +nexturl+ "');</script>");
            return;
        }

    }
}
