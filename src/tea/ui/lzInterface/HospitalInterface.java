package tea.ui.lzInterface;

import org.json.JSONObject;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.yl.shop.ShopHospital;
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
import java.util.List;

public class HospitalInterface extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act", "");
        String sbxh1 = request.getParameter("sbxh");
        Filex.logs("log_interface/hospital/hospital_" + MT.f(new Date()) + ".log", "________：" + sbxh1+"");
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
        Filex.logs("log_interface/hospital/hospital_" + MT.f(new Date()) + ".log", "请求报文：" + request.getRequestURI() + "?" + stb.toString());
        String header = request.getHeader("x-auth-apikey");
        Filex.logs("log_interface/hospital/hospital_" + MT.f(new Date()) + ".log", "x-auth-apikey="+header);


        try {
            if ("ADD_HOSPITAL".equals(act)) {//新增医院
                String name = h.get("NAME", "");//医院名称
                String crmCode = h.get("CRM_CODE", "");//CRM系统编码
                String depName = h.get("DEPARTMENTS_NAME", "");//科室名称
                String depCode = h.get("DEPARTMENTS_CODE", "");//科室编码
                String occTime = h.get("OCC_TIME", "");//请求的时间
                String expirationDate = h.get("EXPIRATION_DATE", "");//有效期
                // 有效期格式是否正确
                Boolean checkDate = false;
                try {
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    df.parse(expirationDate);//抛异常就不是正确格式
                    df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    df.parse(occTime);//抛异常就不是正确格式
                } catch (Exception f) {
                    checkDate = true;
                }
                if (checkDate) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "EXPIRATION_DATE(yyyy-MM-dd)或OCC_TIME(yyyy-MM-dd HH:mm:ss)参数格式有误！");
                } else if ("".equals(name)   || "".equals(depCode)) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "NAME参数不能为空！");
                } else if("".equals(crmCode) ){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "CRM_CODE参数不能为空！");
                }else if("".equals(occTime)){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "OCC_TIME参数不能为空！");
                }else if("".equals(depName)){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "DEPARTMENTS_NAME参数不能为空！");
                }else if("".equals(depCode)){
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "DEPARTMENTS_CODE参数不能为空！");
                }else {
                    int nameCount = ShopHospital.count(" AND name=" + Database.cite(name+depName));
                    if (nameCount > 0) {
                        jo.put("status", "fail");//返回失败
                        jo.put("message", "医院名称+科室名称重复，参数有误！");
                    } else {
                        SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
                        Date parse = sm.parse(expirationDate);
                        //创建医院   赋值取自ShopHospitals.java  act=edit （row：496）
                        ShopHospital shopHospital = ShopHospital.find(0);
                        shopHospital.setExpirationDate(parse);
                        shopHospital.setHos_code(crmCode);
                        shopHospital.setName(name+depName);//医院名称
                        shopHospital.setIssign(1);
                        shopHospital.setNoreplywarn(-1);
                        shopHospital.setNoreplyalarm(-1);
                        shopHospital.setNoinvoicewarn(-1);
                        shopHospital.setNoinvoicealarm(-1);
                        shopHospital.setOldnoinvoice(-1);
                        shopHospital.setOldnoreply(-1.0);
                        shopHospital.setOldisinvoice(-1);
                        shopHospital.setCreatetime(new Date());//创建时间
                        shopHospital.setHospiatl_name(name);
                        shopHospital.setDep_code(depCode);
                        shopHospital.setDepartments_name(depName);
                        shopHospital.set();

                        jo.put("status", "success");
                        jo.put("id", shopHospital.getId());
                    }

                }

            } else if ("UPDATE_HOSPITAL".equals(act)) {//医院修改
                int lz_code = h.getInt("LZ_CODE",-1);//粒子系统医院id
                String hosName = h.get("HOSPITAL_NAME", "");//医院名称
                String depName = h.get("DEPARTMENTS_NAME", "");//科室名称
                String hosCode = h.get("HOSPITAL_CODE", "");//医院编码
                String depCode = h.get("DEPARTMENTS_CODE", "");//科室编码
                String expirationDate = h.get("EXPIRATION_DATE", "");//有效期
                String occTime = h.get("OCC_TIME", "");//请求的时间 yyyyMMddHHmmss

                // 有效期格式是否正确
                Boolean checkDate = false;
                try {
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    if(!expirationDate.equals("")){//不是必填参数  填了要校验
                        df.parse(expirationDate);//抛异常就不是正确格式
                    }
                    df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    df.parse(occTime);//抛异常就不是正确格式
                } catch (Exception f) {
                    checkDate = true;
                }

                if (checkDate) {
                    jo.put("status", "fail");//返回失败
                    jo.put("message", "EXPIRATION_DATE(yyyy-MM-dd)或OCC_TIME(yyyy-MM-dd HH:mm:ss)参数格式有误！");
                } else {
                    if (-1==lz_code) {
                        jo.put("status", "fail");//返回失败
                        jo.put("message", "LZ_CODE参数不能为空！");
                    } else if("".equals(hosName) ){
                        jo.put("status", "fail");//返回失败
                        jo.put("message", "HOSPITAL_NAME参数不能为空！");
                    }else if("".equals(depName)){
                        jo.put("status", "fail");//返回失败
                        jo.put("message", "DEPARTMENTS_NAME参数不能为空！");
                    }else if("".equals(depCode)){
                        jo.put("status", "fail");//返回失败
                        jo.put("message", "DEPARTMENTS_CODE参数不能为空！");
                    }else if("".equals(hosCode)){
                        jo.put("status", "fail");//返回失败
                        jo.put("message", "HOSPITAL_CODE参数不能为空！");
                    }else {
                        ArrayList<ShopHospital> shopHospitals = ShopHospital.find(" AND id=" + lz_code, 0, Integer.MAX_VALUE);
                        Boolean hosNameIsRepetition = false;
                        //查看修改传的名字的医院有多少
                        List<ShopHospital> hospitals1 = ShopHospital.find(" AND name=" + Database.cite(hosName+depName), 0, Integer.MAX_VALUE);
                        for (int i = 0; i <hospitals1.size() ; i++) {
                            ShopHospital hos = hospitals1.get(i);
                            //传来的id 不等于 名字相同的id   说明重复不可改
                            if(hos.getId()!=lz_code){
                                hosNameIsRepetition = true;
                            }
                        }
                        if(hosNameIsRepetition){
                            jo.put("status", "fail");//返回失败
                            jo.put("message", "医院名称+科室名称重复，参数有误！");
                        }else if(shopHospitals.size()==0){
                            jo.put("status", "fail");//返回失败
                            jo.put("message", "LZ_CODE参数错误！");
                        }else {
                            ShopHospital sh = ShopHospital.find(lz_code);
                            if(!expirationDate.equals("")) {//传了有效期参数
                                SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
                                Date parse = sm.parse(expirationDate);
                                sh.setExpirationDate(parse);
                            }
                            sh.setDepartments_name(depName);
                            sh.setHospiatl_name(hosName);
                            sh.setName(hosName + depName);
                            sh.setHos_code(hosCode);
                            sh.setDep_code(depCode);
                            sh.set();
                            jo.put("status", "success");
                            jo.put("id", sh.getId());
                        }
                    }
                }


            } else {
                String sbxh = h.get("sbxh");
                jo.put("sbxh", sbxh+"");//返回失败
                jo.put("status", "fail");//返回失败
                jo.put("message", "act参数不能为空！");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jo.put("status", "fail");
            jo.put("message", "系统异常");
        } finally {
            String backTime = DateUtil.getStringFromDate(new Date(), "yyyy-MM-dd HH:mm:ss");
            jo.put("occTime", backTime);//接口响应时间
            Filex.logs("log_interface/hospital/hospital_" + MT.f(new Date()) + ".log", "响应报文：" + jo.toString());
            out.print(jo);
        }
    }
}
