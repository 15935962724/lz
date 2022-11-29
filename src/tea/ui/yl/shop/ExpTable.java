package tea.ui.yl.shop;


import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.yl.shop.Agreed;
import tea.entity.yl.shop.ProcurementUnitJoin;
import tea.entity.yl.shop.Question;
import tea.ui.util.FreeMarkerTransfer;
import tea.ui.util.FreeMarkerUtils;
import util.Config;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.*;

/**
 * 生产-订单管理
 */
public class ExpTable extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act");
        if ("exp_question".equals(act)) {

            String mypath = this.getServletConfig().getServletContext().getRealPath("/");
            String path = mypath + "res\\yyxidcjl.xml";//导出 excel
            String fileName = "问卷调查.doc";
            String userAgent = request.getHeader("User-Agent");
            boolean isMSIE = ((userAgent != null && userAgent.indexOf("MSIE") != -1) || (null != userAgent && -1 != userAgent.indexOf("like Gecko")));
            List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
            //String sql = h.get("sql");
            String ids = h.get("ids");
            try {
                List<Question> questions = Question.find(" AND id in ("+ids+")".toString(), 0, Integer.MAX_VALUE);
                for (int i = 0; i < questions.size(); i++) {
                    Map<String,Object>map1 = new HashMap<>();
                    Question question = questions.get(i);
                    String creatDate = MT.f(question.getCreatTime());
                    String year = "";
                    String month = "";
                    String day = "";
                    if(creatDate!=null&&creatDate.length()>0){
                        year = creatDate.substring(0,4);
                        month = creatDate.substring(5,7);
                        day = creatDate.substring(8,10);
                    }
                    map1.put("year",year);
                    map1.put("month",month);
                    map1.put("day",day);
                    map1.put("pihao",question.getOrderId()+"");
                    map1.put("begindate",MT.f(question.getBeginTime()));
                    map1.put("enddate",MT.f(question.getEndTime()));
                    map1.put("gender",question.getGender()+"");
                    map1.put("yhjb",MT.f(question.getYhjb()));
                    map1.put("age",MT.f(question.getAge()));
                    map1.put("jws",question.getJws()+"");
                    map1.put("yyyy",MT.f(question.getYyyy()));
                    map1.put("yply",MT.f(question.getYply()));
                    map1.put("sfgs",MT.f(question.getSfgs()));
                    map1.put("num",question.getNum()+"");
                    map1.put("lhyyqk",question.getLhyyqk()+"");
                    map1.put("lhyyqktext",MT.f(question.getLhyyqktext())+"");
                    map1.put("yzqksm",MT.f(question.getYzqksm()));
                    Profile profile = Profile.find(question.getProfile());
                    map1.put("pro_name",MT.f(profile.getMember()));
                    map1.put("datetime",MT.f(question.getCreatTime()));
                    map1.put("hospital_name",MT.f(question.getHospital_name()));
                    map1.put("hospital_ks",MT.f(question.getHospital_ks()));
                    map1.put("mobile",MT.f(profile.getMobile()));

                    listmap.add(map1);
                }


            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (isMSIE) {
                System.out.println("----ie内核");
                fileName = new String(fileName.getBytes("GBK"), "ISO8859-1");
            } else {
                System.out.println("------chrome");
                fileName = new String(fileName.getBytes("UTF8"), "ISO8859-1");
            }

            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("listmap", listmap);
            String html = FreeMarkerUtils.parseText(path, map);
            html = FreeMarkerTransfer.getHtmlFromTmplString(html, map);
            OutputStream os = response.getOutputStream();
            byte b[] = html.getBytes("UTF-8");// 只能输出byte数组，所以将字符串变为byte数组

            os.write(b);
            os.flush();
            os.close();
        }else if("exp_agreed".equals(act)){//导出满意度调查 word
            int type = h.getInt("type");//0是同福服务商     1是高科医院
            String mypath = this.getServletConfig().getServletContext().getRealPath("/");

            String path = "";
            if(type==0){
                path  = mypath + "res\\agreed.xml";//导出 word
            }else {
                path  = mypath + "res\\agreedgk.xml";//导出 高科
            }
            String fileName = type==0?"同辐服务商满意度调查.doc":"高科医院满意度调查.doc";
            String userAgent = request.getHeader("User-Agent");
            boolean isMSIE = ((userAgent != null && userAgent.indexOf("MSIE") != -1) || (null != userAgent && -1 != userAgent.indexOf("like Gecko")));
            List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
            //String sql = h.get("sql");
            String sql = " AND id in ("+h.get("ids")+")";
            try {
                List<Agreed> agreeds = Agreed.find(sql.toString(), 0, Integer.MAX_VALUE);
                for (int i = 0; i < agreeds.size(); i++) {
                    Agreed agreed = agreeds.get(i);
                    Map<String,Object>map1 = new HashMap<>();//主map
                    int companyid = agreed.getCompanyid();//服务商公司id
                    int profile = agreed.getProfile();//用户id
                    Profile profile1 = Profile.find(profile);
                    ProcurementUnitJoin puj = ProcurementUnitJoin.find(companyid);
                    String company = puj.getCompany();//公司名称
                    int puid = puj.getPuid();
                    String cj = "";//厂家
                    if(puid==Config.getInt("gaoke")){
                        cj = "高科";
                    } else if(puid==Config.getInt("junan")){
                        cj = "君安";
                    } else if(puid==Config.getInt("xinke")){
                        cj = "欣科";
                    } else if(puid==Config.getInt("tongfu")){
                        cj = "同辐";
                    }
                    String member = profile1.getMember();//联系人
                    String mobile = profile1.getMobile();//电话
                    String email = profile1.getEmail();//邮箱

                    String myd = agreed.getMyd();
                    String[] splitMyd = myd.split(",");
                    String mydbz = agreed.getMydbz();
                    String[] splitMydbz = mydbz.split(",");
                    for (int j = 0; j <Agreed.TIMU.length; j++) {
                        try {
                            map1.put("daan"+j,MT.f(splitMyd[j]));
                        }catch (Exception e){
                            map1.put("daan"+j,"1");
                        }

                        try {
                            map1.put("bz"+j,MT.f(splitMydbz[j]));
                        }catch (Exception e){
                            map1.put("bz"+j,"");
                        }

                    }

                    map1.put("member",MT.f(member));//姓名
                    map1.put("mobile",MT.f(mobile));//手机号
                    map1.put("email",MT.f(email));//邮箱
                    map1.put("cj",cj);//厂家
                    map1.put("company",MT.f(company));//公司名
                    map1.put("cpxq",MT.f(agreed.getCpxq()));//新产品需求
                    map1.put("cpxqsm",MT.f(agreed.getCpxqsm()));//需求说明
                    map1.put("idea",MT.f(agreed.getIdea()));//意见建议
                    map1.put("gsdz",MT.f(agreed.getGsdz()));//公司地址
                    map1.put("cz",MT.f(agreed.getCz()));//传真
                    map1.put("yymc",MT.f(agreed.getGsdz()));
                    map1.put("ks",MT.f(agreed.getCz()));

                    listmap.add(map1);
                }


            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (isMSIE) {
                System.out.println("----ie内核");
                fileName = new String(fileName.getBytes("GBK"), "ISO8859-1");
            } else {
                System.out.println("------chrome");
                fileName = new String(fileName.getBytes("UTF8"), "ISO8859-1");
            }

            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("listmap", listmap);
            String html = FreeMarkerUtils.parseText(path, map);
            html = FreeMarkerTransfer.getHtmlFromTmplString(html, map);
            OutputStream os = response.getOutputStream();
            byte b[] = html.getBytes("UTF-8");// 只能输出byte数组，所以将字符串变为byte数组

            os.write(b);
            os.flush();
            os.close();


        }else if("expAgreedExcel".equals(act)){//导出满意度调查 excel
            int type = h.getInt("type");//0是同福服务商     1是高科医院
            String mypath = this.getServletConfig().getServletContext().getRealPath("/");
            String path = mypath + "res\\fwsmydexcel.xml";//导出 excel
            String fileName = type==0?"同辐服务商满意度调查.xlsx":"高科医院满意度调查.xlsx";
            String userAgent = request.getHeader("User-Agent");
            boolean isMSIE = ((userAgent != null && userAgent.indexOf("MSIE") != -1) || (null != userAgent && -1 != userAgent.indexOf("like Gecko")));
            List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
            //String sql = h.get("sql");
            String sql = " AND id in ("+h.get("ids")+")";
            try {
                List<Agreed> agreeds = Agreed.find(sql.toString(), 0, Integer.MAX_VALUE);
                for (int i = 0; i < agreeds.size(); i++) {
                    Agreed agreed = agreeds.get(i);
                    Map<String,Object>map1 = new HashMap<>();//主map
                    map1.put("xuhao",i+1);
                    int companyid = agreed.getCompanyid();//服务商公司id
                    ProcurementUnitJoin puj = ProcurementUnitJoin.find(companyid);
                    String company = puj.getCompany();//公司名称
                    String myd = agreed.getMyd();
                    String[] splitMyd = myd.split(",");
                    String mydbz = agreed.getMydbz();
                    String[] splitMydbz = mydbz.split(",");
                    for (int j = 0; j <Agreed.TIMU.length; j++) {
                        try {
                            map1.put("daan"+j,MT.f(splitMyd[j]));
                        }catch (Exception e){
                            map1.put("daan"+j,"1");
                        }

                        try {
                            map1.put("bz"+j,MT.f(splitMydbz[j]));
                        }catch (Exception e){
                            map1.put("bz"+j,"");
                        }

                    }
                    if(type==0) {
                        map1.put("company", MT.f(company));//公司名
                    }else {
                        map1.put("company", MT.f(agreed.getGsdz()));//医院名
                    }
                    map1.put("cpxq",MT.f(agreed.getCpxq()));//新产品需求
                    map1.put("cpxqsm",MT.f(agreed.getCpxqsm()));//需求说明
                    map1.put("idea",MT.f(agreed.getIdea()));//意见建议


                    listmap.add(map1);
                }


            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (isMSIE) {
                System.out.println("----ie内核");
                fileName = new String(fileName.getBytes("GBK"), "ISO8859-1");
            } else {
                System.out.println("------chrome");
                fileName = new String(fileName.getBytes("UTF8"), "ISO8859-1");
            }

            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("listmap", listmap);
            if(type==0){
                map.put("mingc","公司名称");
            }else {
                map.put("mingc","医院名称");
            }
            String html = FreeMarkerUtils.parseText(path, map);
            html = FreeMarkerTransfer.getHtmlFromTmplString(html, map);
            OutputStream os = response.getOutputStream();
            byte b[] = html.getBytes("UTF-8");// 只能输出byte数组，所以将字符串变为byte数组

            os.write(b);
            os.flush();
            os.close();


        }

    }

}
