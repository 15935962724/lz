package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
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
public class Consignees extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();

        // 新增
        if ("asda".equals(act)) {
            try {
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");

                StringBuffer sql = new StringBuffer();
                String name = h.get("name", "");
                if (name.length() > 0) {
                    sql.append(" and profile in (select profile from profile where member like'%" + MT.f(name) + "%')");
                }
                String client = h.get("client", "");
                if (client.length() > 0) {
                    sql.append(" and client like'%" + MT.f(client) + "%'");
                }
                int state = h.getInt("state");
                if (state > -1) {
                    sql.append(" and state=" + state);
                }
                int perfect = h.getInt("perfect");
                if (perfect > -1) {
                    sql.append(" and perfect=" + perfect);
                }
                //sql.append(" and upid in (select upid from upProfile where uptype=0)");

                int sum = EmpowerRecord.count(sql.toString());

                // sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");

                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try {
                        List<EmpowerRecord> erList = EmpowerRecord.find(sql.toString() + " order by empowerTime desc", pos, page_size);
                        for (int i = 0; i < erList.size(); i++) {
                            EmpowerRecord er = erList.get(i);
                            UpProfile up = UpProfile.find(er.getUpid());
                            if (up.getUptype() == 0) {
                                Profile p = Profile.find(er.getProfile());
                                ShopHospital hospital = ShopHospital.find(er.getHospital());
                                JSONObject jo2 = new JSONObject();
                                jo2.put("obj", JSON.toJSON(er));
                                jo2.put("profile", p.getMember());
                                jo2.put("hospital", hospital.getName());
                                ja.put(jo2);
                            }
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
            // 授权申请
        } else if ("empower".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            try {
                int upid = h.getInt("upid");
                int eid = h.getInt("eid");
                int hospital = h.getInt("hospital");
                Date stateTime = h.getDate("stateTime");
                Date endTime = h.getDate("endTime");
                String client = h.get("client");
                int clientID = h.getInt("clientID.attch");
                Date raditaionStart = h.getDate("raditaionStart");
                Date radiation = h.getDate("radiation");
                int radiate = h.getInt("radiate.attch");
                int empower = h.getInt("empower.attch");
                int radiateCard = h.getInt("radiateCard.attch");


                EmpowerRecord er = EmpowerRecord.find(eid);
                er.setUpid(upid);
                er.setStateTime(stateTime);
                er.setState(0);
                er.setEndTime(endTime);
                er.setClient(client);
                er.setHospital(hospital);
                er.setEmpowerTime(new Date());
                er.setProfile(h.member);
                er.setClientID(clientID);
                er.setRaditaionStart(raditaionStart);
                er.setRadiation(radiation);
                er.setRadiate(radiate);
                er.setEmpower(empower);
                er.setRadiateCard(radiateCard);
                er.set();


            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }
            out.print("<script>mt.show('" + message + "',1,'" + "/jsp/yl/shopweb/Empower.jsp" + "');</script>");
            //out.print("<script>mtDiag.show('"+message+"')</script>");
            return;
            // 后台修改授权有效期
        } else if ("editTime".equals(act)) {
            try {
                int eid = h.getInt("eid");
                Date stateTime = h.getDate("stateTime");
                Date endTime = h.getDate("endTime");

                EmpowerRecord er = EmpowerRecord.find(eid);
                er.setStateTime(stateTime);
                er.setEndTime(endTime);
                er.set();

                jo.put("type", "0");
            } catch (Exception e) {
                Filex.logs("member.txt", "Members:" + act + "e" + e);
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
                out.print(jo.toString());
                return;
            }
            out.print(jo.toString());
            return;
        } else if ("saveCer".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            int eid = h.getInt("eid");
            try {
                int certificate = h.getInt("certificate.attch");

                EmpowerRecord er = EmpowerRecord.find(eid);
                er.setCertificate(certificate);
                er.set();

            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }
            out.print("<script>mt.show('" + message + "',1,'" + "/jsp/yl/shop/EmpowerInfo.jsp?eid=" + eid + "');</script>");
            return;
            // 授权审核
        } else if ("examine".equals(act)) {
            try {
                int eid = h.getInt("eid");
                int state = h.getInt("state");
                String desc = h.get("desc", "");

                EmpowerRecord er = EmpowerRecord.find(eid);
                er.setState(state);
                er.setDescribe(desc);
                er.setExamineTime(new Date());
                if (state == 1) {
                    ShopHospital hos = ShopHospital.find(er.getHospital());
                    hos.setUpEmpower(1);
                    hos.set();
                } else if (state == 2) {
                    ShopHospital hos = ShopHospital.find(er.getHospital());
                    hos.setVipEmpower(1);
                    hos.set();
                }
                er.set();
                jo.put("type", "0");
            } catch (Exception e) {
                Filex.logs("member.txt", "Members:" + act + "e" + e);
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
                out.print(jo.toString());
                return;
            }
            out.print(jo.toString());
            return;
            // 完善资料+保存签收人
        } else if ("perfect".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            try {

                int eid = h.getInt("eid");
                int turnApproval = h.getInt("turnApproval.attch");
                int signFor = h.getInt("signFor.attch");
                int hospital = h.getInt("hospital");

                EmpowerRecord er = EmpowerRecord.find(eid);
                er.setTurnApproval(turnApproval);
                er.setSignFor(signFor);
                er.setPerfect(1);
                er.set();

                int sid = h.getInt("sid");
                String[] signatories = h.getValues("signatory");
                String[] departments = h.getValues("department");
                String[] mobiles = h.getValues("mobile");
                String[] signTypes = h.getValues("signType");
                String[] addresses = h.getValues("address");

                // 先清空原有签收人
                List<SignFor> list = SignFor.find(" and eid=" + er.getEid(), 0, Integer.MAX_VALUE);
                if (list.size() > 0) {
                    for (int i = 0; i < list.size(); i++) {
                        SignFor.del(list.get(i).getSid());
                    }
                }
                // 再插入新的签收人
                for (int i = 0; i < signatories.length; i++) {
                    SignFor sf = SignFor.find(sid);
                    sf.setHospital(hospital);
                    sf.setEid(eid);
                    sf.setSignatory(signatories[i]);
                    sf.setDepartment(Integer.parseInt(departments[i]));
                    sf.setMobile(mobiles[i]);
                    sf.setSignType(Integer.parseInt(signTypes[i]));
                    sf.setAddress(addresses[i]);
                    sf.setPerfile(h.member);
                    sf.set();
                }

            } catch (SQLException e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }
            out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
            return;
            // 升级vip
        } else if ("upVip".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            int eid = h.getInt("eid");
            int upid = h.getInt("upid");
            try {
                int hospital = h.getInt("hospital"); // 医院
                int turnApproval = h.getInt("turnApproval.attch"); // 转入转出审批表
                int radiationCard = h.getInt("radiationCard.attch"); // 辐射安全许可证
                Date radiation = h.getDate("radiation"); // 辐射安全许可证有效期结束
                Date raditaionStart = h.getDate("raditaionStart"); // 辐射安全许可证有效期开始
                int radiate = h.getInt("radiate.attch"); // 放射诊疗许可证
                int radiateCard = h.getInt("radiateCard.attch"); // 放射性药品使用许可证
                //int credentials = h.getInt("credentials.attch");
                int signFor = h.getInt("signFor.attch"); // 粒子/发票签收人

                // 签收人信息
                //int sid = h.getInt("sid");
                String[] sids = h.getValues("sid");
                String[] signatories = h.getValues("signatory");
                String[] departments = h.getValues("department");
                String[] mobiles = h.getValues("mobile");
                String[] signTypes = h.getValues("signType");
                String[] addresses = h.getValues("address");

                // 申请vip信息
                UpProfile up = UpProfile.find(upid);
                up.setProfile(h.member);
                up.setUptype(1);
                up.setState(0);
                up.setUptime(new Date());
                up.set();

                upid = up.getUpid();

                // 完善信息
                EmpowerRecord er = EmpowerRecord.find(eid);
                er.setUpid(upid);
                er.setRaditaionStart(raditaionStart);
                er.setRadiation(radiation);
                //er.setCredentials(credentials);
                er.setPerfect(1);
                er.setProfile(h.member);
                er.setEmpowerTime(new Date());
                er.setState(0);
                er.setHospital(hospital);
                er.setRadiateCard(radiateCard);
                er.setRadiate(radiate);
                er.setRadiationCard(radiationCard);
                er.setTurnApproval(turnApproval);
                er.setSignFor(signFor);
                er.set();

                eid = er.getEid();
                for (int i = 0; i < signatories.length; i++) {
                    SignFor sf = null;
                    if (sids != null) {
                        sf = SignFor.find(Integer.parseInt(sids[i]));
                    } else {
                        sf = SignFor.find(0);
                    }
                    sf.setHospital(hospital);
                    sf.setEid(eid);
                    sf.setSignatory(signatories[i]);
                    sf.setMobile(mobiles[i]);
                    sf.setSignType(Integer.parseInt(signTypes[i]));
                    sf.setAddress(addresses[i]);
                    sf.setPerfile(h.member);
                    sf.setDepartment(Integer.parseInt(departments[i]));
                    sf.set();
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }
            //out.print("<script>mt.show('" + message + "',1,'" + "/jsp/yl/shopweb/UpProfile.jsp"+ "');</script>");
            out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
            return;
            // 完善资料审核
        } else if ("add".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";

            try {
                int id = h.getInt("id");
                int city = h.getInt("city1");
                String name = h.get("name");
                String address = h.get("address");
                String mobile = h.get("mobile");
                String youbian = h.get("youbian");
                String ismoren = h.get("ismoren");
                String mail = h.get("mail");
                if(ismoren!=null){
                    if(ismoren.equals("1")||ismoren.equals("on")){
                        List<Consignee> list = Consignee.find("AND member=" + h.member, 0, Integer.MAX_VALUE);
                        for (Consignee c : list) {
                            c.setIsmoren(0);
                            c.set();
                        }
                    }

                }
                Consignee c = Consignee.find(0);
                c.setId(id);
                c.setCity(city);
                c.setName(name);
                c.setAddress(address);
                c.setMobile(mobile);
                c.setMail(mail);
                c.setYoubian(youbian);
                if ("1".equals(ismoren)|| "on".equals(ismoren)) {//改为默认
                    c.setIsmoren(1);
                } else {
                    c.setIsmoren(0);
                }
                c.setMember(h.member);
                c.set();


            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
                return;
            }
            out.print("<script>mt.show('" + message + "',1,'"+nexturl+"');</script>");
            return;
            // 保存签收人信息
        } else if ("delete".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";

            try {
                String id = h.get("id");
                Consignee.delete(id);


            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
                return;
            }
            out.print("<script>mt.show('" + message + "',1,'"+nexturl+"');</script>");
            return;
            // 保存签收人信息
        } else if ("ismoren".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";

            try {
                int id = h.getInt("id");
                Consignee c = Consignee.find(id);
                List<Consignee>list = Consignee.find("AND member="+h.member,0,Integer.MAX_VALUE);
                for (Consignee con : list) {
                    con.setIsmoren(0);
                    con.set();
                }
                c.setIsmoren(1);
                c.set();


            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
                return;
            }
            out.print("<script>mt.show('" + message + "',1,'"+nexturl+"');</script>");
            return;
            // 保存签收人信息
        }

    }
}
