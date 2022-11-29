package tea.entity.member;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import java.text.*;
import jxl.*;
import jxl.write.*;
import tea.db.*;
import tea.entity.*;
import tea.resource.*;

public class ProfileGolf
{
    public static String[] GOLF_AGE =
            {"一年","两年","三年","四年","五年以上"};
    public String member;
    public int golfage; //高尔夫打球年限
    public int results; //总杆最好成绩
    public String oldsys; //原有差点系统名称
    public float oldindex; //原有差点指数
    public String oldmember; //原差点系统会员号

    public ProfileGolf()
    {
        f();
    }

    private void f()
    {
        oldsys = MT.f(oldsys);
        oldmember = MT.f(oldmember);
    }


    public static ProfileGolf find(String member) throws SQLException
    {
        ArrayList al = find(" AND member=" + DbAdapter.cite(member),0,1);
        return al.size() < 1 ? new ProfileGolf() : (ProfileGolf) al.get(0);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,golfage,results,oldsys,oldindex,oldmember FROM ProfileGolf WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                ProfileGolf g = new ProfileGolf();
                g.member = db.getString(1);
                g.golfage = db.getInt(2);
                g.results = db.getInt(3);
                g.oldsys = db.getString(4);
                g.oldindex = db.getFloat(5);
                g.oldmember = db.getString(6);
                g.f();
                al.add(g);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static void set(String member,int golfage,int results,String oldsys,float oldindex,String oldmember) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ProfileGolf(member)VALUES(" + DbAdapter.cite(member) + ")");
            db.executeUpdate("UPDATE ProfileGolf SET golfage=" + golfage + ",results=" + results + ",oldsys=" + DbAdapter.cite(oldsys) + ",oldindex=" + oldindex + ",oldmember=" + DbAdapter.cite(oldmember) + " WHERE member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }


    private static void w(Writer out,String s) throws IOException
    {
        if(out != null)
        {
            out.write("<script>f(\"" + s + "\");</script>");
            out.flush();
        }
    }

    private static void e(Writer out,String s,int go) throws IOException
    {
        if(out != null)
        {
            out.write("<script>alert(\"" + s + "\");history.go(" + go + ");</script>");
            out.flush();
        }
    }

    public static void imp(File file,String community,String password,Writer out) throws Exception
    {
        if(out != null)
        {
            out.write("<html><head><link href='/res/" + community + "/cssjs/community.css' rel='stylesheet' type='text/css'></head><body><h1>数据导入</h1><table cellpadding='0' cellspacing='0' id='tablecenter'><tr><td><span id='info'>正在读取中...</span></td></tr></table><script>var info=document.getElementById('info');function f(s){info.innerHTML=s;}</script>");
            out.flush();
        }
        Sheet sh;
        try
        {
            sh = Workbook.getWorkbook(file).getSheet(0);
        } catch(jxl.read.biff.BiffException ex)
        {
            e(out,"您上传的不是Excel文件!", -1);
            return;
        }
        if(!"差点会员号".equals(s(sh.getCell(2,0))))
        {
            e(out,"您上传的Excel文件 格式不对! 请参考样表修改!", -1);
            return;
        }
        System.out.println("ProfileGolf.java 导入会员...");
        int r = sh.getRows(),sum1 = 0,sum2 = 0;
        try
        {
            for(int i = 1;i < r;i++)
            {
                int j = 0;
                String name = s(sh.getCell(j++,i));
                String pinyin = s(sh.getCell(j++,i));
                String member = s(sh.getCell(j++,i));
                if(member.length() < 1)
                {
                    continue;
                }
                String creditcard = s(sh.getCell(j++,i));
                boolean sex = !"女".equals(s(sh.getCell(j++,i)));
                Date birth = d(sh.getCell(j++,i));
                String country = s(sh.getCell(j++,i));
                int cardtype = Arrayx.indexOf(Profile.CARD_TYPE,s(sh.getCell(j++,i)));
                String card = s(sh.getCell(j++,i));

                int famst = Arrayx.indexOf(Common.FAMST_TYPE,s(sh.getCell(j++,i))); //婚姻状况
                String degree = s(sh.getCell(j++,i)); //教育程度
                String paddress = s(sh.getCell(j++,i)); //住宅地址
                String ptelephone = s(sh.getCell(j++,i)); //住宅电话
                String organization = s(sh.getCell(j++,i)); //公司名称
                String address = s(sh.getCell(j++,i)); //公司地址
                int orgnature = Arrayx.indexOf(Profile.ORG_NATURE,s(sh.getCell(j++,i))); //公司性质
                String job = s(sh.getCell(j++,i)); //现任职务
                String functions = s(sh.getCell(j++,i)); //业务性质
                String zip = s(sh.getCell(j++,i)); //邮编
                String telephone = s(sh.getCell(j++,i)); //公司电话
                String fax = s(sh.getCell(j++,i));
                String mobile = s(sh.getCell(j++,i));
                String email = s(sh.getCell(j++,i));
                int golfage = MT.parseInt(s(sh.getCell(j++,i))); //高尔夫打球年限
                String cl = s(sh.getCell(j++,i));
                String club = s(sh.getCell(j++,i)); //球会名称
                if("是".equals(cl) && club.length() < 1)
                {
                    club = "<未知>";
                }
                int results = (int) f(sh.getCell(j++,i)); //总杆最好成绩
                String ol = s(sh.getCell(j++,i));
                String oldsys = s(sh.getCell(j++,i)); //原有差点系统名称
                if("是".equals(ol) && oldsys.length() < 1)
                {
                    club = "<未知>";
                }
                float oldindex = f(sh.getCell(j++,i)); //原有差点指数
                String oldmember = s(sh.getCell(j++,i)); //原差点系统会员号
                if(i % 10 == 0)
                {
                    w(out,"正在导入 " + name);
                }
                System.out.print(name + " ");
                //
                DbAdapter db = new DbAdapter();
                try 
                {
                    sum2 += db.executeUpdate("INSERT INTO Profile(member,community)VALUES(" + DbAdapter.cite(member) + ","+DbAdapter.cite(community)+")");
                    db.executeUpdate("INSERT INTO ProfileLayer(member,language)VALUES(" + DbAdapter.cite(member) + ",1)");
                    db.executeUpdate("UPDATE Profile SET community=" + DbAdapter.cite(community) + ",password=" + DbAdapter.cite(password) + ",pinyin=" + DbAdapter.cite(pinyin) + ",creditcard=" + DbAdapter.cite(creditcard) + ",sex=" + DbAdapter.cite(sex) + ",birth=" + DbAdapter.cite(birth) + ",cardtype=" + cardtype + ",card=" + DbAdapter.cite(card) + ",famst=" + famst + ",orgnature=" + orgnature + ",mobile=" + DbAdapter.cite(mobile) + ",email=" + DbAdapter.cite(email) + " WHERE member=" + DbAdapter.cite(member));
                    db.executeUpdate("UPDATE ProfileLayer SET firstname=" + DbAdapter.cite(name) + ",paddress=" + DbAdapter.cite(paddress) + ",ptelephone=" + DbAdapter.cite(ptelephone) + ",organization=" + DbAdapter.cite(organization) + ",address=" + DbAdapter.cite(address) + ",country=" + DbAdapter.cite(country) + ",job=" + DbAdapter.cite(job) + ",functions=" + DbAdapter.cite(functions) + ",degree=" + DbAdapter.cite(degree) + ",zip=" + DbAdapter.cite(zip) + ",telephone=" + DbAdapter.cite(telephone) + ",fax=" + DbAdapter.cite(fax) + ",club=" + DbAdapter.cite(club) + " WHERE member=" + DbAdapter.cite(member));
                } finally
                {
                    db.close();
                }
                ProfileGolf.set(member,golfage,results,oldsys,oldindex,oldmember);
                sum1++;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            e(out,"出现错误:" + ex.getMessage(), -1);
            return;
        }
        Profile._cache.clear(); //清空缓存
        w(out,"导入完成!");
        e(out,"导入完成!\\r\\n\\r\\n共导入 " + sum1 + " 条信息, 其中更新 " + (sum1 - sum2) + " 个已有会员信息!", -2);
    }

    public static void exp(String sql,int lang,OutputStream out) throws Exception
    {
        WritableWorkbook ww = Workbook.createWorkbook(out);
        WritableSheet wh = ww.createSheet("差点会员",0);
        String[] title =
                {"姓名（中文）","姓名拼音/英文","差点会员号","差点信用卡号","性别","出生日期","国籍","证件名称","证件号码","婚姻状况","教育程度","住宅地址","住宅电话","公司名称","公司地址","公司性质","现任职务","业务性质","邮编","公司电话","公司传真","移动电话","电子邮箱","高尔夫打球年限","是否是球会会员","球会名称","总杆最好成绩","是否加入过其它差点系统","原有差点系统名称","原有差点指数","原差点系统会员号"};
        for(int i = 0;i < title.length;i++)
        {
            wh.addCell(new Label(i,0,title[i]));
            wh.setColumnView(i,20);
        }
        Enumeration e = Profile.find(sql,0,Integer.MAX_VALUE);
        for(int j = 1;e.hasMoreElements();j++)
        {
            String m = (String) e.nextElement();
            Profile p = Profile.find(m);
            ProfileGolf pg = ProfileGolf.find(m);
            int i = 0;
            wh.addCell(new Label(i++,j,p.getName(lang)));
            wh.addCell(new Label(i++,j,MT.f(p.pinyin)));
            wh.addCell(new Label(i++,j,m));
            wh.addCell(new Label(i++,j,MT.f(p.getCreditcard())));
            wh.addCell(new Label(i++,j,(p.isSex() ? "男" : "女")));
            wh.addCell(new Label(i++,j,p.getBirthToString()));
            wh.addCell(new Label(i++,j,p.getCountry(lang)));
            wh.addCell(new Label(i++,j,MT.f(Profile.CARD_TYPE,p.getCardType())));
            wh.addCell(new Label(i++,j,p.getCard()));
            wh.addCell(new Label(i++,j,MT.f(Common.FAMST_TYPE,p.getFamst())));
            wh.addCell(new Label(i++,j,MT.f(p.getDegree(lang)))); //教育程度
            wh.addCell(new Label(i++,j,MT.f(p.getPAddress(lang))));
            wh.addCell(new Label(i++,j,MT.f(p.getPTelephone(lang))));
            wh.addCell(new Label(i++,j,p.getOrganization(lang)));
            wh.addCell(new Label(i++,j,p.getAddress(lang)));
            wh.addCell(new Label(i++,j,MT.f(Profile.ORG_NATURE,p.orgnature)));
            wh.addCell(new Label(i++,j,p.getJob(lang)));
            wh.addCell(new Label(i++,j,p.getFunctions(lang)));
            wh.addCell(new Label(i++,j,p.getZip(lang)));
            wh.addCell(new Label(i++,j,p.getTelephone(lang)));
            wh.addCell(new Label(i++,j,p.getFax(lang)));
            wh.addCell(new Label(i++,j,p.getMobile()));
            wh.addCell(new Label(i++,j,p.getEmail()));
            wh.addCell(new Label(i++,j,MT.f(ProfileGolf.GOLF_AGE,pg.golfage))); //高尔夫打球年限
            String club = MT.f(p.getClub(lang));
            wh.addCell(new Label(i++,j,(club.length() < 1 ? "否" : "是")));
            wh.addCell(new Label(i++,j,club));
            wh.addCell(new Label(i++,j,MT.f(pg.results)));
            String sys = MT.f(pg.oldsys);
            wh.addCell(new Label(i++,j,(sys.length() < 1 ? "否" : "是")));
            wh.addCell(new Label(i++,j,sys));
            wh.addCell(new Label(i++,j,MT.f(pg.oldindex)));
            wh.addCell(new Label(i++,j,MT.f(pg.oldmember)));
        }
        ww.write();
        ww.close();
        out.close();
    }

    public static float f(Cell s)
    {
        if(s == null)
        {
            return 0f;
        }
        String c = s.getContents();
        if(c == null || c.length() < 1 || c.equals("--"))
        {
            return 0f;
        }
        return Float.parseFloat(c);
    }

    public static String s(Cell s)
    {
        if(s == null)
        {
            return "";
        }
        String c = s.getContents();
        return c == null ? "" : c.trim();
    }

    public static Date d(Cell s)
    {
        String c = s.getContents();
        if(c == null || (c = c.trim()).length() < 8)
        {
            return null;
        } else
        {
            try
            {
                return new SimpleDateFormat("dd/mm/yyyy").parse(c);
            } catch(ParseException ex)
            {
                return null;
            }
        }
    }

    public String getGolfAgeToString()
    {
        return golfage + (golfage > 4 ? "年以上" : "年");
    }

}
