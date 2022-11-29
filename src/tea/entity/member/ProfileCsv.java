package tea.entity.member;

/********
 * 2007年11月12日.star.用于csv项目中
 * ?代表接手后不明确的字段
 *
 * **********************/

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.service.*;


public class ProfileCsv extends Entity
{

    private static Cache _cache = new Cache(100);
    private String community; //社区
    private String member; //会员id
    private java.util.Date term; // 有效期
    private int Csvjoinoutlayid; //参加费用
    private String phoneticize; // 姓名拼音
    private String inkfile; //墨水文件?
    private String bankinghouse; //应行业房子
    private String standbys; //可信赖的人?或备用?
    private String standbyhao; //备用号?
    private String pic; //图片
    private String membernumber; //会员编号
    private int membertype; // 对会员状态的标示
    private Date validate;
    private int linetype;
    private String[] name;
    private String[] lastName;
    private String[] firstName;
    private int memberfafangtype; ///会员发放状态
    private String memberfafangtime; ///会员证书发放时间
    private String introducer; //介绍人
    private int housefafangtype; //犬舍证书状态
    private String housefafangtime; //犬舍证书发放时间
    private String remark; //备注
    /**俱乐部主席、第一副主席、秘书长审核**/
    private int clubzhuxi; //俱乐部主席审核 状态，0 为 未通过，1通过
    private int firstzhuxi; //第一副主席
    private int mishuzhang; //秘书长审核

    /* 2008年2月26号***/
    private String membercode; //csv会员卡号
    //**2008-3-17 注册的同时进行邮箱验证***********///
    private int emailval;
    private boolean istext  = false;


    public static final String MEMBERTYPE[] =
            {"有效", "无效", "除名", "惩处", "注销", "开除"};
    public static final String FFTYPE[] =
            {"未邮寄", "已邮寄"};

    public static final String ZXTYPE[] =
            {"未审核", "未通过", "通过审核"};
    public static final String EMAILVAL[] =
                                            {"邮箱未审核", "邮箱未通过", "邮箱通过审核"};

    public ProfileCsv(String member) throws SQLException
    {
        this.member = member;
        load();
    }

    public static ProfileCsv find(String member) throws SQLException
    {
        return new ProfileCsv(member);
    }

    public static ProfileCsv find(String membercode, String str) throws SQLException
    {
        return new ProfileCsv(membercode, str);
    }

    public ProfileCsv(String membercode, String str) throws SQLException
    {
        this.membercode = membercode;
        loadcode();
    }


    private void loadcode() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community,member, term, Csvjoinoutlayid, phoneticize, inkfile, bankinghouse, standbys, standbyhao, pic, membernumber, membertype, validate,memberfafangtype,memberfafangtime,introducer,housefafangtype,housefafangtime,remark ,clubzhuxi ,firstzhuxi,mishuzhang,membercode,emailval FROM ProfileCsv WHERE membercode=" + DbAdapter.cite(membercode));
            if (db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                term = db.getDate(3);
                Csvjoinoutlayid = db.getInt(4);
                phoneticize = db.getString(5);
                inkfile = db.getString(6);
                bankinghouse = db.getString(7);
                standbys = db.getString(8);
                standbyhao = db.getString(9);
                pic = db.getString(10);
                membernumber = db.getString(11);
                membertype = db.getInt(12);
                validate = db.getDate(13);
                memberfafangtype = db.getInt(14); ///会员发放状态
                memberfafangtime = db.getString(15); ///会员证书发放时间
                introducer = db.getString(16); //介绍人
                housefafangtype = db.getInt(17); //犬舍证书状态
                housefafangtime = db.getString(18); //犬舍证书发放时间
                remark = db.getString(19);
                clubzhuxi = db.getInt(20);
                firstzhuxi = db.getInt(21);
                mishuzhang = db.getInt(22);
                membercode = db.getString(23);
                emailval = db.getInt(24);
                istext = true;

            } else
            {
            }
            if (phoneticize == null)
            {
                phoneticize = "";
            }
            if (inkfile == null)
            {
                inkfile = "";
            }
            if (bankinghouse == null)
            {
                bankinghouse = "";
            }
            if (standbys == null)
            {
                standbys = "";
            }
            if (standbyhao == null)
            {
                standbyhao = "";
            }
            if (pic == null)
            {
                pic = "";
            }
            if (membernumber == null)
            {
                membernumber = "";
            }
        } finally
        {
            db.close();
        }
    }



    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community,member, term, Csvjoinoutlayid, phoneticize, inkfile, bankinghouse, standbys, standbyhao, pic, membernumber, membertype, validate,memberfafangtype,memberfafangtime,introducer,housefafangtype,housefafangtime,remark ,clubzhuxi ,firstzhuxi,mishuzhang,membercode,emailval FROM ProfileCsv WHERE member=" + DbAdapter.cite(member));
            if (db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                term = db.getDate(3);
                Csvjoinoutlayid = db.getInt(4);
                phoneticize = db.getString(5);
                inkfile = db.getString(6);
                bankinghouse = db.getString(7);
                standbys = db.getString(8);
                standbyhao = db.getString(9);
                pic = db.getString(10);
                membernumber = db.getString(11);
                membertype = db.getInt(12);
                validate = db.getDate(13);
                memberfafangtype = db.getInt(14); ///会员发放状态
                memberfafangtime = db.getString(15); ///会员证书发放时间
                introducer = db.getString(16); //介绍人
                housefafangtype = db.getInt(17); //犬舍证书状态
                housefafangtime = db.getString(18); //犬舍证书发放时间
                remark = db.getString(19);
                clubzhuxi = db.getInt(20);
                firstzhuxi = db.getInt(21);
                mishuzhang = db.getInt(22);
                membercode = db.getString(23);
                emailval = db.getInt(24);
                istext = true;

            } else
            {
            }
            if (phoneticize == null)
            {
                phoneticize = "";
            }
            if (inkfile == null)
            {
                inkfile = "";
            }
            if (bankinghouse == null)
            {
                bankinghouse = "";
            }
            if (standbys == null)
            {
                standbys = "";
            }
            if (standbyhao == null)
            {
                standbyhao = "";
            }
            if (pic == null)
            {
                pic = "";
            }
            if (membernumber == null)
            {
                membernumber = "";
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community, String member, Date term, int Csvjoinoutlayid, String phoneticize, String inkfile, String bankinghouse, String standbys, String standbyhao, String pic, String membernumber, int membertype, int province) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into ProfileCsv(member, community, term, Csvjoinoutlayid, phoneticize, inkfile, bankinghouse, standbys, standbyhao, pic, membernumber, membertype, province FROM ProfileCsv)values(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(term) + "," + Csvjoinoutlayid + "," + DbAdapter.cite(phoneticize) + "," + DbAdapter.cite(inkfile) + "," + DbAdapter.cite(bankinghouse) + "," + DbAdapter.cite(standbys) + "," + DbAdapter.cite(standbyhao) + ", " + DbAdapter.cite(pic) + "," + DbAdapter.cite(membernumber) + "," + membertype + "," + province + " FROM ProfileCsv)");
        } finally
        {
            db.close();
        }
    }

    public static void set(String community, String member, Date term, int Csvjoinoutlayid, String phoneticize, String inkfile, String bankinghouse, String standbys, String standbyhao, String pic, String membernumber, int membertype, int province) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ProfileCsv set member" + DbAdapter.cite(member) + ",community=" + DbAdapter.cite(community) + " ,term=" + DbAdapter.cite(term) + ",Csvjoinoutlayid=" + Csvjoinoutlayid + ",phoneticize=" + DbAdapter.cite(phoneticize) + ",inkfile=" + DbAdapter.cite(inkfile) + ",bankinghouse=" + DbAdapter.cite(bankinghouse) + " ,standbys=" + DbAdapter.cite(standbys) + ",standbyhao=" + DbAdapter.cite(standbyhao) + ",pic=" + DbAdapter.cite(pic) + ",membernumber=" + DbAdapter.cite(membernumber) + ",membertype=" + membertype + ",province=" + province + " where member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    /*注册的时候用到的方法*/
    public static void create(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("INSERT INTO ProfileCsv(member)VALUES(LOWER(" + DbAdapter.cite(member) + "))");
        } finally
        {
            db.close();
        }
    }


    /*****会员二审的时候用到的方法******/
    public void set(String phoneticize, String inkfile, String pic, String bankinghouse, String standbys, String standbyhao, int csvjoinoutlay, String membernumber) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update ProfileCsv Set phoneticize=" + DbAdapter.cite(phoneticize) + ",inkfile=" + DbAdapter.cite(inkfile) + ",pic=" + DbAdapter.cite(pic) + ",bankinghouse=" + DbAdapter.cite(bankinghouse) + ",standbys=" + DbAdapter.cite(standbys) + ",standbyhao=" + DbAdapter.cite(standbyhao) + ",csvjoinoutlayid=" + csvjoinoutlay + ",membernumber=" + DbAdapter.cite(membernumber) + " where member =" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.phoneticize = phoneticize;
        this.inkfile = inkfile;
        this.pic = pic;
        this.bankinghouse = bankinghouse;
        this.standbys = standbys;
        this.standbyhao = standbyhao;
        this.Csvjoinoutlayid = csvjoinoutlay;
        this.membernumber = membernumber;

    }

    /**导入数据库*/
    public static void create(String member, String community, String password, String firstname, int province, String card, int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("INSERT INTO Profile(member,community,password,card)VALUES(LOWER(" + DbAdapter.cite(member) + ")," + DbAdapter.cite(community) + "," + DbAdapter.cite(password)
                             + "," + DbAdapter.cite(card) + ")");
            db.executeUpdate("INSERT INTO ProfileLayer(member,community,firstname,province,language)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ","
                             + DbAdapter.cite(firstname) + "," + province + "," + language + ")");
        } finally
        {
            db.close();
        }
    }


    public static void create(String member, String community, String password, boolean sex, String card, int linetype, String email) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Profile(member,community,password,sex,card,linetype,email)VALUES(LOWER(" + DbAdapter.cite(member) + ")," + DbAdapter.cite(community) + "," + DbAdapter.cite(password) + "," + DbAdapter.cite(sex) + "," + DbAdapter.cite(card) + "," + linetype + "," + DbAdapter.cite(email) + ")");

        } finally
        {
            db.close();
        }
    }

    public static void set(String phoneticize, String inkfile, String pic, boolean sex, String card, String bankinghouse, String standbys, String standbyhao, int csvjoinoutlay, String membernumber, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Profile Set phoneticize=" + DbAdapter.cite(phoneticize) + ",inkfile=" + DbAdapter.cite(inkfile) + ",pic=" + DbAdapter.cite(pic) + ",sex=" + DbAdapter.cite(sex) + ",card=" + DbAdapter.cite(card) + ",bankinghouse=" + DbAdapter.cite(bankinghouse) + ",standbys=" + DbAdapter.cite(standbys) + ",standbyhao=" + DbAdapter.cite(standbyhao) + ",csvjoinoutlayid=" + csvjoinoutlay + ",membernumber=" + DbAdapter.cite(membernumber) + " where member =" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    //
    public void set(String firstname, int province, String card) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update ProfileLayer Set firstname=" + DbAdapter.cite(firstname) + ",province=" + province + " where member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    public void set(int Csvjoinoutlayid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ProfileCsv set Csvjoinoutlayid = " + Csvjoinoutlayid + " where member=" + DbAdapter.cite(member));

        } finally
        {
            db.close();
        }
    }

    public static boolean isExisted(String member) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT member FROM ProfileCsv WHERE member=").append(DbAdapter.cite(member));
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

    /*****
     *
     *
     *
     *
     * ******/

    public static boolean optionCode(String membercode, String member) throws SQLException
    {
        boolean falg = false;
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeQuery("select member from ProfileCsv where membercode = " + DbAdapter.cite(membercode) + " and member = " + DbAdapter.cite(member));
            if (db.next())
            {
                falg = true; ///update
            } else
            {
                db2.executeQuery("select member from ProfileCsv where membercode=" + DbAdapter.cite(membercode));
                if (db2.next())
                {

                    falg = false; //有卡号，但是 卡号和用户明对应不上
                } else
                {
                    falg = true; //create
                }
            }
        } finally
        {
            db.close();
            db2.close();
        }
        return falg;
    }


    public String getCommunity()
    {
        return community;
    }

    public String getBankinghouse()
    {
        return bankinghouse;
    }

    public String[] getFirstName()
    {
        return firstName;
    }

    public String getInkfile()
    {
        return inkfile;
    }

    public String[] getLastName()
    {
        return lastName;
    }

    public String getMember()
    {
        return member;
    }

    public String getMembernumber()
    {
        return membernumber;
    }

    public int getMembertype()
    {
        return membertype;
    }

    public String[] getName()
    {
        return name;
    }

    public String getPhoneticize()
    {
        return phoneticize;
    }

    public String getPic()
    {
        return pic;
    }

    public String getStandbyhao()
    {
        return standbyhao;
    }

    public String getStandbys()
    {
        return standbys;
    }

    public Date getTerm()
    {
        return term;
    }

    public int getLinetype()
    {
        return linetype;
    }

    public Date getValidate()
    {
        return validate;
    }

    public int getHousefafangtype()
    {
        return housefafangtype;
    }

    public String getHousefafangtime()
    {
        return housefafangtime;
    }

    public String getIntroducer()
    {
        return introducer;
    }

    public int getMemberfafangtype()
    {
        return memberfafangtype;
    }

    public String getRemark()
    {
        return remark;
    }

    public int getMishuzhang()
    {
        return mishuzhang;
    }

    public int getFirstzhuxi()
    {
        return firstzhuxi;
    }

    public int getClubzhuxi()
    {
        return clubzhuxi;
    }

    public String getMemberfafangtime()
    {
        return memberfafangtime;
    }

    public String getMembercode()
    {
        return membercode;
    }

    public int getEmailval()
    {
        return emailval;
    }

    public boolean isIstext()
    {
        return istext;
    }

    public int getCsvjoinoutlayid()
    {
        return Csvjoinoutlayid;
    }

    /**set***/
    public void setLinetype(int linetype) throws SQLException
    {
        set_("linetype", String.valueOf(linetype));
        this.linetype = linetype;
    }

    /*****set总******/
    public void setCsvjoinoutlayid(int Csvjoinoutlayid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ProfileCsv set Csvjoinoutlayid = " + Csvjoinoutlayid + " where member=" + DbAdapter.cite(member));

        } finally
        {
            db.close();
        }
    }

    public void setMembertype(int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ProfileCsv set membertype =" + membertype + " where member =" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.membertype = membertype;
    }

    public void setIntroducer(String introducer) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ProfileCsv set introducer =  " + DbAdapter.cite(introducer) + " where member =" + DbAdapter.cite(introducer));
        } finally
        {
            db.close();
        }
    }

    public void setTerm(Date term) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update ProfileCsv set term =" + DbAdapter.cite(term) + " where member =" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.term = term;
    }

    public void setStandbys(String standbys)
    {
        this.standbys = standbys;
    }

    public void setMembercode(String membercode, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update ProfileCsv set membercode = " + DbAdapter.cite(membercode) + " where member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }


    public void set_(String field, Object value) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        String str = null;
        if (value instanceof String)
        {
            str = DbAdapter.cite((String) value);
        } else if (value instanceof Date)
        {
            str = DbAdapter.cite((Date) value);
        } else if (value instanceof Boolean)
        {
            str = DbAdapter.cite(((Boolean) value).booleanValue());
        } else if (value != null)
        {
            str = DbAdapter.cite(value.toString());
        }
        try
        {
            db.executeUpdate("UPDATE ProfileCsv SET " + field + "=" + str + " WHERE member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    //文件加密
    public static void md5file(String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            java.util.Enumeration enumers = Profile.findByCommunity(community);
            for (int index = 0; enumers.hasMoreElements(); index++)
            {
                String members = (String.valueOf(enumers.nextElement()));
                Profile probj = Profile.find(members);

                db.executeUpdate("update profile set password=" + DbAdapter.cite(SMS.md5_16(probj.getPassword())) + " where member = " + DbAdapter.cite(probj.getMember()));
            }
        } finally
        {
            db.close();
        }
    }


}
