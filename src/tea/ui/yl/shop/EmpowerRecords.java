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
import tea.entity.yl.shop.ShopHospital;
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
 * 医院授权申请
 */
public class EmpowerRecords extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();

        // 查询所有
        if ("findERList".equals(act)) {
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
                int radiationCard = h.getInt("radiationCard.attch");
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
                er.setRadiationCard(radiationCard);
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
            out.print("<script>mt.show('" + message + "',1,'" + "/jsp/yl/shopweb/Empower.jsp" + "');</script>");
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
                String signatorie=null;
                String signatories_fp =null;
                String mobile =null;
                String mobile_fp =null;
                String addresse =null;
                String addresse_fp=null;
                String department_fp=null;
                String department =null;
                int ismobile = h.getInt("ismobile");
                if (ismobile != 1) {//电脑版
                    if (hospital == 0 || turnApproval == 0 || radiationCard == 0 || radiation == null || raditaionStart == null || radiate == 0 || radiateCard == 0 ||
                            signFor == 0 || signatories == null || departments == null || mobiles == null || signTypes == null || addresses == null) {
                        message = "信息不完整，操作失败";
                        out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
                        return;
                    }
                    if(raditaionStart.after(radiation)||!raditaionStart.after(new Date())){//开始在结束之后不可以
                        message = "辐射安全许可证有效期填写有误，操作失败" ;
                        out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
                        return;
                    }
                } else {//手机版
                     signatorie = h.get("signatory");
                     signatories_fp = h.get("signatory_fp");
                     mobile = h.get("mobile");
                    mobile_fp = h.get("mobile_fp");
                   addresse = h.get("address");
                     addresse_fp = h.get("address_fp");
                    department=h.get("department");
                    department_fp = h.get("department_fp");
                }


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
                if (ismobile != 1) {
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
                } else {//手机版         粒子 0 ， 发票 1
                    int num = SignFor.count("AND perfile="+h.member);
                    if(num!=0){//清除数据  为修改操作
                        List<SignFor> list = SignFor.find("AND perfile="+h.member,0,Integer.MAX_VALUE);
                        for (int j = 0; j <list.size() ; j++) {
                            SignFor.del(list.get(j).getSid());
                        }
                    }
                    for (int i = 0; i < 2; i++) {

                        SignFor sf = null;
                        sf = SignFor.find(0);
                        sf.setHospital(hospital);
                        sf.setEid(eid);
                        if(i==0){//粒子
                            sf.setSignatory(signatorie);
                            sf.setMobile(mobile);
                            sf.setSignType(0);
                            sf.setAddress(addresse);
                            sf.setDepartment(Integer.parseInt(department));
                        }else {//发票
                            sf.setSignatory(signatories_fp);
                            sf.setMobile(mobile_fp);
                            sf.setSignType(1);
                            sf.setAddress(addresse_fp);
                            sf.setDepartment(Integer.parseInt(department_fp));
                        }
                        sf.setPerfile(h.member);
                        sf.set();
                    }
                    out.print("<script>mt.show('" + message + "',1,'" + "/mobjsp/yl/shopweb/VIPapply.jsp" + "');</script>");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }
            //out.print("<script>mt.show('" + message + "',1,'" + "/jsp/yl/shopweb/UpProfile.jsp"+ "');</script>");
            out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
            return;
            // 完善资料审核
        } else if ("allow".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            int eid = h.getInt("eid");
            try {
                int perfect = h.getInt("perfect");
                String desc = h.get("desc", "");
                int certificate = h.getInt("certificate.attch");

                EmpowerRecord er = EmpowerRecord.find(eid);
                er.setPerfect(perfect);
                er.setDescribe(desc);
                if (certificate != 0) {
                    er.setCertificate(certificate);
                }
                er.set();
                jo.put("type", "0");
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
                return;
            }
            out.print("<script>mt.show('" + message + "',1,'/jsp/yl/shop/EmpowerInfo.jsp?eid=" + eid + "');</script>");
            return;
            // 保存签收人信息
        } else if ("signFor".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            int eid = h.getInt("eid");
            int uptype = h.getInt("uptype");
            int upid = h.getInt("upid");
            try {
                int hospital = h.getInt("hospital");

                int sid = h.getInt("sid");
                String[] signatories = h.getValues("signatory");
                String[] departments = h.getValues("department");
                String[] mobiles = h.getValues("mobile");
                String[] signTypes = h.getValues("signType");
                String[] addresses = h.getValues("address");

                // 先清空原有签收人
                List<SignFor> list = SignFor.find(" and eid=" + eid, 0, Integer.MAX_VALUE);
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
            out.print("<script>mt.show('" + message + "');</script>");
            return;
        } else if ("contract".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            try {
                int eid = h.getInt("eid");
                int contract = h.getInt("contract.attch");
                EmpowerRecord er = EmpowerRecord.find(eid);
                er.setContract(contract);
                er.set();

            } catch (SQLException e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }
            out.print("<script>mt.show('" + message + "',1,'" + "/jsp/yl/shopweb/Empower.jsp" + "');</script>");
            return;

        } else if ("mail_ShouQuan".equals(act)) {
            out.println("<script>var mt=parent.parent.mt,doc=parent.parent.document;</script>");
            String message = "操作执行成功！";
            try {
                int eid = h.getInt("eid");
                String company = h.get("company_mail");
                String number = h.get("number_mail");
                EmpowerRecord er = EmpowerRecord.find(eid);
                er.setCompany_mail(company);
                er.setNumber_mail(number);
                er.set();

            } catch (SQLException e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }
            out.print("<script>mt.show('" + message + "',1,'" + "/jsp/yl/shop/EmpowerRecords.jsp" + "');</script>");
            return;

        }else if("update_hos".equals(act)){//管理修改用户申请医院
            out.println("<script>var mt=parent.parent.mt,doc=parent.parent.document;</script>");
            String message = "操作执行成功！";
            try {
               int upid =  h.getInt("upid");
               int hos_id = h.getInt("hospital_id");
               List<EmpowerRecord> list = EmpowerRecord.find("AND upid="+upid,0,Integer.MAX_VALUE);
               EmpowerRecord e = list.get(0);
               e.setHospital(hos_id);
               e.set();

            } catch (SQLException e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
            }
            out.print("<script>mt.show('" + message + "',1,'" + "/jsp/yl/shop/UpgradeInfo.jsp?upid="+h.getInt("upid")+"" + "');</script>");
            return;
        }

    }
}
