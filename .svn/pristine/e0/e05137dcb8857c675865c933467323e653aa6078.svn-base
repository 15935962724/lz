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
import org.apache.poi.ss.usermodel.*;

public class LmsMembers extends HttpServlet
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
            if("upload".equals(act))
            {
                int code = -1;
                String info = null;
                try
                {
                    int type = h.getInt("type");
                    Attch a = Attch.find(h.getInt("file.attch"));
                    String card = a.name.substring(0,a.name.length() - a.type.length() - 1).replaceAll("[ｘＸ]","X");
                    ArrayList al = Profile.find1(" AND p.deleted=0 AND p.type!=4 AND p.card=" + DbAdapter.cite(card),0,200);
                    if(al.size() != 1)
                    {
                        info = "抱歉，“" + card + "”学员不存在！";
                        return;
                    }
                    Profile t = (Profile) al.get(0);
                    String photo = t.getPhotopath(h.language);
                    if(photo != null && photo.length() > 0 && new File(application.getRealPath(photo)).length() > 0)
                    {
                        if(type == 2) //跳过
                        {
                            code = 2;
                            a.delete();
                            return;
                        }
                        if(type == 3) //提示
                        {
                            info = "抱歉，“" + card + "”照片已存在！";
                            return;
                        }
                        code = 1;
                    } else
                    {
                        code = 0;
                    }
//                    Img img = new Img(Http.REAL_PATH + a.path);
//                    img.init();
//                    if(img.width != 144 || img.height != 192)
//                    {
//                        info = "抱歉，“" + card + "”照片宽高是“" + img.width + "px×" + img.height + "px”不符合规则！";
//                        return;
//                    }
                    t.setPhotopath(photo(t,a),h.language);
                } finally
                {
                    out.print("{code:" + code + ",info:'" + MT.f(info) + "'}");
                }
                return;
            }
            String info = "操作执行成功！";
            if("imp".equals(act)) //导入
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                info = imp(h,out);
                if(!info.startsWith("操作"))
                    nexturl = "";
            } else
            {
                String key = h.get("member");
                int member = key == null ? h.member : key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
                Profile t = Profile.find(member);
                if("edit".equals(act))
                {
                    int province;
                    String name = h.get("name");
                    if(name != null)
                    {
                        t.sex = h.getBool("sex");
                        t.birth = h.getDate("birth");
                        t.zzracky = h.get("zzracky");
                        t.polity = h.getInt("polity");
                        t.cardtype = h.getInt("cardtype");
                        t.card = h.get("card").replaceAll("[ｘＸ]","X").toUpperCase();
                        t.jcity = h.getInt("jcity");
                        t.zznyhk = h.getBool("zznyhk");
                        t.job = h.getInt("job");
                        t.orgnature = h.getInt("orgnature");
//                String enterLevel = h.get("enterLevel");
//                String enterLevel1 = h.get("enterLevel1");
//                String enterLevel2 = h.get("enterLevel2");
//                String professionDirection = h.get("professionDirection");
//                String eduLevel = h.get("eduLevel");
//                String currentIsEducation = h.get("currentIsEducation");
//                String currentIsShcoolName = h.get("currentIsShcoolName");
//                String currentIsEducation = h.get("currentIsEducation");
//                String graduationSchoolName = h.get("graduationSchoolName");
//                String hasProfessionName = h.get("hasProfessionName");
//                String graduationDateStr = h.get("graduationDateStr");
                        t.leveltype = h.getInt("leveltype");
                        if(Profile.count(" AND p.profile!=" + t.profile + " AND p.deleted=0 AND p.type!=4 AND p.card=" + DbAdapter.cite(t.card)) > 0)
                        {
                            out.print("<script>mt.show('该学员已在其它学习中心备案，该学员在其学习中心退学后，才可再次备案。');</script>");
                            return;
                        }
                        if(t.profile < 1)
                        {
                            t.agent = h.getInt("agent");
                            t.member = code(t.agent);
                            t.password = "smebs" + t.card.substring(t.card.length() - 6);
                            t.community = h.community;
                            t.time = new Date();
                            ArrayList l1 = Profile.find1(" AND p.deleted=0 AND p.type=4 AND p.card=" + DbAdapter.cite(t.card) + " AND p.cardnumber IS NOT NULL",0,1);
                            if(l1.size() > 0) //传递旧的准考证号
                            {
                                Profile p1 = (Profile) l1.get(0);
                                t.cardnumber = p1.cardnumber;
                            }
                        }
                        province = h.getInt("province1");
                        if(province < 1)
                            province = h.getInt("province0");
                    } else
                    {
                        name = t.getName(h.language);
                        province = t.getProvince(h.language);
                    }
                    int photopath = h.getInt("photopath.attch"); //头像
                    if(photopath > 0)
                    {
                        Attch a = Attch.find(photopath);
                        if(a.length > 51200)
                        {
                            out.print("<script>mt.show('抱歉，照片大小是“" + MT.f(a.length / 1025F,2) + "k”不符合规则！');</script>");
                            return;
                        }
                        if(!a.name.replaceAll("[ｘＸ]","X").toUpperCase().equals(t.card + ".JPG"))
                        {
                            out.print("<script>mt.show('抱歉，照片名称“" + a.name + "”不符合规则！');</script>");
                            return;
                        }
//                        Img img = new Img(Http.REAL_PATH + a.path);
//                        img.init();
//                        if(img.width != 144 || img.height != 192)
//                        {
//                            out.print("<script>mt.show('抱歉，照片宽高是“" + img.width + "px×" + img.height + "px”不符合规则！');</script>");
//                            return;
//                        }
                    }
                    t.mobile = h.get("mobile"); //移动电话
                    t.email = h.get("email"); //电子邮箱
                    t.rclass = h.getInt("rclass"); //是否在读
                    t.gtime = h.getDate("gtime"); //毕业时间
                    t.set();
                    t.setLayer(h.language,name,"",h.get("organization"),province,h.get("address"),h.get("zip"),t.getCountry(h.language),h.get("telephone"),t.getFax(h.language),t.getWebPage(h.language));
                    StringBuilder sql = new StringBuilder();
                    sql.append("UPDATE ProfileLayer SET");
                    sql.append(" degree=").append(DbAdapter.cite(h.get("degree"))); //学历
                    sql.append(",section=").append(DbAdapter.cite(h.get("section"))); //现阶段班级
                    sql.append(",school=").append(DbAdapter.cite(h.get("school"))); //毕业院校
                    sql.append(",functions=").append(DbAdapter.cite(h.get("functions"))); //毕业专业
                    if(photopath > 0)
                    {
                        sql.append(",photopath=").append(DbAdapter.cite(photo(t,Attch.find(photopath))));
                    }
                    sql.append(" WHERE profile=").append(t.profile);
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        db.executeUpdate(t.profile,sql.toString());
                    } finally
                    {
                        db.close();
                    }
                } else if("del".equals(act))
                {
                    t.delete();
                }
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    //学号
    static synchronized String code(int agent) throws SQLException
    {
        String prefix = LmsOrg.find(agent).orgno + (Calendar.getInstance().get(Calendar.YEAR) - 2000),ran = null;
        do
        {
            ran = new DecimalFormat("00000").format(Seq.get("member." + prefix));
            //ran = new DecimalFormat("0.00000").format(Math.random()).substring(2);
        } while(Profile.isExisted(prefix + ran));
        return prefix + ran;
    }

    //上传的头像，转规则存储！
    static String photo(Profile t,Attch a) throws SQLException
    {
        String card = t.getCard();
        if(card.startsWith("军字第"))
            card = card.substring(3);
        String photo = "/res/" + a.community + "/student/photo/" + (t.getAgent() < 1 ? "0" : LmsOrg.find(t.getAgent()).orgno) + "/" + card + ".jpg";
        ArrayList al = Attch.find(" AND deleted=0 AND path=" + DbAdapter.cite(photo),0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            Attch at = (Attch) al.get(i);
            at.delete();
        }
        File f = new File(Http.REAL_PATH + a.path),f2 = new File(Http.REAL_PATH + photo);
        if(f2.exists())
            f2.delete();
        else
            f2.getParentFile().mkdirs();
        if(!f.renameTo(f2))
            Filex.logs("Attch.txt",f + "(" + f.exists() + ") 移动到 " + f2 + "(" + f2.exists() + ") 失败！");
        a.set("path",photo);
        return photo;
    }

    //导入
    static String imp(Http h,Writer out) throws SQLException
    {
        int type = h.getInt("type");
        int agent = h.getInt("agent");
        Workbook wbs = Lms.conv(Http.REAL_PATH + h.get("file"));
        if(wbs == null)
            return "抱歉，请上传xls、xlsx格式文件！";
        int a1 = 0,a2 = 0;
        ArrayList L1 = new ArrayList(),L2 = new ArrayList();
        Sheet s = wbs.getSheetAt(0);
        for(int i = 2;i <= s.getLastRowNum();i++)
        {
            Row r = s.getRow(i);
            if(r == null)
                continue;
            int j = 0;
            String th = null;
            try
            {
                //
                th = "姓名";
                String name = Lms.f(r,j++);
                String card = Lms.f(r,7);
                if((MT.f(name) + MT.f(card)).length() < 1) //空白行（某此单元格中有空格），一班在未尾会出现。
                    continue;
                //
                ArrayList al = Profile.find1(" AND p.deleted=0 AND p.agent=" + agent + " AND p.card=" + DbAdapter.cite(card),0,200);
                Profile t = al.size() < 1 ? new Profile(0) : (Profile) al.get(0);
                if(t.profile > 0)
                {
                    if(type == 2)
                        continue;
                    if(type == 3)
                        return "抱歉，“" + card + "”已存在！";
                    a2++;
                } else
                {
                    if(Profile.count(" AND p.deleted=0 AND p.agent!=" + agent + " AND p.type!=4 AND p.card=" + DbAdapter.cite(card)) > 0)
                        return "抱歉，学员“" + card + "”已在其它学习中心备案，才可再次备案。";
                    t.agent = agent;
                    t.member = code(t.agent);
                    t.password = "smebs" + card.substring(card.length() - 6);
                    t.community = h.community;
                    t.time = new Date();
                    ArrayList l1 = Profile.find1(" AND p.deleted=0 AND p.type=4 AND p.card=" + DbAdapter.cite(card) + " AND p.cardnumber IS NOT NULL",0,1);
                    if(l1.size() > 0) //传递旧的准考证号
                    {
                        Profile p1 = (Profile) l1.get(0);
                        t.cardnumber = p1.cardnumber;
                    }
                    a1++;
                }
                //
                th = "性别";
                t.sex = Lms.f(r,j++,Lms.SEX_TYPE) != 2;
                //
                th = "出生日期";
                String sbirth = Lms.f(r,j++);
                if(sbirth == null || sbirth.length() < 1)
                    return "抱歉，" + th + "列中的数据不能为空！";
                t.birth = MT.SDF[0].parse(sbirth.replaceFirst("['‘’]",""));
                //
                th = "民族";
                t.zzracky = Lms.f(r,j++);
                //
                th = "政治面貌";
                t.polity = Lms.f(r,j++,Lms.POLITY_TYPE);
                //
                th = "籍贯";
                t.jcity = Lms.f(r,j++,"SELECT card FROM card WHERE card<100 AND address=");
                //
                th = "证件类型";
                t.cardtype = Lms.f(r,j++,Lms.CARD_TYPE);
                //
                th = "证件号码";
                t.card = Lms.f(r,j++);
                if(out != null)
                {
                    out.write("<script>mt.progress(" + i + "," + s.getLastRowNum() + ",'姓名：" + name + "　证件号：" + t.card + "');</script>");
                    out.flush();
                }
                //
                th = "户籍";
                t.zznyhk = Lms.f(r,j++,Lms.ZZNYHK_TYPE) == 1;
                //
                th = "报名所在省";
                int province0 = Lms.f(r,j++,"SELECT card FROM card WHERE card<100 AND address=");
                //
                th = "报名所在市";
                int province1 = Lms.f(r,j++,"SELECT card FROM card WHERE card LIKE " + DbAdapter.cite(province0 + "_%") + " AND address=");
                int province = province1 > 0 ? province1 : province0;
                //
                th = "职业";
                t.job = Lms.f(r,j++,Lms.JOB_TYPE);
                //
                th = "单位性质";
                t.orgnature = Lms.f(r,j++,Lms.ORG_NATURE);
                //
                th = "证书级别";
                String enterLevel = Lms.f(r,j++);
                //
                th = "证书方向";
                t.leveltype = Lms.f(r,j++,"SELECT lmscert FROM lmscert WHERE rank=2 AND name=");
                //
                th = "学历";
                String degree = Lms.EDU_LEVEL[Lms.f(r,j++,Lms.EDU_LEVEL)];
                //
                th = "是否在读";
                t.rclass = Lms.f(r,j++,Lms.YES_NO);
                //
                th = "现阶段所在班级";
                String section = Lms.f(r,j++);
                //
                th = "毕业院校";
                String school = Lms.f(r,j++);
                //
                th = "毕业专业";
                String functions = Lms.f(r,j++);
                //
                th = "毕业时间";
                String tmp = Lms.f(r,j++);
                t.gtime = MT.f(tmp).length() < 1 ? null : MT.SDF[0].parse(tmp.replaceFirst("['‘’]",""));
                //
                th = "工作单位";
                String organization = Lms.f(r,j++);
                //
                th = "移动电话";
                t.mobile = Lms.f(r,j++);
                //
                th = "通讯地址";
                String address = Lms.f(r,j++);
                //
                th = "固定电话";
                String telephone = Lms.f(r,j++);
                //Z
                th = "邮编";
                String zip = Lms.f(r,j++);
                //AA
                th = "电子邮箱";
                t.email = Lms.f(r,j++);
                //
                L1.add(t);
                StringBuilder sql = new StringBuilder();
                sql.append("UPDATE ProfileLayer SET");
                sql.append(" firstname=").append(DbAdapter.cite(name));
                sql.append(",organization=").append(DbAdapter.cite(organization));
                sql.append(",province=").append(province);
                sql.append(",address=").append(DbAdapter.cite(address));
                sql.append(",zip=").append(DbAdapter.cite(zip));
                sql.append(",telephone=").append(DbAdapter.cite(telephone));
                sql.append(",degree=").append(DbAdapter.cite(degree)); //学历
                sql.append(",section=").append(DbAdapter.cite(section)); //现阶段班级
                sql.append(",school=").append(DbAdapter.cite(school)); //毕业院校
                sql.append(",functions=").append(DbAdapter.cite(functions)); //毕业专业
                String photopath = h.get("photopath"); //头像
                if(photopath != null)
                    sql.append(",photopath=").append(DbAdapter.cite(photopath));
                sql.append(" WHERE profile=");
                L2.add(sql.toString());
            } catch(Throwable ex)
            {
                ex.printStackTrace();
                return "位置：" + (i + 1) + "x" + j + "<br/>列名：" + th + "<br/>错误：" + ex.getMessage();
            }
        }
        for(int i = 0;i < L1.size();i++)
        {
            Profile t = (Profile) L1.get(i);
            boolean isNew = t.profile < 1;
            t.set();
            DbAdapter db = new DbAdapter();
            try
            {
                if(isNew)
                    db.executeUpdate(t.profile,"INSERT INTO ProfileLayer(profile,member,language)VALUES(" + t.profile + "," + DbAdapter.cite(t.member) + "," + h.language + ")");
                db.executeUpdate(t.profile,(String) L2.get(i) + t.profile);
            } finally
            {
                db.close();
            }
            Profile._cache.remove(t.profile);
        }
        return "操作执行成功！<br/>新增：" + a1 + "条　替换：" + a2 + "条";
    }
}
