package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.*;
import util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.*;

public class ProcurementUnitServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");

        // 查询方法
        PrintWriter out = resp.getWriter();
        if("findProcurementUnit".equals(act)) {
            try {
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");
                //String parameterStr = YlUtil.getAllPar(req, h);

                StringBuffer sql = new StringBuffer();
                String name = h.get("name","");

                if (name.length()>0) {
                    sql.append(" and name like '%" + name + "%'");
                }

                int sum = ProcurementUnit.count(sql.toString());

                // sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");

                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try {
                        List<ProcurementUnit> procurementUnitList = ProcurementUnit.find(sql.toString(), pos, page_size);
                        for (int i = 0; i < procurementUnitList.size(); i++) {
                            ProcurementUnit procurementUnit = procurementUnitList.get(i);
                            // 查询厂商关联医院数量
                            int puCount = ProcurementUnit.findPUCount(procurementUnit.getPuid());
                            // 查询厂商关联服务商数量
                            int proCount = ProcurementUnit.findProCount(procurementUnit.getPuid());
                            // 查询厂商关联药品数量
                            int drugCount = ProcurementUnit.findDrug(procurementUnit.getPuid());
                            JSONObject jo2 = new JSONObject();
                            jo2.put("obj", JSON.toJSON(procurementUnit));
                            jo2.put("puCount",puCount);
                            jo2.put("proCount",proCount);
                            jo2.put("drugCount",drugCount);
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
            // 根据puid查询单个厂商
        }else if("findPU".equals(act)){
            try{
                int puid = h.getInt("puid");
                ProcurementUnit p = ProcurementUnit.find(puid);
                jo.put("type", "0");
                jo.put("obj", JSON.toJSON(p));
            }catch (Exception e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
            }
            out.print(jo.toString());
            return;
            // 编辑或新增厂商
        }else if("editPU".equals(act)){
            try {
                int puid = h.getInt("puid");
                ProcurementUnit p = ProcurementUnit.find(puid);
                if(MT.f(p.getName()).length()==0){
                    p.setName(h.get("name"));
                    p.setFullname(h.get("fullname"));
                    p.setFullnameen(h.get("fullnameen"));
                    p.setMobile(h.get("mobile"));
                    p.setPerson(h.get("person"));
                    p.setEmail(h.get("email"));
                    p.setZipcode(h.get("zipcode"));
                    p.setFax(h.get("fax"));

                    p.setAddress(h.get("address"));
                    p.setTelephone(h.get("telephone"));
                    p.setWebsite(h.get("website"));
                    p.setTelephoneReturn(h.get("telephoneReturn"));


                    p.setTime(new Date());
                    p.setDeleted(0);
                    p.setSort(h.getInt("sort"));

                    p.setRadiationSafetyTime(h.getDate("radiationSafetyTime"));
                    p.setRegistrationApprovalUrl(h.get("radiationSafetyUrl"));
                    p.setBusinessLicenseTime(h.getDate("businessLicenseTime"));
                    p.setBusinessLicenseUrl(h.get("businessLicenseUrl"));
                    p.setProductionLicenseTime(h.getDate("productionLicenseTime"));
                    p.setProductionLicenseUrl(h.get("productionLicenseUrl"));
                    p.setApprovalFormTime(h.getDate("approvalFormTime"));
                    p.setApprovalFormUrl(h.get("approvalFormUrl"));
                    p.setGmpCertificateTime(h.getDate("gmpCertificateTime"));
                    p.setGmpCertificateUrl(h.get("gmpCertificateUrl"));
                    p.setRegistrationApprovalTime(h.getDate("registrationApprovalTime"));
                    p.setRegistrationApprovalUrl(h.get("registrationApprovalUrl"));
                    p.setPowerOfAttorneyTime(h.getDate("powerOfAttorneyTime"));
                    p.setPowerOfAttorneyUrl(h.get("powerOfAttorneyUrl"));
                    p.setManufactorMobile(h.get("manufactorMobile"));
                    p.setPlatformMobile(h.get("platformMobile"));
                    p.setStatus(0);

                    p.set();
                }else{
                    p.setName(h.get("name"));
                    p.setFullname(h.get("fullname"));
                    p.setFullnameen(h.get("fullnameen"));
                    p.setMobile(h.get("mobile"));
                    p.setPerson(h.get("person"));
                    p.setEmail(h.get("email"));
                    p.setZipcode(h.get("zipcode"));
                    p.setFax(h.get("fax"));
                    p.setSort(h.getInt("sort"));
                    p.setAddress(h.get("address"));
                    p.setTelephone(h.get("telephone"));
                    p.setWebsite(h.get("website"));
                    p.setTelephoneReturn(h.get("telephoneReturn"));

                    p.setRadiationSafetyTime(h.getDate("radiationSafetyTime"));
                    p.setRadiationSafetyUrl(h.get("radiationSafetyUrl"));
                    p.setBusinessLicenseTime(h.getDate("businessLicenseTime"));
                    p.setBusinessLicenseUrl(h.get("businessLicenseUrl"));
                    p.setProductionLicenseTime(h.getDate("productionLicenseTime"));
                    p.setProductionLicenseUrl(h.get("productionLicenseUrl"));
                    p.setApprovalFormTime(h.getDate("approvalFormTime"));
                    p.setApprovalFormUrl(h.get("approvalFormUrl"));
                    p.setGmpCertificateTime(h.getDate("gmpCertificateTime"));
                    p.setGmpCertificateUrl(h.get("gmpCertificateUrl"));
                    p.setRegistrationApprovalTime(h.getDate("registrationApprovalTime"));
                    p.setRegistrationApprovalUrl(h.get("registrationApprovalUrl"));
                    p.setPowerOfAttorneyTime(h.getDate("powerOfAttorneyTime"));
                    p.setPowerOfAttorneyUrl(h.get("powerOfAttorneyUrl"));
                    p.setManufactorMobile(h.get("manufactorMobile"));
                    p.setPlatformMobile(h.get("platformMobile"));
                    p.setStatus(0);
                    //p.set();
                    p.update();

                }
                jo.put("type", "0");
            } catch (Exception e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
            }
            out.print(jo.toString());
            return;
            // 分页
        }else if("getpage".equals(act)){
            int pos = h.getInt("pos");
            int sum = h.getInt("sum");
            int size = h.getInt("size");
            //String par = h.get("par");
            String par = "";
            par = URLDecoder.decode(par,"UTF-8");
            par = par.replaceFirst("pos=", "&");
            if (par.indexOf("?") != -1) {
                par += "&pos=";
            } else {
                par += "?pos=";
            }
            String str = new tea.htmlx.FPNL(1, par, pos, sum, size).toString();
            jo.put("data", str);
            if(str.length()>0) {
                jo.put("type", "0");
            }else{
                jo.put("type", "1");
            }
            out.println(jo.toString());
            return;
        }
        // 删除厂商
        if("delPU".equals(act)){
            int puid = h.getInt("puid");
            try {
                ProcurementUnit.delete(puid);
                jo.put("type", "0");
                jo.put("mes","操作执行成功!");
                out.println(jo);
                return;

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                out.close();
            }
        }

        //审核厂商
        if("updateStatus".equals(act)){
            int puid = h.getInt("puid");
            int status = h.getInt("status");
            String message = h.get("message");
            ProcurementUnit p = ProcurementUnit.find(puid);
            try {
                p.setStatus(status);
                p.setMessage(message);
                p.update();
                jo.put("type", "0");
                jo.put("mes","操作执行成功!");
                out.println(jo);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                out.close();
            }
        }
        //延期申请
        if ("addCertificates".equals(act)){
            {
                try {
                    int id = h.getInt("id");
                    Certificates certificates = Certificates.find(id);
                    certificates.setType(h.getInt("type"));
                    certificates.setPuid(h.getInt("puid"));
                    certificates.setName(h.get("name"));
                    certificates.setDelayMessage(h.get("delayMessage"));
                    certificates.setDelayUrl(h.get("delayUrl"));
                    certificates.setStatus(0);
                    certificates.set();
                    jo.put("type", "0");
                } catch (Exception e) {
                    e.printStackTrace();
                    jo.put("type", "2");
                    jo.put("mes", "系统异常，请重试！");
                }
                out.print(jo.toString());
                return;
            }
        }

        //查询延期申请
        if ("queryCertificaters".equals(act)){
            {
                try {
                    int puid = h.getInt("puid");
                    String sql = " and puid = "+puid +" and status != 1" ;
                    List<Certificates> certificates = Certificates.find(sql, 0, 10);
                    jo.put("certificates",certificates);
                    jo.put("type", "0");
                } catch (Exception e) {
                    e.printStackTrace();
                    jo.put("type", "2");
                    jo.put("mes", "系统异常，请重试！");
                }
                out.print(jo.toString());
                return;
            }
        }

        //查询是否有到期证件
        if ("queryIsCertificater".equals(act)){
            {
                try {
                    int puid = h.getInt("puid");
                    ProcurementUnit p = ProcurementUnit.find(puid);
                    Date date = new Date();
                    List<Map> lists = new ArrayList<Map>();
                    if (p.getRadiationSafetyTime().before(date)){
                        Map map = new HashMap();
                        map.put("type",1);
                        map.put("name","辐射安全许可证");
                        lists.add(map);
                    }
                    if (p.getBusinessLicenseTime().before(date)){
                        Map map = new HashMap();
                        map.put("type",2);
                        map.put("name","企业营业执照");
                        lists.add(map);
                    }
                    if (p.getProductionLicenseTime().before(date)){
                        Map map = new HashMap();
                        map.put("type",3);
                        map.put("name","放射药品生产许可证");
                        lists.add(map);
                    }
                    if (p.getApprovalFormTime().before(date)){
                        Map map = new HashMap();
                        map.put("type",4);
                        map.put("name","转让审批表");
                        lists.add(map);
                    }
                    if (p.getGmpCertificateTime().before(date)){
                        Map map = new HashMap();
                        map.put("type",5);
                        map.put("name","药品GMP证书");
                        lists.add(map);
                    }
                    if (p.getRegistrationApprovalTime().before(date)){
                        Map map = new HashMap();
                        map.put("type",6);
                        map.put("name","药品再注册批件");
                        lists.add(map);
                    }
                    if (p.getPowerOfAttorneyTime().before(date)){
                        Map map = new HashMap();
                        map.put("type",7);
                        map.put("name","授权委托书");
                        lists.add(map);
                    }
                    jo.put("flag",lists.size()>0);
                    jo.put("type", "0");
                } catch (Exception e) {
                    e.printStackTrace();
                    jo.put("type", "2");
                    jo.put("mes", "系统异常，请重试！");
                }
                out.print(jo.toString());
                return;
            }
        }

        //延期审核
        if ("updateCertificates".equals(act)){
            {
                try {
                    int puid = h.getInt("puid");
                    int type = h.getInt("type");
                    int status = h.getInt("status");
                    Certificates certificates = new Certificates();
                    certificates.setPuid(puid);
                    certificates.setType(type);
                    certificates.setStatus(status);
                    certificates.update("");
                    Date time = h.getDate("time");
                    if (status==1){
                        ProcurementUnit p = ProcurementUnit.find(puid);
                        if (type==1){
                            p.setRadiationSafetyTime(time);
                        }
                        if (type==2){
                            p.setBusinessLicenseTime(time);
                        }
                        if (type==3){
                            p.setProductionLicenseTime(time);
                        }
                        if (type==4){
                            p.setApprovalFormTime(time);
                        }
                        if (type==5){
                            p.setGmpCertificateTime(time);
                        }
                        if (type==6){
                            p.setRegistrationApprovalTime(time);
                        }
                        if (type==7){
                            p.setPowerOfAttorneyTime(time);
                        }
                        p.update();
                    }

                    jo.put("type", "0");
                } catch (Exception e) {
                    e.printStackTrace();
                    jo.put("type", "2");
                    jo.put("mes", "系统异常，请重试！");
                }
                out.print(jo.toString());
                return;
            }
        }

        //资质提醒
        if ("remind".equals(act)){
            {
                try {
                    int puid = h.getInt("puid");
                    int day = 0;
                    ProcurementUnit procurementUnit = ProcurementUnit.find(puid);
                    day = DateUtil.countTwoDate(procurementUnit.getRadiationSafetyTime());
                        //给厂商预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的辐射安全许可证还有"+day+"天到期。", 2);
                        //给平台预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的辐射安全许可证还有"+day+"天到期。", 2);
                    day = DateUtil.countTwoDate(procurementUnit.getBusinessLicenseTime());
                        //给厂商预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的企业营业执照还有"+day+"天到期。", 2);
                        //给平台预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的企业营业执照还有"+day+"天到期。", 2);
                    day = DateUtil.countTwoDate(procurementUnit.getProductionLicenseTime());
                        //给厂商预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的放射药品生产许可证还有"+day+"天到期。", 2);
                        //给平台预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的放射药品生产许可证还有"+day+"天到期。", 2);
                    day = DateUtil.countTwoDate(procurementUnit.getApprovalFormTime());
                        //给厂商预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的转让审批表还有"+day+"天到期。", 2);
                        //给平台预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的转让审批表还有"+day+"天到期。", 2);
                    day = DateUtil.countTwoDate(procurementUnit.getGmpCertificateTime());
                        //给厂商预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的药品GMP证书还有"+day+"天到期。", 2);
                        //给平台预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的药品GMP证书还有"+day+"天到期。", 2);
                    day = DateUtil.countTwoDate(procurementUnit.getRegistrationApprovalTime());
                        //给厂商预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的药品再注册批件还有"+day+"天到期。", 2);
                        //给平台预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的药品再注册批件还有"+day+"天到期。", 2);
                    day = DateUtil.countTwoDate(procurementUnit.getPowerOfAttorneyTime());
                        //给厂商预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getManufactorMobile(), 1, procurementUnit.getName() + "的授权委托书还有"+day+"天到期。", 2);
                        //给平台预留电话发短信
                        SMSMessage.sendExpireMessage("Home", "amdin", procurementUnit.getPlatformMobile(), 1, procurementUnit.getName() + "的授权委托书还有"+day+"天到期。", 2);
                    jo.put("type", "0");
                } catch (Exception e) {
                    e.printStackTrace();
                    jo.put("type", "2");
                    jo.put("mes", "系统异常，请重试！");
                }
                out.print(jo.toString());
                return;
            }
        }

        //停止供货  or 继续供货
        if ("isStopSupply".equals(act)){
            {
                try {
                    int puid = h.getInt("puid");
                    int day = 0;
                    ProcurementUnit procurementUnit = ProcurementUnit.find(puid);
                    procurementUnit.setIsStopSupply(procurementUnit.getIsStopSupply()==0?1:0);
                    procurementUnit.update();
                    jo.put("type", "0");
                } catch (Exception e) {
                    e.printStackTrace();
                    jo.put("type", "2");
                    jo.put("mes", "系统异常，请重试！");
                }
                out.print(jo.toString());
                return;
            }
        }

        //查看是否停止供货
        if ("showIsStopSupply".equals(act)){
            {
                try {
                    int puid = h.getInt("puid");
                    int day = 0;
                    ProcurementUnit procurementUnit = ProcurementUnit.find(puid);
                    jo.put("type", "0");
                    jo.put("flag", procurementUnit.getIsStopSupply()==1);
                } catch (Exception e) {
                    e.printStackTrace();
                    jo.put("type", "2");
                    jo.put("mes", "系统异常，请重试！");
                }
                out.print(jo.toString());
                return;
            }
        }



        // 关联医院
        if("joinHosp".equals(act)) {
            int puid = h.getInt("puid");
            try{
                ProcurementUnit p = ProcurementUnit.find(puid);
                if(p!=null) {
                    String checkList = h.get("checkList");
                    String checkNoList = h.get("checkNoList");
                    List<Integer> inds = ProcurementUnit.JoinHosp(puid);
                    // 添加关联
                    if (checkList != null) {
                        String[] hids = checkList.split(",");
                        for (int i = 1; i < hids.length; i++) {
                            int hid = Integer.parseInt(hids[i]);
                            if (!inds.contains(hid)) {
                                ProcurementUnit.AddJoinHosp(puid, hid);
                            }

                        }
                    }
                    // 移除关联
                    if (checkNoList != null) {
                        String[] hids_no = checkNoList.split(",");
                        for (int j = 1; j < hids_no.length; j++) {
                            int hid = Integer.parseInt(hids_no[j]);
                            if (inds.contains(hid)) {
                                ProcurementUnit.RemoveJoinHosp(puid, hid);
                            }
                        }
                    }
                }

                jo.put("type", "0");
                jo.put("mes","操作执行成功!");
                out.println(jo);
                return;

            } catch(Exception e){
                e.printStackTrace();
            } finally {
                out.close();
            }
        }

        // 查询已关联医院列表
        if("findShopHospital".equals(act)){
            int puid = h.getInt("puid");
            try{
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");
                //String parameterStr = YlUtil.getAllPar(req, h);

                StringBuffer sql = new StringBuffer("");
                String name = h.get("name");
                if(!"".equals(name) && name != null){
                    sql.append(" AND name like'%" + name + "%'");
                }

                sql.append(" and id in (select hid from hospitals_join where puid="+puid+")");

                int sum = ShopHospital.count(sql.toString());

                //int sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
                if (sum > 0) {
                    //jsonSb.append(ja.get("tblist"));
                    JSONArray ja = new JSONArray();


                    try{
                        List<ShopHospital> list = ShopHospital.find(sql.toString(), pos, page_size);
                        for (int i = 0; i < list.size(); i++) {
                            ShopHospital sh = list.get(i);
                            JSONObject jo2 = new JSONObject();
                            jo2.put("obj", JSON.toJSON(sh));
                            ja.put(jo2);
                        }
                    }catch (Exception e) {

                    }
                    jsonSb.append(ja);
                } else {
                    jsonSb.append("\"\"");
                }
                jsonSb.append(",\"type\":\"0\"}");
                out.print(jsonSb.toString());
                return;
            }catch(Exception e){
                Filex.logs("member.txt", "Members:" + act+"e"+e);
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
                out.print(jo.toString());
                return;
            }
        // 查询未关联医院列表
        }else if("findShopHospitalNo".equals(act)){
            int puid = h.getInt("puid");
            try{
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");
                //String parameterStr = YlUtil.getAllPar(req, h);

                StringBuffer sql = new StringBuffer("");
                String name = h.get("name");
                if(!"".equals(name) && name != null){
                    sql.append(" AND name like'%" + name + "%'");
                }
                List<Integer> ints = ProcurementUnit.JoinHosp(puid);
                StringBuffer SQsql = new StringBuffer();
                for (Integer anInt : ints) {
                    SQsql.append(" and id != " + anInt);
                }
                sql.append(SQsql);

                int sum = ShopHospital.count(sql.toString());

                //int sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
                if (sum > 0) {
                    //jsonSb.append(ja.get("tblist"));
                    JSONArray ja = new JSONArray();

                    try{
                        List<ShopHospital> list = ShopHospital.find(sql.toString(), pos, page_size);
                        for (int i = 0; i < list.size(); i++) {
                            ShopHospital sh = list.get(i);
                            JSONObject jo2 = new JSONObject();
                            jo2.put("obj", JSON.toJSON(sh));
                            ja.put(jo2);
                        }
                    }catch (Exception e) {

                    }
                    jsonSb.append(ja);
                } else {
                    jsonSb.append("\"\"");
                }
                jsonSb.append(",\"type\":\"0\"}");
                out.print(jsonSb.toString());
                return;
            }catch(Exception e){
                Filex.logs("member.txt", "Members:" + act+"e"+e);
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
                out.print(jo.toString());
                return;
            }
        // 查询关联服务商
        }else if("joinProfile".equals(act)){
            int puid = h.getInt("puid");
            try{
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");

                StringBuffer sql = new StringBuffer("");
                String member = h.get("member");
                if(!"".equals(member) && member != null){
                    sql.append(" AND member like'%" + member + "%'");
                }
                sql.append(" and profile in (select profile from procurementunit_join where puid="+puid+")");

                int sum = Profile.count(sql.toString());

                //int sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try{
                        List<Profile> list = Profile.find1(sql.toString(), pos, page_size);
                        for (Profile profile : list) {
                            JSONObject jo2 = new JSONObject();
                            //jo2.put("obj",JSON.toJSON(profile));
                            if(profile.member==null){
                                jo2.put("member","--");
                            }else{
                                jo2.put("member",profile.member);
                            }
                            jo2.put("profile",profile.profile);
                            if(profile.mobile==null){
                                jo2.put("mobile","--");
                            }else{
                                jo2.put("mobile",profile.mobile);
                            }
                            if(profile.email==null){
                                jo2.put("email", "--");
                            }else {
                                jo2.put("email", profile.email);
                            }
                            ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid, profile.profile);
                            if(puj.company==null){
                                jo2.put("company","--");
                            }else{
                                jo2.put("company",puj.company);
                            }
                            ja.put(jo2);
                        }
                    }catch (Exception e) {
                        e.printStackTrace();
                    }
                    jsonSb.append(ja);
                } else {
                    jsonSb.append("\"\"");
                }
                jsonSb.append(",\"type\":\"0\"}");
                out.print(jsonSb.toString());
                return;
            }catch(Exception e){
                Filex.logs("member.txt", "Members:" + act+"e"+e);
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
                out.print(jo.toString());
                return;
            }
            // 查看关联药品
        }else if("joinDrug".equals(act)){
            int puid = h.getInt("puid");
            try{
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");

                StringBuffer sql = new StringBuffer("");
                String name1 = h.get("name1");
                if(!"".equals(name1) && name1 != null){
                    sql.append(" AND name1 like'%" + name1 + "%'");
                }
                sql.append(" and puid="+puid);

                int sum = ShopProduct.count(sql.toString());

                //int sum = 0;
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try{
                        List<ShopProduct> list = ShopProduct.find(sql.toString(), pos, page_size);
                        for (ShopProduct shopProduct : list) {
                            JSONObject jo2 = new JSONObject();
                            //jo2.put("obj",JSON.toJSON(profile));
                            ShopProductModel spm = ShopProductModel.find(shopProduct.model_id); // 获取药品规格
                            jo2.put("name1",shopProduct.name[1]); // 名称
                            jo2.put("yucode",shopProduct.yucode); // 编号
                            ShopBrand shopBrand = ShopBrand.find(shopProduct.brand); // 品牌表查询品牌名称
                            jo2.put("brand",shopBrand.name[1]); // 品牌
                            ShopCategory shopCategory = ShopCategory.find(shopProduct.category); // 分类表查询分类信息
                            jo2.put("category",shopCategory.name[1]); // 分类
                            if(spm.getModel()==null){
                                jo2.put("model","--");
                            }else{
                                jo2.put("model",spm.getModel());
                            }
                            ja.put(jo2);
                        }
                    }catch (Exception e) {
                        e.printStackTrace();
                    }
                    jsonSb.append(ja);
                } else {
                    jsonSb.append("\"\"");
                }
                jsonSb.append(",\"type\":\"0\"}");
                out.print(jsonSb.toString());
                return;
            }catch(Exception e){
                Filex.logs("member.txt", "Members:" + act+"e"+e);
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
                out.print(jo.toString());
                return;
            }
        }

    }
}
