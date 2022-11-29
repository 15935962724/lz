package tea.entity.member;

import java.io.*;
import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class ProfileZh extends Entity implements Serializable
{
    private static Cache _cache = new Cache(100);
    private String member;
    private String name;
    private String nationnal;
    private String nactive;
    private String bplace;
    private String political;
    private String card;
    private String photo;
    private String faddr;
    private String zip;
    private String homephone;
    private String web;
    private String comname;
    private String job;
    private String comphone;
    private String fax;
    private String comaddr;
    private String comzip;
    private String otherjob;
    private String cper;
    private String cjob;
    private String cphone;
    private String cfax;
    private String zipsend;
    private String infosend;
    private String resume;
    private int isopen;
    private int regbuffer;
    private int regstyle; //注册类型： 0理事 1专家 2媒体 3特约通讯员
    public static final String[] regTos =
            {"理事","专家","媒体","特约通讯员"};
    public static final String zs[] =
            {"单位","住宅"};
    public static final String is[] =
            {"个人邮箱","传真"};
    public static final String res[] =
            {"date","com","job"};
    private boolean exists;

    public ProfileZh(String member) throws SQLException
    {
        this.member = member;
        load();
    }

    public ProfileZh(String member,String name,String nationnal,String nactive,String bplace,
                     String political,String card,String photo,String faddr,String zip,String homephone,
                     String web,String comname,String job,String comphone,String fax,String comaddr,
                     String comzip,String otherjob,String cper,String cjob,String cphone,
                     String cfax,String zipsend,String infosend,String resume,int isopen,int regbuffer,int regstyle) throws SQLException
    {
        this.member = member;
        this.name = name;
        this.nationnal = nationnal;
        this.nactive = nactive;
        this.bplace = bplace;
        this.political = political;
        this.card = card;
        this.photo = photo;
        this.faddr = faddr;
        this.zip = zip;
        this.homephone = homephone;
        this.web = web;
        this.comname = comname;
        this.job = job;
        this.comphone = comphone;
        this.fax = fax;
        this.comaddr = comaddr;
        this.comzip = comzip;
        this.otherjob = otherjob;
        this.cper = cper;
        this.cjob = cjob;
        this.cphone = cphone;
        this.cfax = cfax;
        this.zipsend = zipsend;
        this.infosend = infosend;
        this.resume = resume;
        this.isopen = isopen;
        this.regbuffer = regbuffer;
        this.exists = true;
        this.regstyle = regstyle;
        _cache.clear();
    }

    public static ProfileZh find(String member) throws SQLException
    {
//        ProfileZh obj = (ProfileZh) _cache.get(member);
//        if(obj == null)
//        {
//            obj = new ProfileZh(member);
//            _cache.put(member,obj);
//        }
        return new ProfileZh(member);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select member,name,nationnal,bplace,political,card,photo,faddr,homephone,web,comname,job,comphone,fax,comaddr,comzip,otherjob,cper,cjob,cphone,cfax,zipsend,infosend,resume,nactive,zip,isopen,regbuffer,regstyle from ProfileZh where member=" + db.cite(member));
            if(db.next())
            {
                member = db.getString(1);
                name = db.getString(2);
                nationnal = db.getString(3);
                bplace = db.getString(4);
                political = db.getString(5);
                card = db.getString(6);
                photo = db.getString(7);
                faddr = db.getString(8);
                homephone = db.getString(9);
                web = db.getString(10);
                comname = db.getString(11);
                job = db.getString(12);
                comphone = db.getString(13);
                fax = db.getString(14);
                comaddr = db.getString(15);
                comzip = db.getString(16);
                otherjob = db.getString(17);
                cper = db.getString(18);
                cjob = db.getString(19);
                cphone = db.getString(20);
                cfax = db.getString(21);
                zipsend = db.getString(22);
                infosend = db.getString(23);
                resume = db.getString(24);
                nactive = db.getString(25);
                zip = db.getString(26);
                isopen = db.getInt(27);
                regbuffer = db.getInt(28);
                regstyle = db.getInt(29);
                exists = true;
                _cache.clear();
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String member,String password,String community,String email,String mobile,boolean sex,String birth) throws SQLException
    {

        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("INSERT INTO Profile(member,password,community,email,time,mobile,sex,birth)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(password) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(email) + "," + db.citeCurTime() + ", " + db.cite(mobile) + ", " + db.cite(sex) + ", " + db.cite(birth) + ")");
        } finally
        {
            db.close();
        }
    }


    public static void create(String member,String name,String nationnal,String nactive,String bplace,
                              String political,String card,String photo,String faddr,String zip,String homephone,
                              String web,String comname,String job,String comphone,String fax,String comaddr,
                              String comzip,String otherjob,String cper,String cjob,String cphone,
                              String cfax,String zipsend,String infosend,String resume,int isopen,int regstyle) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Insert into ProfileZh(member,name,nationnal,nactive,bplace,political,card,photo,faddr,zip,homephone,web,comname,job,comphone,fax,comaddr,comzip,otherjob,cper,cjob,cphone,cfax,zipsend,infosend,resume,isopen,regbuffer,regstyle) values(" + db.cite(member) + "," + db.cite(name) + "," + db.cite(nationnal) + "," + db.cite(nactive) + ", " + db.cite(bplace) + "," + db.cite(political) + "," + db.cite(card) + "," + db.cite(photo) + "," + db.cite(faddr) + "," + db.cite(zip) + "," + db.cite(homephone) + "," + db.cite(web) + "," + db.cite(comname) + "," + db.cite(job) + "," + db.cite(comphone) + "," + db.cite(fax) + "," + db.cite(comaddr) + "," + db.cite(comzip) + "," + db.cite(otherjob) + "," + db.cite(cper) + "," + db.cite(cjob) + "," + db.cite(cphone) + "," +
                             db.cite(cfax) + "," + db.cite(zipsend) + "," + db.cite(infosend) + "," + db.cite(resume) + "," + isopen + ",0," + regstyle + ")");
            _cache.clear();
        } finally
        {
            db.close();
        }
    }


    public static void set(String member,String name,String nationnal,String nactive,String bplace,
                           String political,String card,String photo,String faddr,String zip,String homephone,
                           String web,String comname,String job,String comphone,String fax,String comaddr,
                           String comzip,String otherjob,String cper,String cjob,String cphone,
                           String cfax,String zipsend,String infosend,String resume,int isopen) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ProfileZh set name=" + db.cite(name) + ",nationnal=" + db.cite(nationnal) + ",nactive=" + db.cite(nactive) + ", bplace=" + db.cite(bplace) + ",political=" + db.cite(political) + ",card=" + db.cite(card) + ",photo=" + db.cite(photo) + ",faddr=" + db.cite(faddr) + ",zip=" + db.cite(zip) + ",homephone=" + db.cite(homephone) + ",web=" + db.cite(web) + ",comname=" + db.cite(comname) + ",job=" + db.cite(job) + ",comphone=" + db.cite(comphone) + ",fax=" + db.cite(fax) + ",comaddr=" + db.cite(comaddr) + ",comzip=" + db.cite(comzip) + ",otherjob=" + db.cite(otherjob) + ",cper=" + db.cite(cper) + ",cjob=" + db.cite(cjob) + ",cphone=" + db.cite(cphone) + ",cfax=" + db.cite(cfax) + ",zipsend=" + db.cite(zipsend) + ",infosend=" + db.cite(infosend) + ",resume=" +
                             db.cite(resume) + ", isopen=" + isopen + " where member=" + db.cite(member));
            _cache.clear();
        } finally
        {
            db.close();
        }
    }

    public static void set(String member,int regstyle) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ProfileZh set regstyle=" + regstyle + " where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
    }


    public static void setRegBuffer(String member,int regbuffer) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ProfileZh set regbuffer=" + regbuffer + " where member=" + db.cite(member));
            _cache.clear();
        } finally
        {
            db.close();
        }
    }

    public static void delAccess(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from accessmember where member=" + db.cite(member));
        } catch(SQLException e)
        {
            e.getMessage();
        } finally
        {
            db.close();
        }
    }

    public static void setAccess(String member,int regstyle) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update accessmember set node=" + regstyle + " where member=" + db.cite(member));
        } catch(SQLException e)
        {
            e.getMessage();
        } finally
        {
            db.close();
        }
    }


    public static int findId(String member) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select member from ProfileZh where member=" + db.cite(member));
            while(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;

    }

    public static void delete(String member) throws SQLException
    {

        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("delete from profile where member=" + db.cite(member));
            db.executeUpdate("delete from profilezh where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
    }


    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT member FROM Profile WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT count(*) FROM Profile WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static boolean isExisted(String member) throws SQLException
    {
        boolean flag = false;

        StringBuilder sb = new StringBuilder();
        sb.append("SELECT member FROM Profile WHERE member=").append(DbAdapter.cite(member));
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            flag = db.next();
        } finally
        {
            db.close();
        }

        return flag;
    }

    public static boolean AisExisted(String member) throws SQLException
    {
        boolean flag = false;

        StringBuilder sb = new StringBuilder();
        sb.append("SELECT member FROM accessmember WHERE member=").append(DbAdapter.cite(member));
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            flag = db.next();
        } finally
        {
            db.close();
        }

        return flag;
    }


    public boolean isExists()
    {
        return exists;
    }

    public String getZipsend()
    {
        if(zipsend == null)
        {
            return "";
        }
        return zipsend;
    }

    public String getWeb()
    {
        return web;
    }

    public String getResume()
    {
        return resume;
    }

    public String getPolitical()
    {
        return political;
    }

    public String getPhoto()
    {
        return photo;
    }

    public String getOtherjob()
    {
        return otherjob;
    }

    public String getNationnal()
    {
        return nationnal;
    }

    public String getName()
    {
        return name;
    }

    public String getMember()
    {
        return member;
    }

    public String getJob()
    {
        return job;
    }

    public String getInfosend()
    {
        if(infosend == null)
        {
            return "";
        }
        return infosend;
    }

    public String getHomephone()
    {
        return homephone;
    }

    public String getFax()
    {
        return fax;
    }

    public String getFaddr()
    {
        return faddr;
    }

    public String getCphone()
    {
        return cphone;
    }

    public String getCper()
    {
        return cper;
    }

    public String getComzip()
    {
        return comzip;
    }

    public String getComphone()
    {
        return comphone;
    }

    public String getComname()
    {
        return comname;
    }

    public String getComaddr()
    {
        return comaddr;
    }

    public String getCjob()
    {
        return cjob;
    }

    public String getZsToHtml()
    {
        if(zipsend.length() == 1)
        {
            return "";
        }
        String h = null;
        if(zipsend.contains("0") && !zipsend.contains("1"))
        {
            h = zs[0];
        } else if(zipsend.contains("1") && !zipsend.contains("0"))
        {
            h = zs[1];
        } else
        {
            h = zs[0] + "  " + zs[1];
        }
        return h;

    }

    public String getIsToHtml()
    {
        if(infosend.length() == 1)
        {
            return "";
        }
        String h = null;
        if(infosend.contains("0") && !infosend.contains("1"))
        {
            h = is[0];
        } else if(infosend.contains("1") && !infosend.contains("0"))
        {
            h = is[1];
        } else
        {
            h = is[0] + "  " + is[1];
        }
        return h;

    }

    public String getRegToHtml()
    {
        String reg = "";
        reg = regTos[regstyle];
        return reg;

    }


    public String getCfax()
    {
        return cfax;
    }

    public String getCard()
    {
        return card;
    }

    public String getBplace()
    {
        return bplace;
    }

    public String getNactive()
    {
        return nactive;
    }

    public String getZip()
    {
        return zip;
    }

    public int getIsopen()
    {
        return isopen;
    }

    public int getRegbuffer()
    {
        return regbuffer;
    }

    public int getRegstyle()
    {
        return regstyle;
    }

}
