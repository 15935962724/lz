package tea.ui.lzInterface;


import org.json.JSONArray;
import org.json.JSONObject;
import tea.entity.*;
import tea.entity.admin.orthonline.Hospital;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.ProcurementUnitJoin;
import tea.entity.yl.shop.ShopHospital;
import tea.entity.yl.shopnew.ReplyMoney;
import util.Config;
import util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

public class ReturnedMoneyInterface extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act", "");
        PrintWriter out = response.getWriter();
        JSONObject jo = new JSONObject();
        Enumeration e2 = request.getParameterNames();//获取所有参数名

        //获取请求的URL、参数
        StringBuffer stb = new StringBuffer();
        while (e2.hasMoreElements()) {//通过Enumeration类中的hasMoreElements()判断是否还有参数名
            String parameterName = (String) e2.nextElement(); //获取当前参数名
            //通过request.getParameter("")的方法来获取对应参数名的值
            stb.append(parameterName + "=" + request.getParameter(parameterName) + "&");

        }
        Filex.logs("log_interface/ReturnedMoneyInterface/ReturnedMoney_" + MT.f(new Date()) + ".log", "请求报文：" + request.getRequestURI() + "?" + stb.toString());

        try {
            if ("ADD_REPLY".equals(act)) {//新增回款
                String replyTime = h.get("REPLY_TIME", "");//回款时间
                int lz_hospital = h.getInt("LZ_HOSPITAL", -1);//粒子系统的医院id
                /*String hospitalCode = h.get("HOSPITAL_CODE", "");//CRM医院编码*/
                String money = h.get("MONEY", "");//回款金额
                String occTime = h.get("OCC_TIME", "");//请求时间
                int puid = h.getInt("PUID", -1);// 高科  君安 同福
                Boolean checkDate = false;
                Date replyTime_new = new Date();
                String note = h.get("NOTE");//备注

                try {
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    replyTime_new = df.parse(replyTime);//抛异常就不是正确格式
                } catch (Exception f) {
                    checkDate = true;
                }
                if (checkDate) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "回款时间参数有误！");
                } else if (lz_hospital == -1 || lz_hospital == 0) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "LZ_HOSPITAL参数不能为空！");
                } else if ("".equals(money)) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "MONEY参数不能为空！");
                } else if ("".equals(occTime)) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "OCC_TIME参数不能为空！");
                } else if (puid == -1) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "PUID参数不能为空！");
                } else {

                    ArrayList<ShopHospital> shopHospitals = ShopHospital.find(" AND id=" + lz_hospital, 0, 1);
                    if (shopHospitals.size() == 0) {
                        jo.put("status", "fail");//返回失败
                        jo.put("message", "LZ_HOSPITAL参数有误！");
                    } else {
                        ShopHospital hos = ShopHospital.find(lz_hospital);
                   /* if(hos.getName()==null||"".equals(hos.getName())){
                        jo.put("status", "fail");//返回失败
                        jo.put("message", "粒子医院编码参数有误！");
                    }else*/
                        if (puid == 15419 || puid == 1540101 || puid == 1540600) {
                            if (puid == 1540600) {
                                puid = Config.getInt("gaoke");
                            } else if (puid == 15419) {
                                puid = Config.getInt("junan");
                            } else if (puid == 1540101) {
                                puid = Config.getInt("tongfu");
                            }

                            ReplyMoney t = ReplyMoney.find(0);
                            t.setStatus(3); // 新增时: 改为待提交状态
                            t.setTime(new Date());
                            t.setCode("HK" + Seq.get());
                            t.setType(0);
                            t.setPuid(puid);
                            t.setReplyTime(replyTime_new);
                            t.setContext(note);
                            t.setReplyPrice(Float.parseFloat(money));
                            t.setHid(lz_hospital);
                            t.setAdd_type(0);
                            t.set();
                            jo.put("status", "success");
                            jo.put("id", t.getId());

                        } else {
                            jo.put("status", "fail");//返回失败
                            jo.put("message", "PUID参数有误！");
                        }

                    }
                }

            } else {
                jo.put("status", "fail");//返回失败
                jo.put("message", "act参数有误！");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jo.put("status", "fail");
            jo.put("message", "系统异常");
        } finally {
            String backTime = DateUtil.getStringFromDate(new Date(), "yyyy-MM-dd HH:mm:ss");
            jo.put("OCC_TIME", backTime);//接口响应时间
            Filex.logs("log_interface/ReturnedMoneyInterface/ReturnedMoney_" + MT.f(new Date()) + ".log", "响应报文：" + jo.toString());
            out.print(jo);
        }
    }
}
