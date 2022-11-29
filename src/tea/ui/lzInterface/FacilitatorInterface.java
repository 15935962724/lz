package tea.ui.lzInterface;


import org.json.JSONArray;
import org.json.JSONObject;

import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;

import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.ProcurementUnitJoin;
import util.Config;
import util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

public class FacilitatorInterface extends HttpServlet {
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
        Filex.logs("log_interface/facilitator/facilitator_" + MT.f(new Date()) + ".log", "请求报文：" + request.getRequestURI() + "?" + stb.toString());

        try {
            if ("ADD_SERVICEP".equals(act)) {//新增服务商

                String name = h.get("NAME", "");//服务商名称
                String mobile = h.get("MOBILE", "");//手机号
                String crmCode = h.get("PROFILE_CODE", "");//CRM系统编码
                String mail = h.get("MAIL", "");//邮箱
                /*String factory = h.get("FACTORY", "");//厂商*/
                String occTime = h.get("OCC_TIME", "");//请求的时间 yyyyMMddHHmmss
                String company = h.get("COMPANY", "");// json 数组
                int mob = Profile.count(" AND mobile="+Database.cite(mobile)+" AND deleted=0 ");
                int crmCount = Profile.count(" AND code = " + Database.cite(crmCode)+" AND deleted=0 ");
                int mailCount =0;
                if(!"".equals(mail)) {
                    mailCount = Profile.count(" AND email = " + Database.cite(mail)+" AND deleted=0 ");
                }
                if ("".equals(name) ) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "NAME参数不能为空！");
                }else if("".equals(mobile)){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "MOBILE参数不能为空！");
                }else if("".equals(crmCode)){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "PROFILE_CODE参数不能为空！");
                }else if("".equals(occTime)){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "OCC_TIME参数不能为空！");
                }else if("".equals(company)){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "COMPANY参数不能为空！");
                }else if (mob > 0) {//手机号重复
                    jo.put("status", "fail");
                    jo.put("message", "MOBILE参数重复！");
                } else if (crmCount > 0) {//crm用户编码重复
                    jo.put("status", "fail");
                    jo.put("message", "PROFILE_CODE参数重复！");
                } else if (mailCount > 0) {//邮箱重复
                    jo.put("status", "fail");
                    jo.put("message", "MAIL参数重复！");
                } else {
                    String member="";
                    while (true){//用户名重复后+1 直到无重复值
                        int count = Profile.count(" AND member = " + Database.cite(name)+" AND deleted=0 ");
                        if(count==0){
                            member = name;
                            break;
                        }
                        name = name+"1";
                    }
                    //创建用户
                    Profile p = Profile.create(member,"111111",h.community,mail,"https://www.brachysolution.com/");
                    p.setMobile(mobile);
                    p.setType(0);
                    p.setMembertype(2);
                    p.set("qualification","0");
                    p.set("isvip", 0);
                    p.set("hospitals","|");
                    p.set("email",mail);
                    p.setCode(crmCode);
                    //账户创建成功发送短信

                    StringBuffer proUnit = new StringBuffer();//profile类厂商字段
                    proUnit.append("|");
                    JSONArray jsonArray = new JSONArray(company);
                    Boolean istrue = true;//服务商公司信息是否正确
                    if (jsonArray.length() > 0) {//服务商公司信息  不可为空
                        for (int i = 0; i < jsonArray.length(); i++) {
                            JSONObject jsonObject = jsonArray.getJSONObject(i);
                            boolean f_id = jsonObject.isNull("F_ID");
                            boolean f_name = jsonObject.isNull("F_NAME");
                            boolean f_factory = jsonObject.isNull("F_FACTORY");
                            if(!f_id&!f_name&&!f_factory) {
                                String fId = jsonObject.get("F_ID").toString();//CRM服务商公司id
                                String fName = jsonObject.get("F_NAME").toString();//服务商公司名称
                                String fFactory = jsonObject.get("F_FACTORY").toString();//服务商厂商    君安  欣科  高科
                                if (fName == null || "".equals(fName)) {
                                    jo.put("status", "fail");//返回失败
                                    jo.put("message", "F_NAM参数不能为空！");
                                    istrue = false;
                                } else if (fFactory == null || "".equals(fFactory)) {
                                    jo.put("status", "fail");//返回失败
                                    jo.put("message", "F_FACTORY参数不能为空！");
                                    istrue = false;
                                } else if (fId == null || "".equals(fId)) {
                                    jo.put("status", "fail");//返回失败
                                    jo.put("message", "F_ID参数不能为空！");
                                    istrue = false;
                                } else if ("君安欣科高科".contains(fFactory)) {
                                    if (fFactory.equals("君安")) {
                                        proUnit.append(Config.getString("junan") + "|");
                                        ProcurementUnitJoin puj = ProcurementUnitJoin.find(0);
                                        puj.setCompany(fName);
                                        puj.setPuid(Integer.parseInt(Config.getString("junan")));
                                        puj.setProfile(p.profile);
                                        puj.setCrmid(fId);
                                        puj.set();
                                    } else if (fFactory.equals("欣科")) {
                                        proUnit.append(Config.getString("xinke") + "|");
                                        ProcurementUnitJoin puj = ProcurementUnitJoin.find(0);
                                        puj.setCompany(fName);
                                        puj.setPuid(Integer.parseInt(Config.getString("xinke")));
                                        puj.setProfile(p.profile);
                                        puj.setCrmid(fId);
                                        puj.set();
                                    } else if (fFactory.equals("高科")) {
                                        proUnit.append(Config.getString("gaoke") + "|");
                                        ProcurementUnitJoin puj = ProcurementUnitJoin.find(0);
                                        puj.setCompany(fName);
                                        puj.setPuid(Integer.parseInt(Config.getString("gaoke")));
                                        puj.setProfile(p.profile);
                                        puj.setCrmid(fId);
                                        puj.set();
                                    } else {
                                        jo.put("status", "fail");//返回失败
                                        jo.put("message", "厂商参数错误！");
                                        istrue = false;
                                    }

                                } else {//服务商厂商问题
                                    jo.put("status", "fail");//返回失败
                                    jo.put("message", "F_FACTORY参数有误！");
                                }
                            }else {
                                istrue = false;
                            }
                        }
                        if(istrue) {//服务商信息正常保存  发短信给用户  返回接口正确信息
                            p.set("community", "Home");
                            p.set("procurementUnit", proUnit.toString());
                            SMSMessage.create("Home", p.member, p.mobile, 1, "您好，您已成功注册近距离粒子一站式平台服务商。官网地址：www.brachysolution.com ，请使用此手机号获取验证码登录，如有疑问联系管理员处理。");
                            jo.put("status", "success");
                            jo.put("id", p.profile);
                        }else {// 服务商信息不正常  删除用户
                            p.set("deleted","1");
                            jo.put("status", "fail");//返回失败
                            jo.put("message", "COMPANY参数有误！");
                        }
                    }

                }
            }else if("ADD_COMPANY".equals(act)){//增加服务商的服务商公司信息
                int lzProfileCode = h.getInt("LZ_CODE", -1);
                String company = h.get("COMPANY", "");// json 数组
                if(lzProfileCode==-1){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "LZ_CODE参数不能为空！");
                }else if("".equals(company)){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "COMPANY参数不能为空！");
                }else {

                    ArrayList arrayList = Profile.find1(" AND profile=" + lzProfileCode + " AND deleted=0 ", 0, 1);
                    if(arrayList.size()==0){
                        jo.put("status", "fail");//返回失败
                        jo.put("message", "LZ_CODE参数有误！");
                    }else {
                        Profile p = (Profile) arrayList.get(0);
                        String proUnit_ = p.procurementUnit;//服务商原先的厂商
                        StringBuffer proUnit = new StringBuffer();//profile类厂商字段
                        JSONArray jsonArray = new JSONArray(company);
                        Boolean istrue = true;//服务商公司信息是否正确
                        if (jsonArray.length() > 0) {//服务商公司信息  不可为空
                            for (int i = 0; i < jsonArray.length(); i++) {
                                JSONObject jsonObject = jsonArray.getJSONObject(i);
                                boolean f_id = jsonObject.isNull("F_ID");
                                boolean f_name = jsonObject.isNull("F_NAME");
                                boolean f_factory = jsonObject.isNull("F_FACTORY");
                                if (!f_id & !f_name && !f_factory) {
                                    String fId = jsonObject.get("F_ID").toString();//CRM服务商公司id
                                    String fName = jsonObject.get("F_NAME").toString();//服务商公司名称
                                    String fFactory = jsonObject.get("F_FACTORY").toString();//服务商厂商    君安  欣科  高科
                                    if (fName == null || "".equals(fName)) {
                                        jo.put("status", "fail");//返回失败
                                        jo.put("message", "F_NAM参数不能为空！");
                                        istrue = false;
                                    } else if (fFactory == null || "".equals(fFactory)) {
                                        jo.put("status", "fail");//返回失败
                                        jo.put("message", "F_FACTORY参数不能为空！");
                                        istrue = false;
                                    } else if (fId == null || "".equals(fId)) {
                                        jo.put("status", "fail");//返回失败
                                        jo.put("message", "F_ID参数不能为空！");
                                        istrue = false;
                                    } else if ("君安欣科高科".contains(fFactory)) {
                                        if (fFactory.equals("君安")) {
                                            if(proUnit_.contains(Config.getString("junan"))){
                                                proUnit.append(Config.getString("junan") + "|");
                                            }
                                            ProcurementUnitJoin puj = ProcurementUnitJoin.find(0);
                                            puj.setCompany(fName);
                                            puj.setPuid(Integer.parseInt(Config.getString("junan")));
                                            puj.setProfile(p.profile);
                                            puj.setCrmid(fId);
                                            puj.set();
                                        } else if (fFactory.equals("欣科")) {
                                            if(proUnit_.contains(Config.getString("xinke"))){
                                                proUnit.append(Config.getString("xinke") + "|");
                                            }

                                            ProcurementUnitJoin puj = ProcurementUnitJoin.find(0);
                                            puj.setCompany(fName);
                                            puj.setPuid(Integer.parseInt(Config.getString("xinke")));
                                            puj.setProfile(p.profile);
                                            puj.setCrmid(fId);
                                            puj.set();
                                        } else if (fFactory.equals("高科")) {
                                            if(!proUnit_.contains(Config.getString("gaoke"))){
                                                proUnit.append(Config.getString("gaoke") + "|");
                                            }
                                            ProcurementUnitJoin puj = ProcurementUnitJoin.find(0);
                                            puj.setCompany(fName);
                                            puj.setPuid(Integer.parseInt(Config.getString("gaoke")));
                                            puj.setProfile(p.profile);
                                            puj.setCrmid(fId);
                                            puj.set();
                                        } else {
                                            jo.put("status", "fail");//返回失败
                                            jo.put("message", "厂商参数错误！");
                                            istrue = false;
                                        }

                                    } else {//服务商厂商问题
                                        jo.put("status", "fail");//返回失败
                                        jo.put("message", "F_FACTORY参数有误！");
                                    }
                                } else {
                                    istrue = false;
                                }
                            }
                            if (istrue) {//服务商信息正常保存  发短信给用户  返回接口正确信息
                                String pro_ = proUnit_+proUnit.toString();
                                p.set("procurementUnit", pro_);
                                jo.put("status", "success");
                                jo.put("id", p.profile);
                            } else {// 服务商信息不正常  删除用户
                                p.set("deleted", "1");
                                jo.put("status", "fail");//返回失败
                                jo.put("message", "COMPANY参数有误！");
                            }
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
            Filex.logs("log_interface/facilitator/facilitator_" + MT.f(new Date()) + ".log", "响应报文：" + jo.toString());
            out.print(jo);
        }
    }
}



