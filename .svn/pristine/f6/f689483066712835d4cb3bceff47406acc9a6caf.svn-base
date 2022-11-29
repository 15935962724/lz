package tea.entity.admin;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import java.math.BigDecimal;

public class Laborage extends Entity
{
    private int laborage; //主键ID
    private Date changetime; //转账日期
    private String labname; //姓名
    private String card; //身份证号
    private int branch; //部门
    private int role; //人员类型
    private int bank; //银行
    private String bankaccounts; //帐号
    private int months; //出勤月数
    private int days; //出勤天数
    private BigDecimal basiclab; //基本工资
    private BigDecimal dropheat; //降暑费
    private BigDecimal mess; //伙食补贴
    private BigDecimal rests; //其他
    private BigDecimal shouldlab; //应发工资
    private BigDecimal actuary; //保险基数
    private BigDecimal provide; //基本养老保险
    private BigDecimal medical; //基本医疗保险
    private BigDecimal idleness; //失业金
    private BigDecimal accumulation; //公积金基数
    private BigDecimal housingacc; //住房公积金
    private BigDecimal supplyprovidebase; ////补充养老保险基数
    private int service; //工龄
    private BigDecimal supplyprovide; //补充养老保险
    private BigDecimal supplymedical; //补充医疗保险
    private BigDecimal agiobase; //扣税基数
    private BigDecimal labor; //劳保
    private float cess; //税率
    private BigDecimal eraagio; ////代扣税
    private BigDecimal bucklefund; //扣款合计
    private BigDecimal factlab; //实发工资(元)：
    private String content; //备注
    private int iftype; //是否设为工资模板
    private String cyclostylename; //模板名称
    private String member; //添加人
    private String community; //社区
    private Date times; //添加时间

    public static final String BANK_TYPE[] =
                                             {"------","建设银行","农业银行","招商银行","工商银行"};
    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Laborage(int laborage) throws SQLException
    {
        this.laborage = laborage;
        load();
    }

    public static Laborage find(int laborage) throws SQLException
    {
        Laborage obj = (Laborage) _cache.get(new Integer(laborage));
        if(obj == null)
        {
            obj = new Laborage(laborage);
            _cache.put(new Integer(laborage),obj);
        }
        return obj;
    }


    public static void create(Date changetime,String labname,String card,int branch,int role,int bank,String bankaccounts,int months,int days,BigDecimal basiclab,BigDecimal dropheat,BigDecimal mess,BigDecimal rests,BigDecimal shouldlab,BigDecimal actuary,BigDecimal provide,BigDecimal medical,BigDecimal idleness,BigDecimal accumulation,BigDecimal housingacc,BigDecimal supplyprovidebase,int service,BigDecimal supplyprovide,BigDecimal supplymedical,BigDecimal agiobase,BigDecimal labor,float cess,BigDecimal eraagio,BigDecimal bucklefund,BigDecimal factlab,String content,int iftype,String cyclostylename,String member,String community) throws SQLException
    {
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Laborage(changetime,labname,card,branch,role,bank,bankaccounts,months,days,basiclab,dropheat,mess,rests,shouldlab,actuary,provide,medical,idleness,accumulation,housingacc,supplyprovidebase,service,supplyprovide,supplymedical,agiobase,labor,cess,eraagio,bucklefund,factlab,content,iftype,cyclostylename,member,community,times)VALUES(" + DbAdapter.cite(changetime) + "," + DbAdapter.cite(labname) + "," + DbAdapter.cite(card) + "," + branch + "," + role + "," + bank + "," + DbAdapter.cite(bankaccounts) + "," + months + "," + days + "," + (basiclab) + "," + dropheat + "," + mess + "," + rests + "," + shouldlab + "," + actuary + "," + provide + "," + medical + "," + idleness + "," + accumulation + "," + housingacc + "," + supplyprovidebase + "," + service +
                             "," + supplyprovide + "," +
                             supplymedical + "," + agiobase + "," + labor + "," + cess + "," + eraagio + "," + bucklefund + "," + factlab + "," + DbAdapter.cite(content) + "," + iftype + "," + DbAdapter.cite(cyclostylename) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(times) + " )");
        } finally
        {
            db.close();
        }
    }


    public void set(Date changetime,String labname,String card,int branch,int role,int bank,String bankaccounts,int months,int days,BigDecimal basiclab,BigDecimal dropheat,BigDecimal mess,BigDecimal rests,BigDecimal shouldlab,BigDecimal actuary,BigDecimal provide,BigDecimal medical,BigDecimal idleness,BigDecimal accumulation,BigDecimal housingacc,BigDecimal supplyprovidebase,int service,BigDecimal supplyprovide,BigDecimal supplymedical,BigDecimal agiobase,BigDecimal labor,float cess,BigDecimal eraagio,BigDecimal bucklefund,BigDecimal factlab,String content,int iftype,String cyclostylename,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Laborage SET changetime=" + DbAdapter.cite(changetime) + ",labname=" + DbAdapter.cite(labname) + ",card=" + DbAdapter.cite(card) + ",branch=" + branch + ",role=" + role + ",bank=" + bank + " ,bankaccounts=" + DbAdapter.cite(bankaccounts) + ",months=" + months + ",days=" + days + ",basiclab=" + basiclab + ",dropheat=" + dropheat + ",mess=" + mess + ",rests=" + rests + ",shouldlab=" + shouldlab + ",actuary=" + actuary + ",provide=" + provide + ",medical=" + medical + ",idleness=" + idleness + ",accumulation=" + accumulation + ",housingacc=" + housingacc + ",supplyprovidebase=" + supplyprovidebase + ",service=" + service + ",supplyprovide=" + supplyprovide + ",supplymedical=" + supplymedical + ",agiobase=" + agiobase + ",labor=" + labor + ",cess=" + cess +
                             ",eraagio=" + eraagio + ",bucklefund=" + bucklefund + ",factlab=" + factlab + ",content=" + DbAdapter.cite(content) + ",iftype=" + iftype + ",cyclostylename=" + DbAdapter.cite(cyclostylename) + ",member=" + DbAdapter.cite(member) + "  WHERE laborage=" + laborage);
        } finally
        {
            db.close();
        }
        this.changetime = changetime;
        this.labname = labname;
        this.card = card;
        this.branch = branch;
        this.role = role;
        this.bank = bank;
        this.bankaccounts = bankaccounts;
        this.months = months;
        this.days = days;
        this.basiclab = basiclab;
        this.dropheat = dropheat;
        this.mess = mess;
        this.rests = rests;
        this.shouldlab = shouldlab;
        this.actuary = actuary;
        this.provide = provide;
        this.medical = medical;
        this.idleness = idleness;
        this.accumulation = accumulation;
        this.housingacc = housingacc;
        this.supplyprovidebase = supplyprovidebase;
        this.service = service;
        this.supplyprovide = supplyprovide;
        this.supplymedical = supplymedical;
        this.agiobase = agiobase;
        this.labor = labor;
        this.cess = cess;
        this.eraagio = eraagio;
        this.bucklefund = bucklefund;
        this.factlab = factlab;
        this.content = content;
        this.iftype = iftype;
        this.cyclostylename = cyclostylename;
        this.member = member;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Laborage WHERE laborage=" + laborage);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(laborage));
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Laborage WHERE community=" + DbAdapter.cite(community) + sql);
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

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT laborage FROM Laborage WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT changetime,labname,card,branch,role,bank,bankaccounts,months,days,basiclab,dropheat,mess,rests,shouldlab,actuary,provide,medical,idleness,accumulation,housingacc,supplyprovidebase,service,supplyprovide,supplymedical,agiobase,labor,cess,eraagio,bucklefund,factlab,content,iftype,cyclostylename,member,community,times FROM  Laborage WHERE laborage=" + laborage);
            if(db.next())
            {

                changetime = db.getDate(1);
                labname = db.getString(2);
                card = db.getString(3);
                branch = db.getInt(4);
                role = db.getInt(5);
                bank = db.getInt(6);
                bankaccounts = db.getString(7);
                months = db.getInt(8);
                days = db.getInt(9);
                basiclab = db.getBigDecimal(10,2);
                dropheat = db.getBigDecimal(11,2);
                mess = db.getBigDecimal(12,2);
                rests = db.getBigDecimal(13,2);
                shouldlab = db.getBigDecimal(14,2);
                actuary = db.getBigDecimal(15,2);
                provide = db.getBigDecimal(16,2);
                medical = db.getBigDecimal(17,2);
                idleness = db.getBigDecimal(18,2);
                accumulation = db.getBigDecimal(19,2);
                housingacc = db.getBigDecimal(20,2);
                supplyprovidebase = db.getBigDecimal(21,2);
                service = db.getInt(22);
                supplyprovide = db.getBigDecimal(23,2);
                supplymedical = db.getBigDecimal(24,2);
                agiobase = db.getBigDecimal(25,2);
                labor = db.getBigDecimal(26,2);
                cess = db.getFloat(27);
                eraagio = db.getBigDecimal(28,2);
                bucklefund = db.getBigDecimal(29,2);
                factlab = db.getBigDecimal(30,2);
                content = db.getString(31);
                iftype = db.getInt(32);
                cyclostylename = db.getString(33);
                member = db.getString(34);
                community = db.getString(35);
                times = db.getDate(36);

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

    public static String getDateToString() throws SQLException
    {
        Date dd = new Date();
        return sdf.format(dd);
    }

    public BigDecimal getAccumulation()
    {
        return accumulation;
    }

    public BigDecimal getActuary()
    {
        return actuary;
    }

    public BigDecimal getAgiobase()
    {
        return agiobase;
    }

    public int getBank()
    {
        return bank;
    }

    public String getBankaccounts()
    {
        return bankaccounts;
    }

    public BigDecimal getBasiclab()
    {
        return basiclab;
    }

    public int getBranch()
    {
        return branch;
    }

    public BigDecimal getBucklefund()
    {
        return bucklefund;
    }

    public String getCard()
    {
        return card;
    }

    public float getCess()
    {
        return cess;
    }

    public Date getChangetime()
    {
        return changetime;
    }

    public String getChangetimeToString()
    {
        if(changetime == null)
        {
            return "";
        }
        return sdf.format(changetime);
    }

    public String getCommunity()
    {
        return community;
    }

    public String getContent()
    {
        return content;
    }

    public String getCyclostylename()
    {
        return cyclostylename;
    }

    public int getDays()
    {
        return days;
    }

    public BigDecimal getDropheat()
    {
        return dropheat;
    }

    public BigDecimal getEraagio()
    {
        return eraagio;
    }

    public BigDecimal getFactlab()
    {
        return factlab;
    }

    public BigDecimal getHousingacc()
    {
        return housingacc;
    }

    public BigDecimal getIdleness()
    {
        return idleness;
    }

    public int getIftype()
    {
        return iftype;
    }

    public String getLabname()
    {
        return labname;
    }

    public int getLaborage()
    {
        return laborage;
    }

    public BigDecimal getMedical()
    {
        return medical;
    }

    public String getMember()
    {
        return member;
    }

    public BigDecimal getMess()
    {
        return mess;
    }

    public int getMonths()
    {
        return months;
    }

    public BigDecimal getProvide()
    {
        return provide;
    }

    public BigDecimal getRests()
    {
        return rests;
    }

    public int getRole()
    {
        return role;
    }

    public int getService()
    {
        return service;
    }

    public BigDecimal getShouldlab()
    {
        return shouldlab;
    }

    public BigDecimal getSupplymedical()
    {
        return supplymedical;
    }

    public BigDecimal getSupplyprovide()
    {
        return supplyprovide;
    }

    public BigDecimal getSupplyprovidebase()
    {
        return supplyprovidebase;
    }

    public Date getTimes()
    {
        return times;
    }

    public BigDecimal getLabor()
    {
        return labor;
    }
}
