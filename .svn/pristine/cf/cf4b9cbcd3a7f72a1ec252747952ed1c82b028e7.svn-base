package tea.entity.lms;

import java.io.*;
import java.text.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import tea.entity.member.*;
import tea.entity.admin.*;
import tea.ui.lms.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
import org.apache.poi.poifs.filesystem.*;

//
public class Lms
{
    public static String[] YES_NO =
            {"--","是","否"};
    public static String[] SEX_TYPE =
            {"--","男","女"};
    public static String[] CARD_TYPE =
            {"--","身份证","军官证","护照","港澳通行证","其他"};
    public static String[] JOB_TYPE =
            {"--","国家机关、党群组织、企业、事业单位负责人","专业技术人员","办事人员和有关人员","商业、服务业人员","学生","其他"};
    public static String[] ORG_NATURE =
            {"--","政府及事业单位","国有企业","私营企业","外资（合资）企业","学校及社会团体","其他"};
    public static String[] MEMBER_TYPE =
            {"未注册","管理员","注册","已确认","已退学"};
    public static String[] ZZNYHK_TYPE =
            {"非农业","农业"};
    public static String[] POLITY_TYPE =
            {"--","团员","党员","群众","其它"};
    public static String[] EDU_LEVEL =
            {"--","研究生及以上","本科","专科","高中及同等学历","初中及以下"};
    public static String[] YESNO_TYPE =
            {"--","团员","党员","群众","其它"};
    public static String[] IMPORT_TYPE =
            {"--","替换","跳过","提示"};
    public static String when(String[] arr,String f)
    {
        StringBuilder sb = new StringBuilder();
        for(int i = 0;i < arr.length;i++)
        {
            sb.append(" CASE WHEN " + f + "=" + i + " THEN '" + arr[i] + "' ELSE");
        }
        sb.append(" null");
        for(int i = 0;i < arr.length;i++)
        {
            sb.append(" END");
        }
        return sb.toString();
    }

    //must: 是否必填
    public static String query(Http h,StringBuilder sql,StringBuilder par,boolean must) throws SQLException
    {
        int lmsorg = h.getInt("lmsorg");
        int agent = h.getInt("agent");
        int level = 0;
        Profile p = Profile.find(h.member);
        if(p.getAgent() > 0)
        {
            LmsOrg lo = LmsOrg.find(p.getAgent());
            if(lo.father > 0) //学习中心
            {
                lmsorg = lo.father;
                agent = lo.lmsorg;
                level = 2;
            } else
            {
                lmsorg = lo.lmsorg;
                level = 1;
            }
        }
        if(sql != null)
        {
            par.append("&lmsorg=" + lmsorg);
            if(agent > 0)
            {
                sql.append(" AND p.agent=" + agent);
                par.append("&agent=" + agent);
            } else if(lmsorg > 0)
            {
                sql.append(" AND p.agent IN(SELECT lmsorg FROM lmsorg WHERE father=" + lmsorg + ")");
            }
        }
        return "<th>" + (must ? "<em>*</em>" : "") + "省助学发展机构:</th><td>" + (level > 0 ? LmsOrg.find(lmsorg).orgname : "<select name='lmsorg' class='lmsorg' onchange='lms.org(this)' alt=" + (must ? "省助学发展机构" : "") + "><option value=''>--</option>" + LmsOrg.options(" AND isasp=1",lmsorg) + "</select>") + "</td>"
                + (must ? "</tr><tr>" : "")
                + "<th>" + (must ? "<em>*</em>" : "") + "学习服务中心:</th><td>" + (level > 1 ? "<input type='hidden' name='agent' value='" + agent + "'>" + LmsOrg.find(agent).orgname : "<select name='agent' alt=" + (must ? "学习中心" : "") + "><option value=''>--</option>" + (lmsorg < 1 ? "" : LmsOrg.options(" AND father=" + lmsorg,agent)) + "</select>") + "</td>";
    }

    public static String f(Row r,int j)
    {
        Cell c = r.getCell(j);
        if(c == null)
            return null;
        if(Cell.CELL_TYPE_NUMERIC == c.getCellType())
        {
            return new DecimalFormat("0.##").format(c.getNumericCellValue());
        }
        return c.toString().trim();
    }

    public static int f(Row r,int j,String[] arr) throws Exception
    {
        String str = f(r,j);
        int i = Arrayx.indexOf(arr,str);
        if(i == -1)
            throw new Exception("“" + str + "”不是预期值！");
        return i;
    }

    public static int f(Row r,int j,String sql) throws Exception
    {
        String str = f(r,j);
        int i = DbAdapter.execute(sql + DbAdapter.cite(str));
        if(i < 1)
            throw new Exception("“" + str + "”不是预期值！");
        return i;
    }

    public static Workbook conv(String file) throws SQLException
    {
        Filex.logs("Lms_imp.txt","文件：" + file);
        Workbook wbs = null;
        try
        {
            FileInputStream is = new FileInputStream(file);
            try
            {
                wbs = new HSSFWorkbook(is); //xls
            } catch(OfficeXmlFileException ex)
            {
                is.close();
                is = new FileInputStream(file);
                wbs = new XSSFWorkbook(is); //xlsx
            }
            is.close();
        } catch(Throwable ex)
        {
            Filex.logs("Lms_imp.txt",ex);
            ex.printStackTrace();
        }
        return wbs;
    }

    public static void income() throws SQLException
    {
        DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
        try
        {
            db.executeQuery("SELECT * FROM `lms`.rate_incomemarkup_tab");
            for(int i = 0;db.next();i++)
            {
                int j = 1;
                int id = db.getInt(j++);
                int province = db.getInt(j++);
                int applyid = db.getInt(j++);
                Date starttime = db.getDate(j++);
                Date endtime = db.getDate(j++);
                float rate = db.getFloat(j++);
                int approval = db.getInt(j++);
                int permanent = db.getInt(j++);
                int usd = db.getInt(j++);
                d2.executeUpdate("INSERT INTO LmsIncome(lmsincome,city,starttime,endtime,price,type,state,unlimited,deleted,time)VALUES("
                                 + (id + 3000) + "," + province / 10000 + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(endtime) + "," + rate + ",3," + approval + "," + permanent + "," + (usd == 0 ? 1 : 0) + "," + DbAdapter.cite(starttime) + ")");
                d2.executeUpdate("UPDATE LmsIncome SET sync=CONCAT('rate_incomemarkup_tab.'," + id + ") WHERE lmsincome=" + (id + 3000));
            }
            d2.setAutoCommit(true);
        } finally
        {
            db.close();
            d2.close();
        }
    }

    public static void main(String[] args) throws SQLException
    {
        //System.out.println(when(POLITY_TYPE,"1"));
        //lmsmembercourse();


//补充LmsPlanCourse
//        ArrayList al = LmsPlan.find(" AND lmsplan=9 ORDER BY lmsplan",0,200);
//        for(int i = 0;i < al.size();i++)
//        {
//            LmsPlan lp = (LmsPlan) al.get(i);
//
//            StringBuilder ids = new StringBuilder();
//            ArrayList aa = LmsMemberCourse.find(" AND lmsplan=" + lp.lmsplan,0,2000);
//            for(int j = 0;j < aa.size();j++)
//            {
//                LmsMemberCourse lmc = (LmsMemberCourse) aa.get(j);
//                ids.append(lmc.lmscourse0.substring(1) + lmc.lmscourse1.substring(1));
//            }
//            if(ids.length() < 3)
//            {
//                System.out.println(lp.lmsplan);
//                continue;
//            }
//            String[] arr = ids.toString().split("[|]");
//            for(int j = 0;j < arr.length;j++)
//            {
//                LmsPlanCourse lpc = LmsPlanCourse.find(lp.lmsplan,Integer.parseInt(arr[j]));
//                if(lpc.lmsplancourse > 0)
//                    continue;
//                lpc.lmsplan = lp.lmsplan;
//                lpc.lmscourse = Integer.parseInt(arr[j]);
//                lpc.starttime = lpc.endtime = lpc.time = new Date();
//                lpc.member = 14050001;
//                lpc.set();
//            }
//        }

        ArrayList al = LmsCourse.find(" AND status=1",0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            LmsCourse t = (LmsCourse) al.get(i);
            System.out.println("UPDATE lmschapter SET lmscourse=" + t.lmscourse + " WHERE lmscourse=" + t.code + ";");
        }
    }

    public static void sec_role_tab() throws SQLException
    {
        DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
        try
        {
            d2.setAutoCommit(false);
//            db.executeQuery("SELECT * FROM `lms`.sec_role_tab");
//            for(int i = 0;db.next();i++)
//            {
//                int j = 1;
//                int SysID = db.getInt(j++);
//                int RoleID = db.getInt(j++);
//                String Name = db.getString(j++);
//                String Description = db.getString(j++);
//                d2.executeUpdate("INSERT INTO AdminRole(id,community,type,name,content)VALUES('" + RoleID + "','lms',1," + DbAdapter.cite(Name) + "," + DbAdapter.cite(Description) + ")");
//            }
            db.executeQuery("SELECT userid,roleid FROM `lms`.`sec_userrole_tab` WHERE roleid!=9");
            while(db.next())
            {
                int userid = db.getInt(1),rolid = db.getInt(2);
                AdminUsrRole aur = AdminUsrRole.find("lms",userid);
                aur.setRole("/" + rolid + "/");
            }
            d2.setAutoCommit(true);
        } finally
        {
            db.close();
            d2.close();
        }
    }

    public static void lms_user_student_tab() throws SQLException
    {
        DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
        try
        {
            d2.setAutoCommit(false);
            db.executeQuery("SELECT * FROM `lms`.lms_user_student_tab");
            for(int i = 0;db.next();i++)
            {
                int j = 1;
                int StudentID = db.getInt(j++);
                int UserID = db.getInt(j++);
                String CurrentHasEducation = db.getString(j++);
                String HasProfessionName = db.getString(j++); //毕业专业
                Date GraduationDate = db.getDate(j++); //毕业时间
                String DiplomaCode = db.getString(j++);
                String GraduationSchoolName = db.getString(j++); //毕业院校
                String GraduationSchoolCode = db.getString(j++);
                String CurrentIsShcoolName = db.getString(j++); //填写现阶段班级
                String IsProfessionName = db.getString(j++);
                int CurrentIsEducation = db.getInt(j++); //是否在读 1:是 2:否
                int IsLearnType = db.getInt(j++);
                String ProfessionDirection = db.getString(j++); //专业方向
                int EnterLevel = db.getInt(j++);
                String FareList = db.getString(j++);
                float PubCredit = db.getFloat(j++);
                float ProfCredit = db.getFloat(j++);
                int leveltype = d2.getInt("SELECT certtypeid FROM `lms`.lms_certificate_tab WHERE CODE=" + DbAdapter.cite(ProfessionDirection));
                d2.executeUpdate("UPDATE Profile SET gtime=" + DbAdapter.cite(GraduationDate) + ",rclass=" + CurrentIsEducation + ",leveltype=" + leveltype + " WHERE profile=" + UserID);
                d2.executeUpdate("UPDATE ProfileLayer SET school=" + DbAdapter.cite(GraduationSchoolName) + ",functions=" + DbAdapter.cite(HasProfessionName) + ",section=" + DbAdapter.cite(CurrentIsShcoolName) + " WHERE profile=" + UserID);
                if(i % 1000 == 0)
                {
                    d2.commit();
                    System.out.println(UserID);
                }
            }
            d2.setAutoCommit(true);
        } finally
        {
            db.close();
            d2.close();
        }
    }

    public static void main11(String[] args) throws SQLException
    {
        //UPDATE lms.u_user_tab SET desc0='2000-01-01' WHERE desc0='123';
        //UPDATE  lms.u_user_tab SET  LastloginDate=NULL WHERE  LastloginDate='0000-00-00 00:00:00';

        DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
        try
        {
            db.executeQuery("SELECT * FROM `lms`.U_USER_TAB ");
            while(db.next())
            {
                int j = 1;
                int userid = db.getInt(j++);
                String loginname = db.getString(j++);
                System.out.println(userid + "/" + loginname);
                String password = db.getString(j++);
                String name = db.getString(j++);
                int type = db.getInt(j++); //available,-2:已退学,现改为4　1:管理员(估)　0:未注册　2:注册　3:已确认
                String email = db.getString(j++);
                String card = db.getString(j++);
                int sex = db.getInt(j++);
                String phone = db.getString(j++); //Phone
                String mobile = db.getString(j++); //Cellphone
                String address = db.getString(j++);
                String zip = db.getString(j++); //postalcode
                String degree = db.getString(j++); //Edulevel,学历
                String pwdquestion = db.getString(j++);
                String pwdanawer = db.getString(j++);
                Date time = db.getDate(j++);
                int agent = db.getInt(j++); //catalogid,学习中心
                Date login = db.getDate(j++); //LastloginDate
                Date birth = db.getDate(j++); //desc0
                String zzracky = db.getString(j++); //desc1
                String content = db.getString(j++); //Description,无内容
                int polity = db.getInt(j++); //remark1
                String remark2 = db.getString(j++); //,无内容
                int province = db.getInt(j++); //remark3,报名所在地
                int city2 = db.getInt(j++); //remark4
                if(city2 > 0)
                    province = city2;
                int cardtype = db.getInt(j++); //remark5
                String photopath = db.getString(j++); //remark6,头像
                if(MT.f(photopath).length() > 0)
                    photopath = "/res/lms/" + photopath;
                String sjob = db.getString(j++); //remark7,职　　业
                int job = sjob == null ? 0 : Arrayx.indexOf(JOB_TYPE,sjob);
                String organization = db.getString(j++); //remark8,工作单位
                String remark9 = db.getString(j++); //,无内容
                String sorgnature = db.getString(j++); //remark10,单位性质
                int orgnature = sorgnature == null ? 0 : Arrayx.indexOf(ORG_NATURE,sorgnature);
                String remark11 = db.getString(j++); //,准考证号
                String remark12 = db.getString(j++); //
                password = db.getString(j++);
                String externalsystemuserid = db.getString(j++); //,无内容
                String fax = db.getString(j++);
                int jcity = db.getInt(j++) / 10000; //brithplace,籍贯
                boolean zznyhk = db.getInt(j++) == 2; //户　　籍
                String learntype = db.getString(j++); //,无内容
                String fare = db.getString(j++); //,无内容
                //
                d2.executeUpdate("INSERT INTO Profile(profile,member,community,password,time,mobile,sex,card,cardtype,ltime0,email,question,answer,birth,polity,jcity,zznyhk,job,orgnature,type,agent,zzracky,deleted)VALUES("
                                 + userid + "," + DbAdapter.cite(loginname) + ",'lms'," + DbAdapter.cite(password) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(mobile) + "," + sex + "," + DbAdapter.cite(card) + "," + cardtype + "," + DbAdapter.cite(login) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(pwdquestion) + "," + DbAdapter.cite(pwdanawer) + "," + DbAdapter.cite(birth) + "," + polity + "," + jcity + "," + DbAdapter.cite(zznyhk) + "," + job + "," + orgnature + "," + type + "," + agent + "," + DbAdapter.cite(zzracky) + ",0" + ")");
                d2.executeUpdate("INSERT INTO ProfileLayer(member,language,firstname,lastname,telephone,address,zip,photopath,degree,province,organization)VALUES("
                                 + DbAdapter.cite(loginname) + "," + 1 + "," + DbAdapter.cite(name) + ",''," + DbAdapter.cite(phone) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(photopath) + "," + DbAdapter.cite(degree) + "," + province + "," + DbAdapter.cite(organization) + ")");
            }
        } finally
        {
            db.close();
            d2.close();
        }
    }

    public static void lmsmembercourse() throws SQLException
    {
        DbAdapter db = new DbAdapter(),d2 = new DbAdapter(),d3 = new DbAdapter();
        try
        {
            d3.setAutoCommit(false);
            //UPDATE T_USER_MAST_USIGSJ_TAB SET sync=CONCAT(userid,':',batchid)
            db.executeQuery("SELECT sync FROM `lms`.t_user_mast_usig_tab GROUP BY sync");
            for(int i = 0;db.next();i++)
            {
                String sync = db.getString(1);
                int id = 0,userid = 0,batchid = 0;
                Date time = null;
                StringBuilder ids = new StringBuilder("|");
                d2.executeQuery("SELECT * FROM `lms`.t_user_mast_usig_tab WHERE sync=" + DbAdapter.cite(sync) + " ORDER BY userid");
                while(d2.next())
                {
                    //id = d2.getInt(1);
                    userid = d2.getInt(2);
                    int masterid = d2.getInt(3);
                    time = d2.getDate(4);
                    batchid = d2.getInt(5);
                    ids.append(masterid + "|");
                }
                //
                LmsMemberCourse lmc = LmsMemberCourse.find(userid,batchid);
                //lmc.lmsmembercourse = id;
                lmc.member = userid;
                lmc.lmsplan = batchid;
                lmc.lmscourse1 = ids.toString();
                if(lmc.lmsmembercourse < 1)
                {
                    lmc.time = time;
                }
                lmc.set(d3);
                if(i % 100 == 0)
                {
                    System.out.println(i);
                    d3.commit();
                }
            }
        } finally
        {
            db.close();
            d2.close();
            d3.setAutoCommit(true);
            d3.close();
        }
    }

    public static String getAnchor(Profile p) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        htm.append("<div style='display:none'><table><tr><td rowspan='3' valign='top'><img _src='" + MT.f(p.getPhotopath(1),"/tea/image/avatar.gif") + "?max-age=0' style='width:50px' /></td><td>" + p.getName(1) + "，" + (p.isSex() ? "男" : "女") + "</td></tr>");
        htm.append("<tr><td>" + LmsCert.f(p.getLeveltype()) + "</td></tr>");
        htm.append("<tr><td>" + p.getMobile() + "</td></tr>");
        htm.append("</table></div>");
        htm.append("<a href='/jsp/lms/LmsMemberView.jsp?member=" + MT.enc(p.getProfile()) + "' onmouseover=\"mt.tip(this,previousSibling.innerHTML.replace('_src=','src='))\">" + p.getName(1) + "</a>");
        return htm.toString();
    }

    //如果是退学后，到另一家学习中心报考的考生，准考证号码是否被记录下来了，因为准考证号码和身份证号码是一一对应的，也就是说不会因为学员换了学习中心而改变
    public static void ref() throws SQLException
    {
        DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
        try
        {
            ArrayList al = new ArrayList();
            db.executeQuery("SELECT card,COUNT(card) FROM profile WHERE deleted=0 AND card!='' GROUP BY card HAVING COUNT(card)>1");
            while(db.next())
            {
                String card = db.getString(1);
                al.add(card);
            }
            for(int i = 0;i < al.size();i++)
            {
                String card = (String) al.get(i);
                System.out.println("<hr>");
                db.executeQuery("SELECT member,type,cardnumber FROM Profile WHERE card=" + DbAdapter.cite(card));
                while(db.next())
                {
                    System.out.print(db.getString(1));
                    System.out.print("　" + db.getInt(2));
                    System.out.print("　" + db.getString(3));
                    System.out.println("<br>");
                }
            }
            db.executeQuery("SELECT cardnumber,card FROM profile WHERE deleted=0 AND card!='' AND type=4 AND cardnumber IS NOT NULL");
            while(db.next())
            {
                d2.executeUpdate("UPDATE profile SET cardnumber=" + DbAdapter.cite(db.getString(1)) + " WHERE cardnumber IS NULL AND card=" + DbAdapter.cite(db.getString(2)));
            }
        } finally
        {
            db.close();
            d2.close();
        }
    }
}
