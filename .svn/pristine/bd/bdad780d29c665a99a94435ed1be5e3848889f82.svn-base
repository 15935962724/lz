package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.text.DecimalFormat;
import tea.entity.admin.*;

public class LmsOrgs extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            if("json".equals(act))
            {
                out.print("[");
                ArrayList al = LmsOrg.find(" AND father=" + h.getInt("father"),0,Integer.MAX_VALUE);
                for(int i = 0;i < al.size();i++)
                {
                    LmsOrg t = (LmsOrg) al.get(i);
                    if(i > 0)
                        out.print(",");
                    out.print(t.toString());
                }
                out.print("]");
                return;
            }
            String key = h.get("lmsorg");
            int lmsorg = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
            if("del".equals(act)) //删除
            {
                LmsOrg t = LmsOrg.find(lmsorg);
                int val = LmsOrg.count(" AND father=" + lmsorg);
                if(val > 0)
                {
                    out.print("<script>mt.show('机构“" + t.orgname + "”下有“" + val + "”个子机构，不能被删除！');</script>");
                    return;
                }
                val = Profile.count(" AND agent=" + lmsorg);
                if(val > 0)
                {
                    out.print("<script>mt.show('机构“" + t.orgname + "”下有“" + val + "”个用户，不能被删除！');</script>");
                    return;
                }
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                LmsOrg t = LmsOrg.find(lmsorg);
                t.father = h.getInt("father");
                //t.aspid = h.getInt("aspid");
                //t.layer = h.getInt("layer");
                t.orgtype = h.getInt("orgtype");
                t.orgname = h.get("orgname");
                //t.orgstatus = h.getInt("orgstatus");
                //t.forguest = h.get("forguest");
                //t.orgno = h.get("orgno");
                t.isasp = h.getInt("isasp");
                //t.province = h.get("province");
                t.city = h.getInt("city2");
                if(t.city < 1)
                    t.city = h.getInt("city1");
                //t.county = h.get("county");
                t.dnsname = h.get("dnsname");
                if(t.isasp == 1)
                {
                    t.description = h.get("description");
                    t.member = h.get("member");
                    t.bxzj = h.get("bxzj");
                    t.establish = h.getDate("establish");
                    t.sprxsj = h.getDate("sprxsj");
                    t.jzarea = h.getFloat("jzarea");
                    t.averagejxarea = h.getFloat("averagejxarea");

                    t.booknum = h.getInt("booknum");
                    t.seatnum = h.getInt("seatnum");
                    t.averagebooknum = h.getInt("averagebooknum");

                    t.averagecomputernum = h.getFloat("averagecomputernum");
                    t.jxsbmoney = h.getFloat("jxsbmoney");
                    t.pxtotal = h.getInt("pxtotal");
                    t.teachernum = h.getInt("teachernum");
                    t.managernum = h.getInt("managernum");
                } else //学习中心
                {
                    //t.orgno = String.valueOf(t.city) + (t.orgtype == 6 ? 0 : t.orgtype) + LmsOrg.find(t.father).lmsorg;
                    t.record = h.getInt("record");
                    t.branch = h.getInt("branch");
                    t.schoolid = h.get("schoolid");
                    t.raddress = h.get("raddress");
                    t.rpostcode = h.get("rpostcode");
                    t.tel = h.get("tel");
                    t.fax = h.get("fax");
                    t.lan = h.getInt("lan");
                    t.adsl = h.getInt("adsl");
                    t.speed = h.getInt("speed");
                    t.classroom1 = h.getInt("classroom1");
                    t.classroom2 = h.getInt("classroom2");
                    t.specialized = h.getBool("specialized");
                    t.undergraduate = h.getBool("undergraduate");
                    t.specializednum = h.getInt("specializednum");
                    t.undergraduatenum = h.getInt("undergraduatenum");
                }
                //t.remark1 = h.get("remark1");
                //t.remark2 = h.get("remark2");
                //t.remark3 = h.get("remark3");
                //t.remark4 = h.get("remark4");
                //t.remark5 = h.get("remark5");
                //t.startdate = h.getDate("startdate");
                //t.enddate = h.getDate("enddate");
                //t.logo = h.get("logo");
                //t.regdate = h.getDate("regdate");
                //t.ischeck = h.get("ischeck");

                t.bxzjcode = h.get("bxzjcode");
                t.address = h.get("address");
                t.postcode = h.get("postcode");
                //t.billprice = h.getFloat("billprice");
                t.sjdepartment = h.get("sjdepartment");
                //t.txpostcode = h.get("txpostcode");
                //t.aa = h.getInt("aa");
                t.fullnum = h.getInt("fullnum");
                t.sparenum = h.getInt("sparenum");
                t.zdarea = h.getFloat("zdarea");
                t.jxxzarea = h.getFloat("jxxzarea");
                t.fujzarea = h.getFloat("fujzarea");
                t.computernum = h.getInt("computernum");
                //t.zgtotal = h.getInt("zgtotal");
                //t.remark11 = h.get("remark11");
                //t.remark12 = h.get("remark12");
                //t.remark13 = h.get("remark13");
                //t.remark14 = h.get("remark14");
                //t.remark15 = h.get("remark15");
                if(t.lmsorg < 1)
                {
                    t.state = 1;
                }
                t.set();

                String[] ids = h.getValues("lmspeople");
                for(int i = 0;i < ids.length;i++)
                {
                    LmsPeople lp = LmsPeople.find(Integer.parseInt(ids[i]));
                    lp.lmsorg = t.lmsorg;
                    lp.type = Math.min(i + 1,3);
                    lp.name = h.get("name_" + i);
                    lp.sex = h.getInt("sex_" + i);
                    lp.brithday = h.getDate("brithday_" + i);
                    lp.age = h.getInt("age_" + i);
                    lp.nation = h.get("nation_" + i);
                    lp.telphone = h.get("telphone_" + i);
                    lp.cellphone = h.get("cellphone_" + i);
                    if(i == 1)
                    {
                        lp.fax = h.get("fax_" + i);
                    }
                    String tmp = h.get("mail_" + i);
                    if(tmp != null)
                        lp.mail = tmp;
                    lp.set();
                }
                if(t.isasp == 0)
                {
                    //计划承担的工作
                    LmsWork lw = LmsWork.find(t.lmsorg);
                    lw.isinschool = h.getInt("isinschool");
                    lw.isadmincourse = h.getInt("isadmincourse");
                    lw.isonlinecourse = h.getInt("isonlinecourse");
                    lw.isregistration = h.getInt("isregistration");
                    lw.isexnotice = h.getInt("isexnotice");
                    lw.isexamption = h.getInt("isexamption");
                    lw.isteach = h.getInt("isteach");
                    lw.isthepaper = h.getInt("isthepaper");
                    lw.isenglish = h.getInt("isenglish");
                    lw.iscertificate = h.getInt("iscertificate");
                    lw.isequipment = h.getInt("isequipment");
                    lw.isclass = h.getInt("isclass");
                    lw.isstudy = h.getInt("isstudy");
                    lw.ispractice = h.getInt("ispractice");
                    lw.isteaching = h.getInt("isteaching");
                    lw.issafety = h.getInt("issafety");
                    lw.isoperation = h.getInt("isoperation");
                    lw.iscoach = h.getInt("iscoach");
                    lw.ispracticecoach = h.getInt("ispracticecoach");
                    lw.isinvoice = h.getInt("isinvoice");
                    lw.set();
                }
            } else if("state".equals(act)) //状态
            {
                LmsOrg t = LmsOrg.find(lmsorg);
                t.state = h.getInt("state");
                if(t.state == 2 && t.orgno == null)
                {
                    Seq.SKIP_4 = true;
                    if(t.isasp == 1) //省助学发展机构
                    {
                        String str = String.valueOf(t.member) + String.valueOf(t.city).substring(0,4) + t.orgtype;
                        int seq = Seq.get("lmsorg1." + str);
                        t.orgno = str + new DecimalFormat("00").format(seq);
                    } else //学习中心
                    {
                        String str = String.valueOf(t.city).substring(0,4) + (t.orgtype == 6 ? 0 : t.orgtype);
                        int seq = Seq.get("lmsorg0." + str);
                        t.orgno = str + new DecimalFormat("000").format(seq);
                    }
                    Seq.SKIP_4 = false;
                    //项目负责人 做为登陆
                    {
                        LmsPeople lp = LmsPeople.find(t.lmsorg,2);
                        Profile p = Profile.create(t.orgno,lp.cellphone,h.community,lp.mail,request.getServerName());
                        p.setType(1);
                        p.setSex(lp.sex != 2);
                        p.setAgent(t.lmsorg);
                        if(lp.name != null)
                            p.setFirstName(lp.name,h.language);
                        if(lp.nation != null)
                            p.set("zzracky",lp.nation);
                        if(lp.brithday != null)
                            p.setBirth(lp.brithday);
                        if(lp.address != null)
                            p.setAddress(lp.address,h.language);
                        if(lp.telphone != null)
                            p.setTelephone(lp.telphone,h.language);
                        if(lp.fax != null)
                            p.setFax(lp.fax,h.language);
                        AdminUsrRole aur = AdminUsrRole.find(h.community,p.getProfile());
                        aur.setRole("/" + (t.isasp == 1 ? 5 : 4) + "/");
                    }
                }
                t.set();
            } else
            {
                String[] arr = h.getValues("lmsorgs");
                if("state4".equals(act)) //禁用
                {
                    for(int i = 0;i < arr.length;i++)
                    {
                        LmsOrg t = LmsOrg.find(Integer.parseInt(arr[i]));
                        t.set("state",String.valueOf(t.state = t.state == 2 ? 4 : 2));
                        //
                        Profile p = Profile.find(t.orgno);
                        p.setLocking(t.state == 4);
                    }
                }
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
