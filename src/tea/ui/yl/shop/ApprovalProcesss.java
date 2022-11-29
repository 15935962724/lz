package tea.ui.yl.shop;


import org.json.JSONObject;
import tea.entity.*;
import tea.entity.member.ModifyRecord;
import tea.entity.yl.shop.ActivityWarning;
import tea.entity.yl.shop.ApprovalProcess;
import tea.entity.yl.shop.ShopHospital;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;

/**
 * 流程
 */
public class ApprovalProcesss extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();
        try {

            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            int id = h.getInt("id");//医院id
            int apid = h.getInt("apid");//流程id
            if ("edityanqi".equals(act)) {//编辑

                int yqlb = h.getInt("yqlb");//延期选择的证件
                String reason = h.get("reason");//原因
                Date yqrq = h.getDate("yqrq");//延期日期
                int yanqiFile = h.getInt("yanqi.attch");//延期提交文件
                int create_profile = h.member;
                ApprovalProcess ap = ApprovalProcess.find(apid);
                ap.setHid(id);
                ap.setCreate_profile(create_profile);
                ap.setType(0);
                ap.setApproval(0);
                ap.setApproval_profile(1);
                if(yanqiFile>0) {
                    ap.setAttchid(yanqiFile);
                }
                ap.setYqlb(yqlb);
                ap.setBq("");
                ap.setYqrq(yqrq);
                ap.setReason(reason);
                ap.set();


            }else if("editchaoliang".equals(act)){//超量申请 编辑

                String reason = h.get("reason");//原因
                String bq = h.get("bq");
                Boolean dataIsOk = true;

                try {
                    bq = bq.replaceAll(",","");
                    Long aLong = Long.valueOf(bq);
                }catch (Exception e){
                    dataIsOk = false;
                }

                if(!dataIsOk){//数据有问题
                    out.print("<script>mt.show('数据有误请重新输入！',1,'" + nexturl + "');</script>");
                    return;
                }

                int yanqiFile = h.getInt("yanqi.attch");//延期提交文件
                int create_profile = h.member;
                ApprovalProcess ap = ApprovalProcess.find(apid);
                ap.setHid(id);
                ap.setCreate_profile(create_profile);
                ap.setType(1);
                ap.setApproval(0);
                ap.setApproval_profile(1);
                if(yanqiFile>0) {
                    ap.setAttchid(yanqiFile);
                }
                ap.setBq(bq);
                ap.setReason(reason);
                ap.set();

            }else if("submitap".equals(act)){//提交

                ApprovalProcess ap = ApprovalProcess.find(apid);
                ap.setApproval(1);//状态改为审核中
                ap.setApproval_profile(2);//改为第二位
                ap.set();
                ModifyRecord.creatModifyRecord(apid+"","提交",h.member,(ap.getType()==0?"延期申请":"超量申请")+"提交");


            }else if("apPass".equals(act)){//通过

                int type = h.getInt("type", 0);// 0 延期   1 超量

                Boolean isfinish = false;

                ApprovalProcess ap = ApprovalProcess.find(apid);
                int approval_profile = ap.getApproval_profile();
                ap.setApproval_profile(approval_profile+1);
                if(approval_profile==4){
                    isfinish = true;
                    ap.setApproval(3);
                }
                ap.set();
                ModifyRecord.creatModifyRecord(ap.getId()+"", ShopHospital.approvalRole[approval_profile]+"审批",h.member,ShopHospital.approvalRole[approval_profile]+"审批通过");


                //质量管理员审批完毕   查看是否需要质量负责人审批    不需要则自动审批通过  加日志  状态改为已完成审批
                if(approval_profile == 3 ){

                    ActivityWarning aw = ActivityWarning.find(2022);
                    if(aw.getStop().equals("1")){
                        isfinish = true;
                        ap = ApprovalProcess.find(apid);
                        approval_profile = ap.getApproval_profile();
                        ap.setApproval_profile(approval_profile+2);
                        ap.setApproval(3);
                        ap.set();

                        ModifyRecord.creatModifyRecord(ap.getId()+"", ShopHospital.approvalRole[approval_profile]+"审批",h.member,ShopHospital.approvalRole[approval_profile]+"审批通过");
                    }

                }

                //调整医院对应的表到  审批完成的 延期日期
                if(isfinish){
                    if(type==0) {
                        Date yqrq = ap.getYqrq();
                        int yqlb = ap.getYqlb();
                        ShopHospital hospital = ShopHospital.find(id);
                        String yqlbStr = ShopHospital.dqzjArr[yqlb];
                        String yarqold = "";
                        switch (yqlb) {
                            case 0:
                                yarqold = MT.f(hospital.getFsaqxkzrq());
                                hospital.setFsaqxkzrq(yqrq);
                                break;
                            case 1:
                                yarqold = MT.f(hospital.getFsxypsyxkzrq());
                                hospital.setFsxypsyxkzrq(yqrq);
                                break;
                            case 2:
                                yarqold = MT.f(hospital.getFszlxkzrq());
                                hospital.setFszlxkzrq(yqrq);
                                break;
                            case 3:
                                yarqold = MT.f(hospital.getZfspbrq());
                                hospital.setZfspbrq(yqrq);
                                break;
                        }
                        hospital.set();
                        ModifyRecord.creatModifyRecord(ap.getId() + "", "文件延期", h.member, yqlbStr + "原日期：" + yarqold + " ,调整为：" + MT.f(yqrq));
                    }else {
                        String bqNew = ap.getBq();
                        ShopHospital hospital = ShopHospital.find(id);
                        String bqOld = hospital.getBq1();
                        float mciOld = hospital.getBqmci();
                        hospital.setBq1(bqNew);
                        float mciNew = ShopHospital.getMciByBq(bqNew);
                        hospital.setBqmci(mciNew);
                        hospital.set();
                        ModifyRecord.creatModifyRecord(ap.getId()+"","超量申请" ,h.member,"原Bq数量："+bqOld+" 调整为："+bqNew+" ; 原mci："+mciOld+" 调整为："+mciNew);

                    }
                }


            }else if("apRefuse".equals(act)){//拒绝

                ApprovalProcess ap = ApprovalProcess.find(apid);
                int approval_profile = ap.getApproval_profile();
                String nobackreason = h.get("nobackreason");
                ap.setApproval(2);//拒绝
                ap.setApproval_profile(0);
                ap.setRefuse_reason(nobackreason);
                ap.set();
                ModifyRecord.creatModifyRecord(ap.getId()+"",ShopHospital.approvalRole[approval_profile]+"审批",h.member,ShopHospital.approvalRole[approval_profile]+"审批拒绝，拒绝原因："+nobackreason);

            }

            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
    }


}
