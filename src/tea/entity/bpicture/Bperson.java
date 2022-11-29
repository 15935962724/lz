package tea.entity.bpicture;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

public class Bperson extends Entity
{
    private int id;
    private String name;
    private int sex; //1：男  0：女
    private String member;
    private String email;
    private String password;
    private String jobstyle;
    private String comstyle;
    private String comname;
    private String web;
    private String city;
    private String state;
    private String addr;
    private String zip;
    private String mobile;
    private String phone;
    private int terms; //BP协议
    private int regstyle; //注册类型 0：卖家  1：买家
    private String chequePayee;
    private int chequeTerms; //贡献者协议
    private String chequeCity;
    private String chequeCounty;
    private String chequeaddr;
    private String chequeZip;
    private String otherAgencies;
    private String represent;
    private String currentlightbox;
    private int payStyle; //0-支票；1-转帐
    private String card; //身份证复印件或军官证复印件
    private String testpic; //上传测试样图
    private int auditsaler; //1:通过 0：拒绝
    private int typestatic; // 0 正常   1 注销  唐嗣达 2009年1月21日13:56:20
    private int moneytype; // 1人民币 2美元 3英镑 4欧元 5其他
    private String meteria;
    private String vector;
    private int phyear;
    private String MSN;
    private int addvalue; //UK增值税
    private int mailto; //邮件  ： 新闻  活动
    private String account; //银行帐户
    private String bank; //开户行
    private int accountnum; //帐号
    private String invmen; //发票收件人
    private String invaddr; //发票地址
    private String invzip; //发票邮编
    private String invcomname; //发票公司
    private boolean exists;

    public Bperson(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public Bperson(int id,String name,int sex,String member,String email,String password,String jobstyle,String comstyle,String comname,String web,String city,String state,String addr,String zip,
                   String mobile,String phone,int terms,int regstyle,String chequePayee,int chequeTerms,String chequeCity,String chequeCounty,String chequeaddr,String chequeZip,String otherAgencies,String represent,String currentlightbox,int payStyle,String card,String testpic,int auditsaler,int typestatic,int moneytype,String meteria,String vector,int phyear,String MSN,int addvalue,int mailto,String account,String bank,int accountnum,String invmen,String invaddr,String invzip,String invcomname) throws SQLException
    {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.member = member;
        this.email = email;
        this.password = password;
        this.jobstyle = jobstyle;
        this.comstyle = comstyle;
        this.comname = comname;
        this.web = web;
        this.city = city;
        this.state = state;
        this.addr = addr;
        this.zip = zip;
        this.mobile = mobile;
        this.phone = phone;
        this.terms = terms;
        this.regstyle = regstyle;
        this.chequePayee = chequePayee;
        this.chequeTerms = chequeTerms;
        this.chequeCity = chequeCity;
        this.chequeCounty = chequeCounty;
        this.chequeaddr = chequeaddr;
        this.chequeZip = chequeZip;
        this.otherAgencies = otherAgencies;
        this.represent = represent;
        this.currentlightbox = currentlightbox;
        this.payStyle = payStyle;
        this.card = card;
        this.testpic = testpic;
        this.auditsaler = auditsaler;
        this.typestatic = typestatic;
        this.moneytype = moneytype;
        this.meteria = meteria;
        this.vector = vector;
        this.phyear = phyear;
        this.MSN = MSN;
        this.addvalue = addvalue;
        this.mailto = mailto;
        this.account = account;
        this.bank = bank;
        this.accountnum = accountnum;
        this.invmen = invmen;
        this.invaddr = invaddr;
        this.invzip = invzip;
        this.invcomname = invcomname;
        this.exists = true;

    }

    public static Bperson find(int id) throws SQLException
    {
//        Bperson obj = (Bperson) _cache.get(id);
//        if(obj == null)
//        {
//            obj = new Bperson(id);
//            _cache.put(id,obj);
//        }
        return new Bperson(id);
    }

    public static Bperson findmember(String member) throws SQLException
    {
        return new Bperson(member);
    }

    public Bperson(String member) throws SQLException
    {
        this.member = member;
        loadmember();
    }

    public void loadmember() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,name,sex,member,email,password,jobstyle,comstyle,comname,web,city,state,addr,zip,mobile,phone,terms,regstyle,chequepayee,chequeterms,chequecity,chequecounty,chequeaddr,chequezip,otheragencies,represent,currentlightbox,paystyle,card,testpic,auditsaler,typestatic,moneytype,meteria,vector,phyear,msn,addvalue,mailto,account,bank,accountnum,invmen,invaddr,invzip,invcomname from Bperson where member=" + db.cite(member));
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                name = db.getString(j++);
                sex = db.getInt(j++);
                member = db.getString(j++);
                email = db.getString(j++);
                password = db.getString(j++);
                jobstyle = db.getString(j++);
                comstyle = db.getString(j++);
                comname = db.getString(j++);
                web = db.getString(j++);
                city = db.getString(j++);
                state = db.getString(j++);
                addr = db.getString(j++);
                zip = db.getString(j++);
                mobile = db.getString(j++);
                phone = db.getString(j++);
                terms = db.getInt(j++);
                regstyle = db.getInt(j++);
                chequePayee = db.getString(j++);
                chequeTerms = db.getInt(j++);
                chequeCity = db.getString(j++);
                chequeCounty = db.getString(j++);
                chequeaddr = db.getString(j++);
                chequeZip = db.getString(j++);
                otherAgencies = db.getString(j++);
                represent = db.getString(j++);
                currentlightbox = db.getString(j++);
                payStyle = db.getInt(j++);
                card = db.getString(j++);
                testpic = db.getString(j++);
                auditsaler = db.getInt(j++);
                typestatic = db.getByte(j++);
                moneytype = db.getInt(j++);
                meteria = db.getString(j++);
                vector = db.getString(j++);
                phyear = db.getInt(j++);
                MSN = db.getString(j++);
                addvalue = db.getInt(j++);
                mailto = db.getInt(j++);
                account = db.getString(j++);
                bank = db.getString(j++);
                accountnum = db.getInt(j++);
                invmen = db.getString(j++);
                invaddr = db.getString(j++);
                invzip = db.getString(j++);
                invcomname = db.getString(j++);
                exists = true;

            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,name,sex,member,email,password,jobstyle,comstyle,comname,web,city,state,addr,zip,mobile,phone,terms,regstyle,chequepayee,chequeterms,chequecity,chequecounty,chequeaddr,chequezip,otheragencies,represent,currentlightbox,paystyle,card,testpic,auditsaler,typestatic,moneytype,meteria,vector,phyear,msn,addvalue,mailto from Bperson where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                name = db.getString(j++);
                sex = db.getInt(j++);
                member = db.getString(j++);
                email = db.getString(j++);
                password = db.getString(j++);
                jobstyle = db.getString(j++);
                comstyle = db.getString(j++);
                comname = db.getString(j++);
                web = db.getString(j++);
                city = db.getString(j++);
                state = db.getString(j++);
                addr = db.getString(j++);
                zip = db.getString(j++);
                mobile = db.getString(j++);
                phone = db.getString(j++);
                terms = db.getInt(j++);
                regstyle = db.getInt(j++);
                chequePayee = db.getString(j++);
                chequeTerms = db.getInt(j++);
                chequeCity = db.getString(j++);
                chequeCounty = db.getString(j++);
                chequeaddr = db.getString(j++);
                chequeZip = db.getString(j++);
                otherAgencies = db.getString(j++);
                represent = db.getString(j++);
                currentlightbox = db.getString(j++);
                payStyle = db.getInt(j++);
                card = db.getString(j++);
                testpic = db.getString(j++);
                auditsaler = db.getInt(j++);
                typestatic = db.getByte(j++);
                moneytype = db.getInt(j++);
                meteria = db.getString(j++);
                vector = db.getString(j++);
                phyear = db.getInt(j++);
                MSN = db.getString(j++);
                addvalue = db.getInt(j++);
                mailto = db.getInt(j++);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findByCommunity(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT id FROM bperson WHERE 1=1" + sql,pos,size);
            while(db.next())
            {

                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByCommunitymember(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT member FROM bperson WHERE 1=1" + sql,pos,size);
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

    public static void upAudit(int id,int au) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update bperson set auditsaler=" + au + " where id=" + id);
        } finally
        {
            db.close();
        }

    }

    public static int count(String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  count(id) FROM bperson WHERE 1=1" + sql);
            while(db.next())
            {
                i = db.getInt(1);
            }

        } finally
        {
            db.close();
        }
        return i;
    }

    public static void createBuy(String name,String ename,int sex,String member,String email,String password,String MSN,String mobile,String phone,int terms,int regstyle,int mailto) throws SQLException
    {
        if(!Profile.isExisted(member))
        {
            String pwd = password;
            Profile.create(member,pwd,"bigpic",email,null);
            Profile p = Profile.find(member);
            p.setFirstName(name,1);
            p.setLastName(ename,1);
            p.setMobile(mobile);
            boolean sx;
            sx = sex != 0;
            p.setSex(sx);

            java.util.Date d = new java.util.Date();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("Insert into Bperson(name,sex,member,email,MSN,password,mobile,phone,terms,regstyle,mailto,currentlightbox,represent) values(" + db.cite(name) + "," + sex + "," + db.cite(member) + "," + db.cite(email) + "," + db.cite(MSN) + "," + db.cite(password) + "," + db.cite(mobile) + "," + db.cite(phone) + "," + terms + "," + regstyle + "," + mailto + ",'我的收藏','1')");
				for(int i = 1; i <4; i ++){
                    db.executeUpdate("insert into lightbox(name,bpid,picid,createtime,accesstime) values('我的收藏夹"+i+"'," + db.cite(member) + ",',', " + db.cite(d) + ", " + db.cite(d) + ")");
                }
            } finally
            {
                db.close();
            }
        }
    }


    public static void create(String name,int sex,String member,String email,String password,String MSN,String comstyle,String comname,String city,String state,String addr,String zip,
                              String mobile,String phone,int terms,int regstyle,int photoyear,String meteria,String vector,int mailto) throws SQLException
    {
        if(!Profile.isExisted(member))
        {
            String pwd = password;
            Profile.create(member,pwd,"bigpic",email,null);
            Profile p = Profile.find(member);
            p.setFirstName(name,1);
            p.setMobile(mobile);
            p.setZip(zip,1);
            p.setProvince(Integer.parseInt(state),1);

            java.util.Date d = new java.util.Date();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("Insert into Bperson(name,sex,member,email,MSN,password,comstyle,comname,city,state,addr,zip,mobile,phone,terms,regstyle,mailto,currentlightbox) values(" + db.cite(name) + "," + sex + "," + db.cite(member) + "," + db.cite(email) + "," + db.cite(MSN) + "," + db.cite(password) + "," + db.cite(comstyle) + "," + db.cite(comname) + "," + db.cite(city) + "," + db.cite(state) + "," + db.cite(addr) + "," + db.cite(zip) + "," + db.cite(mobile) + "," + db.cite(phone) + "," + terms + "," + regstyle + "," + mailto + ",'我的收藏')");
                if(regstyle == 0)
                {
                    db.executeUpdate("update bperson set meteria=" + db.cite(meteria) + ", phyear=" + photoyear + ", vector=" + db.cite(vector) + " where member=" + db.cite(member));
                }
                db.executeUpdate("insert into lightbox(name,bpid,picid,createtime,accesstime) values('我的收藏'," + db.cite(member) + ",',', " + db.cite(d) + ", " + db.cite(d) + ")");

            } finally
            {
                db.close();
            }
        }
    }

    public static String fingCL(String member) throws SQLException
    {
        String a = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select currentlightbox from bperson where member=" + db.cite(member));
            while(db.next())
            {
                a = db.getString(1);

            }
        } finally
        {
            db.close();
        }
        return a;

    }

    public static void set(String member,String addr,String city,String state,String zip,String comname,String comstyle,int regstyle,String represent,String card,String testpic,int photoyears,String vectors,String meterias) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Bperson set addr=" + db.cite(addr) + ", city=" + db.cite(city) + ",state=" + db.cite(state) + ",zip=" + db.cite(zip) + ",comname=" + db.cite(comname) + ",comstyle=" + db.cite(comstyle) + ",regstyle=" + regstyle + ",represent=" + db.cite(represent) + ",card=" + db.cite(card) + ",testpic=" + db.cite(testpic) + ",phyear=" + photoyears + ",meteria=" + db.cite(meterias) + ",vector=" + db.cite(vectors) + " where member=" + db.cite(member));

        } finally
        {
            db.close();
        }
    }


    public static void set(String member,String chequePayee,String chequeCity,String chequeCounty,String chequeaddr,String chequeZip,int payStyle,String invmen,String invaddr,String invzip,String invcomname,String account,String bank,int accountnum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Bperson set chequepayee=" + db.cite(chequePayee) + ",chequecity=" + db.cite(chequeCity) + ",chequecounty=" + db.cite(chequeCounty) + ",chequeaddr=" + db.cite(chequeaddr) + ",chequezip=" + db.cite(chequeZip) + ",paystyle=" + payStyle + ",invmen=" + db.cite(invmen) + ",invaddr=" + db.cite(invaddr) + ",invzip=" + db.cite(invzip) + ",invcomname=" + db.cite(invcomname) + ",account=" + db.cite(account) + ",bank=" + db.cite(bank) + ",accountnum=" + accountnum + " where member=" + db.cite(member));

        } finally
        {
            db.close();
        }
    }


    public static void setCurrn(String member,String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update bperson set currentlightbox=" + db.cite(name) + " where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
    }

    public static void create(String member,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into bprice values(" + db.cite(member) + ", " + db.cite(community) + ")");
        } finally
        {
            db.close();
        }
    }


    public static void set(String member,String name,String ename,int sex) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(Profile.isExisted(member))
            {
                Profile p = Profile.find(member);
                p.setSex(sex != 0);
                p.setFirstName(name,1);
                p.setLastName(ename,1);
            }

            db.executeUpdate("Update Bperson set name=" + db.cite(name) + ", sex=" + sex + " where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
    }

    public static void set(String member,String addr,String city,String state,String zip,String comname,String comstyle,int regstyle,String represent,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Bperson set addr=" + db.cite(addr) + ", city=" + db.cite(city) + ",state=" + db.cite(state) + ",zip=" + db.cite(zip) + ",comname=" + db.cite(comname) + ",comstyle=" + db.cite(comstyle) + ",regstyle=" + regstyle + ",represent=" + db.cite(represent) + sql + " where member=" + db.cite(member));

        } finally
        {
            db.close();
        }
    }

    //更改个人信息
    public static void setph(String member,String addr,String city,String state,String zip,String comname,String comstyle,int phyear,String vector,String meteria,String MSN,String mobile,String phone,String card,String testpic) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Bperson set addr=" + db.cite(addr) + ", city=" + db.cite(city) + ",state=" + db.cite(state) + ",zip=" + db.cite(zip) + ",comname=" + db.cite(comname) + ",comstyle=" + db.cite(comstyle) + ",phyear=" + phyear + ",meteria=" + db.cite(meteria) + ",vector=" + db.cite(vector) + ",MSN=" + db.cite(MSN) + ",mobile=" + db.cite(mobile) + ",phone=" + db.cite(phone) + ",card=" + db.cite(card) + ",testpic=" + db.cite(testpic) + " where member=" + db.cite(member));

        } finally
        {
            db.close();
        }
    }


    public static void set(String member,String password) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Bperson set password=" + db.cite(password) + " where member=" + db.cite(member));

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
            db.executeQuery("select id from bperson where member=" + db.cite(member));
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

    public static boolean isExisted(String member) throws SQLException
    {
        boolean flag = false;

        StringBuilder sb = new StringBuilder();
        sb.append("SELECT member FROM bperson WHERE member=").append(DbAdapter.cite(member));
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


    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete Bperson  where id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static void delMember(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date deldate = new Date();
        try
        {
            db.executeUpdate("delete Bperson  where member=" + db.cite(member));
            db.executeUpdate("delete lightbox  where bpid=" + db.cite(member));
            db.executeUpdate("delete bimage  where member=" + db.cite(member));
            db.executeUpdate("delete profile  where member=" + db.cite(member));
            db.executeUpdate("delete profilelayer  where member=" + db.cite(member));
            db.executeUpdate("insert into bpdeltime values(" + db.cite(member) + "," + db.cite(deldate) + ")");
        } finally
        {
            db.close();
        }
    }

    public static Date delTime(String member) throws SQLException
    {
        Date deltime = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select deltime from bpdeltime where member=" + db.cite(member));
            while(db.next())
            {
                deltime = db.getDate(1);
            }
        } finally
        {
            db.close();
        }
        return deltime;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getId()
    {
        return id;
    }

    public String getName()
    {
        return name;
    }

    public int getSex()
    {
        return sex;
    }

    public String getEmail()
    {
        return email;
    }

    public String getPassword()
    {
        return password;
    }

    public String getJobStyle()
    {
        return jobstyle;
    }

    public String getComStyle()
    {
        return comstyle;
    }

    public String getComName()
    {
        return comname;
    }

    public String getWeb()
    {
        return web;
    }

    public String getCity()
    {
        return city;
    }

    public String getState()
    {
        return state;
    }

    public String getAddr()
    {
        return addr;
    }

    public String getZip()
    {
        return zip;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getPhone()
    {
        return phone;
    }

    public int getTerms()
    {
        return terms;
    }

    public int getRegStyle()
    {
        return regstyle;
    }

    public String getChequePayee()
    {
        return chequePayee;
    }

    public int getChequeTerms()
    {
        return chequeTerms;
    }

    public String getChequeCity()
    {
        return chequeCity;
    }

    public String getChequeCounty()
    {
        return chequeCounty;
    }

    public String getChequeAddr()
    {
        return chequeaddr;
    }

    public String getChequeZip()
    {
        return chequeZip;
    }

    public String getOtherAgencies()
    {
        return otherAgencies;
    }

    public String getRepresent()
    {
        return represent;
    }

    public String getCurrentlightbox()
    {
        return currentlightbox;
    }

    public int getPayStyle()
    {
        return payStyle;
    }

    public String getCard()
    {
        return card;
    }

    public int getAuditsaler()
    {
        return auditsaler;
    }

    public int getTypestatic()
    {
        return typestatic;
    }

    public String getMeteria()
    {
        return meteria;
    }

    public String getMember()
    {
        return member;
    }

    public int getMoneytype()
    {
        return moneytype;
    }

    public int getPhyear()
    {
        return phyear;
    }

    public String getVector()
    {
        return vector;
    }

    public int getMailto()
    {
        return mailto;
    }

    public int getAddvalue()
    {
        return addvalue;
    }

    public String getTestpic()
    {
        return testpic;
    }

    public int getAccountnum()
    {
        return accountnum;
    }

    public String getChequeaddr()
    {
        return chequeaddr;
    }

    public String getBank()
    {
        return bank;
    }

    public String getAccount()
    {
        return account;
    }

    public String getInvaddr()
    {
        return invaddr;
    }

    public String getInvcomname()
    {
        return invcomname;
    }

    public String getInvmen()
    {
        return invmen;
    }

    public String getInvzip()
    {
        return invzip;
    }

    public String getMSN()
    {
        return MSN;
    }


    public static void setTypestatic(String member,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Bperson set typestatic = " + type + "  where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
    }


}
