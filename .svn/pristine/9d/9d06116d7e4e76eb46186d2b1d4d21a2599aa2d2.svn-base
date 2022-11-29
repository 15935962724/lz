package tea.ui.lzInterface;

import org.apache.commons.lang.time.DateUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import tea.entity.Database;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.RV;
import tea.entity.member.Logs;
import tea.entity.member.Profile;
import tea.entity.site.Community;
import tea.entity.yl.shop.ProcurementUnitJoin;
import tea.entity.yl.shop.ShopHospital;
import util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.SimpleFormatter;

public class LzInterface extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act", ""), nexturl = h.get("nexturl", "");
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        JSONObject jo = new JSONObject();
        String backTime = DateUtil.getStringFromDate(new Date(),"yyyyMMddHHmmss");
        try{
            if ("ADD_HOSPITAL".equals(act)) {//新增医院
                String name = h.get("NAME","");//接收医院名称
                String crm_code = h.get("CRM_CODE","");//客商编码
                String occTimeStr = h.get("OCC_TIME","");//传输时间yyyyMMddHHmmss
                Date occTime = DateUtil.getDateFromString(occTimeStr,"yyyyMMddHHmmss");

                //查询是否存在医院名称
                ShopHospital shopHospital = ShopHospital.find(name);
                //查询是否存在客商编码
                List<ShopHospital> shopHosBycodeList = ShopHospital.find(" and h_code = " + Database.cite(name),0,1);

                if("".equals(name)){
                    jo.put("fail", "医院名称不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(crm_code)){
                    jo.put("fail","客商编码不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if(shopHospital.getId() !=0){
                    jo.put("fail", "医院名称已存在，请重新填写后提交 ！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if(shopHosBycodeList.size() != 0){
                    jo.put("fail", "客商编码已存在，请重新填写后提交 ！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else{

                    shopHospital = new ShopHospital(0);
                    shopHospital.setName(name);//医院名称
                    shopHospital.setH_code(crm_code);//客商编码
                    shopHospital.setCreatetime(occTime);//创建时间
                    shopHospital.set();

                    jo.put("status", "success");//返回成功
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }
            }else if ("ADD_PROFILE".equals(act)) {//新增用户
                String name = h.get("NAME","");//接收医院名称
                String mobile = h.get("MOBILE","");//手机号
                String profileCode = h.get("PROFILE_CODE","");//用户编码
                String hospitalCode = h.get("HOSPITAL_CODE","");//客商编码   需要以逗号分隔
                String occTimeStr = h.get("OCC_TIME","");//传输时间yyyyMMddHHmmss
                Date occTime = DateUtil.getDateFromString(occTimeStr,"yyyyMMddHHmmss");

                //查询是否存用户名称
                List<Profile> nameList = Profile.find1(" and member = " + Database.cite(name),0,1);
                //查询是否存在手机号
                List<Profile> mobileList = Profile.find1(" and mobile = " + Database.cite(mobile),0,1);
                //查询是否存在用户编码
                List<Profile> profileCodeList = Profile.find1(" and code = " + Database.cite(profileCode),0,1);
                if("".equals(name)){
                    jo.put("fail", "用户名称不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(mobile)){
                    jo.put("fail","手机号不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(profileCode)){
                    jo.put("fail","用户编码不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if(nameList.size() !=0){
                    jo.put("fail", "用户名称已存在，请重新填写后提交 ！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if(mobileList.size() != 0){
                    jo.put("fail", "手机号已存在，请重新填写后提交 ！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if(profileCodeList.size() != 0){
                    jo.put("fail", "用户编码已存在，请重新填写后提交 ！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else{
                    hospitalCode = "|"+hospitalCode+"|";//医院编码前默认加 |

                    Profile profile = new Profile(0);
                    profile.setMember(name);
                    profile.setPassword("111111");
                    profile.setMobile(mobile);
                    profile.setCode(profileCode);
                    profile.hospitals = hospitalCode;
                    profile.setTime(occTime);//创建时间
                    profile.setByInterface();

                    jo.put("status", "success");//返回成功
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }
            }else if ("ADD_SERVICEP".equals(act)) {//新增服务商
                String name = h.get("NAME","");//接收用户名
                String mobile = h.get("MOBILE","");//手机号
                String profileCode = h.get("PROFILE_CODE","");//用户编码
                String mail = h.get("MAIL","");//邮箱
                String factory = h.get("FACTORY","");//采购厂商
                int tax = h.getInt("P_TAX",0);//进项税返还政策
                int formula = h.getInt("P_FORMULA",0);//服务费公式
                int issalesman = h.getInt("P_ISSALESMAN",0);//是否是自营业员
                String companyStr = h.get("COMPANY","");

                String occTimeStr = h.get("OCC_TIME","");//传输时间yyyyMMddHHmmss
                Date occTime = DateUtil.getDateFromString(occTimeStr,"yyyyMMddHHmmss");

                //查询是否存用户名称
                List<Profile> nameList = Profile.find1(" and member = " + Database.cite(name),0,1);
                //查询是否存在手机号
                List<Profile> mobileList = Profile.find1(" and mobile = " + Database.cite(mobile),0,1);
                //查询是否存在用户编码
                List<Profile> profileCodeList = Profile.find1(" and code = " + Database.cite(profileCode),0,1);
                //邮箱是否存在
                List<Profile> mailList = Profile.find1(" and mail = " + Database.cite(mail),0,1);
                if("".equals(name)){
                    jo.put("fail", "用户名称不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(mobile)){
                    jo.put("fail","手机号不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(profileCode)){
                    jo.put("fail","用户编码不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(mail)){
                    jo.put("fail","邮箱不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(factory)){
                    jo.put("fail","采购厂商不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(tax)){
                    jo.put("fail","进项税返还政策不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(formula)){
                    jo.put("fail","服务费公式不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if("".equals(issalesman)){
                    jo.put("fail","是否是自营业员不能为空！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if(nameList.size() !=0){
                    jo.put("fail", "用户名称已存在，请重新填写后提交 ！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if(mobileList.size() != 0){
                    jo.put("fail", "手机号已存在，请重新填写后提交 ！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if(profileCodeList.size() != 0){
                    jo.put("fail", "用户编码已存在，请重新填写后提交 ！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else if(mailList.size() != 0){
                    jo.put("fail", "邮箱已存在，请重新填写后提交 ！");
                    jo.put("status", "fail");//返回失败
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }else{

                    //新增服务商信息 主表
                    Profile profile = new Profile(0);
                    profile.setMember(name);
                    profile.setPassword("111111");
                    profile.setMobile(mobile);
                    profile.setCode(profileCode);
                    profile.setEmail(mail);
                    profile.procurementUnit = factory;
                    profile.tax = tax;
                    profile.formula = formula;
                    profile.issalesman = issalesman;
                    profile.setTime(occTime);//创建时间
                    profile.set();

                    //子表信息
                    int id = profile.profile;
                    JSONArray ja = new JSONArray(companyStr);
                    for (int i = 0; i < ja.length(); i++) {

                        ProcurementUnitJoin procurementUnitJoin = new ProcurementUnitJoin(0);
                        JSONObject jsonObject =  ja.getJSONObject(i);
                        String fName = (String)jsonObject.get("F_NAME");//服务商公司名称
                        int fFactory = (Integer) jsonObject.get("F_FACTORY");// 公司厂商
                        int fTax = (Integer)jsonObject.get("F_TAX");//进项税返还政策
                        int fFormula = (Integer)jsonObject.get("F_FORMULA");//服务费公式
                        float fAgentprice = (Float)jsonObject.get("F_AGENTPRICE");//底价设置

                        procurementUnitJoin.setProfile(id);
                        procurementUnitJoin.setCompany(fName);
                        procurementUnitJoin.setPuid(fFactory);
                        procurementUnitJoin.setTax(fTax);
                        procurementUnitJoin.setFormula(fFormula);
                        procurementUnitJoin.setAgentPriceNew(fAgentprice);
                        procurementUnitJoin.set();
                    }


                    jo.put("status", "success");//返回成功
                    jo.put("OCC_TIME", backTime);//接口响应时间
                }
            }

        }catch (Exception e){
            e.printStackTrace();
            jo.put("status", "fail");
            jo.put("fail", "系统异常");
            jo.put("OCC_TIME", backTime);//接口响应时间
        } finally {
            out.print(jo);
        }
    }
}
