package tea.ui.yl.shop;

import org.json.JSONObject;
import tea.entity.Database;
import tea.entity.Http;
import tea.entity.member.Profile;
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
import java.util.List;

/**
 * 问卷调查
 */
public class Questions extends HttpServlet {

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
                String order_id = h.get("pihao");//订单号
                //List<Question> questions = Question.find(" AND orderId=" + Database.cite(order_id), 0, Integer.MAX_VALUE);
                Date time0 = h.getDate("time0");//开始时间
                Date time1 = h.getDate("time1");//结束时间

                if (time0.getTime() >= time1.getTime()) {
                    out.print("<script>mt.show('时间选择有误');</script>");
                    return;
                } else {

                    int gender = h.getInt("gender");//性别
                    int nl = h.getInt("nl");//年龄
                    String yhjb = h.get("yhjb");//原患疾病
                    int jws = h.getInt("jws");//既往史
                    String yyyy = h.get("yyyy");//用药原因
                    int yply = h.getInt("yply");//药品来源
                    int num = h.getInt("num");//用量
                    int lhyyqk = h.getInt("lhyyqk");//联合用药情况是否
                    String lhyyqktext = h.get("lhyyqktext");//联合用药情况
                    int sfgs = h.getInt("sfgs1");//是否改善
                    String yzqksm = h.get("yzqksm");//严重情况说明
                    int blfy = h.getInt("blfy");//不良反应
                    String blfytext = h.get("blfytext");//不良反应详情
                    ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(order_id);
                    int hospital_id = sod.getA_hospital_id();//医院id
                    int profile = h.member;//用户id
                    Profile profile1 = Profile.find(profile);
                    Question que = Question.find(0);
                    que.setOrderId(order_id);
                    que.setBeginTime(time0);
                    que.setEndTime(time1);
                    que.setCreatTime(new Date());
                    que.setGender(gender);
                    que.setAge(nl);
                    que.setYhjb(yhjb);
                    que.setJws(jws);
                    que.setYyyy(yyyy);
                    que.setYply(yply);
                    que.setNum(num);
                    que.setLhyyqk(lhyyqk);
                    que.setLhyyqktext(lhyyqktext);
                    que.setSfgs(sfgs);
                    que.setYzqksm(yzqksm);
                    que.setBlfy(blfy);
                    que.setBlfytext(blfytext);
                    que.setProfile(h.member);
                    ArrayList<ShopOrderAddress> soas = ShopOrderAddress.find(" AND hospitalId=" + hospital_id + " AND mobile=" + Database.cite(profile1.mobile), 0, Integer.MAX_VALUE);
                    if (soas.size() > 0) {
                        ShopOrderAddress soa = soas.get(0);
                        String hospital = soa.getHospital();
                        String department = soa.getDepartment();//科室
                        que.setHospital_name(hospital);
                        que.setHospital_ks(department);
                    }
                    que.set();
                    ShopHospital hospital = ShopHospital.find(hospital_id);
                    int questionnum = hospital.getQuestionnum();
                    hospital.setQuestionnum(questionnum+1);
                    hospital.set();
               /*
                String pro_name = profile.getMember();//收集人姓名
                String pro_mobile = profile.getMobile();//收集人手机号
                ShopHospital hospital = ShopHospital.find(hospital_id);
                String hos_name = hospital.getName();//医院名称
                */

                }
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>mt.show('系统异常,请重试！');</script>");
                return;
            }

        }else if("addAgreed".equals(act)){//服务商满意度调查
            int company = h.getInt("company", 0);
            if(company==0){//没有选公司
                out.print("<script>mt.show('请选择公司');</script>");
                return;
            }
            String gsdz = h.get("gsdz","");//公司地址
            if(gsdz.equals("")){
                out.print("<script>mt.show('请输入公司地址');</script>");
                return;
            }
            //校验是否合规   3、4 需要填备注
            StringBuilder sbcpxq = new StringBuilder();
            StringBuilder sbcpxqsm = new StringBuilder();
            for (int i = 1; i < Agreed.TIMU.length+1; i++) {
                int anInt = h.getInt("myd" + i, 0);
                if(anInt==0){//未填写
                    out.print("<script>mt.show('请选择满意度');</script>");
                    return;
                }else {
                    sbcpxq.append(anInt).append(",");
                    //需要填备注
                    if(anInt>=3){
                        String mybdz = h.get("mydbz" + i, "");
                        if(mybdz.equals("")){//未填备注
                            out.print("<script>mt.show('请输入原因');</script>");
                            return;
                        }

                    }
                    sbcpxqsm.append(h.get("mydbz" + i, "")).append(",");

                }
            }
            int cpxq = h.getInt("cpxq", 0);//产品需求
            String cpxqsmstr = h.get("cpxqsmstr", "");//产品需求说明
            if(cpxq==0){
                out.print("<script>mt.show('请选择有无产品需求');</script>");
                return;
            }else if(cpxq==1){
                if(cpxqsmstr.equals("")){
                    out.print("<script>mt.show('请输入对哪些产品有需求');</script>");
                    return;
                }
            }

            String idea = h.get("idea","");
            if(idea.equals("")){
                out.print("<script>mt.show('请输入对本公司其他方面的意见或建议');</script>");
                return;
            }

            try {
                String substring = sbcpxq.toString().substring(0, sbcpxq.toString().length() - 1);//去逗号
                String substring1 = sbcpxqsm.toString().substring(0, sbcpxqsm.toString().length() - 1);//去逗号
                Agreed agreed = Agreed.find(0);
                agreed.setProfile(h.member);
                agreed.setMyd(substring);
                agreed.setMydbz(substring1);
                agreed.setCpxq(cpxq);
                agreed.setCpxqsm(cpxqsmstr);
                agreed.setCreatTime(new Date());
                agreed.setCompanyid(company);
                agreed.setIdea(idea);
                agreed.setGsdz(gsdz);
                agreed.setCz(h.get("cz",""));
                agreed.setType(0);
                agreed.set();
                Profile profile = Profile.find(h.member);
                int agreednum = profile.agreednum;
                profile.set("agreednum",agreednum+1);


            } catch (SQLException e) {
                e.printStackTrace();
            }


        }else if("addGkAgreed".equals(act)){//高科医生满意度调查
            String keshi = h.get("keshi","");//科室名
            String hospital_id = h.get("hospital_id","");//医院id
            if(hospital_id.equals("")){//提交人不是签收人
                out.print("<script>mt.show('您还未成为签收人不可提交满意度调查');</script>");
                return;
            }
            ShopHospital hospital = ShopHospital.find(Integer.parseInt(hospital_id));
            if(keshi.equals("")){
                out.print("<script>mt.show('请输入科室');</script>");
                return;
            }
            //校验是否合规   3、4 需要填备注
            StringBuilder sbcpxq = new StringBuilder();
            StringBuilder sbcpxqsm = new StringBuilder();
            for (int i = 1; i < Agreed.TIMU.length+1; i++) {
                int anInt = h.getInt("myd" + i, 0);
                if(anInt==0){//未填写
                    out.print("<script>mt.show('请选择满意度');</script>");
                    return;
                }else {
                    sbcpxq.append(anInt).append(",");
                    //需要填备注
                    if(anInt>=3){
                        String mybdz = h.get("mydbz" + i, "");
                        if(mybdz.equals("")){//未填备注
                            out.print("<script>mt.show('请输入原因');</script>");
                            return;
                        }

                    }
                    sbcpxqsm.append(h.get("mydbz" + i, "")).append(",");

                }
            }
            int cpxq = h.getInt("cpxq", 0);//产品需求
            String cpxqsmstr = h.get("cpxqsmstr", "");//产品需求说明
            if(cpxq==0){
                out.print("<script>mt.show('请选择有无产品需求');</script>");
                return;
            }else if(cpxq==1){
                if(cpxqsmstr.equals("")){
                    out.print("<script>mt.show('请输入对哪些产品有需求');</script>");
                    return;
                }
            }

            String idea = h.get("idea","");
            if(idea.equals("")){
                out.print("<script>mt.show('请输入对本公司其他方面的意见或建议');</script>");
                return;
            }

            try {
                String substring = sbcpxq.toString().substring(0, sbcpxq.toString().length() - 1);//去逗号
                String substring1 = sbcpxqsm.toString().substring(0, sbcpxqsm.toString().length() - 1);//去逗号
                Agreed agreed = Agreed.find(0);
                agreed.setProfile(h.member);
                agreed.setMyd(substring);
                agreed.setMydbz(substring1);
                agreed.setCpxq(cpxq);
                agreed.setCpxqsm(cpxqsmstr);
                agreed.setCreatTime(new Date());
                agreed.setCompanyid(0);
                agreed.setIdea(idea);
                agreed.setGsdz(hospital.getName());//医院名
                agreed.setCz(keshi);//科室
                agreed.setType(1);
                agreed.set();
                Profile profile = Profile.find(h.member);
                int agreednum = profile.agreednum;
                profile.set("agreednum",agreednum+1);


            } catch (SQLException e) {
                e.printStackTrace();
            }


        }
        out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
        return;
    }
}
